import 'package:clean_architecture/data/datasource/PersonDataSource.dart';
import 'package:clean_architecture/data/dto/Person.dart';
import 'package:clean_architecture/domain/entity/Person_entity.dart';

class PersonMapper {
  PersonMapper();
  final PersonDataSource _personDataSource = PersonDataSource();

  PersonEntity getPersonMapper({String? email}) {
    PersonDTO person = _personDataSource.getPersonRemote(email: email);

    PersonEntity personEntity = PersonEntity.fromJson(person.toJson());

    return personEntity;
  }
}
