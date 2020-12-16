import styled from 'styled-components';

const PostCard = ({ article }) => {
    return (
        <Card>
            <img src={article.urlToImage} alt="" />
            <Content>
                <h2>{article.title}</h2>
                <p>{article.description}</p>
            </Content>
            <Author>Author: {article.author}</Author>
            <Date>Date: {article.publishedAt}</Date>
            <Vote>Up: 100 | Down: 18</Vote>
        </Card>
    );
};

const Card = styled.div`
    padding: 1.2rem 2rem;
    margin-top: 2rem;

    display: flex;

    position: relative;

    box-shadow: 1px 1px 2px rgba(30, 30, 30, 0.3);

    background: #fff;
    img {
        width: 250px;
        height: 220px;
        object-fit: cover;
    }
`;

const Vote = styled.span`
    position: absolute;
    bottom: 1.2rem;
    right: 2rem;
`;

const Author = styled.div`
    position: absolute;
    bottom: 1.2rem;
    left: 40rem;
`;

const Date = styled.span`
    position: absolute;
    bottom: 1.2rem;
    left: 19.5rem;
`;

const Content = styled.div`
    margin-left: 1rem;

    h2 {
        color: #04d28f;
    }

    p {
        margin-top: 1.5rem;

        display: inline-block;
    }
`;

export default PostCard;
