Date: Wed, 19 Dec 2001 14:45:06 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Gary Lowder <gary@lowder.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
In-Reply-To: <3C20D492.10504@lowder.com>
Message-ID: <Pine.GSO.4.33.0112191439070.5056-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 19 Dec 2001, Gary Lowder wrote:

> I hate to completely change the direction you're headed but...
> Based on what you've said earlier about what you want to accomplish, it
> seems a chroot jail is what you want for your users.  Why reinvent the
> wheel?  Of course you can beat SELinux into doing what you're asking,
> but that's not really what it was designed to directly accomplish.

I suppose that this depends on what he needs.  If he wants a completely
isolated directory tree for each user and he wants this to be transparent
to applications, then using chroot makes sense, although I would still
suggest using SELinux to confine any damage if the chroot jail is broken
and to protect the integrity of the base system.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
