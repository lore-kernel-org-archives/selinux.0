Date: Wed, 24 Apr 2002 13:07:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: How to fix configuration 
In-Reply-To: <20020424151143.4AF0D815C8@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0204241301060.4053-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Apr 2002, Debian User wrote:

> Im getting lots of error messages when i use my pc after installing
> selinux. How do I fix the configs? Where should i start? Are the error
> messages enough to be able to fix my configuration?

Are you using Russell Coker's Debian selinux package or the upstream
distribution?  If the latter, I'd suggest using the former, since the
upstream distribution isn't set up for Debian.

There is a contributed script in the distribution, scripts/newrules.pl,
that filters your dmesg output and generates the allow rules that would
need to be added to your policy configuration to avoid these denials.
However, you will typically need to review these rules carefully to
determine whether they are truly acceptable.  In many cases, you will need
to add new domains and/or types rather than simply adding the allow rule
that corresponds to the audit message.  These issues are discussed briefly
in a new report that will hopefully be available soon.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
