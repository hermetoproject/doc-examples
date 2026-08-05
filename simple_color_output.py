"""Simple Python program outputting color text to the terminal."""

from colored import Back, Fore, Style


def main() -> None:
    print(
        Fore.white
        + Back.green
        + Style.bold
        + "Hello colorful World!"
        + Style.reset
    )


if __name__ == "__main__":
    main()
