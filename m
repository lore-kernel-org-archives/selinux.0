Subject: Re: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux List <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <418662EE.5090001@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 16:27:40 -0500
Message-Id: <1099344460.23756.49.camel@pham.columbia.tresys.com>
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
> duration of its execution.  This is similar, but *much* more powerful than, 
> changing the uid, or even using the libcap interface to drop specific capabilities.
> 

Dropping privileges after startup can already be accomplished with
conditional policies, though it requires that only one process be
running in a given domain.

Karl


-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
