Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5C8K7rT009770
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:20:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5C8JwP2017948
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 04:19:59 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: SELinux on Debian (Sid)
Date: Sat, 12 Jun 2004 18:19:57 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <200406111413.40262.russell@coker.com.au> <20040611232613.GA10019@yggdrasil.localdomain>
In-Reply-To: <20040611232613.GA10019@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406121819.57709.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 12 Jun 2004 09:26, Greg Norris <haphazard@kc.rr.com> wrote:
> Speaking of which, I'm trying to install this version (new install) on
> one of my Debian sid systems.  It gets through all of the interactive
> policy prompting OK, but then croaks with the following messages:
>
>    /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>    domains/user.te:42:ERROR 'unknown type user_xserver_tmp_t' at token ';'
> on line 21459: #line 42
>    allow user_uml_t user_xserver_tmp_t:sock_file { write };
>    /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
>    make: *** [/etc/security/selinux/policy.17] Error 1

What version of the policy package?  I think I've fixed that in recent 
versions...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
