Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA22HwXZ002359
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 21:17:58 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA22HwfG021147
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 02:17:58 GMT
Subject: Re: dynamic context transitions
From: Colin Walters <walters@verbum.org>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <418662EE.5090001@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 21:18:00 -0500
Message-Id: <1099361880.3998.4.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 10:23 -0600, Darrel Goeddel wrote:
> James,
>      I am hoping that this response will also address your question of 
> applicability outside of the MLS policy.
> 
> Luke Kenneth Casson Leighton wrote:
> >  this proposal is a little bit like seteuid-for-selinux, only not
> >  really, because seteuid has the ability to switch to any uid and then
> >  to any uid after that, ad infinitum.
> > 
> 
> That is correct.  We are looking at a well-defined (via the policy) set of 
> available type transitions.  Note that you can also specify a one-way dynamic 
> transition as well (type1_t can dynamically transition to type2_t, but type2_t 
> has no dynamic transitions available).  This will allow a daemon process to 
> initialize itself with one set of access rights (bind ports, read conf files, 
> etc.), and then lock itself into a domain with less access rights for the 
> duration of its execution. 

I can see some specialized uses for this with e.g. the Samba example,
but I'm having trouble seeing how it would be broadly useful, although I
haven't thought about the MLS case much.  But in your examples above,
the policy can already restrict which ports a domain can bind; it
doesn't seem useful to drop the privileges to bind to those ports.
Also, why would it be useful to drop the privileges to read
configuration files?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
