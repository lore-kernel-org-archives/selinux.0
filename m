Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CD2krT001679
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:02:46 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CD2NDC003895
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:02:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: policy to allow upgrade of nfs-utils
Date: Mon, 12 Jul 2004 23:02:35 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200407081319.05138.russell@coker.com.au> <200407111904.24856.russell@coker.com.au> <1089637087.22449.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089637087.22449.47.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407122302.35515.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2004 22:58, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Sun, 2004-07-11 at 05:04, Russell Coker wrote:
> > A patched version of vi should solve that.  In any case if the file gets
> > etc_t then it is just readable to everyone which isn't so bad.  The only
> > potential problem is if you edit the file with an unpatched editor and
> > delete all content so that initrc_t will want to append "#" to it.
> >
> > What do you think of the attached patch?
>
> Looks ok, but is it sufficient, i.e. does it only require permission to
> write to the existing /etc/exports, or does it need to be able to unlink
> and re-create the file?

The init script only requires append permission.  Of course other programs 
need read access which my patch didn't grant, so it's not complete in that 
regard.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
