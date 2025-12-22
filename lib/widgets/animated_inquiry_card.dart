// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:ghar_for_sale/model/inquiry_model.dart';

// class AnimatedInquiryCard extends StatefulWidget {
//   final InquiryModel inquiry;
//   final int delay;

//   const AnimatedInquiryCard({
//     super.key,
//     required this.inquiry,
//     required this.delay,
//   });

//   @override
//   State<AnimatedInquiryCard> createState() => _AnimatedInquiryCardState();
// }

// class _AnimatedInquiryCardState extends State<AnimatedInquiryCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fade;
//   late Animation<Offset> _slide;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

//     _slide = Tween<Offset>(
//       begin: const Offset(0, 0.25),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

//     Future.delayed(Duration(milliseconds: widget.delay), () {
//       if (mounted) _controller.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Color _statusColor(String status) {
//     switch (status) {
//       case 'New':
//         return Colors.blue;
//       case 'Contacted':
//         return Colors.orange;
//       case 'Closed':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final inquiry = widget.inquiry;

//     return FadeTransition(
//       opacity: _fade,
//       child: SlideTransition(
//         position: _slide,
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 14),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Avatar
//               CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Colors.blue.shade100,
//                 child: const Icon(Icons.person, color: Colors.blue),
//               ),
//               const SizedBox(width: 14),

//               /// Inquiry Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// Name
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           inquiry.name,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 10,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _statusColor(
//                               inquiry.status,
//                             ).withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             inquiry.status,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: _statusColor(inquiry.status),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 6),

//                     /// Message
//                     Text(
//                       inquiry.message,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                     ),

//                     const SizedBox(height: 8),

//                     /// Date + Property ID
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           size: 14,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           DateFormat(
//                             'dd MMM yyyy',
//                           ).format(inquiry.createdAt.toDate()),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         Icon(Icons.home, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 6),
//                         Text(
//                           inquiry.propertyId,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               /// ➡️ Action
//               IconButton(
//                 icon: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onPressed: () {
//                   // TODO: Navigate to inquiry detail
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
