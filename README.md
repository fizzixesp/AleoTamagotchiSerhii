# 🐾 Tamagotchi Leo Project 🐾

Discord: fizzixesp

Welcome to the Tamagotchi Project, a nostalgic virtual pet blockchain game revived with the power of Aleo's Leo programming language. Nurture your digital companions in an immersive environment that combines the charm of classic Tamagotchi with modern blockchain technology.

<!-- TOC -->
* [🐾 Tamagotchi Leo Project 🐾](#-tamagotchi-leo-project-)
  * [🐶 Project Overview](#-project-overview)
    * [🍽️ Feeding Your Pet](#-feeding-your-pet)
    * [🎈 Playing with Your Pet](#-playing-with-your-pet)
    * [🚑 Healing Your Pet](#-healing-your-pet)
  * [📝 Essential Transitions](#-essential-transitions)
  * [🛠 Installation & Setup](#-installation--setup)
  * [⚖️ License](#-license)
  * [🤝 Contributing](#-contributing)
  * [🙏 Acknowledgements](#-acknowledgements)
<!-- TOC -->

## 🐶 Project Overview

In this virtual pet world, you're tasked with caring for your pet's well-being by managing its:

- Saturation
- Health
- Happiness
- Block heights for creation, updating, feeding, and playing.

Pets start with a saturation, health, and happiness value of `8640`, ensuring 12 hours of carefree life considering an average block time of 5 seconds. Keep your pet satiated to maintain its health and happiness, or face the consequences of neglect.

### 🍽️ Feeding Your Pet

Feed your pet with a variety of dishes to maintain its saturation, and indirectly, its health and happiness. Below is the menu of available dishes:

| Dish ID | Dish Type            | Cost ($ALEO) | Saturation Increase | Happiness Increase | Health Increase | Health Decrease |
|---------|----------------------|--------------|---------------------|--------------------|-----------------|-----------------|
| 0       | Basic Food           | 2            | 2000                | -                  | -               | -               |
| 1       | Healthy Salad        | 5            | 3000                | 1000               | 1000            | -               |
| 2       | Deluxe Meal          | 10           | 4000                | 3000               | -               | -               |
| 3       | Sweet Treat          | 3            | 1000                | 2000               | -               | 500             |
| 4       | Energizing Smoothie  | 7            | 2000                | 2000               | 2000            | -               |

### 🎈 Playing with Your Pet

Every 500 blocks, take a moment to play with your pet using toys to boost their happiness and, sometimes, affect their health. Here's the toy chest:

| Toy ID | Toy Type       | Cost ($ALEO) | Happiness Increase | Health Decrease |
|--------|----------------|--------------|--------------------|-----------------|
| 0      | Ball           | 1            | 1000               | -               |
| 1      | Frisbee        | 2            | 2000               | -               |
| 2      | Puzzle         | 2            | 3000               | 1000            |
| 3      | Cat Tree       | 2            | 2000               | 500             |
| 4      | Laser Pointer  | 3            | 1000               | -               |

### 🚑 Healing Your Pet

When your pet's health hits zero, it's time for some healing! Choose from several medical treatments to restore their vitality:

| Variant ID | Treatment Type    | Cost ($ALEO) | Health Increase |
|------------|-------------------|--------------|-----------------|
| 0          | Basic Medicine    | 15           | 500             |
| 1          | Advanced Medicine | 27           | 1000            |
| 2          | Deluxe Medicine   | 50           | 2000            |
| 3          | Miracle Cure      | 90           | 4000            |

## 📝 Essential Transitions

Your pet's life cycle is managed through a series of smart contract functions:

- `top_up_balance`: Ensure your pet's account has enough $ALEO tokens for their needs.
- `create`: Begin your journey by creating a new pet with a secret key and the current block height.
- `update`: Regularly update your pet's status to keep track of their well-being.
- `feed`: Choose from a diverse menu to nourish your pet.
- `play`: Engage in playful activities to boost happiness.
- `heal`: When health runs low, provide your pet with the necessary medical attention.

Remember, all pets live on the blockchain, providing a secure and permanent home for your digital companion.

## 🚀 Launch Instructions

To interact with your Tamagotchi pet on the Aleo blockchain using Leo, you'll need to run and execute Leo programs. For detailed instructions on how to do this, please refer to the official [Leo Commands Guide](https://developer.aleo.org/leo/commands).

## 🔗 Useful Links

- [Leo Documentation](https://developer.aleo.org/leo/) - Learn more about the Leo programming language.
- [Aleo Website](https://aleo.org/) - Discover more about the Aleo project and its features.

## 🐱‍💻 Ready to Play?

With the Leo commands at your fingertips and your digital pet eager for attention, you're all set to embark on a delightful journey of pet care on the blockchain. Let the adventures begin!

## ⚖️ License

This project is released under the MIT License. Enjoy your digital pet caring experience with full freedom!

## 🤝 Contributing

We welcome contributions and suggestions! Feel free to fork, submit PRs, or open issues to help improve the Tamagotchi Leo experience.

## 🙏 Acknowledgements

A heartfelt thanks to the Aleo project for empowering decentralized applications with privacy by default.

---

Embrace the joy of virtual pet care reimagined with blockchain technology. Happy pet parenting!


