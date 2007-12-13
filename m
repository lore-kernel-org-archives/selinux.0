Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDDSs5v011973
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 08:28:54 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBDDSq3i016426
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 13:28:53 GMT
Subject: ANN: SELinux Policy IDE (SLIDE) version 1.3
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: slide <slide@tresys.com>
Content-Type: text/plain
Date: Thu, 13 Dec 2007 08:28:52 -0500
Message-Id: <1197552532.3555.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 1.3 of the SELinux Policy IDE (SLIDE) from Tresys Technology is
now available for download from the Tresys Open source website at
http://oss.tresys.com.

SLIDE is an Eclipse plug-in that integrates with the SELinux Reference
Policy to provide a development environment for building SELinux policy.

SLIDE Features:

* A graphical user interface for policy development, including policy
syntax highlighting, context suggestions, and integrated compilation.
* Integration with SELinux Reference Policy, including quick lookup and
documentation for interfaces and macros.
* Wizards and easy to use templates to automate common tasks from
creating a new SELinux policy to adding an interface into an existing
module.
* Integrated remote policy installation and audit log monitoring, to
facilitate policy testing.
* Integration with SETools to provide many analysis and auditing
features.
* Seamless integration with the power of standard Eclipse.

Version 1.3 highlights:

* Graphical interface for editing user and rolemap files.
* Modified syntax coloring to include attributes, classes, permissions,
roles, type and users.
* Integration with SETools 3.3 to include some basic analysis features
including TE Rule searching and Domain Transition Analysis.
* Integration with audit2allow to provide quick and easy way to convert
one or more audit denials into call to interfaces or allow rules.
* New 'Open Module' dialog to quickly find and open any module based on
name.
* Improved documentation on the open source web site.
* Updates to work with SETools version 3.3.
* Fixed problems with the Console output.
* Bugs fixed with undo/redo when toggling commenting on numerous lines
of policy.


If you would like to contribute, currently the best help would be to
test and provide feedback on the SLIDE plugin and SLIDE Remote.

Dave Sugar
Tresys Technology, LLC



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
