Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71CsLrT006829
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 08:54:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71Crl52021416
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 12:53:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Date: Sun, 1 Aug 2004 22:54:15 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040801103252.GC7384@lkcl.net>
In-Reply-To: <20040801103252.GC7384@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408012254.15553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 20:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> there appears to be quite a lot of things missing from the
> debian selinux-policy-default package.
>
> - the appconfig directory
> - the targeted directory
> - the strict directory.

There is no support for targeted in Debian, only strict and it has the 
directory name "." .

> so, i can't use run_init because targeted/contexts/initrc_context
> doesn't exist.

Your /etc/selinux/config file should have the following line:
SELINUXTYPE=.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
