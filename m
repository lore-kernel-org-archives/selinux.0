Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA02414
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:27:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00177
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 16:25:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA00166 for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 16:25:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: losing type information under high load
Date: Fri, 27 Sep 2002 18:27:07 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209271156480.9356-300000@raven>
In-Reply-To: <Pine.GSO.4.33.0209271156480.9356-300000@raven>
MIME-Version: 1.0
Message-Id: <200209271827.07234.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Sep 2002 18:14, Stephen Smalley wrote:
> On Fri, 27 Sep 2002, Russell Coker wrote:
> > I have two machines running ReiserFS for /var/cache/squid where files
> > occasionally get changed to type system_u:object_r:file_t for no good
> > reason.
> >
> > This has happened for the last few kernel patches, with kernel 2.4.18 and
> > 2.4.19, and is not related to power failures or crashes.
>
> Or switching back and forth between a SELinux kernel and a non-SELinux
> kernel?  That could cause the file to be re-created while running a
> non-SELinux kernel, leaving it with an unspecified PSID.

Not in this case.  This has happened with machines that were not rebooted for 
any reason.

> Unless ReiserFS is dynamically remapping inode numbers (which would be
> very bad for the SELinux persistent label mapping), I don't know why you

I don't think it's doing such things.  If ReiserFS did that then SE Linux 
would not work at all, machines configured to be in enforcing mode at boot 
probably would not complete the boot process.

> The only case where SELinux resets an inode to the default file PSID is
> when the inode is deleted (the final iput with a hard link count of zero).
> This isn't strictly necessary, since the inode will be reassigned a PSID
> when it is next allocated for a new file, but is good form.  The
> first attached patch disables this code; you can try this patch if you
> like with ReiserFS to see if it makes any difference.

I'll give it a go, but it will take some time to get results.

> > However this raises another issue.  In the default policy we allow almost
> > everything read access to file_t directories, sym-links, and files.  So
> > any situation that results in a file changing to the default type (EG a
> > power failure at an inconveniant time) may make a file world-readable!!!
> >
> > Is there any reason for not restricting file_t to the administrator only?
>
> Not anymore.  The second attached patch removes general read access to
> file_t, although further testing and review is recommended.

I'll test it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
