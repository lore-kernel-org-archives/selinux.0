Date: Mon, 28 Jan 2002 08:57:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <1012000959.2215.12.camel@phobos>
Message-ID: <Pine.GSO.4.33.0201280837290.24971-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 25 Jan 2002, Timothy Wood wrote:

> Question.  I noticed you said "routing messages".  Ok, two questions
> really.  First off what does routing messages have to do with raising
> the interface?

The option listed as "Routing messages", aka CONFIG_RTNETLINK, allows user
space programs to receive routing information over netlink sockets.  The
RH7.2 networking utilities expect this support to be present.  I don't
know why they can't gracefully recover when it isn't available.

>Secondly, why is the routing messages not mentioned in
> the install readme?  Because the install mentions netlink, which I
> kindly made certain was built into the kernel and why I so greatly
> protested that I was not stupid enough to have missed something in the
> readme I so carefully followed to the letter.

It was an oversight in the README that was in the 12/10/2001 release,
and was fixed in the README before the 1/18/2002 release.  Of course, it
is now irrelevant for the 2.4-based SELinux because the two netlink
options have been mainstreamed in 2.4.17.

>Also, you mentioned there
> was a new version of the lsm out and I just downloaded the one I have
> now only like a week ago.  So am I going to the wrong place for all this
> stuff or what?  The NSA site is the right place correct?

The NSA SELinux web site was updated on 1/18/2002.  So if you downloaded
the release prior to that date, you would have obtained the prior release,
which was made on 12/10/2001.  Yes, the NSA web site is the right place,
but new releases have been relatively frequent to track new kernel
versions and other developments.

> At any rate it IS working now and I feel terrible that I wasted
> everyone's time.  I would like to suggest that the install readme be
> updated though and I would be happy to do it if someone would tell me
> where I can submit the change.  Thanks again everyone.

It was already fixed.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
