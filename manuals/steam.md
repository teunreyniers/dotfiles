# Installation Instructions for Playing Games on Arch Linux Using Steam

## Prerequisites

Ensure your system is up to date:

```bash
sudo pacman -Syu
```

## Step 1: Install Steam

Install Steam 

```bash
sudo pacman -S steam
```

## Step 2: Install Required Dependencies

Install the necessary libraries and drivers for gaming:

```bash
sudo pacman -S mesa lib32-mesa nvidia nvidia-utils
```

*Note: Replace `nvidia` and `nvidia-utils` with your appropriate graphics drivers if you are using AMD or Intel.*

## Step 3: Enable Multilib Repository

In `/etc/pacman.conf` Uncomment the following lines:

   ```plaintext
   [multilib]
   Include = /etc/pacman.d/mirrorlist
   ```

4. Update the package database:

   ```bash
   sudo pacman -Syu
   ```

## Step 4: Install Additional Packages

Install additional packages for better gaming experience:

```bash
sudo pacman -S steam-native-runtime
```

## Step 5: Launch Steam

You can now launch Steam from your application menu or by running:

```bash
steam
```

## Step 6: Configure Steam Play (Optional)

1. In Steam, go to `Settings`.
2. Under `Steam Play`, enable `Enable Steam Play for all other titles`.
3. Select the desired compatibility tool (e.g., Proton).
