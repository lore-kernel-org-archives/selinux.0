Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B4Q2rT004223
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 00:26:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B4PtP2010314
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 00:25:56 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: too many sysadmfile?
Date: Fri, 11 Jun 2004 14:25:50 +1000
Cc: Chris PeBenito <pebenito@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <1086884579.19414.30.camel@gorn.pebenito.net> <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111425.50212.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 04:57, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> consider restricting inputs to sysadm_t, e.g. preventing sysadm_t from
> reading symlinks with non-system types to prevent an admin from
> following a malicious symlink.

The problem with restricting sym-link access is that lnk_file read access is 
required by ls to show where the link points to!  Preventing a sym-link race 
condition from making "cat something > /tmp/foo" by the administrator become
"cat something > /etc/passwd" would be good, but if it means that
"ls -l /tmp/foo" can't discover where the link points to (and therefore what 
the user is doing) then it's very inconvenient.

We could have a separate domain sysadm_ls_t which can getattr on all files and 
{ getattr read } on all lnk_files, but then we have issues of "ls -l > file" 
not working (and solving this is then a regression).

Unless we can have the kernel recognise readlink(2) as different from doing an 
open(2) which just happens to follow a sym-link then I don't think we can 
implement a painless solution to this problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
