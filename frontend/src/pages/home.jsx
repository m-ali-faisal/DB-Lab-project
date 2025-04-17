import "../styles/home.css"
import "../styles/buttons.css"
import { useNavigate } from "react-router-dom"
import { useEffect } from "react";

function Home() {
    const navigate = useNavigate();

    const goToLogin = () => {
        navigate("/login");
    };

    const goToSignup = () => {
        navigate("/signup");
    };


    useEffect(() => {
        document.body.className = "home-body"; // set class
      
        return () => {
          document.body.className = "";
        };
      }, [])

    return (

        <div className="home">
            <div className="home-container">
                <h1>Welcome</h1>
                <div className="button-container">
                    <button className="button1" onClick={goToLogin}>
                        LOGIN
                    </button>
                    <button className="button1" onClick={goToSignup}>
                        SIGNUP
                    </button>
                </div>
            </div>
        </div>
    );
}

export default Home;