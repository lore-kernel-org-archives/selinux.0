Subject: RE: [RFC] Ability to allow undefined permissions and classes -v2
From: Eric Paris <eparis@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Chad Sellers <csellers@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 14:40:28 -0500
Message-Id: <1171482028.18488.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 14:22 -0500, Joshua Brindle wrote:
> > From: Eric Paris [mailto:eparis@redhat.com] 
> > All of the policy for the whole system:
> > - My ^ 0xffffffff method will work just fine since the policy 
> > knows what is defined by policy and we can simply allow 
> > everything else.
> > - This would be the only reasonable way the kernel could 
> > answer through /selinux for userapace objects.  If the kernel 
> > doesn't know about the userspace objects or permissions how 
> > can it answer yes or no with any meaning?
> > 
> 
> It answers no if it doesn't know about it because selinux is deny by
> default, no means it isn't allowed.

The whole point of this exercise is to make it possible for the policy
author to make that rule a little less rigid.  But your point is taken
and I think we can make what you want work.

> > Only the kernel policy is loaded into the kernel:
> > - Either method works fine although the more directed method 
> > might help to catch accidental bugs in the kernel which would 
> > be missed by the shotgun method.
> > - Obviously userspace can't ask the kernel to make decisions 
> > since it doesn't know, so it seems I can be directed or just 
> > allow everything.
> > 
> 
> No, if userspace does manage to ask the kernel about something (on
> accident or otherwise) it must be denied by default, SELinux is a deny
> by default mechanism. The routing mechanism is in userland (in
> libselinux) so the kernel doesn't know to point the requester somewhere
> else for an answer, it must simply answer denied.

Hmmmmm, right now I say that any tclass in an access decision which is
larger than the highest class defined in policy is 'unknown' and so I
allow it.  If I want to try to make this methodology even more kernel
specific I will leave my current permissions table and I guess I also
need to define a bit map and fill it during validate_classes based on
the appearance of the class both in the loaded policy and in the kernel
pre-definitions...

> > So really I just need some ejumakashun on the mythic 
> > userspace security server and just what information will be 
> > available to the kernel when it is passed the policy.  And 
> > just what decision context_struct_compute_av might be ask to decide.
> > 
> 
> We haven't totally decided but I think its safe to assume that the
> kernel won't have policy for userspace object classes at all and may not
> even know of the existance of said classes. The userspace requests would
> be routed to a userspace security server and the kernel would only
> answer questions for object classes it controls (or maybe not even
> those).

Super kernel specific work coming up.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
