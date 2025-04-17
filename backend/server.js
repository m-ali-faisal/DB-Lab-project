import express from 'express';
import sql from 'mssql';
import cors from 'cors';
import { connectDB } from './connection.js'; 
import routes from './routes.js'

const app = express();
const PORT = 5000;

app.use(cors({
    origin: 'http://localhost:5173', 
    credentials: true
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use('/api', routes);


app.get('/', async (req, res) => {
    try {
        await connectDB();
        res.json({ message: 'Database connection successful' });
    } catch (err) {
        console.error('Database connection error:', err);
        res.status(500).json({ error: 'Database connection failed' });
    }
});


app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Something went wrong!' });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});