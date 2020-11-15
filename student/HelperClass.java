package rs.etf.sab.student;

public class HelperClass {
	
	public static String formatirajUSkup(String... asd) {
        StringBuilder sb = new StringBuilder("(");
        for (int i = 0; i < asd.length; i++) {
        	sb.append("'");
            sb.append(asd[i]);
        	sb.append("'");
            if(i != asd.length - 1)
                sb.append(",");
            else
                sb.append(")");
        }
        return sb.toString();
    }

}
