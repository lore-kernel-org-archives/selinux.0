Date: Mon, 1 Oct 2001 14:30:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: distribution of kernel patches
In-Reply-To: <20011001174958.61F7B37D943@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0110011412470.27258-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 1 Oct 2001, Russell Coker wrote:

> This raises another issue.  It's probably a good idea to ship a copy of the
> un-patched utility programs.
>
> Hopefully I won't have the same problems here (at least you presumably have
> the matching upstream source somewhere, and it's too new to have disappeared
> from all the FTP sites yet).  But to save future problems for us it would be
> good to have a copy of the source without the patches.

We have the original unpatched sources in CVS, so I suppose we could provide
unpatched source tar balls for each of the modified daemons and utilities.
But I expect that you'll need to port the SELinux daemon and utility
patches to the corresponding source package provided with Debian, unless
they happen to use the same base sources as RedHat and do not deviate
significantly in terms of distribution-specific patches.

Also, unless you want to defer it to your end users, it would be good for
you to customize setfiles/file_contexts and the example policy
configuration for a typical Debian system.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
