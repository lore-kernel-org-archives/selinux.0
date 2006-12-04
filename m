Subject: RE: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C8267@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C8267@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:24:11 -0500
Message-Id: <1165245851.2923.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 10:11 -0500, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > Policy rebuilds and libsepol awareness aren't precisely 
> > onerous for a new feature that enables unknown classes and 
> > permissions to be allowed.
> > compat_net caused us a fair amount of pain (there was and 
> > still is no clean way to synchronize it with the actual 
> > policy being loaded).  How one handles undefined classes and 
> > permissions is a policy issue, and should be defined in the 
> > policy.  Making it a separate setting makes it difficult to 
> > synchronize (even booleans have initial states defined in
> > policy) and makes policy unanalyzable (does a given policy 
> > allow or not allow a class or permission that it didn't 
> > define - you can't tell from the policy itself).
> > 
> 
> I don't know what analysis you can do on unknown access vectors...
> 
> The same applies already, if this policy is loaded in kernel < 2.6.X
> then those would be allowed (due to no hooks being present) but in >
> 2.6.x they are checked, but in > 2.6.X with some config option set they
> are allowed.

...or maybe not, all depending on some transient value in a selinuxfs
node at the precise moment that permission check fires.  Not precisely
well-defined behavior even for a particular kernel and policy pair.  

> > We already have a word in the policy header for flags, 
> > presently only used for the MLS flag, so it is trivial to 
> > adjust checkpolicy/libsepol to set and preserve it (from base 
> > to kernel policy) and to have libsepol and the kernel 
> > interpret it at policy load time.
> > 
> 
> I know, I'm saying from a convenience standpoint this should be system
> specific, not policy specific. There is always a default value, either
> built into the kernel or command line, if it needs to be changed it can
> be done before the policy is loaded, not sure what the synchronization
> issue is here (the compat_net was different because it was enabling
> different hooks which causes issues, this is disabling them once the
> policy is loaded)

Convenience should certainly be our primary design criteria.  On
synchronization, the issue is applying a property (compat_net or
handle_undefined) to a given policy and nothing else.  With booleans, we
can preload them into the policy image before loading it.  With
compat_net or handle_undefined, we have to switch it before (possibly
affecting the currently running policy) or after (leaving open a window
where the new policy has the wrong setting), and we have to have a
mechanism for coordinating that switch and reload (vs. a single loading
mechanism).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
