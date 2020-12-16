import Homepage from './pages/Homepage';
import Navbar from './components/Navbar';
import Footer from './components/Footer';
import Article from './pages/Article';
import GlobalStyle from './components/GlobalStyles';

import { Switch, Route, useLocation } from 'react-router-dom';

//

import { useState, useEffect } from 'react';
import axios from 'axios';

//

function App() {
    const [articles, setArticles] = useState(null);
    const headers = {
        'Content-Type': 'text/plain',
        // 'Content-Type': 'application/x-www-form-urlencoded',
    };
    useEffect(() => {
        axios
            .get(
                'http://newsapi.org/v2/everything?q=apple&from=2020-12-14&to=2020-08-14&sortBy=popularity&apiKey=cb20d7f029194a348867100d6f717707'
            )
            .then((response) => setArticles(response.data.articles))
            .catch((error) => console.error(error));
        axios
            .post(
                'http://123.21.172.185:8080/afs/abc',
                { data: { pageNumber: 2 } },
                { headers }
            )
            .then((response) => console.log(response))
            .catch((error) => console.log(error));
    }, []);

    const location = useLocation();

    return (
        <div>
            <GlobalStyle />
            <Navbar />
            <Switch location={location} key={location.pathname}>
                {articles && (
                    <Route path="/" exact>
                        <Homepage articles={articles} />
                    </Route>
                )}
                <Route path="/article" exact>
                    <Article />
                </Route>
            </Switch>
            <Footer />
        </div>
    );
}

export default App;
