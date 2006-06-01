From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Thu, 01 Jun 2006 11:09:13 +0100
Message-ID: <11225.1149156553@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> This revision of my patch incorporates a few more changes suggested
> by Stephen.  I eliminated the "lookup" permission, due to the possibility
> for kernel confusion, and because of its strange semantics (e.g. it was
> possible to write to a key without performing a lookup on it).

Remember: keys aren't files and they don't exactly follow UNIX filesystem
semantics.

I think the default permissions for a key must be only the possessor is allowed
to do anything to it or with it, and that the user should be granted some
things (setattr, for instance), and that no-one else should be granted
anything.

The default permissions probably need a good overhaul.

> I also added an unlink permission to the keys subsystem and SELinux, which
> is checked before a key is unlinked from a keyring.  I felt this change was
> fairly trivial and within the overall spirit of the patch, which is why I
> included it here.

It isn't as trivial as you think.  Unlink is implied by several operations you
haven't altered: link, add key, request key, clear keyring and search keyring.
This is because you can displace a key link from a keyring by adding a link to
another key of matching type and description.

> If any of you decide it should be split off into some other patch, I'd be
> glad to remove it.

It certainly needs be split off into its own patch as it's a fairly major
change.  Your changes in this area are also incomplete.

I also don't really want unlinkable keys for a number of reasons:

 (1) You can't get rid of them when they're dead (unless you allow a specific
     bypass).

 (2) If they're your keys, they eat your quota and but you may not be able to
     ditch them.

 (3) If someone accidentally zeroes the mask on the key, they're left with a
     key that they can't get rid of.

 (4) What are the semantics of dealing with a keyring that has a link to an
     unlinkable key within it?  Does the keyring become automatically
     unlinkable too?

 (5) How do we deal with an unlinkable session keyring?  Should this prevent
     someone joining a new session?  And should this affect all their heirs
     also?

I feel that unlinkability really should apply to the link to a key, not to the
key itself if we have it at all.

Why do you want unlinkable keys anyway?

> -#define	KEY_SETATTR	0x20	/* require permission to change attributes */
> +#define	KEY_SETATTR	0x40	/* require permission to change attributes */

NAK!  You may not change this as this will invalidate RHEL4's kernel and the
keyutils package.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
