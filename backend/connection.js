import dotenv from 'dotenv'
import sql from 'mssql'

dotenv.config();

async function connectDB() {

    const config = {

        server: process.env.SERVER_NAME, 
        database: process.env.DATABASE_NAME,
        user: process.env.DATABASE_USER, 
        password: process.env.DATABASE_PASSWORD, 
        driver: "ODBC Driver 18 for SQL Server",

        options: {
            encrypt: false,
            trustServerCertificate: true
        }
    };

    let pool = await sql.connect(config);
    
    try {
        console.log(" Database connected successfully!");
        return pool;
    } catch (err) {
        console.error(" Database Connection Failed:", err);
        process.exit(1);
    }
}

connectDB()
export { connectDB }