import 'package:collaborative_app/core/app/enums.dart';
import 'package:collaborative_app/src/entities/user_entity.dart';

class PhoneAuthStateEntity {

  final UserEntity? userEntity;
  final String? verificationId;
  final String? errorMessage;
  final int? resendToken;
  final bool? isResend;
  final PhoneAuthStateType type;

  PhoneAuthStateEntity._(
    this.type,
    {this.isResend, this.userEntity, this.verificationId, this.errorMessage, this.resendToken}
  );

  factory PhoneAuthStateEntity.completed(UserEntity userEntity) {
    return PhoneAuthStateEntity._(PhoneAuthStateType.completed, userEntity: userEntity);
  }

  factory PhoneAuthStateEntity.failed(String errorMessage) {
    return PhoneAuthStateEntity._(PhoneAuthStateType.failed, errorMessage: errorMessage);
  }

  factory PhoneAuthStateEntity.codeSent(String verificationId, int? resendToken, bool isResend) {
    return PhoneAuthStateEntity._(
      PhoneAuthStateType.codeSent,
      verificationId: verificationId,
      resendToken: resendToken,
      isResend: isResend
    );
  }

  factory PhoneAuthStateEntity.timeout(String verificationId) {
    return PhoneAuthStateEntity._(
      PhoneAuthStateType.timeout,
      verificationId: verificationId,
    );
  }


}






