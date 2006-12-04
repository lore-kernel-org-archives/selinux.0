Subject: Re: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4570F2F8.2030809@tresys.com>
References: <1164989217.2079.106.camel@localhost.localdomain>
	 <1164998469.23019.1065.camel@moss-spartans.epoch.ncsc.mil>
	 <4570F2F8.2030809@tresys.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 09:46:56 -0500
Message-Id: <1165243616.2923.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-01 at 22:28 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2006-12-01 at 11:06 -0500, Eric Paris wrote:
> >   
> >> Denials will show up in the logs just as if it were 'permissive' even
> >> though we are allowing checks against undefined classes and permissions.
> >>     
> >
> > I don't think that this is the desired behavior.   If the policy
> > indicates that undefined classes/perms should be allowed (via a flag in
> > the policy header), then we want the checks allowed silently as if the
> > check was not present at all.  Logging them as if permissive could
> > easily flood the logs.
> >
> >   
> I disagree that this should be in the header. We discussed this at 
> tresys and decided that it would probably be best to make it a kernel 
> option selectable in Kconfig and also switchable via selinuxfs or the 
> command line. Doing it in the policy requires policy rebuilds and extra 
> infrastructure (eg., libsepol needs to know about it to switch it at 
> expand time). Making it switchable via selinuxfs is much easier from a 
> user point of view.

Policy rebuilds and libsepol awareness aren't precisely onerous for a
new feature that enables unknown classes and permissions to be allowed.
compat_net caused us a fair amount of pain (there was and still is no
clean way to synchronize it with the actual policy being loaded).  How
one handles undefined classes and permissions is a policy issue, and
should be defined in the policy.  Making it a separate setting makes it
difficult to synchronize (even booleans have initial states defined in
policy) and makes policy unanalyzable (does a given policy allow or not
allow a class or permission that it didn't define - you can't tell from
the policy itself).

We already have a word in the policy header for flags, presently only
used for the MLS flag, so it is trivial to adjust checkpolicy/libsepol
to set and preserve it (from base to kernel policy) and to have libsepol
and the kernel interpret it at policy load time.

> > I think that this should be transparent to the AVC.  At policy load
> > time, you know which permissions are not defined in the policy, so you
> > can immediately set to 1s all such permission bits in the access vectors
> > in the avtab if the desired behavior is to allow undefined permissions,
> > and you can also generate a table of default access vectors per class
> > for the case where this is no avtab entry.  Then security_compute_av
> > just needs to handle undefined classes (return allowed vector with all
> > 1s) and defined class but no avtab entry (return the default access
> > vector for the class).
> >   
> To do this with a runtime option the avc would have to know about it 
> unfortunately. The avc will need a bitmap of known classes/permissions 
> at load time. Not totally ideal but the end result would be much easier 
> to use IMO

Even with your approach, it wouldn't require AVC awareness - you would
just have the function that changes the setting flush the AVC (just like
setting booleans) and security_compute_av could pad the access vectors
as appropriate based on the current setting (just like adding in any
permissions allowed by conditional rules that are presently enabled).
Not that I agree with your approach, but neither approach requires AVC
awareness, and AVC awareness would break the architecture.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
