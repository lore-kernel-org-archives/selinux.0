Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IJVJrT019588
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 15:31:19 -0400 (EDT)
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>, guttman@mitre.org (Joshua D. Guttman)
Subject: Re: Fedora Core 2 setools RPM
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: slinux)
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	<ogtpt7x10ni.fsf@mitre.org>
	<1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
	<nhak6y43hgj.fsf@malabar.mitre.org>
	<1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
	<nhafz8s3f2y.fsf@malabar.mitre.org>
	<1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 18 Jun 2004 15:31:09 -0400
In-Reply-To: <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <nhabrjg3bpe.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve --

So in some sense the bottom line is that you think the type relations
give the essential core of the policy info, and to a first
approximation one can focus on that.

Of course, it's still desirable to have access to the supplementary
information (and an idea how to interpret it) so that the further
refinement will eventually work out.  

A different point is that the main value added of slat is much more
expressive security goals (even when restricted to the types info).
You're not just talking about accessibility of a type to information
flow from another, but also whether all the possible flows go through
a desired gate type.  And the key fact you mentioned at the end of
your last message

Stephen Smalley <sds@epoch.ncsc.mil> writes:

>   But from an information flow perspective, you simply want to prove
>   that user_t can only reach sysadm_t through specific gate domains
>   like newrole_t.

is of this form:  It's apparently not expressible as a simple
information flow accessibility assertion.

Cheers --

        Joshua 



-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
