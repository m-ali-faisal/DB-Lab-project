import express from 'express';
import sql from 'mssql';
import { connectDB } from './connection.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const router = express.Router();

// JWT Secret Key
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

// Helper function to generate JWT token
const generateToken = (user) => {
    return jwt.sign(
        { id: user.id, username: user.username, role: user.role },
        JWT_SECRET,
        { expiresIn: '1d' }
    );
};

router.get('/message', (req, res) => {
    res.json({ message: 'Hello from the backend!' });
});

// add a user
router.post('/addUser' , async(req , res)=>{

    try { 
    const pool = await connectDB()
    const { username , email , password , role  } = req.body

    await pool.request()
    .input('username' , sql.NVarChar , username)
    .input('email' , sql.NVarChar , email)
    .input('password' , sql.NVarChar , password)
    .input('role' , sql.NVarChar , role)
    .execute('createUser')

    res.json({msg: "user added"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }

})
// Get all players

router.get( '/getAllPlayers' , async(req , res)=>{

    try {
    const pool = await connectDB()
    const q = "Select * From Players"
    const results = await pool.request().query(q)
    res.json(results.recordset)
    }
    catch(err){
        console.log(err)
        res.json({msg: "player not found"})
    }

})

// Signup route
router.post('/signup', async (req, res) => {
    try {
        const pool = await connectDB();
        const { username, email, password, role } = req.body;

        console.log('Signup attempt for:', { username, email, role });

        // Check if user already exists
        const existingUser = await pool.request()
            .input('username', sql.NVarChar, username)
            .input('email', sql.NVarChar, email)
            .query(`SELECT * FROM Users WHERE username = @username OR email = @email`);

        console.log('Existing user check:', existingUser.recordset);

        if (existingUser.recordset.length > 0) {
            console.log('User already exists');
            return res.status(409).json({ msg: 'Username or Email already taken' });
        }

        // Hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        console.log('Original password:', password);
        console.log('Hashed password:', hashedPassword);

        // Create user using direct SQL query
        const result = await pool.request()
            .input('username', sql.NVarChar, username)
            .input('email', sql.NVarChar, email)
            .input('password', sql.NVarChar, hashedPassword)
            .input('role', sql.NVarChar, role)
            .query(`
                INSERT INTO Users (username, email, password, role)
                VALUES (@username, @email, @password, @role)
            `);

        console.log('User created successfully');
        res.status(201).json({ msg: 'User created successfully' });
    } catch (err) {
        console.error('Signup error:', err);
        res.status(500).json({ msg: 'Error creating user' });
    }
});

// Login route
router.post('/login', async (req, res) => {
    try {
        const pool = await connectDB();
        const { email, password } = req.body;

        console.log('Login attempt for email:', email);

        // Find user by email using direct SQL query
        const result = await pool.request()
            .input('email', sql.NVarChar, email)
            .query(`
                SELECT * FROM Users 
                WHERE email = @email
            `);

        console.log('Database query result:', result.recordset);

        if (result.recordset.length === 0) {
            console.log('No user found with email:', email);
            return res.status(401).json({ msg: 'Invalid credentials' });
        }

        const user = result.recordset[0];
        console.log('User found:', user.username);
        console.log('Stored password:', user.password);

        // Check if the stored password is hashed (starts with $2a$)
        const isHashed = user.password.startsWith('$2a$');
        let isMatch;

        if (isHashed) {
            // Compare hashed passwords
            isMatch = await bcrypt.compare(password, user.password);
            console.log('Comparing hashed passwords');
        } else {
            // Compare plain text passwords
            isMatch = password === user.password;
            console.log('Comparing plain text passwords');
            
            // If match is successful, update the password to hashed version
            if (isMatch) {
                const salt = await bcrypt.genSalt(10);
                const hashedPassword = await bcrypt.hash(password, salt);
                
                await pool.request()
                    .input('email', sql.NVarChar, email)
                    .input('password', sql.NVarChar, hashedPassword)
                    .query(`
                        UPDATE Users 
                        SET password = @password 
                        WHERE email = @email
                    `);
                
                console.log('Password updated to hashed version');
            }
        }

        console.log('Password match:', isMatch);
        console.log('Input password:', password);
        console.log('Hashed input password:', await bcrypt.hash(password, 10));

        if (!isMatch) {
            console.log('Password mismatch for user:', user.username);
            return res.status(401).json({ msg: 'Invalid credentials' });
        }

        // Generate token
        const token = generateToken(user);

        // Remove password from user object
        const { password: _, ...userWithoutPassword } = user;

        console.log('Login successful for user:', user.username);
        res.json({
            msg: 'Login successful',
            token,
            user: userWithoutPassword
        });
    } catch (err) {
        console.error('Login error:', err);
        res.status(500).json({ msg: 'Error during login' });
    }
});

// Get Player by Id

router.get('/getPlayerById/:id', async (req, res) =>{

    const pool = await connectDB()
    const id = Number(req.body.id)
    const q = "Select * From Players Where id = @id"
    
    const results = await pool.request().input('id' , sql.Int , id)
    .query(q)

    res.json(results.recordset)

})

// get only attackers

router.get('/getAttackers' , async(req , res)=>{

    const pool = await connectDB()
    const q = "Select * From Players Where position = 'Forward' "
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// get only defenders

router.get('/getDefenders' , async(req , res)=>{

    const pool = await connectDB()
    const q = "Select * From Players Where position = 'Defender' "
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// get only Midfielders

router.get('/getMidfielders' , async(req , res)=>{

    const pool = await connectDB()
    const q = "Select * From Players Where position = 'Midfielder' "
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// get only goalies
router.get('/getGoalkeepers' , async(req , res)=>{

    const pool = await connectDB()
    const q = "Select * From Players Where position = 'Goalkeeper' "
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// show leaderboard

router.get('/showLeaderboard' , async(req , res)=>{

    const pool = await connectDB()
    const q = " select top 3 up.userId , u.username, up.totalPoints from UserPoints up join Users u on u.id = up.userId order by totalPoints desc "
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// show all players in the user team

router.get('/showTeamPlayers' , async (req,res)=>{

    const pool = await connectDB()
    const userId = Number(req.body.userId)
    
    const results =   await pool.request()    
    .input('userId' , sql.Int , userId)
    .execute('GetUserTeamPlayers')

    res.json(results.recordset)

})

// show best rated players

router.get('/showBestRatedPlayers' , async(req , res)=>{

    const pool = await connectDB()
    const q = 'select* from bestPlayers'
    const results = await pool.request().query(q)
    res.json(results.recordset)

})

// delete User

router.delete('/deleteUser/:id' , async(req,res)=>{

    try{
    const pool = await connectDB()
    const id = Number(req.body.id)
    const q = "Delete From Users Where id = @id"

    await pool.request().input('id' , sql.Int , id)
    .query(q)
    
    res.json({msg: "User Deleted"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }
    
})

// update user

router.put('/updateUser/:id' , async(req,res)=>{

    try{
    const pool = await connectDB()
    const iD = Number(req.body.id)
    const {id , username , email , password , role } = req.body

    const q = "Update Users Set username = @username , email = @email , password = @password , role = @role Where id = @id"

    await pool.request()
    .input('id' , sql.Int , iD)
    .input( 'username' , sql.NVarChar , username)
    .input( 'email' , sql.NVarChar , email)
    .input( 'password' , sql.NVarChar , password)
    .input( 'role' , sql.NVarChar , role)
    .query(q)

    res.json({msg: "User Updated!"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }
    
})

// create user team

router.post('/createUserTeam' , async(req , res)=>{

    try{
    const pool = await connectDB()

    const {userId , teamName} = req.body
    const q = "Insert Into Teams (userId , teamName) Values (@userId , @teamName)"

    await pool.request()
    .input('userId' , sql.Int , userId)
    .input('teamName' , sql.NVarChar , teamName)
    .query(q)

    res.json({msg: "user team created"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }
    
})

// delete user team

router.delete('/deleteUserTeam' , async(req,res)=>{
  
    const pool = await connectDB()

    const id = Number(req.body.id)
    const q = "Delete From Teams Where id = @id"

    await pool.request().input('id' , sql.Int , id)
    .query(q)
    
    res.json({msg: "User team deleted"})
    
})

// add player to user team

router.post('/addPlayerToUserTeam' , async(req , res)=>{

    try{ 
    const pool = await connectDB()
    const {teamId , playerId} = req.body
    
    await pool.request()
    .input('teamId' , sql.Int , teamId)
    .input('playerId' , sql.Int , playerId)
    .execute('AddPlayerToTeam')

    res.json({msg: "Player added to team"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }
    
})

// sell team player

router.delete('/sellTeamPlayer' , async (req , res)=>{

    try{
    const pool = await connectDB()
    const {teamId , playerId} = req.body

    await pool.request()
    .input( 'teamId' , sql.Int , teamId)
    .input( 'playerId' , sql.Int , playerId)
    .execute( 'SellTeamPlayer')
    
    res.json({msg: "player sold"})
    }
    catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }

})

// update points

router.post("/updateUserPoints", async (req, res) => {
   
        const pool = await connectDB()
        await pool.request()
        .execute("UpdateUserPoints")
        res.json({ message: "User points updated successfully." });
   
});

// captain a player

router.post('/captainPlayer' , async(req , res)=>{

    try{
    const pool = await connectDB()
    const id = Number(req.body.playerId)

    await pool.request()
    .input('playerId' , sql.Int , id)
    .execute('captainPlayer')

    res.json({msg: "Player captained"})

    }catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }

})

router.post('/doubleCaptainPlayer' , async(req , res)=>{

    try{
    const pool = await connectDB()
    const id = Number(req.body.playerId)

    await pool.request()
    .input('playerId' , sql.Int , id)
    .execute('doubleCaptainPlayer')

    res.json({msg: "Player double captained"})

    }catch(err){
        console.log(err)
        res.json({msg: "error occured"})
    }

})

export default router