Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9TGUkMA001215
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 12:30:46 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9TGQGBP026647
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 16:26:17 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.5/8.13.5/Debian-3) with ESMTP id j9TGIEvq026959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sat, 29 Oct 2005 11:18:15 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: [owner@bugs.debian.org: Bug#249499 acknowledged by developer (Bug#249499: fixed in pam 0.79-1)]
References: <20050927101848.GF11050@lkcl.net>
	<1127845849.21671.73.camel@moss-spartans.epoch.ncsc.mil>
Date: Sat, 29 Oct 2005 11:18:14 -0500
In-Reply-To: <1127845849.21671.73.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Tue, 27 Sep 2005 14:30:49 -0400")
Message-ID: <871x24z48p.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Sep 2005 14:30:49 -0400, Stephen Smalley <sds@tycho.nsa.gov> said: 

> That summary looks consistent with the SELinux-related changes in
> the Fedora pam package, although one would naturally need to check
> the code for consistency.  Looking at the Fedora public CVS tree's
> pam package, I see that the main pam selinux patch was upstreamed
> into pam 0.80.  But pam-pwdbselinux.patch and
> pam-0.80-selinux-nofail.patch are separate patches in the Fedora pam
> package that don't appear to be upstream yet.

        The patches accepted in Debian are based in part of my port of
 the patches from fedora, and Debian's PAM is now patched in a manner
 close to that fedora uses. And it does seem to work for my test UML
 virtual machines.

        manoj
-- 
When the cup is full, carry it level.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
