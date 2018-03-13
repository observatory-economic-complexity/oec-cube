# Cubifying raw COMTRADE Data from the OEC

The following is intended to be a one stop shop for spinning up a Mondrian Cube with COMTRADE data. Below are the steps

## Installation instructions for Ubuntu Linux

1. Install rvm + jruby
```
sudo apt install gnupg2
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=jruby
sudo apt install jruby
```
Test the installation with this command:
```
jruby -v
```
WARNING!!! NEED TO LOG OUT AND LOG BACK IN FOR RVM TO WORK!

2. Clone this repo! And check the config file to fill in your specific configuration
```
git clone https://github.com/observatory-economic-complexity/oec-cube
cd oec-cube
cat config.ru
```

3. Install dependencies
```
sudo apt install make
gem install gem-wrappers
gem install bundler
bundle install # needs to be run from project directory!
```

4. Generate wrapper script
```
rvm wrapper jruby oec-cube bundle
```

5. Run it on localhost and test that it works
```
JRUBY_OPTS=-G rackup
```
Test it in a new window:
```
curl localhost:9292/cubes
```

## Installation of Mondrian-Rest-UI

1. Install nginx and node
```
git clone https://github.com/Datawheel/mondrian-rest-ui.git
cd mondrian-rest-ui
npm i
```
2. Change settings.js

3. Build and run site
```
npm run build
npm start
```


## Steps for setup
1. Data processing for mondrian cube
2. Download from COMTRADE
3. Process data using R (using c++ magic)
    1. without pci, eci, rca etc
    2. output single CSV / year
4. Ingest to PostgreSQL DB
    1. Setup Dimension tables
    2. Import Fact tables (raw data) from step 2 CSV
5. Create schema
6. Hook up modrian-rest-ui
7. PROFIT! 🎉

## References:
1. https://github.com/jazzido/mondrian-rest-demo
2. https://github.com/cnavarreteliz/mondrian-rest-oec
