import { parseFirst } from "pgsql-ast-parser";
import {readFileSync} from "fs";

function parse(query) {
    console.log(parseFirst(query.replace(/\n/g, "")));
}

parse(readFileSync(process.argv[2]).toString());
