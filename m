Date: Tue, 22 Jan 2002 14:28:51 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: restricted guest domain accounts
In-Reply-To: <20020121091553.A28411@lemuria.org>
Message-ID: <Pine.GSO.4.33.0201221410110.20295-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 21 Jan 2002, Tom wrote:

> there's of course a tight deadline - I'm using a locked-down, minimalistic
> Debian system.
> however, I would just love to lock it down much more. that's where
> SELinux comes into play, because I believe here I can really put a
> policy into play that says "after successful login, you are allowed to
> execute exactly THESE three programs."
> as a matter of fact, I wouldn't mind blocking a selection of system
> calls that I know won't be needed. :)

It seems like using SELinux on this system would be beneficial even
without a special guest user domain.  The example policy provides a user_t
domain for ordinary users that is already limited, e.g. even if such a
user obtains superuser privileges, he cannot modify the system software,
configuration files, or logs.  The issue is not what programs can be run
by the user but what permissions are granted to domains that can be
entered by the user.  You could strip the user_t domain down further if
desired, but you need to consider whether you are really improving
security by doing so.  With regard to system calls, SELinux doesn't
interpose on system calls - it provides low-level controls over the actual
kernel operations on kernel objects.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
