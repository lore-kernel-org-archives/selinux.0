Message-ID: <43C406A5.2000404@tresys.com>
Date: Tue, 10 Jan 2006 14:10:29 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, SELinux-dev@tresys.com
Subject: ANN: Userspace security server update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The userspace security server CVS repository at sepolicy-server.sf.net 
has been updated. The update incorporates all recent patches including a 
recent fix to MLS in libsepol. As before this version is a prototype and 
should not be considered for production use. Current limitations include:

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
