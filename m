Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA12338
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 04:36:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA01446
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:34:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA01442
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:34:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tracy R Reed <treed@ultraviolet.org>
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 10:36:04 +0200
Cc: selinux@tycho.nsa.gov
References: <20021001153638.J5416@ultraviolet.org> <200210020201.46223.russell@coker.com.au> <20021001175422.A18667@ultraviolet.org>
In-Reply-To: <20021001175422.A18667@ultraviolet.org>
MIME-Version: 1.0
Message-Id: <200210021036.04427.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 02:54, Tracy R Reed wrote:
> > > But the new ps, ls, sshd, etc. do not seem to be included here. Where
> > > do I get those? Are they not in a deb?
> >
> > They are in coreutils, fileutils, shellutils, textutils, cron, dpkg, ssh,
> > login, logrotate, procps, and psmisc packages.
>
> Yes, but these are the non-SE Linux patched utils, right?

The packages on my site and on Brian's site are the SE patched ones.

> Ok, I copied that file into place. Now the error I get is:
>
> /usr/sbin/checkpolicy:  loading policy configuration from
> /etc/security/selinux/src/policy.conf
> ERROR 'name conflict for type run_deb_t' at token ';' on line 121201:
> #
> type run_deb_t, domain, privrole, privuser, privlog, auth;
> /usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.12] Error 1
>
> Upon doing some digging in policy.conf I see that type run_deb_t is indeed
> declared twice. It is declared in all.te and in all_domains.te but those
> are in /usr/share/selinux/policy/current and default. What is the
> relationship of those two dirs to /etc/selinux/domains? Looks like stuff
> has been moved around compared to the RedHat version.

This comes from run_deb.te which is supposed to be removed.  There is a bug in 
Brian's package.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
