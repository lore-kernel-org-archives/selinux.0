Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8Q9rHrT026757
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 05:53:17 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8Q9rGhU003248
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 09:53:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Remove unrestricted_admin
Date: Sun, 26 Sep 2004 19:53:10 +1000
Cc: Dale Amon <amon@vnl.com>, "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <20040925220708.GB15912@vnl.com> <415609AD.5000808@tresys.com>
In-Reply-To: <415609AD.5000808@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409261953.10585.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 Sep 2004 10:13, Joshua Brindle <jbrindle@tresys.com> wrote:
> I _really_ hope you aren't suggesting that you do a dd from a host disk
> to something else while a machine is in production. This _will_ lead to
> an inconsistant image and I don't think I need to explain why.

Unless you use LVM snapshots or a split RAID-1.

> This corner case shouldn't determine what is in the default policy, but
> I'm not even sure that is what we are talking about here, Russell never
> said how he wants this implemented (keep the unrestricted_admin macro or
> put that unrestricted fixed disk access in the standard policy. At any
> rate, I hope very much that noone expects or desires that this be put in
> unconditionally. Raw disk access is a very obvious attack vector and
> must be treated as such, period.

Restrictions don't matter that much to any domain which can do
"echo 0 > /selinux/enforce".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
