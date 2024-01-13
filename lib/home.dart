import 'package:desktop/desktop.dart';
import 'package:flutter/material.dart' as material;
import 'package:train_map/start_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Tree(
      title: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            'Tree111111111111111111111111111111111111111111111111111111111111111111111111111111',
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ),
      nodes: [
        TreeNode.child(
          titleBuilder: (context) => const Text('开始'),
          builder: (context) => Container(
            decoration: const BoxDecoration(
                border: Border(
              left: BorderSide(color: material.Colors.grey, width: 1.0),
            )),
            child: const StartPage(),
          ),
        ),
        TreeNode.children(
          titleBuilder: (context) => const Text('Node 1'),
          children: [
            TreeNode.child(
              titleBuilder: (context) => const Text('Node 0'),
              builder: (context) => Center(
                child: Text(
                  'Node 1 -> 0',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            TreeNode.child(
              titleBuilder: (context) => const Text('Node 1'),
              builder: (context) => Center(
                child: Text(
                  'Node 1 -> 1',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            TreeNode.child(
              titleBuilder: (context) => const Text('Node 2'),
              builder: (context) => Center(
                child: Text(
                  'Node 1 -> 2',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            TreeNode.children(
              titleBuilder: (context) => const Text('Node3'),
              children: [
                TreeNode.child(
                  titleBuilder: (context) => const Text('Node 0'),
                  builder: (context) => Center(
                    child: Text(
                      'Node 1 -> 3 -> 0',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TreeNode.child(
                  titleBuilder: (context) => const Text('Node 1'),
                  builder: (context) => Center(
                    child: Text(
                      'Node 1 -> 3 -> 1',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        TreeNode.child(
          titleBuilder: (context) => const Text('Node 2'),
          builder: (context) => Center(
            child: Text(
              'Node 2 ',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        TreeNode.children(
          titleBuilder: (context) => const Text('Node 3'),
          children: [
            TreeNode.child(
              titleBuilder: (context) => const Text('Node 0'),
              builder: (context) => Center(
                child: Text(
                  'Node 3 -> 0',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            TreeNode.child(
              titleBuilder: (context) => const Text('Node 1'),
              builder: (context) => Center(
                child: Text(
                  'Node 3 -> 1',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 12.0), child: Text('Train Map'));
  }
}
