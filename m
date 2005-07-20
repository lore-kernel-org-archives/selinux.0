Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KCt3gA015397
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 08:55:03 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KCodDg024336
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 12:50:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j6KCp59F003187
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 08:51:05 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j6KCp5NS003186
	for selinux@tycho.nsa.gov; Wed, 20 Jul 2005 08:51:05 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KBYjgA015007
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 07:34:46 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KBULDg018938
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 11:30:21 GMT
Date: Wed, 20 Jul 2005 12:30:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: SElinux nss/nscd service
Message-ID: <20050720113015.GO8851@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com> <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com> <20050719215424.GA8851@lkcl.net> <1121815377.15541.15.camel@localhost.localdomain> <20050720095524.GK8851@lkcl.net> <1121857492.24646.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121857492.24646.21.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 20, 2005 at 07:04:52AM -0400, Ivan Gyurdiev wrote:
> 
> > > Instead
> > > we will be mapping many Unix users to few SElinux users,
> > > which may also be called security "classes". The default
> > > class would also be configurable (not hardcoded on user_u).
> > 
> >  sounds good (and also after a bit of thought for 10 mins it
> >  clears up the abiguity above)
> > 
> >  is this "requirements specification" or "functional spec"?
> 
> Like I said, no formal specification or requirements exist
> at this time. 

 i invited people to point me at something formal or informal.

 
> The project I am working on is to integrate
> shadow-utils and similar code with selinux user management.
> The requirements we have are basically that we want useradd 
> to be able to configure selinux parameters (whatever those are)
> for the user, usermod to modify those, and userdel to remove 
> selinux data relating to the user being deleted.
> 
> Based on discussions, it seems appropriate to implement this
> map-to-security class idea as part of reaching this objective.
> 
> > > It is also being proposed to 
> > > place this code in pam, but I don't see how this will work at 
> > > all - if you place code in pam, than all the code that doesn't
> > > use pam (and there's already a few planned callers - admin
> > > programs) cannot make use of it, and has to write its 
> > > own interface.
> > 
> >  again: the provision of a winbindd-like service will allow you to write
> >  a pam module that reads the persistent information from the service.
>  
> Pam modules are for authentication and login issues. 
> This mapping is used for other purposes as well, and also needs to 
> be modified from multiple programs and/or shared libraries, which should
> not replicate the necessary code.

 then you almost undoubtedly need something like winbindd in
 order to "centralise" the management of the security "classes",
 and to provide a simple RPC mechanism for communicating over a unix
 domain socket (or other IPC mechanism - but _please_ don't put dbus
 on the list of options to explore).

 i think you will find that a very simple RPC mechanism will
 be _much_ more palatable than "multiple programs and/or shared
 libraries resulting in replicated necessary code".

 the anticipated complexity [of these proposed selinux
 "classes" and their management] is then "hidden" behind a
 simple RPC-based API that pam_winbindlikeselinuxservice,
 nss_winbindlinesexlinuxservice etc. call all use, WITHOUT
 knowing OR CARING how it's implemented.

 aside from anything, as long as you get the simple RPC
 mechanism correct and well-defined, you can CHANGE the
 implementation [of selinux "classes"] behind the RPC mechanism -
 and it's _not going to matter_.


> >  winbindd has a unix domain socket over which communication is carried
> >  out - pam_winbindd, nss_winbindd and, in the version of winbindd
> >  present in samba tng, freedce's ntlmsspauth.so as well.
> 
> We don't have a daemon, so our code has to go in a shared library
> (unless you're proposing writing a daemon, which sounds crazy to me).
 
 see above.
 
 before you go criticising the reasons why i recommended a
 winbindd-like solution, can i invite you to examine its source
 code (or better yet the nss_winbindd source code because it's
 simpler) and also ask questions about why winbindd was created?

 aside from anything, a second [and more importantly, redhat-funded]
 person examining a solution recommended by an external source [who
 isn't funded to work on selinux] means that this proposed area to
 explore can be properly evaluated: it might _not_ be a good way
 forward.

 all i can say is that winbindd in combination with its nsswitch
 and pam service works _extremely_ well at providing "the holy
 grail" single-sign-on, in a mixed NT and Unix environment.

 ... and very few people actually know about it.

 (ironically and as off-topic side note: winbindd cannot be
 used to join a unix workstation to a samba 3 primary domain
 controller, whereas it _can_ be used to join a unix workstation
 to a samba tng controlled domain.  oh well.)

> >  ... you're implementing groups :)
> 
> Essentially... groups for MAC, which have associated
> role sets and MLS sensitivity (so they're not very similar 
> to groups for DAC).

 ack.


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
