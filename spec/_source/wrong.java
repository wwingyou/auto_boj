import java.util.*;

public class wrong {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    int n = scanner.nextInt();
    int result = 0;
    for (int i = 1; i <= n; i++) {
      result -= i;
    }
    System.out.println(result);
  }
}
