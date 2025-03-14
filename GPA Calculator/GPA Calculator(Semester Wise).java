import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter total number of subjects: ");
        int sub = sc.nextInt();

        double yourScore = 0, totalCredits = 0;

        for (int i = 0; i < sub; i++) {
            System.out.print("Enter grade for subject " + (i + 1) + " (S for A+, A, B, ..., F): ");
            char grade = sc.next().toUpperCase().charAt(0);

            System.out.print("Enter credits for subject " + (i + 1) + ": ");
            int credits = sc.nextInt();

            switch (grade) {
                case 'S':
                    yourScore += 10 * credits;
                    break;
                case 'A':
                    yourScore += 9 * credits;
                    break;
                case 'B':
                    yourScore += 8 * credits;
                    break;
                case 'C':
                    yourScore += 7 * credits;
                    break;
                case 'D':
                    yourScore += 6 * credits;
                    break;
                case 'E':
                    yourScore += 5 * credits;
                    break;
                case 'F':
                    // Do nothing as 'F' contributes 0 points
                    break;
                default:
                    System.out.println("Invalid grade entered for subject " + (i + 1));
                    continue; // Skip this iteration if grade is invalid
            }

            totalCredits += credits;
        }

        sc.close(); // Close the Scanner

        // Check to avoid division by zero
        if (totalCredits > 0) {
            System.out.printf("Your GPA is: %.2f%n", (yourScore / totalCredits));
        } else {
            System.out.println("No valid subjects were entered to calculate GPA.");
        }
    }
}
