import 'package:clean_architecture/data/dto/Person.dart';

abstract class PersonDataSourceBluePrint {
  PersonDTO getPersonRemote({String? email});
}

class PersonDataSource extends PersonDataSourceBluePrint {
  PersonDataSource();

  @override
  PersonDTO getPersonRemote({String? email}) {
    return PersonDTO.fromJson({"email": email ?? ""});
  }
}
