import "../styles/home.css";
import "../styles/buttons.css";
import "../styles/dashboard.css";
import "../styles/header.css";
import { useContext, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../App";
import axios from "axios";

function Header() {
    const { user, logout } = useContext(AuthContext);
    const navigate = useNavigate();
    const [budget, setBudget] = useState(null);
    
    useEffect(() => {
        const fetchBudget = async () => {
            if (user?.id) {
                try {
                    const response = await axios.get(`http://localhost:5000/api/getTeamBudget/${user.id}`);
                    setBudget(response.data.budget);
                } catch (error) {
                    console.error('Error fetching budget:', error);
                }
            }
        };
        
        fetchBudget();
    }, [user?.id]);

    const handleLogout = () => {
        logout();
        navigate("/login");
    };

    return (
        <>
            <div className="headerarea"> 
                <div className="leftheader"> 
                    <h3>Budget Remaining: {budget !== null ? `$${budget.toFixed(2)}` : 'Loading...'}</h3>
                </div> 

                <div className="middleheader">
                    <h1 style={{ fontFamily: 'Nabla', fontSize: '35px' }}>Welcome, {user?.username}!</h1>
                </div> 

                <div className="rightheader"> 
                    <button onClick={handleLogout} className="button1">
                        LOGOUT
                    </button>
                </div> 
            </div>
        </>
    );
}

export default Header;