Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KFqTrT018481
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 11:52:29 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KFqST2003151
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 15:52:28 GMT
Subject: Re: [RFC] Upstream policy handling
From: Colin Walters <walters@verbum.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Joshua Brindle <method@gentoo.org>, Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095684970.8397.117.camel@selinux>
References: <414DA0A7.1000708@gentoo.org>
	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>
	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org>
	 <1095651232.4431.123.camel@nexus.verbum.private>
	 <1095684970.8397.117.camel@selinux>
Content-Type: text/plain
Date: Mon, 20 Sep 2004 11:53:47 -0400
Message-Id: <1095695627.4431.157.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-09-20 at 08:56 -0400, Christopher J. PeBenito wrote:

> And my response was that it was not a clean way to do it imo.  I think
> sysadmfile is an overused attribute.  You're suggesting adding another
> attribute to fix an attribute problem.  The way I did it was to reduce
> the sysadmfile types, and then add a tunable that gives back full access
> if needed by using { file_type -shadow_t }, which is basically what
> sysadmfile is currently.  If there are other references to sysadmfile,
> they can also be replaced with the above set.  I don't see how this is
> less mergeable.

I'd need to see your patch, but if sysadmfile is really as close to
{ file_type -shadow_t } as you say, then that sounds fine too.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
