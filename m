Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5R8xArT007353
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 04:59:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5R8wr5h004798
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 08:58:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: fsck deleting extended attributes
Date: Sun, 27 Jun 2004 18:58:24 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040626220355.GL3559@lkcl.net>
In-Reply-To: <20040626220355.GL3559@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406271858.24058.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 27 Jun 2004 08:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> the issue is that if a system is switched off without shutdown and
> the filesystem is damaged, such that some extended attributes are
> deleted on an fsck, that's it - the file cannot be accessed!

The fact that a file without a label is inaccessible to most programs is a bug 
not a feature.  You wouldn't want /etc/shadow to lose it's label and give 
away passwords...

No matter what you do there are situations in which a file system can be 
messed up beyond the ability of fsck to fix it.  By default there are many 
situations in which fsck will want to operate in manual mode (you have to 
edit something under /etc to have fsck run with -f to have it recover from 
most errors without intervention).

> i am setting up a system where the users will NOT be told what
> the root password is, nor will they be given a user login
> (they will be given an automatic KDE login), and there is
> ABSOLUTELY no chance of either user support or admin support.

How about mounting the root fs R/O so that it can't be messed up and then 
having /var and /home relabelled on some schedule (eg every 5th boot).

> a) get fsck.ext2 fixed?

I think it's already as good as it's going to get in this regard.

> b) forcibly run make -C /etc/selinux relabel from /etc/init.d/checkfs.sh

Yes, but not every boot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
