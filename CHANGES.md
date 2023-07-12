# My changes in a nutshell

With this challenge, I tried to balance changes between rule business, new features, improvements in the project standards and the dev experience.

I assumed that this api will serve a front-end api for a local store, like blockbuster.
Of course, there is a lot of pieces to improve, but I thought and prioritized changes which didn't depend so much on the business rules, in other words, implemented the expected behavior for a movie rent store.

### Rule business and new features

For a movie rental, the api lacks some of the basic functionalities of rent and return, including calculating the amount to pay, max tolerance day to return and marking when the client returned.

### Project standards and dev experience

Here I put CORS, added `/api/v1` as a prefix to all endpoints, and created a standard json response, to pagination either.
