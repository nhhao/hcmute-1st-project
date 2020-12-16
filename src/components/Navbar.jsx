import styled from 'styled-components';

const Navbar = () => {
    return (
        <Nav>
            <div className="logo">Something</div>
            <div className="authentication">
                <a href="http://google.com">Log In</a>
                <button>Sign Up</button>
            </div>
        </Nav>
    );
};

const Nav = styled.div`
    padding: 1rem 10rem;
    margin: 0 -10rem;
    position: sticky;
    top: 0;

    box-shadow: 1px 1px 2px rgba(30, 30, 30, 0.3);

    background-color: #fff;

    display: flex;
    align-items: center;
    justify-content: space-between;

    z-index: 5;

    .authentication {
        a {
            color: #04d28f;

            text-decoration: none;

            &:hover {
                text-decoration: underline;
            }
        }

        button {
            padding: 0.5rem 1rem;
            margin-left: 0.5rem;

            border: none;
            border-radius: 5px;

            color: #fff;
            background: #04d28f;

            cursor: pointer;
            outline: none;
            &:hover {
                transform: translateY(-2px);
            }
        }
    }

    .logo {
        font-family: 'Satisfy', cursive;
        font-size: 1.5rem;
        color: #fec516;
        cursor: pointer;
    }
`;

export default Navbar;
