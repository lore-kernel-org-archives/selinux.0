Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QLRtrT028736
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 17:27:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QLQq76020604
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 21:26:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom London <selinux@gmail.com>
Subject: Re: reconnecting USB p rinter
Date: Mon, 27 Sep 2004 07:27:44 +1000
Cc: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <4c4ba1530409251901fa541f6@mail.gmail.com> <200409262314.37967.russell@coker.com.au> <4c4ba153040926112828a7c55@mail.gmail.com>
In-Reply-To: <4c4ba153040926112828a7c55@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409270727.44674.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 04:28, Tom London <selinux@gmail.com> wrote:
> That's not right, is it? Shouldn't cupsd be running in cupsd_t?

Correct.

> The following patch adds a
> domain_auto_trans(hald_t, cupsd_exec_t, cupsd_t)
> to cups.te

Good work, I've put that in my tree.

Also we should remove the can_exec_any() from hald.te ASAP, it's a time bomb 
allowing large numbers of undesired programs to run in hald_t.

> This makes the 'new' cupsd run in cupsd_t.
> This doesn't fix everything, as there are still about 170 AVCs.
>
> Do we need to add a bunch of 'domain_auto_trans' rules for
> hald_t (for apmd_t, crond_t, ......)?  dontaudits?

I'll look into that later.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
