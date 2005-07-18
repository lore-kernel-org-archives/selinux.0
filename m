Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IMXVgA002776
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 18:33:31 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IMTMlV024668
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 22:29:22 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF274E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: [RFC] selinux management API
Date: Mon, 18 Jul 2005 18:31:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I want to clarify something below.

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, July 15, 2005 10:57 AM
> To: Joshua Brindle
> Cc: selinux@tycho.nsa.gov
> Subject: Re: [RFC] selinux management API
> 
> ===========================
> 
> During a teleconference meeting with Tresys, and Stephen, we 
> discussed Karl's proposal for mapping users to selinux users 
> many-to-one (see previous discussions), and several key points were
> established:
> 
> 1) Granularity at the Unix user level (and not just the selinux user
> level) is useful for implementing the categories for the MCS policy
> that Redhat is developing. As a result, we plan to move MLS categories
> from the selinux user config file into the map file (or alternative
> backend), where they can be associated with users, and not just selinux
> users. The set of accessible categories will be configured by login
> programs. Sensitivities would remain associated with selinux users.
> 

Is this just having categories available in the mapping file for users and
leaving the original MLS Range definition as per the current binary policy
in the selinux users file? 

Some simple MLS scenarios scenarios could be satisfied by a Unix user to
SELinux user mapping.   

-Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
