//dashy very fire
import "../styles/home.css";
import "../styles/buttons.css";
import Sidebar from "./sidebar";
import "../styles/dashboard.css";
import Header from "./header";
import { useEffect }from "react";



function Dashboard() {


    useEffect(() => {
        document.body.className = "dashboard-body"; 
      
        return () => {
          document.body.className = "";
        };
      }, []);

    return (
        <div className="dashboard">
            
            <Sidebar/>
            <Header/>
        
            

        </div>
    

);
}

export default Dashboard;