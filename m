Date: Sun, 11 Jan 2004 23:04:24 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux@tycho.nsa.gov
Subject: Re: Module problems after 2.4 upgrade
Message-ID: <20040111220424.GC21938@rom.cip.informatik.uni-muenchen.de>
References: <1081059900.1073854917797.JavaMail.osg@spnode33>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1081059900.1073854917797.JavaMail.osg@spnode33>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* "PORTER,CHRISTOPHER B" <console@ufl.edu> [2004-01-11 22:46]:
> KERNEL: 2.4.20-8
> OS: Redhat 9 (Shrike)
> 
> I've installed the SE kernel, done make bzdisk, and done make 
> modules and make modules_install. Everything exited successfully, 
> and the floppy boots fine. However, when the system goes to start 
> various services and load modules, I get a range of problems such 
> as those that follow:
> 
> "modprobe: Can't locate module ..."
> 
> "Do you need to install insmod?"
> 
> I double-checked and made sure that loadable module support WAS 
> compiled in. I tried once before to grab new modutils but it 
> didn't pan out. Any suggestions or known problems?
 
Have you relabeled your /lib/modules? Only matters if you boot up in
enforcing mode, which is not clear from your message.

Just a random thought, because I stumbled over this two times today.

Friendly,
Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
