Date: Wed, 19 Dec 2001 16:29:23 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Question
In-Reply-To: <1008796006.1168.8.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112191619580.5056-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 19 Dec 2001, Justin Smith wrote:

> Is there a simple way to determine whether the system is in enforcing or
> permissive mode (other than issuing the avc_toggle command twice)?

Not currently.  We originally created the Development option and
avc_toggle with the intent of only using it for the development of
security policy configurations, expecting that one would build a kernel
without the option for operational use once the desired policy
configuration had been developed.  However, some people may choose to
always use a kernel with this option enabled and use avc_toggle in an rc
script to switch into enforcing mode during initialization so that they
can revert to permissive mode later from an authorized domain.  In that
situation, I can see that it would be useful to be able to determine
whether the kernel is currently permissive or enforcing.  Curiously, I
received this same question via private email from another person earlier
this week.

I suppose that we can add this to our TODO list.  It should be quite
trivial.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
