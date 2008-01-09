Subject: RE: Sudo Changes for SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>
References: <4784EFE8.9050106@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 13:23:26 -0500
Message-Id: <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 12:51 -0500, Todd Miller wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > I have a working demonstration of  My version of RBAC in Rawhide/FC8.
> > In my view of the world, users have two roles.  User Role and Admin
> > Role. 
> > 
> > So I might login as a staff_t user and be able to transition to
> > webadm_r:webadm_r.
> > 
> > In Rawhide right now staff_t can only run sudo to become root.
> > Staff_t is not allowed to execute su.  staff_t users should not know
> > the root password. I have hacked up a script /usr/bin/webadm which
> > executes newrole -r webadm_r -t webadm_t and newrole's pam has
> > pam_rootok. 
> > 
> > Now I edit the /etc/sudoers and allow
> > 
> > dwalsh ALL=(ALL) /usr/bin/webadm
> > 
> > This allows me to use sudo to become webadm_t as root.  (Policy
> > obviously has to be correct.  But this is very cumbersome for the
> > administrator and does not scale.
> > 
> > I think we need to add SELinux support to sudo, so the administrator
> > could easily add something to /etc/sodoers like
> > 
> > dwalsh ALL=(ALL) ROLE=webadm_r TYPE=webadm_t /bin/sh
> > 
> > then sudo would execute the code that newrole does to very the
> > transition and
> > 
> > setexeccon(dwalsh:webadm_t:webadm_t)
> > exec(/bin/sh)
> > 
> > I was told that you are the upstream maintainer of sudo, so I wanted
> > your input/help on making sudo selinux aware.
> 
> I suppose it depends on what you really want to be able to do.  Do you
> 
> a) wish to be able to run arbitrary commands via sudo but be able to
>    specify a role and type ala newrole via -r and -t flags?
> 
> or
> 
> b) want to be able to force a command run by sudo to use a role and type
>    that is specified in the sudoers file?
> 
> Doing a) is probably easier than b) though the two are not mutually
> exclusive.

Didn't we used to have a) in Fedora (before Fedora 5, IIRC)?  And didn't
it suffer from a number of problems?  Have to go back to the
fedora-selinux archives and/or bugzillas to recapture the history there.

Also, while integration with sudo might be useful, it seems more
pressing to integrate with policykit given its increasing adoption by
distributions, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
