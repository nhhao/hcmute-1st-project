import styled from 'styled-components';

const PageNumber = () => {
    return (
        <PageNumberStyle>
            <span>1</span>
            <span>2</span>
            <span>...</span>
            <span>124</span>
        </PageNumberStyle>
    );
};

const PageNumberStyle = styled.div`
    margin-top: 2.5rem;
    text-align: center;

    span {
        padding: 0.8rem;

        border: 1px solid #04d28f;
        color: #04d28f;
        border-radius: 5px;

        cursor: pointer;

        &:first-child {
            border: none;

            color: #fff;
            background-color: #04d28f;
        }

        &:not(:first-child) {
            margin-left: 0.25rem;
            &:hover {
                text-decoration: underline;
            }
        }
    }
`;

export default PageNumber;
