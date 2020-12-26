import styled from 'styled-components';
import Comments from '../components/Comments';
import { useHistory } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretUp, faCaretDown } from '@fortawesome/free-solid-svg-icons';
import { Remarkable } from 'remarkable';
import { Markup } from 'interweave';

const Article = ({ articles, role, userAvatarUrl, user }) => {
    const history = useHistory();
    const url = history.location.pathname.slice(1);
    const [article, setArticle] = useState(null);
    const markdown = new Remarkable();
    useEffect(() => {
        const currentArticle = articles.filter(
            (article) => article.url === url
        )[0];
        setArticle(currentArticle);
    }, [url, articles]);

    return (
        <>
            {article && (
                <div>
                    <ArticleStyled>
                        <h1>{article.title}</h1>
                        <div className="info">
                            <span>Written by: {article.author}</span>
                            <span>Published {article.datetime}</span>
                            <span className="vote">
                                <FontAwesomeIcon icon={faCaretUp} />
                                <span>{article.upVote - article.downVote}</span>
                                <FontAwesomeIcon icon={faCaretDown} />
                            </span>
                        </div>
                        <div className="content">
                            <p>
                                <Markup content={article.content} />
                            </p>
                        </div>
                    </ArticleStyled>
                    <Comments
                        role={role}
                        userAvatarUrl={userAvatarUrl}
                        articleId={article._id}
                        user={user}
                    ></Comments>
                </div>
            )}
        </>
    );
};

const ArticleStyled = styled.article`
    margin-top: 1rem;

    h1 {
        font-size: 2.4rem;
    }

    svg {
        font-size: 2rem;
        color: #888;

        cursor: pointer;

        &:not(:first-child) {
            margin-left: 0.35rem;
        }

        &.active {
            color: #04d28f;
        }
    }

    .vote {
        display: flex;
        align-items: center;
        span {
            margin-left: 0.35rem;
        }
    }

    .info {
        margin-top: 0.4rem;

        display: flex;
        justify-content: space-between;
    }

    .content {
        margin-top: 1.2rem;

        h2 {
            margin-top: 1.4rem;

            font-size: 1.8rem;
        }

        h3 {
            margin-top: 0.7rem;
            font-size: 1.2rem;
        }

        p {
            margin-top: 0.7rem;

            font-size: 1.2rem;
            line-height: 1.5;
        }

        h2 + p,
        h3 + p {
            text-indent: 3rem;
        }
    }
`;

export default Article;
