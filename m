Message-Id: <200211261922.OAA21434@moss-shockers.ncsc.mil>
Date: Tue, 26 Nov 2002 14:22:21 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: RH8.0 Install problems
To: SELinux@tycho.nsa.gov, Alexander.Michael@HILL.af.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> ds: no socket drivers loaded!
> VFS: Cannot open root device "LABEL=/" or 00:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 00:00

Edit your grub.conf file and specify an explicit root device
for your SELinux kernel, e.g. root=/dev/hda2 rather than root=LABEL=/.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
