Subject: Re: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <45748D8D.8040500@mentalrootkit.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C82D7@exchange.columbia.tresys.com>
	 <1165263959.2923.148.camel@moss-spartans.epoch.ncsc.mil>
	 <45748652.4050100@mentalrootkit.com>
	 <1165265045.2923.168.camel@moss-spartans.epoch.ncsc.mil>
	 <45748D8D.8040500@mentalrootkit.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 08:31:50 -0500
Message-Id: <1165325510.15979.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 16:05 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > In the approach I described, security_load_policy would:
> > - continue to check for undefined kernel classes and permissions as it
> > currently does,
> > - handle policy rejection if that is the behavior selected by the flag,
> > - pad any access vectors loaded into the avtab to grant undefined
> > permissions if the flag says to do so,
> > - generate a table indexed by class with a default access vector per
> > kernel class that contains only the undefined permissions if the flag
> > says to allow.
> > 
> 
> Why not generate avtab entries for the unknown classes? I don't see any 
> problem with an "invalid" object classes being stored in the avtab. If 
> we make a fake attribute applied to all types it should be one avtab 
> entry per object class.
>
> > security_compute_av would:
> > - handle undefined classes based on the flag (silently return an access
> > vector with all ones if it says to allow, otherwise return error),
> > - if a matching avtab entry is found, just use it - it is already
> > padded.
> > - otherwise, use the default per-class access vector that only contains
> > the undefined permissions.
> > 
> > I'm not sure how one would do that in userspace (e.g. the default
> > per-class table for holes in the avtab wouldn't have a very compact
> > representation in userspace), and you'd still need the checking at least
> > in the kernel.
> > 
> 
> See above.

You still need validation in the kernel, and the policy would still lack
kernel classes and/or permissions unless libsemanage/libsepol is also
inserting fake entries for the missing ones, so how would the kernel
handle missing classes and permissions?  How would it know that
userspace had already padded the avtab for them?

I'm unconvinced that this approach is simpler overall compared to direct
kernel implementation at load time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
