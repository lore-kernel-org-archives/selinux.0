Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA28394
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 17:04:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA11310
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 22:04:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id WAA11306
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 22:04:04 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA04403
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 17:04:10 -0500 (EST)
Date: Fri, 9 Feb 2001 17:04:07 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200102092204.RAA05539@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: Crypto FS
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Dustin Reyes wrote:

> Will the SE Linux team (NAI Labs, NSA, etc.) be conducting
> an extensive security audit of current Linux disk encryption?
> 

No. The goals of this project are pretty specific. We are looking to
incorporate a flexible mandatory access control architecture into
Linux. We are not trying to find/fix bugs or to analyze security
components like a crypto FS to improve on their designs. That is not to
say that these activities aren't useful or needed to improve the
security of Linux in general. It is just not what we have set out to
do. The security of Linux will be improved by the addition of such
security features as those in SE Linux.

>From the point of view of this project our interest in cryptography is
really to investigate ways that the selection of cryptographic
mechanisms can be integrated with the MAC policy applying the same
principles of policy flexibility and separation of enforcement from the
policy decisions. In short we'd like to see a flexible cryptographic
usage policy which is enforced just as the system security policy is.
We hope to be able to make crypto mechanism selection decisions,
including a decision of whether crypto is even required, based on the
security contexts.

I think that these ideas should be investigated in both file system and
network implementations. Certainly cryptography defined behind a
well-defined crypto API makes this idea more feasible. Doing this for
file cryptography is still something we would like to try in the
future, but have no immediate plans. However, we do have plans to build
upon our previous work in this area for networking. We will be
integrating IKE and IPSEC with the existing MAC policy. As this work
really gets started, we'll have more to say about it.

> I know that the team hopes that the philosophy behind SE Linux's
> architecture and SE Linux itself become a standard in
> the industry, but will the strength of fs crypto be compromised,
> or not examined with the same rigor, as the rest of the
> distribution/system?

Again, the goals of our project are not to improve or certify existing
cryptography. We are interested in providing the necessary system
support to use whatever cryptography the system supports in a way that
can be tied to the mandatory access control policy. The details of the
cryptography should be independent of this support, or as much so as is
possible.

Peter Loscocco
Security-enhanced Linux Project Leader
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
