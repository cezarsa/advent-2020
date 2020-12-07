//usr/bin/clang++ -Wall -Werror -std=c++2a -o /tmp/7.out "$0" && exec /tmp/7.out "$@"
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <memory>
#include <sstream>

using namespace std;

class Node {
private:
    string name;

public:
    map<string, int> edgesBack;
    map<string, int> edgesForward;
    bool visited = false;

    Node(string name)
        : name(name) {};
};

class Graph {
    map<string, shared_ptr<Node>> nodes;

    Node* get(string name)
    {
        if (nodes.find(name) != nodes.end()) {
            return nodes[name].get();
        }
        auto n = new Node(name);
        nodes.insert(make_pair(name, n));
        return n;
    }

public:
    int parents(string name)
    {
        auto n = nodes[name];
        if (n->visited) {
            return 0;
        }
        n->visited = true;
        int count = 1;
        for (auto it = n->edgesBack.begin(); it != n->edgesBack.end(); it++) {
            count += parents(it->first);
        }
        return count;
    }

    int children(string name)
    {
        auto n = nodes[name];
        int count = 1;
        for (auto it = n->edgesForward.begin(); it != n->edgesForward.end(); it++) {
            count += (it->second * children(it->first));
        }
        return count;
    }

    void parse()
    {
        ifstream input("input");
        string del1 = " bags contain ";

        for (string line; getline(input, line);) {
            int pos = line.find(del1);
            string name = line.substr(0, pos);
            auto n = get(name);

            istringstream tokenStream(line.substr(pos + del1.size()));
            for (string token; getline(tokenStream, token, ',');) {
                int i;
                string a, b;
                istringstream(token) >> i >> a >> b;
                if (i == 0) {
                    continue;
                }
                ostringstream out;
                out << a << " " << b;
                auto node = get(out.str());
                node->edgesBack[name] = i;
                n->edgesForward[out.str()] = i;
            }
        }
    }
};

int main()
{
    Graph g;
    g.parse();
    cout << g.parents("shiny gold") - 1 << endl;
    cout << g.children("shiny gold") - 1 << endl;
    return 0;
}
