Message-ID: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: SELinux@tycho.nsa.gov
Subject: SELinux RPM Version
Date: Fri, 19 Apr 2002 15:26:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I expect to release a beta version to sourceforge 
of an rpm package of SELinux next week.

Current Configuration.

/etc/selinux/policy	The main policy directory 
If the directory does not exist then the rpm 
packages will create it and install example policy files.

/etc/selinux/setfiles	Same for the policy directory

The example policy is installed
/usr/share/doc/selinux/examples/policy


Flask files
/usr/lib/flask

Libsecure
/usr/lib/libsecure.a

All the added programs for selinux such as newrole
will be install into /usr/bin

The include directory
/usr/include/selinux

All packages such as 
fileutils-4.1-4

have been renamed to

fileutils-selinux-4.1-4

This packages provides: fileutils

The provides is so other rpms can 
meet requirements. 

All packages have been build for original spec files
with the selinux patch added. So the will install into
normal locations. 

the --replacefiles option must be used when installing.

Comments or suggestions


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
