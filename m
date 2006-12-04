Subject: RE: [RFC] Ability to allow unknown class and permissions
From: Eric Paris <eparis@parisplace.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C829F@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C829F@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 13:49:30 -0500
Message-Id: <1165258170.8203.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 13:13 -0500, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > 
> > Convenience should certainly be our primary design criteria.  
> > On synchronization, the issue is applying a property (compat_net or
> > handle_undefined) to a given policy and nothing else.  With 
> > booleans, we can preload them into the policy image before 
> > loading it.  With compat_net or handle_undefined, we have to 
> > switch it before (possibly affecting the currently running 
> > policy) or after (leaving open a window where the new policy 
> > has the wrong setting), and we have to have a mechanism for 
> > coordinating that switch and reload (vs. a single loading mechanism).
> > 
> 
> Ok, ok.. It sounds like you are pretty bitter about compat_net :)
> 
> Are you suggesting we add to libsemanage the ability to manipulate the
> config field? Do you dislike the idea of it being settable via some
> other means at all? Should someone be able to build a kernel that does
> not allow this option? Can it be switchable at runtime without a
> rebuild/reload?

How about both?  I can make a /selinux tunable which takes affect
immediately when changed.  And use 2 bits in the config field to set
that value on policy reload.  When I originally implemented this I had
a /selinux entry and protected it with SECURITY__LOAD_POLICY.  So policy
would still be able to enforce if it could be turned on or off.

Does that meet all the needs?  You can still change it later by hand
without building and loading a whole new policy, and we don't have
races/sync problems loading new policy since the policy itself would set
the value when it loads.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
