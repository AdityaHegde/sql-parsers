import { Parser } from "node-sql-parser";
import {readFileSync} from "fs";

const nodeSqlParser = new Parser();
function parse(query) {
    try {
        console.log(nodeSqlParser.parse(query));
    } catch (err) {
        console.log(`${err.message}` +
            `\nAt line ${err.location.start.line} col ${err.location.start.column}`);
    }
}

parse(readFileSync(process.argv[2]).toString());
