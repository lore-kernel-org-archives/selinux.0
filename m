Date: Mon, 17 Dec 2001 07:42:49 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: iptables.te  errors
In-Reply-To: <3C1CE2BD.20707@pcez.com>
Message-ID: <Pine.GSO.4.33.0112170740240.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 16 Dec 2001, Shaun Savage wrote:

> HI
> I am having a hard time with getting courier to work that I decided to
> try somwthing easier. iptables. Attached is the te file that I am using.

It looks like you used the ipchains_t domain as your starting point.
Is there any reason why iptables needs its own domain (i.e. does it need
significantly different permissions from ipchains)?  If not, you should
just label iptables with the ipchains_exec_t type and use the existing
ipchains_t domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
