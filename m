Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i627KBrT012118
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 03:20:11 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i627Jsel027210
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 07:19:55 GMT
Date: Fri, 2 Jul 2004 07:15:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jan Gehring <pr0gm4@linoratix.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Compiling error - sysvinit
Message-ID: <20040702071544.GA3277@lkcl.net>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040702134850.353b2f51.pr0gm4@linoratix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jan, hi,

under what system are you doing the compiling, if debian,
have you done apt-get build-dep sysvinit?

l.

On Fri, Jul 02, 2004 at 01:48:50PM +0200, Jan Gehring wrote:
> Hello ml,
> 
> i tried to compile sysvinit-2.85 but i get the following error.
> 
> root@maracuja src # make LDFLAGS="-s -lselinux" CFLAGS="-D_GNU_SOURCE"
> cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
> [...]
> init.c:97: error: `SELINUXMNT' undeclared (first use in this function)
> [...]
> init.c:123: error: `SELINUXPOLICY' undeclared (first use in this function)
> make: *** [init.o] Error 1
> 
> 
> What am i doing wrong?
> 
> Thanks for any help
> 
> Jan
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
