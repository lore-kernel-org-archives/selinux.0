Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BGrArT025112
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 12:53:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BGqE9R024288
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 16:52:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: initscripts sysv se2
Date: Sun, 12 Sep 2004 02:53:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040910181322.GS14060@lkcl.net>
In-Reply-To: <20040910181322.GS14060@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409120253.02597.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Sep 2004 04:13, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i raised the bug about /etc/mtab on debian, they said it's not
> critical to debian because i'm using patched versions of initscripts.

What patches are you using on the init scripts?  My patch to sysvinit only 
changes /sbin/init itself, the scripts remain the same.

Who said that it's not critical to Debian?  Where did they say it?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
