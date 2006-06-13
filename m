From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150218605.3488.25.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150218605.3488.25.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Subject: Re: [PATCH] keys: restrict /proc/keys and /proc/key-users 
Date: Tue, 13 Jun 2006 18:42:45 +0100
Message-ID: <28863.1150220565@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> I expect that this patch will be slightly controversial, but I'd like to
> at least discuss it.

Definitely controversial.

> I think that /proc/keys is actually useful to have, in case the user wants a
> quick summary of what keys the kernel is keeping for them.

That might be true.

> However, they obviously should not be able to access information about keys
> that they are prohibited from viewing.  The following patch adds a simple
> permission check to ensure that this doesn't occur.

Unless I'm debugging stuff - in which case I want to see the whole lot.  This
would need a config option to disable it for debugging purposes.  You could
move the one that enables /proc/keys to just disable the permissions check.

I'm still not sure /proc/keys should be available at all, though I know people
like looking at lists of things in /proc. 

> It also restricts the /proc/key-users file, so that ordinary users can only
> view information on their own keys, while allowing the super-user to view
> information about all the keys belonging to all users.

That sounds reasonable.

> This file is still problematic, as it, too could be used to form a covert
> channel based on the quota used by each user, but this patch should at least
> be a step in the right direction.

It must be terrible being that paranoid:-) Is this any less safe than disk
quotas?

> +	/* allow the superuser to view all statistics;
> +	   allow other users to only view their own statistics */
> +	if ((current->user->uid != 0) &&
> +	    (current->user->uid != user->uid))
> +		return 0;

Use capable(CAP_SYS_ADMIN) please.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
