Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IIpDYv031654
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 14:51:13 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3IIpBOP028230
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 18:51:12 GMT
Subject: ANN: SELinux Policy IDE (SLIDE) version 1.1
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: slide <slide@tresys.com>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 14:51:11 -0400
Message-Id: <1176922271.3611.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 1.1 of the SELinux Policy IDE (SLIDE) from Tresys is now
available for download from the Tresys Open Source website at
http://oss.tresys.com.

SLIDE is an Eclipse plug-in that integrates with the SELinux Reference
Policy to provide a development environment for building SELinux policy.

SLIDE features:

* A graphical user interface for policy development, including policy
syntax highlighting, context suggestions, and integrated compilation.
* Integration with SELinux Reference Policy, including quick lookup and
documentation for interfaces.
* Wizards and easy to use templates to automate common tasks from
creating a new SELinux policy to adding an interface into an existing
module.
* Integrated remote policy installation and audit log monitoring, to
facilitate policy testing.
* Seamless integration with the power of standard Eclipse.

Version 1.1 highlights:

* Disabled interfaces indicated in module editor.
* Improved documentation on the open source web site.
* Updates to SLIDERemote to work with SETools version 3.1.
* Support for new fields in build.conf editor.
* Fixed problems with the Console output.


If you would like to contribute, currently the best help would be to
test and provide feedback on the SLIDE plugin and SLIDE Remote.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
