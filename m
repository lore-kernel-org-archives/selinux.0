Date: Mon, 10 Dec 2001 12:26:20 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: New security policy
In-Reply-To: <3C14E66E.10405@pcez.com>
Message-ID: <Pine.GSO.4.33.0112101211460.13300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 10 Dec 2001, Shaun Savage wrote:

> The sysadm_r is see as the every day admin.  checking logs, add/del
> users,accounts using system-tools.
> But the secoff_r locks down system. if the secoff_r unlocks the system
> then sysadm_r can then a administrator the whole system.  The reason I
> like this is that an unknow root exploit can't comprimise the whole system.

I'm not sure what you mean.  A root exploit isn't significant, because
the SELinux nondiscretionary access controls aren't based on the Linux
identity attributes.  If someone exploits a flaw in a daemon that runs as
root, they are still limited to the permissions granted to the domain
assigned to that daemon.  If an unprivileged user (e.g. user_t) exploits a
flaw in a setuid program to become root, they are still limited to the
permissions granted to the user_t domain.  You don't need a separate
secoff_r role to protect against such exploits.

But feel free to add such a role if you like.  Just be sure that you are
really enforcing the kind of separation that you want.

> Where can I get the work that has been done already?

There should be a new release very soon.  We'll look over your patches and
try to incorporate them into future releases (but it is too late to put
them into the next one) if they are correct.  It looks like we only
duplicated each others' work for the fileutils patch.  We are currently
up-to-date with respect to the fileutils, logrotate, openssh, procps,
sh-utils, util-linux, and vixie-cron patches.  We'll see how your
updated fileutils patch differs from ours, and also look at your updated
patches for findutils, stat, and tar.   That just leaves the psmisc patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
