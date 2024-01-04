import 'package:clean_architecture/data/mapper/PersonMapper.dart';
import 'package:clean_architecture/domain/entity/Person_entity.dart';

abstract class PersonUsecase {
  final PersonMapper _personMapper = PersonMapper();

  PersonEntity getPersonEntity({String? email});
}

class PersonUsecaseImpl extends PersonUsecase {
  @override
  PersonEntity getPersonEntity({String? email}) {
    PersonEntity person = _personMapper.getPersonMapper(email: email);

    return PersonEntity(email: person.email);
  }
}
