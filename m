Date: Mon, 17 Dec 2001 07:55:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: Paul Krumviede <pwk@acm.org>, <SELinux@tycho.nsa.gov>
Subject: Re: iptables.te  errors
In-Reply-To: <3C1D871D.8020908@pcez.com>
Message-ID: <Pine.GSO.4.33.0112170754050.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 16 Dec 2001, Shaun Savage wrote:

> I have a iptables.te with some documentation.

Thanks for contributing.  However, I was wondering if the additional
permissions that you've defined should be merged back into the ipchains_t
domain, and that domain could be used for both programs.  Is there any
real reason to maintain separate domains for the two programs?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
