# AWS ngrok

## How to run your own ngrokd server

### 1. Launch from AMI

Launch EC2 virtual machine.

#### Security Group

* 22 - ssh
* 80 - ngrok
* 443 - ngrok for https
* 4443 - Tunneling connections
* 8080 - Clients download

### 2. Modify your DNS

You need to use the DNS management tools given to you by your provider to create an A
record which points *.example.com to the IP address of the server where you will run ngrokd.

### 3. Run the server

You'll run the server with the following command.

```
ngrokd -domain="example.com"
```

### 4. Download the client software

Please download client software from the following url.

* windows_amd64.zip
* darwin_amd64.zip

```
http://example.com:8080/
```

### 5. Configure the client

In order to connect with a client, you'll need to set two options in ngrok's configuration file. The ngrok configuration file is a simple YAML file that is read from ~/.ngrok by default. You may specify a custom configuration file path with the -config switch. Your config file must contain the following two options.

```
server_addr: example.com:4443
trust_host_root_certs: true
```

### 6. Connect with a client

Then, just run ngrok as usual to connect securely to your own ngrokd server!

```
./ngrok 80
```

If you use the Vagrant.

```
./ngrok 192.168.33.10:80
```

## Other information.

* https://ngrok.com/
* https://github.com/inconshreveable/ngrok/tree/master/docs


