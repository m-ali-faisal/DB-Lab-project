import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/home.css";
import "../styles/buttons.css";

function SignUp() {
    const [formData, setFormData] = useState({
        username: "",
        email: "",
        password: "",
        role: "user"
    });
    const [error, setError] = useState("");
    const navigate = useNavigate();

    const handleChange = (e) => {
        setFormData({
            ...formData,[e.target.name]: e.target.value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");

        try {
            const response = await fetch("http://localhost:5000/api/signup", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.msg || "Signup failed");
            }

            navigate("/login");
        } catch (err) {
            setError(err.message);
        }
    };

    return (
        <div className="form-container">
            <form className="form" onSubmit={handleSubmit}>
                <h2>SIGN UP</h2>
                
                {error && <div className="error-message">{error}</div>}
                
                <div className="formTings">
                    <input
                        type="text"
                        placeholder="Username"
                        name="username"
                        value={formData.username}
                        onChange={handleChange}
                        required
                    />
                </div>
                
                <div className="formTings">
                    <input
                        type="email"
                        placeholder="Email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        required
                    />
                </div>
                
                <div className="formTings">
                    <input
                        type="password"
                        placeholder="Password"
                        name="password"
                        value={formData.password}
                        onChange={handleChange}
                        required
                    />
                </div>
                
                <button type="submit" className="button1">
                    SIGN UP
                </button>
            </form>
        </div>
    );
}

export default SignUp; 