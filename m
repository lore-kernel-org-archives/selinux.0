Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7I7oTrT018666
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 03:50:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7I7nlho002975
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 07:49:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Timothy Wood <timothy@diyab.net>
Subject: Re: [patch] setting default role from ssh
Date: Wed, 18 Aug 2004 17:50:19 +1000
Cc: Colin Walters <walters@verbum.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
   selinux@tycho.nsa.gov, Nalin The Nalinator Dahyabhai <nalin@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <1092513257.4515.28.camel@nexus.verbum.private> <1092670862.9971.20.camel@nexus.verbum.private> <41221FC2.8050403@diyab.net>
In-Reply-To: <41221FC2.8050403@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408181750.19891.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Aug 2004 01:09, Timothy Wood <timothy@diyab.net> wrote:
> It is still used.  Although the way they use it, from what I have run
> into, is more like a way to define the authentication method you want to
> use.  For example if you wanted to log in using skey you would use
>
> username:skey@hostname
>
> so maybe, as colin posted, using this
>
> username/role:selinux@hostname

What if you want to specify the role and request skey authentication?

This style option seems like a useful feature, I don't think that we want to 
have SE Linux conflict with it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
