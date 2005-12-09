Message-ID: <4399F00C.7040106@tresys.com>
Date: Fri, 09 Dec 2005 15:58:52 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: ANN: userspace security server prototype
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A prototype of the SELinux userspace security server has been released.
The userspace security server provides access decisions to userspace
object managers, rather than forcing them to use the kernel for access
control decisions. This version has several limitations and should not
be considered for production use. Those issues include:
- mls issues in the libsepol security server
- no setbool support (need to figure out access control on booleans)
- no load policy support (policy loaded at startup)
- no enforcement on setenforce
- no routing is done, all userspace requests go to the USS if it is 
enabled, unless the USS cannot be contacted, this is to allow a system 
to boot up properly and will be addressed

To test the uss check out the cvs module with:

cvs -z3
-d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/sepolicy-server co -P uss

make and install the tree (it was synchronized with the nsa tree on
2005-12-08). Then add the following to /etc/selinux/config

[ss]
name=uss
location=/var/run/uss
update=/var/run/uss-update

and copy the uss.conf from the uss directory to /etc/selinux (and change
any options you want)

finally, run ./uss and use any userspace object manager to see the results.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
