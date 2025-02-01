import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoCard extends StatelessWidget {
  final TodoModel model;
  const TodoCard({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.5.h,
          horizontal: 2.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 0.5.h,
          children: [
            Text(
              model.title ?? '',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(thickness: 0.5),
            Row(
              children: [
                Text(
                  'Status:',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: model.completed ?? false
                        ? Colors.green.shade400
                        : Colors.red.shade400,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.w,
                    vertical: 0.2.h,
                  ),
                  child: Text(
                    model.completed ?? false ? 'Completed' : 'Pending',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
