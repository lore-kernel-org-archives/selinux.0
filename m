Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>
In-Reply-To: <47EA0C14.5060304@redhat.com>
References: <47E7E7A5.6090603@manicmethod.com>
	 <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
	 <47EA0C14.5060304@redhat.com>
Content-Type: text/plain
Date: Wed, 26 Mar 2008 09:33:58 -0400
Message-Id: <1206538438.3302.328.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-26 at 09:40 +0100, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
> >> This implements user_transition in the toolchain. It should help on
> >> distro's like Ubuntu that can't use run_init due to the user not knowing
> >> the root password. It also seems like a more eloquent way to handle
> >> service restarts than assigning system_r to user accounts and having the
> >> daemons run as someuser:system_r:foo_t.
> > 
> > Yes, that's something that has been wanted in Fedora for quite some
> > time.
> > 
> > The real issue with run_init isn't the re-authentication stage, as that
> > can always be disabled via pam config (and was just a weak form of
> > confirming user intent, not an authorization mechanism), but rather the
> > difficulty in transparently interposing it into all situations where
> > services get started/re-started.  Only Gentoo seemed to have a good
> > story there.
> > 
> >> This has some issues in policy due to users not always being known in
> >> the policy (eg., semanage users). I hope Chris or Dan will be able to
> >> give some suggestions there.
> > 
> > I'm not sure why anyone needs to add users to policy via semanage users
> > given the base set of generic users and the ability to map Linux users
> > to them via seusers aka semanage login.
> > 
> Can we define users in modules?  I envision and have provided
> modifications to do system-config-selinux for someone to take a guest_t
> and create a new role/type guest_plussendmail_t for a limited privileged
> login account that can connect to the sendmail port.
> 
> So once I have created this new User Type,  I need a way to define the
> user.  In Fedora right now, we define the xguest and guest accounts in
> the postinstall using semanage.

You can already define SELinux users in modules (after any TE/RBAC
rules).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
