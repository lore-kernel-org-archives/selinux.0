Date: Fri, 5 Jul 2002 08:08:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: named pt2
In-Reply-To: <1025732909.3620.136.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207050805400.29942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Jul 2002, Timothy Wood wrote:

> Can someone explain to my why bind works if I let init start it but it
> does not start if I start it as root from the cli?

When running init scripts directly from an administrator shell, you need
to use run_init so that the init script will run with the right security
context (system_u:system_r:initrc_t) and any daemons will transition to
the correct domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
