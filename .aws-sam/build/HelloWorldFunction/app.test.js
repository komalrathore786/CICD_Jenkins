'use strict';

const app = require('./app.js');

var event, context;

describe('Tests index', function () {
    it('verifies successful response', async () => {
        const result = await app.lambdaHandler(event, context)

        //expect(result).to.be.an('object');
        expect(result.statusCode).toEqual(200);
        //expect(result.body).to.be.an('string');

        let response = JSON.parse(result.body);

        //expect(response).to.be.an('object');
        expect(response.message).toEqual("hello world");
        // expect(response.location).to.be.an("string");
    });
});
