Date: Mon, 8 Jul 2002 12:30:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new LSM ver
In-Reply-To: <1026141595.1724.71.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207081134580.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 8 Jul 2002, Timothy Wood wrote:

> This is true.  You can also merely change the context when you login (if
> you log in as root).

If you login via sshd, you can only login with the default context.  You
can then change contexts via newrole.

> however I do like the idea of severely restricting root or removing root
> altogether.  Would I be correct in that pretty much everything would
> have to be rewritten if this were to be accomplished (the removal of
> root, that is)?

This is simple as far as the kernel is concerned.  You would simply
disable the stacking support in the SELinux module or stack with a null
module so that SELinux would provide the sole authoritative decision for
Linux capabilities (i.e. root privileges).  The difficult tasks would be
updating all of the applications that have hardcoded assumptions about uid
0 or about setuid programs (and don't forget ld.so!), and configuring the
policy appropriately now that you are depending entirely on the
SELinux policy to authorize root privileges.

See http://marc.theaimsgroup.com/?l=selinux&m=97922666422991&w=2 for an
earlier discussion of how SELinux relates to Linux capabilities.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
