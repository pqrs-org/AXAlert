AXAlert
=======

AXAlert shows an alert message when "access for assistive devices" is enabled.

"access for assistive devices" provides very useful API and many excellent utilities use it.
But that API is too powerful. It allows all apps to steal your keyboard events via such API.

AXAlert is useful if you don't want to enable "access for assistive devices".


Web pages
---------

* master: https://pqrs.org/macosx/AXAlert/


System requirements
-------------------
Mac OS X 10.7 or higher.


How to build
------------

Requirements:

* OS X 10.8
* Xcode 4.5+
* Command Line Tools for Xcode

### Step1: Getting source code

Execute a following command in Terminal.app.

<pre>
git clone --depth 10 https://github.com/tekezo/AXAlert.git
</pre>

### Step2: Building a package

Execute a following command in Terminal.app.

<pre>
cd AXAlert
make package
</pre>

Then, AXAlert-VERSION.app.zip has been created in the current directory.
It's a distributable package.


**Note:**<br />
Build may be failed if you changed environment values or changed /usr/bin files.<br />
Use clean environment (new account) if build was failed.
