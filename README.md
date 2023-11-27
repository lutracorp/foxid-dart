<p align="center">
    <a href="" rel="noopener">
    <img width=200px height=200px src="https://git.kasefuchs.su/foxcordchat/branding/raw/branch/main/subprojects/foxid/logo.svg" alt="FOxID logo"></a>
</p>

<h3 align="center">FOxID</h3>

---

<p align="center"> Floof Object IDentifier
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Specification](#specification)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

Here at FoxCord, we spent a long time deciding between Snowflake and ULID, but each had its own disadvantages, and in the end we decided to create our own identifier format that includes the advantages of both. FOxID is a 128-bit identifier that is encoded using Crockford's Base32 and includes timestamp, generator identifier and two security measures against duplicate identifiers.

## 🏁 Getting Started <a name = "getting-started"></a>

### Prerequisites

```
Dart SDK: >=2.18.0 <4.0.0
```

### Installing

With Dart:

```shell
$ dart pub add foxid
```

With Flutter:
```shell
$ flutter pub add foxid
```

## 🎈 Usage <a name="usage"></a>

Usage examples can be found on [Forgejo](https://git.kasefuchs.su/foxcordchat/foxid/src/branch/main/example) and [GitHub](https://github.com/foxcordchat/foxid/tree/main/example) or directly on [pub.dev](https://pub.dev/packages/foxid/example)

## 📑 Specification <a name = "specification"></a>

### 🪛 Structure

Bit breakdown for an FOxID e.g. `065DTQHTA65T6JGMGBCTXT9P1M` (counter is `8575406`, random is `15283725`, datacenter is `35747` and worker is `18964`) looks like this:

```
 000000011000101011011101010111100011101001010001 1000101110100011 0100101000010100 100000101101100110101110 111010010011011000001101
                                                                                                            |------------------------| 24-bit random
                                                                                   |------------------------|                          24-bit counter
                                                                  |----------------|                                                   16-bit worker id
                                                 |----------------|                                                                    16-bit datacenter id
                                                 |----------------+----------------|                                                   32-bit generator id
|------------------------------------------------|                                                                                     48-bit timestamp
```

### ⚙️ Components

#### 🕒 Timestamp

UNIX-time in milliseconds since epoch.

- 48-bit unsigned integer.

#### 🆔 Generator ID

Identifier of this generator.

> **Note**
> You can combine datacenter and worker ids to get an even larger field which can contain 32-bit unsigned integers.

##### 🖥️ Datacenter ID

Identifier of datacenter on which FOxID generator is running.

- 16-bit unsigned integer.

##### 👷 Worker ID

Identifier of worker on which FOxID generator is running (e.g. process id).

- 16-bit unsigned integer.

#### 🧮 Counter

Incrementing number to prevent ID conflict.

- 24-bit unsigned integer.

#### 🎲 Random

Random number to prevent ID conflict.

- 24-bit unsigned integer.

### 📦 Encoding

Each FOxID is a big endian byte buffer. Which can be represented as a string using [Crockford's Base32](https://www.crockford.com/base32.html) encoding.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- [ULID](https://github.com/ulid/spec)
- [Snowflake](https://developer.twitter.com/en/docs/twitter-ids)
