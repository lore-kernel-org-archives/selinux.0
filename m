Message-ID: <1081059900.1073854917797.JavaMail.osg@spnode33>
Date: Sun, 11 Jan 2004 16:01:57 -0500 (EST)
From: "PORTER,CHRISTOPHER B" <console@ufl.edu>
To: SELinux@tycho.nsa.gov
Subject: Module problems after 2.4 upgrade
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KERNEL: 2.4.20-8
OS: Redhat 9 (Shrike)

I've installed the SE kernel, done make bzdisk, and done make 
modules and make modules_install. Everything exited successfully, 
and the floppy boots fine. However, when the system goes to start 
various services and load modules, I get a range of problems such 
as those that follow:

"modprobe: Can't locate module ..."

"Do you need to install insmod?"

I double-checked and made sure that loadable module support WAS 
compiled in. I tried once before to grab new modutils but it 
didn't pan out. Any suggestions or known problems?


Thank you,


Christopher Porter
console@ufl.edu


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
