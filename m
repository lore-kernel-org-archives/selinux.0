Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KCsirT017168
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 08:54:44 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KCsdT2026199
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 12:54:43 GMT
Subject: Re: [RFC] Upstream policy handling
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Colin Walters <walters@verbum.org>
Cc: Joshua Brindle <method@gentoo.org>, Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095651232.4431.123.camel@nexus.verbum.private>
References: <414DA0A7.1000708@gentoo.org>
	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>
	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org>
	 <1095651232.4431.123.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1095684970.8397.117.camel@selinux>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 08:56:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-09-19 at 23:33, Colin Walters wrote:
> As we discussed on IRC, at least for the sysadmfile removals, there's an
> easy way to preserve the existing semantics and keep the patch
> mergeable: just use another attribute instead of sysadmfile.  

And my response was that it was not a clean way to do it imo.  I think
sysadmfile is an overused attribute.  You're suggesting adding another
attribute to fix an attribute problem.  The way I did it was to reduce
the sysadmfile types, and then add a tunable that gives back full access
if needed by using { file_type -shadow_t }, which is basically what
sysadmfile is currently.  If there are other references to sysadmfile,
they can also be replaced with the above set.  I don't see how this is
less mergeable.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
