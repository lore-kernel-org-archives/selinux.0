Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17246
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 18:17:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA06690
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 22:15:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA06686
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 22:15:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: limiting types on a file system
Date: Thu, 26 Sep 2002 00:16:54 +0200
Cc: selinux@tycho.nsa.gov
References: <200209251622.02323.russell@coker.com.au> <20020925215924.GI26806@snoopy.apana.org.au>
In-Reply-To: <20020925215924.GI26806@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200209260016.54271.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Sep 2002 23:59, Brian May wrote:
> Would you want to allow the disk to be labelled based on information
> stored on that disk?

Ideally yes but within certain limits.

> I think this goes against the principles behind SE-Linux, where
> it is the system adminstrator who is in control of the system,
> not each user.

The system administrator would still be in control, they could limit which 
types a particular mount domain could create.

Currently the user can change files between user_home_t, user_netscape_ro_t, 
and user_netscape_rw_t in their home directory.  Why not allow them to store 
the same types on a floppy disk?

> Also floppy disks are typically small, and you want to maximize
> available space.

The difference between minix and ext2 is probably greater than the size of 
/...security ...

> How about a fixed type depending on who is doing the mount command,
> and what parameters they use?

That would be workable.

> (eg. so one user may want the floppy disk to save files downloaded
> from netscape, but another user may want to prevent netscape having
> any access)
>
> Are there any implications here in case the user wants to back
> up their private gpg key on floppy disk?

Yes, so the user can mount one disk for netscape to access, umount it and then 
mount a disk for the gpg private key (which netscape is not allowed to 
access) with a different type.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
