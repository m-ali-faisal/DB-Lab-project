import "../styles/sidebar.css"
import strategyImg from '../styles/images/strategy.png';
import stadiumImg from '../styles/images/stadium.png';


function Sidebar() {
    return (
        <div className="sidebar"> 
            <div className="sidebaricons">
                <img src={strategyImg}/> 
                <div>Mango</div>
            </div>

            <div className="sidebaricons"> 
                <img src={strategyImg}  />
                <div>Mangi</div>
            </div>

            <div className="sidebaricons"> 
                <img src={stadiumImg}/>
                <div>Mango</div>
            </div>
        </div>
    );
}

export default Sidebar;
