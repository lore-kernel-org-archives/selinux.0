Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69CqVrT019067
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 08:52:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69CqONR004657
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 12:52:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: policy to allow upgrade of nfs-utils
Date: Fri, 9 Jul 2004 22:52:08 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200407081319.05138.russell@coker.com.au> <1089292484.6414.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089292484.6414.17.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407092252.08749.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jul 2004 23:14, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-07-07 at 23:19, Russell Coker wrote:
> > The attached policy patch is needed to allow nfs-utils to be upgraded to
> > the latest version on a rawhide system.
>
> Should /etc/exports get its own type?

I guess so.  nfsd_etc_t or exports_t?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
