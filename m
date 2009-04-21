Subject: Re: libselinux behavior in permissive mode wrt invalid domains
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <49EE2D59.3080403@manicmethod.com>
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
	 <49E5CFD8.6060903@redhat.com>
	 <1239800627.27560.34.camel@localhost.localdomain>
	 <49E7D1BF.2010405@tycho.nsa.gov>
	 <1239973084.15304.17.camel@localhost.localdomain>
	 <49EE2D59.3080403@manicmethod.com>
Content-Type: text/plain
Date: Tue, 21 Apr 2009 16:41:39 -0400
Message-Id: <1240346499.1678.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-21 at 16:32 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Thu, 2009-04-16 at 20:47 -0400, Eamon Walsh wrote:
> >> Stephen Smalley wrote:
> <snip>
> 
> > 
> > No, I don't want to change the behavior upon context_to_sid calls in
> > general, as we otherwise lose all context validity checking in
> > permissive mode.
> > 
> > I think I'd rather change compute_sid behavior to preclude the situation
> > from arising in the first place, possibly altering the behavior in
> > permissive mode upon an invalid context to fall back on the ssid
> > (process) or the tsid (object).  But I'm not entirely convinced any
> > change is required here.
> > 
> 
> I just want to follow up to make sure we are all on the same page here. Was the 
> suggestion to change avc_has_perm in libselinux or context_to_sid in the kernel 
> or leave the code as is and fix the callers of avc_has_perm to correctly handle 
> error codes?
> 
> I prefer the last approach because of Eamon's explanation, EINVAL is already 
> passed in errno to specify the context was invalid (and if object managers 
> aren't handling that correctly now there is a good chance they aren't handling 
> the ENOMEM case either).

I'd be inclined to change compute_sid (not context_to_sid) in the kernel
to prevent invalid contexts from being formed even in permissive mode
(scenario is a type transition where role is not authorized for the new
type).  That was originally to allow the system to boot in permissive
mode.  But an alternative would be to just stay in the caller's context
(ssid) in that situation.

Changing the callers of avc_has_perm() to handle EINVAL and/or ENOMEM
may make sense, but that logic should not depend on enforcing vs.
permissive mode.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
