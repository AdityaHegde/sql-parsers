import { GenericSQL } from "dt-sql-parser";
import {readFileSync} from "fs";

const FUNCTION_NAME_REGEX = /function (\w*)\(.*\)/;

const dtSqlParser = new GenericSQL();

function treeTraversal(tree, query: string) {
    const className = tree.constructor.toString().match(FUNCTION_NAME_REGEX)?.[1];
    console.log(className);
    tree.children?.forEach(child => treeTraversal(child, query));
}
function parse(query: string) {
    treeTraversal(dtSqlParser.parse(query), query);
}

parse(readFileSync(process.argv[2]).toString());
