import PostCard from '../components/PostCard';
import PageNumber from '../components/PageNumber';

const Homepage = ({ articles }) => {
    return (
        <div>
            {articles.map((article) => (
                <PostCard article={article} />
            ))}
            <PageNumber />
        </div>
    );
};

export default Homepage;
