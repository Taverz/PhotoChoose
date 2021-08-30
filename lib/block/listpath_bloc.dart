// import 'dart:typed_data';

// import 'package:bloc/bloc.dart';
// import 'package:dsf/block/listpath_event.dart';
// import 'package:dsf/block/listpath_state.dart';

// import 'package:flutter/cupertino.dart';





// class ListPathBloc extends Bloc<ListPathEvent, ListPathStates> {


//   ListPathBloc(ListPathStates initialState) : super(initialState);

//   Future init(BuildContext context) async {
//   }



//   @override
//   ListPathStates get initialState => UninitializedP();

//   @override
//   Stream<ListPathStates> mapEventToState(ListPathEvent event) async* {
//     try{
//       switch (event.runtimeType) {
//         case AccomodationChoiceYesEvent:
//           // RoomApi.changeSettle();
//           // yield ChoiceYes();
//           break;
//         case ListElementShooise:
//           // yield ChoiceNo();
//           break;
//         case AccomodationSuccessEvent:
//           // yield Success();
//           break;
//         case AccomodationErrorEvent:
//           // yield Error();
//           break;
//       }
//     }
//     catch (e) {
//       yield ErrorP();
//     }
//   }

// }
