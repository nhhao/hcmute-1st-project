import styled from 'styled-components';
import Comment from './Comment';

const Comments = () => {
    return (
        <CommentsStyled>
            <div className="line"></div>
            <h3>Comments:</h3>
            <Comment />
            <Comment />
            <Comment />
            <Comment />
            <Comment />
            <div className="leave-comment">
                <img
                    src="https://www.sketchappsources.com/resources/source-image/profile-illustration-gunaldi-yunus.png"
                    alt="Avatar"
                />
                <textarea placeholder="Leave a comment..."></textarea>
            </div>
        </CommentsStyled>
    );
};

const CommentsStyled = styled.div`
    margin-top: 1.5rem;

    font-size: 1.2rem;
    line-height: 1.5;

    h3 {
        margin-top: 1.5rem;
    }

    .line {
        width: 100%;
        height: 1px;
        background: rgba(32, 32, 32, 0.6);
    }

    .leave-comment {
        margin-top: 1.5rem;
        padding: 1rem 2rem 1rem 0;

        display: flex;

        box-shadow: 1px 1px 2px rgba(30, 30, 30, 0.2);

        img {
            width: 8rem;
            height: 8rem;
            object-fit: cover;
        }

        textarea {
            padding: 1rem 2rem;
            width: 100%;

            border: none;

            font-size: 1.2rem;
            line-height: 1.5;

            outline: none;
            resize: none;
        }
    }
`;

export default Comments;
