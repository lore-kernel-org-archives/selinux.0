Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IK9crT019878
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 16:09:38 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5IK9Spw015256
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 20:09:28 GMT
Subject: Re: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>
In-Reply-To: <nhabrjg3bpe.fsf@malabar.mitre.org>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	 <ogtpt7x10ni.fsf@mitre.org>
	 <1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
	 <nhak6y43hgj.fsf@malabar.mitre.org>
	 <1087581080.27697.132.camel@moss-spartans.epoch.ncsc.mil>
	 <nhafz8s3f2y.fsf@malabar.mitre.org>
	 <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil>
	 <nhabrjg3bpe.fsf@malabar.mitre.org>
Content-Type: text/plain
Message-Id: <1087589345.27697.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 16:09:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-18 at 15:31, Joshua D. Guttman wrote:
> So in some sense the bottom line is that you think the type relations
> give the essential core of the policy info, and to a first
> approximation one can focus on that.

I'd put it a bit more strongly, but close enough.

> Of course, it's still desirable to have access to the supplementary
> information (and an idea how to interpret it) so that the further
> refinement will eventually work out.  

Fair.

> A different point is that the main value added of slat is much more
> expressive security goals (even when restricted to the types info).
> You're not just talking about accessibility of a type to information
> flow from another, but also whether all the possible flows go through
> a desired gate type.  And the key fact you mentioned at the end of
> your last message

I may be wrong, but I think that you can determine this information via
libapol as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
