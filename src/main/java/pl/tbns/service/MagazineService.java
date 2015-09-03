/**
 * 
 */
package pl.tbns.service;

import java.util.List;

import pl.tbns.model.Magazine;

/**
 * @author Szymon Iwański
 *
 */
public interface MagazineService {

	public Magazine getMagazineByID(Long id);
	public List<Magazine> findAllMagazine();
	public void createMagazine(Magazine magazine);
	public void modifyMagazine(Magazine magazine);
	public void deleteMagazineById(Long id);
	public Magazine findMagazineById(Long id);
}
