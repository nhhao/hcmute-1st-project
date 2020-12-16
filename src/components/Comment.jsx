import styled from 'styled-components';

const Comment = () => {
    return (
        <CommentStyled>
            <div>
                <img
                    src="https://previews.123rf.com/images/igorrita/igorrita1507/igorrita150700024/42584408-flat-hipster-character-stylish-young-guy-with-glasses-avatar-icon-man-vector-illustration-eps10.jpg"
                    alt="Avatar"
                />
                <span className="username">Nhathao0215</span>
                <span className="datetime">12/17/2020 | 03:22</span>
            </div>
            <p>
                Incredible. I can't believe in my eyes. Lorem ipsum dolor sit
                amet consectetur adipisicing elit. Quidem, itaque! Rem quis, sit
                blanditiis cumque aspernatur aut. Nulla. Lorem Lorem, ipsum
                dolor sit amet consectetur adipisicing elit. ipsum dolor sit
                amet consectetur adipisicing elit.
            </p>
        </CommentStyled>
    );
};

const CommentStyled = styled.div`
    margin-top: 1.5rem;
    padding: 1rem 2rem 1rem 0;

    display: flex;

    box-shadow: 1px 1px 2px rgba(30, 30, 30, 0.2);

    background: #fff;

    img {
        width: 8rem;
        height: 8rem;
        object-fit: cover;
    }

    span {
        margin-top: 0.25rem;

        display: flex;

        font-size: 0.85rem;
    }

    p {
        margin-left: 2rem;
    }
`;

export default Comment;
