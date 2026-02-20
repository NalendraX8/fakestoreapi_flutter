import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
    final IconData iconData;
    final String title;
    final bool isSelected;
    final VoidCallback onTap;

    const CategoryItem({
        super.key,
        required this.iconData,
        required this.title,
        this.isSelected = false,
        required this.onTap,
    });

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: onTap,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: isSelected ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isSelected ? [] : [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                ),
                            ],
                        ),
                        child: Icon(
                            iconData,
                            size: 40,
                            color: isSelected ? Colors.white : Colors.black87,
                        ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.black : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                    ),
                ],
            ),
        );
    }
}