Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h837D6La023184
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 03:13:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h837BYpQ024298
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 07:11:34 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id h837BXQX024295
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 07:11:34 GMT
Date: Wed, 3 Sep 2003 09:12:59 +0200
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Enable SELinux via boot parameter
Message-ID: <20030903091258.L30963@lemuria.org>
References: <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com> <1062558452.1838.52.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1062558452.1838.52.camel@chris.pebenito.net>; from pebenito@gentoo.org on Tue, Sep 02, 2003 at 10:07:32PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 02, 2003 at 10:07:32PM -0500, Chris PeBenito wrote:
> There is one thing I don't like about this.  SELinux should be by
> default on.  You should have to specify that its disabled, rather than
> the opposite.  In general if people are compiling their own kernels, and
> they want SELinux, they'll want it enabled by default, and shouldn't
> need to specify extra kernel parameters.  The distributions shipping one
> single kernel is more of a special case.

The broad public will not be using SELinux for now, so I'm afraid it's
not really a special case.

There should, however, be a kernel config option to turn it on by
default and FORCE it on. (i.e. no way to boot that kernel without SE
enabled). Otherwise we have a trivial boot security problem.

I know securing physical access to the system isn't really the scope of
SE, but it shouldn't be THAT easy.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
