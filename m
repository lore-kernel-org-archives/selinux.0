Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15356
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 12:30:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA10133
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 17:27:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA10081
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 17:26:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, selinux@tycho.nsa.gov
Subject: Re: Problems with policy in RH8
Date: Fri, 1 Nov 2002 18:27:30 +0100
References: <72222DC86846D411ABD300A0C9EB08A10152444C@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152444C@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <200211011827.30404.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Nov 2002 16:15, Westerman, Mark wrote:
> On Friday, November 01, 2002 9:03 AM Russell Coker wrote:
> > I don't think that the Postfix policy is related to the  problem reported
> > by Aldrovando.  They report problems aith atd and other
> > programs that will never access files under /var/spool/postfix.
>
> The problem I was talking about is in Red Hat, the files
> /var/spool/postfix/lib are hard linked (shareing the same
> inode) to the orginal location.

Well that's one reason for not using hard-links to put files in a chroot!  The 
other reason is that a process that has root access in the chroot environment 
will be able to write to them...

> The setfile utilities uses
> the last defination and was relabeling the libs with var_spool_t
> adding the label definations to the postfix.fs fix the problem.

What happens if you add the following:
/var/spool/postfix/(lib)|(etc)(/.*)? <<null>>

That should result in the files under the chroot not being considered as part 
of file labelling decisions (which among other things means that if you 
change the entries for the libs you only need to make a change in one place).

> I was having same problem about the libs being labeled var_spool_t
> and the previous Information I supplied correctd the problem

Or alternately Red Hat could be fixed to not use hard links and to not do 
anything about the chroot unless master.cf references chroot environments.  
The Debian package of Postfix is so much better.

> PS: This should be added into the distribution as a patch
>
> file: file_contexts/program/postfix.fc
> /var/spool/postfix/flush(/.*)? system_u:object_r:postfix_spool_flush_t
> /var/spool/postfix/lib(/.*)?                    system_u:object_r:lib_t
> /var/spool/postfix/lib/ld.*\.so.*               system_u:object_r:ld_so_t
> /var/spool/postfix/lib/lib.*\.so.*              system_u:object_r:shlib_t
> /var/spool/postfix/lib/[^/]*/lib.*\.so.*        system_u:object_r:shlib_t
> /var/spool/postfix/lib/devfsd/.*\.so.*  system_u:object_r:shlib_t
> /var/spool/postfix/etc/services         system_u:object_r:etc_t

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
