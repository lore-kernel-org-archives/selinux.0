Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8EgKIi015986
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 09:42:20 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8EgLDE027782
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 14:42:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: dynamic context transitions
Date: Tue, 9 Nov 2004 01:42:16 +1100
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
References: <418662EE.5090001@trustedcs.com> <20041101203524.GJ9643@lkcl.net> <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411090142.16657.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 November 2004 07:25, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> >  the helper application opens files as-and-when they are needed,
> >  [and also does mkdirs? and rmdirs?] and then passes the file
> >  descriptor over a unix-domain-socket to the smbd process,
> >  which NEVER itself does file opens under a user context.
> >
> >  i believe it then no longer becomes necessary for smbd to
> >  call become_user().
>
> Except that SELinux mediates access to file descriptors upon transfer
> via local socket IPC as well as attempted use for read/write, so SELinux
> is still going to apply a permission check to the parent smbd process in
> that situation.  Not to mention that this no doubt has a significant
> cost.

The cost is only for open, creat, link, symlink, unlink, mkdir, and rmdir 
operations, which usually aren't that performance critical.  The few 
applications for which such operations are performance critical (Maildir 
format mail spool and old style INN news spool) are unlikely to be used over 
SMB.

As for allowing operations, the parent must be permitted to receive file 
handles from the child and to have read/write access to all files that the 
child processes may open.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
