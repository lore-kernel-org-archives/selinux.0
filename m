Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA20858
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 19:43:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA13015
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 23:43:01 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id XAA13011
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2001 23:42:58 GMT
Date: Thu, 19 Apr 2001 01:42:26 +0200
From: Magosanyi Arpad <mag@bunuel.tii.matav.hu>
To: Stephen Smalley <sds@tislabs.com>
Cc: "John S. Gage" <jgage@epo.som.sunysb.edu>, selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: security enhancements outside of flask model
Message-ID: <20010419014226.C25192@bunuel.tii.matav.hu>
References: <5.0.2.1.0.20010418111107.00a8fec0@informatics.informatics.sunysb.edu> <Pine.SOL.3.95.1010418164308.21294W-100000@clipper.gw.tislabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.SOL.3.95.1010418164308.21294W-100000@clipper.gw.tislabs.com>; from sds@tislabs.com on Wed, Apr 18, 2001 at 04:45:05PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezőm azt hiszi, hogy Stephen Smalley a következőeket írta:
[]
> 
> Third, arguing that the difficulty in managing fine-grained access
> controls means that we should not have fine-grained access controls
> is illogical.  When you have a feature or some piece of functionality
> that is needed for some purpose, and that feature/functionality is
> difficult to manage, do you throw it out or do you develop higher-level
> tools to help you manage the complexity?  People have been trying to
> propose Different New Stuff for a long time now, and they have yet
> to find anything that is any better (and usually their solutions
> are far worse).
> 

And dont't forget that lotsa difficulty of administering these systems
are due to the fact that the applications does not aware of even the
notion of security policy. One metrica of the seriousness of the problem
is that name space separation is not just a handy helper, but an absolute
must for any system today implementing any MAC policy if it wants to remain
usable. That means that big part of the problem is not in the domain of
the Stuff, but in the domain of the Things That Should Have Been At Least
Orthogonal To The Stuff (see bugtraq for proof).

-- 
GNU GPL: csak tiszta forrásból

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
