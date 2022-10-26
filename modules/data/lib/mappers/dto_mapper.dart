abstract class DtoMapper<Dto, Domain> {
  Domain mapFromDto(Dto dto);

  Dto mapToDto(Domain domain);
}