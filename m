Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KCR4rT016954
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 08:27:04 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KCR3T2025450
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 12:27:04 GMT
Message-ID: <414ECC8C.9080801@redhat.com>
Date: Mon, 20 Sep 2004 08:26:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
   selinux <selinux@tycho.nsa.gov>, Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
References: <414DA0A7.1000708@gentoo.org>	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org> <1095651232.4431.123.camel@nexus.verbum.private>
In-Reply-To: <1095651232.4431.123.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think we do want to start moving strict policy back.  A lot of the 
changes and tunables we added were to make
SELinux work in a mainstream operating system.  This finally led us to 
the targeted policy which can satisfy our
desire to add some SELinux functionality to the Masses without leading 
them to turn it off and worse bury our
support centers with calls.  :^(  I see even targeted policy slowly 
moving toward strict policy over then next few
years as we better undestand how MAC can work in a mainstream operating 
system.

So I have no problem with moving strict policy back towards a more 
strict behavior and the elimination of some tunables.
(Singleuserdomain should be eliminated).  Some of the unlimitedXYZ 
should be removed also, as long as the people using
strict policy can put up with the pain, and it would probably force us 
to fix some more applications. 

As far as the policy having a Red Hat bent, this is because we have 
probably submitted more patches to policy then any other
distro.  

I would like to get to the point that policy-sources would only be 
installed like kernel-sources is now.  IE only required for
developers. 

Allowing sysadmin's to configure policy via booleans is in my opinion a 
much better way to go.

I believe that having Stephen and NSA as being the final Policy CZar is 
the way to go and I worry about distributions, not
submitting the patches to policy for peer review.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
