<!-- Headings -->
# Data Engineering Playground
## This Project aims to set up a Data Engineering Practice environment on Local WSL with VS code IDE integration.
### Environment Details

<!-- UL -->
* Language Support
    * Java - 
    * Scala -
    * Python -

* Big Data Stack
    * Hadoop - 
    * Hive - 
    * Spark -
    * Kafka -
    * Hbase -

##### Note: Versions are cntrolled via versions.txt properties file and tested on Linux Ubuntu 20.04 

### PreRequisites
* WSL installation with Ubuntu 20
* VS Code installation on Windows


#### VS Code Integration
<!-- UL -->
* Remote WSL extension
* Go to correct wsl directory eg: 
``` bash 
/home/$USER/Codebases/bigdata-dev-env-setup
``` 
and do 
``` bash 
code .
```
This will download VS code server in WSL and allow remote development.
* Java Extension pack
* Scala Metals
* python extension
* Additional Extensions and settings
    * Bracket pair colorizer
    * format on save and autosave
    * shortcut key binding to convert uppercase and lowercase
    * Get Noctis theme :  https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis

#### Installation
* JDK 8 and 11 (Required Java 8 - Hive doesnot run on java 11 https://github.com/exasol/hadoop-etl-udfs/issues/59 and Java 11 is required for VS code Java Language server to work)
* MySQL (for hive metastore and an RDBMS)
* Hive
* Spark
* Kafka
* Hbase

It will use the below directories for package downloads, installation and data
```bash
* DOWNLOAD_DIR="/home/$USER/bigdata-downloads"
* INSTALL_DIR="/home/$USER/bigdata-installation"
* DATA_DIR="/home/$USER/bigdata-data"
```
#### Services
* mysql server - hive metastore
* spark master
* spark worker

#### Notes
<!-- UL -->
* Idea is to run as less daemons as possible - so hadoop services (yarn, hdfs) are not started, instead local file system is used.
* Spark with Hive: Spark version 3.1.2 works with hive 3.1.2
* Hive on Spark: Hive needs spark 2.3.3 to run on spark execution engine (doesn't work right now)
* Item 3

<!-- Italics -->
*This text* is italic

_This text_ is italic

<!-- Strong -->
**This text** is italic

__This text__ is italic

<!-- Strikethrough -->
~~This text~~ is strikethrough

<!-- Horizontal Rule -->

---
___

<!-- Blockquote -->
> This is a quote

<!-- Links -->
[Traversy Media](http://www.traversymedia.com)

[Traversy Media](http://www.traversymedia.com "Traversy Media")

<!-- UL -->
* Item 1
* Item 2
* Item 3
  * Nested Item 1
  * Nested Item 2

<!-- OL -->
1. Item 1
1. Item 2
1. Item 3

<!-- Inline Code Block -->
`<p>This is a paragraph</p>`

<!-- Images -->
![Markdown Logo](https://markdown-here.com/img/icon256.png)

<!-- Github Markdown -->

<!-- Code Blocks -->
```bash
  npm install

  npm start
```

```javascript
  function add(num1, num2) {
    return num1 + num2;
  }
```

```python
  def add(num1, num2):
    return num1 + num2
```

<!-- Tables -->
| Name     | Email          |
| -------- | -------------- |
| John Doe | john@gmail.com |
| Jane Doe | jane@gmail.com |

<!-- Task List -->
* [x] Task 1
* [x] Task 2
* [ ] Task 3



Get theme : https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis



## Execution

bash setup-all.sh

bash run-services.sh
