package models.Servicies;

import models.Entities.Finca;
import models.Repositories.FincaRepository;

public class CreateFincaService {

    private final FincaRepository fincaRepository;

    public CreateFincaService() {
        this.fincaRepository = new FincaRepository();
    }

    public boolean create(Finca finca) {

        boolean resp = fincaRepository.createFinca(finca);
        return resp;
    }
}
