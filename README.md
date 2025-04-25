# Academic Progress Tracker Smart Contract

This smart contract enables students to register, update, and retrieve their academic profiles on the blockchain. It stores and manages important educational information such as courses, goals, academic progress metrics, and estimated graduation dates.

## Features

- **Create Academic Profile**: Students can create their academic profile with details like name, semester count, credits earned, study hours, goals, and enrolled courses.
- **Modify Academic Profile**: Allows students to update their academic information to reflect ongoing progress.
- **Retrieve Academic Profile**: Fetch a student's full academic profile, including all metrics and enrolled courses.
- **Course Enrollment Data**: Retrieve just the course enrollment details for departmental planning.
- **Academic Objective**: Retrieve the student's career or educational goal.
- **Graduation Estimate**: Calculate an estimated graduation date based on current progress and typical program length.

## Installation

To deploy this smart contract, you'll need to use the [Clarity SDK](https://github.com/blockstack/clarity). Ensure you have the necessary setup to interact with the Stacks blockchain.

### Prerequisites
- Clarity SDK
- A working Clarity environment or testnet setup

### Deploying
1. Clone this repository:
    ```bash
    git clone https://github.com/<your-username>/academic-progress-tracker.git
    cd academic-progress-tracker
    ```

2. Deploy the contract to a blockchain environment.

## Contract Functions

- **create-academic-profile**: Registers a new academic profile for a student.
- **modify-academic-profile**: Updates an existing academic profile.
- **retrieve-academic-profile**: Retrieves the full academic profile.
- **retrieve-student-courses**: Retrieves the list of enrolled courses for a student.
- **retrieve-student-objective**: Retrieves the student's academic or career objective.
- **calculate-graduation-estimate**: Estimates the remaining semesters to graduation.

## Error Codes

- `ERR-RECORD-NOT-FOUND`: Profile does not exist.
- `ERR-RECORD-ALREADY-EXISTS`: Profile already exists for this student.
- `ERR-INVALID-SEMESTER-COUNT`: Invalid semester count provided.
- `ERR-INVALID-FULL-NAME`: Invalid full name provided.
- `ERR-INVALID-CREDITS`: Invalid credits provided.
- `ERR-INVALID-STUDY-HOURS`: Invalid study hours provided.
- `ERR-INVALID-OBJECTIVE`: Invalid academic objective provided.
- `ERR-INVALID-COURSES`: Invalid course data provided.

## Contributing

If you'd like to contribute to the project, feel free to fork the repository and submit a pull request. Make sure to include tests for new features and bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
