import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
    const SearchBar({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                    ),
                ],
            ),
            child: Row(
                children: [
                    const Icon(Icons.search,
                    color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                        child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                            ),
                        ),
                    ),
                    Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey.shade600,
                    ),
                ],
            ),
        );
    }
}