Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KB7OgA014876
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 07:07:24 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KB30Dg017020
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 11:03:00 GMT
Subject: Re: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <20050720095524.GK8851@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com>
	 <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com>
	 <20050719215424.GA8851@lkcl.net>
	 <1121815377.15541.15.camel@localhost.localdomain>
	 <20050720095524.GK8851@lkcl.net>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 07:04:52 -0400
Message-Id: <1121857492.24646.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Instead
> > we will be mapping many Unix users to few SElinux users,
> > which may also be called security "classes". The default
> > class would also be configurable (not hardcoded on user_u).
> 
>  sounds good (and also after a bit of thought for 10 mins it
>  clears up the abiguity above)
> 
>  is this "requirements specification" or "functional spec"?

Like I said, no formal specification or requirements exist
at this time. The project I am working on is to integrate
shadow-utils and similar code with selinux user management.
The requirements we have are basically that we want useradd 
to be able to configure selinux parameters (whatever those are)
for the user, usermod to modify those, and userdel to remove 
selinux data relating to the user being deleted.

Based on discussions, it seems appropriate to implement this
map-to-security class idea as part of reaching this objective.

> > It is also being proposed to 
> > place this code in pam, but I don't see how this will work at 
> > all - if you place code in pam, than all the code that doesn't
> > use pam (and there's already a few planned callers - admin
> > programs) cannot make use of it, and has to write its 
> > own interface.
> 
>  again: the provision of a winbindd-like service will allow you to write
>  a pam module that reads the persistent information from the service.
 
Pam modules are for authentication and login issues. 
This mapping is used for other purposes as well, and also needs to 
be modified from multiple programs and/or shared libraries, which should
not replicate the necessary code.

>  winbindd has a unix domain socket over which communication is carried
>  out - pam_winbindd, nss_winbindd and, in the version of winbindd
>  present in samba tng, freedce's ntlmsspauth.so as well.

We don't have a daemon, so our code has to go in a shared library
(unless you're proposing writing a daemon, which sounds crazy to me).

>  ... you're implementing groups :)

Essentially... groups for MAC, which have associated
role sets and MLS sensitivity (so they're not very similar 
to groups for DAC).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
