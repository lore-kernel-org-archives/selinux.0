Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23689
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 18:45:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA27273
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:43:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA27269
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:43:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: boot loader
Date: Tue, 23 Apr 2002 00:45:03 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204221825010.5657-100000@raven>
MIME-Version: 1.0
Message-Id: <20020422224503.C7C6744A5A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 00:27, Stephen Smalley wrote:
> > Also I added devfs_t to the following line:
> > allow bootloader_t { etc_t device_t devfs_t }:dir r_dir_perms;
>
> There is one other potential issue.  If an administrator directly edits
> /etc/lilo.conf, it will revert to etc_t

Unless the administrator edits the file with vi (and not vim or at least not 
vim with the backup feature turned on).  If you use nvi or vim without 
backups then the same file will be used, hard links won't be broken, SIDs 
won't change, etc.

> (and become inaccessible to lilo
> unless it is then relabeled by the administrator).  Is there any strong
> reason to maintain a separate type on this file?  It is problematic to
> keep it in a separate type from other /etc files, since it may be directly
> modified by the administrator and it doesn't live in its own separate
> subdirectory.

/etc/lilo.conf will (on any properly configured system) contain a boot 
password for the system, which is the best way of taking over a system 
entirely without disassembling the hardware.  I think that this deserves a 
different type to world-readable files such as /etc/passwd!

I think that the situation is similar for other boot loaders.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
