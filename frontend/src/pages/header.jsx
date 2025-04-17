
import "../styles/home.css";
import "../styles/buttons.css";
import "../styles/dashboard.css";
import "../styles/header.css";
import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../App";

function Header(){

    const { user, logout } = useContext(AuthContext);
        const navigate = useNavigate();
    
        const handleLogout = () => {
            logout();
            navigate("/login");
        };

    return(
        <>
            <div  className="headerarea"> 

                <div className="leftheader"> 
                <h3>Budget Remaining: {}</h3>

                </div> 

                <div className="middleheader" >

                    <h1 style={{ fontFamily: 'Nabla', fontSize: '35px' }}>Welcome, {user?.username}!</h1>
                </div> 

                <div className="rightheader"> 
                <button onClick={handleLogout} className="button1" >
                    LOGOUT
                </button>
                </div> 

            </div>


        
        </>
    )
}

export default Header;