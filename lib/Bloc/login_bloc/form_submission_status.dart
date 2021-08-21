abstract class FormSubmissionStatus{

  const FormSubmissionStatus();

}

class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus{}

class SubmittingSuccess extends FormSubmissionStatus{}

class SubmissionFailed extends FormSubmissionStatus{

  final Exception exception;

  SubmissionFailed(this.exception);

}