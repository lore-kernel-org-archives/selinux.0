Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13753
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 10:03:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA06518
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:01:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA06514 for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:01:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'azeredo@qmc.ufsc.br'" <azeredo@qmc.ufsc.br>, selinux@tycho.nsa.gov
Subject: Re: Problems with policy in RH8
Date: Fri, 1 Nov 2002 16:03:23 +0100
References: <72222DC86846D411ABD300A0C9EB08A10152444B@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152444B@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <200211011603.23195.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Nov 2002 15:44, Westerman, Mark wrote:
> I have run across this before. Look at  file_context/programs/postfix.fc

I don't think that the Postfix policy is related to the problem reported 
by Aldrovando.  They report problems aith atd and other programs that will 
never access files under /var/spool/postfix.

> See if the following line are in the file
>
> /var/spool/postfix/lib(/.*)?                    system_u:object_r:lib_t
> /var/spool/postfix/lib/ld.*\.so.*               system_u:object_r:ld_so_t
> /var/spool/postfix/lib/lib.*\.so.*              system_u:object_r:shlib_t
> /var/spool/postfix/lib/[^/]*/lib.*\.so.*        system_u:object_r:shlib_t
> /var/spool/postfix/lib/devfsd/.*\.so.*  system_u:object_r:shlib_t
> /var/spool/postfix/etc/services         system_u:object_r:etc_t
>
> Add to the end of the postfix context file. I have not look at the
> new version, but this problem existed on the previous version.

No, there is not a problem in the postfix policy.  The correct thing to do is 
to configure Postfix to operate without chroot mode (about 10 bytes of 
changes are required to /etc/postfix/master.cf) and to not have the files 
copied.

A good distribution will have a Postfix startup script that copies all the 
files to the chroot environment if necessary.  Hacking such a script to 
preserve the security context would be difficult.  Giving such a script 
access to write and/or relabel files to those contexts is undesirable.

Using chroot with Postfix under SE Linux is painful, undesirable, and 
unnecessary.  SE Linux will protect against attacks on Postfix much better 
than chroot() ever could.

The only down-side to this is that when you are migrating a server to SE Linux 
you may have a short period after you configure Postfix to not use chroot but 
before you go to enforcing mode.  There are a number of issues such as this 
when moving to SE Linux, this probably isn't the worst one...


PS  There is absolutely no need for a Postfix chroot to have a devfsd shared 
object.  Postfix is unable to use such a shared object, your scripts for 
creating the chroot for Postfix are buggy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
