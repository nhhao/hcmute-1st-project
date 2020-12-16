import Homepage from './pages/Homepage';
import Navbar from './components/Navbar';
import Footer from './components/Footer';
import GlobalStyle from './components/GlobalStyles';

//

import { useState, useEffect } from 'react';
import axios from 'axios';

//

function App() {
    const [articles, setArticles] = useState(null);
    useEffect(() => {
        axios
            .get(
                'http://newsapi.org/v2/everything?q=apple&from=2020-12-14&to=2020-12-14&sortBy=popularity&apiKey=cb20d7f029194a348867100d6f717707'
            )
            .then((response) => setArticles(response.data.articles))
            .catch((error) => console.error(error));
    }, []);

    return (
        <div>
            <GlobalStyle />
            <Navbar />
            {articles && (
                <>
                    <Homepage articles={articles} />
                    <Footer />
                </>
            )}
        </div>
    );
}

export default App;
