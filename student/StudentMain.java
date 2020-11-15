
package rs.etf.sab.student;

import rs.etf.sab.operations.AddressOperations;
import rs.etf.sab.operations.CityOperations;
import rs.etf.sab.operations.CourierOperations;
import rs.etf.sab.operations.CourierRequestOperation;
import rs.etf.sab.operations.DriveOperation;
import rs.etf.sab.operations.GeneralOperations;
import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.operations.StockroomOperations;
import rs.etf.sab.operations.UserOperations;
import rs.etf.sab.operations.VehicleOperations;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;


public class StudentMain {

    public static void main(String[] args) {
        AddressOperations addressOperations = new sa150288_AddressOperations(); // Change this to your implementation.
        CityOperations cityOperations = new sa150288_CityOperations(); // Do it for all classes.
        CourierOperations courierOperations = new sa150288_CourierOperations(); // e.g. = new MyDistrictOperations();
        CourierRequestOperation courierRequestOperation = new sa150288_CourierRequestOperation();
        DriveOperation driveOperation = new sa150288_DriveOperation();
        GeneralOperations generalOperations = new sa150288_GeneralOperations();
        PackageOperations packageOperations = new sa150288_PackageOperations();
        StockroomOperations stockroomOperations = new sa150288_StockroomOperations();
        UserOperations userOperations = new sa150288_UserOperations();
        VehicleOperations vehicleOperations = new sa150288_VehicleOperations();
        
        //DB.getInstance();


        TestHandler.createInstance(
                addressOperations,
                cityOperations,
                courierOperations,
                courierRequestOperation,
                driveOperation,
                generalOperations,
                packageOperations,
                stockroomOperations,
                userOperations,
                vehicleOperations);

       TestRunner.runTests();
        
    }
}
