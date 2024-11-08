import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/tickets/raise_ticket.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';
import '../../utils/upload_to_firebase.dart';
import 'package:dio/dio.dart' as dio;

class IssueTicketController {
  late final String ticketId;
  final _dio = dio.Dio();
  final _options = dio.Options(
    headers: {
      'Content-Type': 'application/json',
    },
  );
  final url = '$host/ticket/?format=json';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IssueTicketModel ticket = IssueTicketModel(
      firstName: '', lastName: '', email: '', description: '', attachFile: '');
  File? attachedFile; // For storing the picked image file

  Future<bool> submitTicket(BuildContext context) async {
    // Save the form state directly without validation
    formKey.currentState?.save();
    String? fileUrl;

    // Handle file upload
    if (attachedFile != null) {
      fileUrl = await uploadFileToFirebase(attachedFile!);
      if (fileUrl != null) {
        ticket.attachFile = fileUrl; // Assign file URL if available
      } else {
        if(context.mounted){
          showToastMessage(context, 'File upload failed');
        }
        return false;
      }
    }

    // Make POST request
    final response = await _dio.post(
      url,
      options:_options,
      data: {
        'first_name': ticket.firstName,
        'last_name': ticket.lastName,
        'email': ticket.email,
        'select_order': ticket.selectedOrder,
        'description': ticket.description,
        'attach_file': ticket.attachFile,
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      ticketId = response.data["id"];
      return true;
    } else {
      if(context.mounted){
        showToastMessage(context,'Ticket submission failed' );
      }
      return false;
    }
  }
}
