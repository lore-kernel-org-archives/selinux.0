Date: Fri, 25 Jan 2002 09:56:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <1011969383.1945.1.camel@phobos>
Message-ID: <Pine.GSO.4.33.0201250950190.7127-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 25 Jan 2002, Timothy Wood wrote:

> > Did you enable Netlink support when you configured the kernel?
> > What release of SELinux are you using?
>
> Yes. 2001121010 (according to the tarball)

Make sure that you enabled both Netlink and its associated Routing
messages options.  These options are needed by the RH7.2 utilities, but
were not needed on RH7.1.

Also, be aware that you are using an older release - the current release
is 2002011718.  I would recommend upgrading to the current release.

> The system boots into permissive mode and I usually leave it there.

Ok, so this means that SELinux isn't preventing anything from happening.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
