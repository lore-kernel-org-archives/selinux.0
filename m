Date: Thu, 24 Jan 2002 13:58:23 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
In-Reply-To: <1011892644.1401.0.camel@phobos>
Message-ID: <Pine.GSO.4.33.0201241340360.28970-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 24 Jan 2002, Timothy Wood wrote:

> Cannot send dump request: Connection refused

Did you enable Netlink support when you configured the kernel?
What release of SELinux are you using?

> module and by building it straight into the kernel.  Which brings me to
> the module problem.  Dmesg shows that it finds the nic but I never see
> the module as being loaded when I run lsmod and when I try to insmod it
> I get an error saying that it can't locate the card on the console and
> avc errors in the system log.

If you build the module into the kernel, it won't show up in lsmod.
What AVC errors are being logged?  Did you run insmod after logging
into the sysadm_r role?  Also, is your kernel in permissive mode or
enforcing mode?

> I'm also running this on ext3 if that might have something to do with it
> since I know ext3 isn't properly supported yet.  Anyhow, any ideas are
> welcome and I can reload this machine if the need arises.  Thanks.

ext3 works fine.  It was only an issue when ext3 support wasn't in the
mainstream kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
