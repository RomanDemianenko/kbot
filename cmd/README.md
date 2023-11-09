# Telegram Bot in Golang

This repository contains the code for a simple Telegram bot built with Golang. The bot is capable of responding to messages using the Telegram bot API.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Install [Golang](https://golang.org/dl/) and set up your Go environment.
- Set up your development environment. If you use [GitHub Codespaces](https://github.com/features/codespaces), all necessary settings are already configured.

### Installation

1. Clone the repository to your local machine:
    ```sh
    git clone https://github.com/RomanDemianenko/kbot.git
    cd kbot
2. Install the required dependencies:
    ```
    go get github.com/spf13/cobra
    go get gopkg.in/telebot.v3
    ```
3. Create a new bot in Telegram using [BotFather](https://t.me/botfather) and obtain a bot token.
4. Store the bot token in an environment variable named TELE_TOKEN.

### Setting Up the Bot
1. Import the necessary libraries in your Golang files.
2. Initialize a new bot object using telebot.NewBot() with the token obtained from BotFather.
3. Add a message handler to respond to text messages:
    ```
    b.Handle(telebot.OnText, func(m *telebot.Message) {
        // Your message handling logic here
    })
    ```
4. Write the handler function that will execute when a message is received.

### Building and Running
1. Compile the bot using the following command:
    ```sh
    go build -ldflags "-X="github.com/RomanDemianenko/kbot/cmd.appVersion=vX.X.X
    ```
2. Run the compiled bot:
    ```sh
    ./kbot start
    ```
### Testing the Bot
Send a message to your bot on Telegram to see it in action.

### Documentation
Refer to the [Telegram Bot API](https://core.telegram.org/bots/api) for more details on how to develop bots.

### Usage
    https://t.me/romandemianenko_bot

Send a message to the bot, and it will respond according to the logic you've implemented.