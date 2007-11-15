From: David Howells <dhowells@redhat.com>
In-Reply-To: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
References: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil> <1194628263.3630.14.camel@vogon> <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil> <24708.1194612682@redhat.com> <22421.1194637689@redhat.com> <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Stefan Schulze Frielinghaus <stefan@seekline.net>,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: type class key]
Date: Thu, 15 Nov 2007 13:08:24 +0000
Message-ID: <24667.1195132104@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Ah, wait - this is an automatic allocation of a per-uid keyring upon a
> setuid() call, right?

Maybe that's the solution:  Don't automatically allocate the per-UID keyrings
until someone tries to link to one or put something into one.

Searching the keyrings won't create them - there's no point as they'd be empty
anyway.

The pam_keyinit module could then be made to take a "nouser" argument that
would tell it to avoid making the link from the session keyring it creates to
the user keyring (or conversely a "user" argument that tells it to create the
link).

That way I can arrange for only login processes (login, ssh, kdm, gdm, telnet,
etc) to use the per-UID keyrings.  Things such as dovecot wouldn't then use
it and so wouldn't create it.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
