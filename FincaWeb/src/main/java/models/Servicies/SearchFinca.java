package models.Servicies;

import models.Entities.Finca;
import models.Repositories.FincaRepository;

public class SearchFinca {

    private FincaRepository repoFinca = new FincaRepository();

    public Finca searchFinca(String codigoOnombre) {
        Finca finca = repoFinca.findFincaByCod(codigoOnombre);
        if (finca != null) {
            return finca;
        }
        finca = repoFinca.findFincaByCod(codigoOnombre);
        return finca;
    }
}
