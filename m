Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TJHerT018398
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 15:17:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TJGanY002112
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 19:16:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ReiserFS
Date: Thu, 30 Sep 2004 05:17:35 +1000
Cc: fedora-selinux-list@redhat.com
References: <200409300512.44632.russell@coker.com.au>
In-Reply-To: <200409300512.44632.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409300517.35322.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Sep 2004 05:12, Russell Coker <russell@coker.com.au> wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134111
>
> We are having some discussions of ReiserFS in the Red Hat bugzilla.
>
> fs_use_xattr reiserfs system_u:object_r:fs_t;
>
> It seems to me that the easiest solution is to remove the above line from
> fs_use and add the following to genfs_contexts:
>
> genfscon reiserfs /                     system_u:object_r:nfs_t

allow mount_t unlabeled_t:dir search;

I almost forgot to mention that mount_t needs search access to a directory of 
type unlabeled_t for the above hack to work.  Not sure why, but it's fairly 
harmless.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
