import 'package:task_mp/ui/widget/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static String getNewTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getProgressTask =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static const String recoveryResetPassword = '$_baseUrl/RecoverResetPass';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static const String updateProfile = '$_baseUrl/profileUpdate';
}
