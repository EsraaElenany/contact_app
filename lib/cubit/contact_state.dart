part of 'contact_cubit.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}

class GetDataBaseStates extends ContactState{}

class InsertDataBaseSuccessStates extends ContactState{}
class InsertDataBaseErrorStates extends ContactState{}


class UpdateDataBaseSuccessStates extends ContactState{}
class UpdateFavoriteSuccessStates extends ContactState{}
class UpdateDataBaseErrorStates extends ContactState{}



class LoadingGetDataBaseStates extends ContactState{}
class SuccessGetDataBaseStates extends ContactState{}
class ErrorGetDataBaseStates extends ContactState{}


class DeleteDataBaseErrorStates extends ContactState{}

class ChangeBottomSheetStates extends ContactState{}

class ChangeBottomNavBarStates extends ContactState{}
