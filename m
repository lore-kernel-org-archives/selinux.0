Date: Wed, 10 Oct 2001 10:22:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carl Carpenter <ccarpenter@hillcountry.org>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with eth0
In-Reply-To: <DIECIJMLKGOOCPBJIBKJAELJCEAA.ccarpenter@hillcountry.org>
Message-ID: <Pine.GSO.4.33.0110101014090.25153-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Oct 2001, Carl Carpenter wrote:

> Seriously, I have a problem when running the SELinux kernel in that the eth0
> module can't be found during bootup (modprobe:  can't locate module eth0).

You need to customize your kernel configuration for your hardware.  The
default kernel configuration (part of the mainstream linux kernel tree,
not modified by LSM/SELinux) doesn't enable many network card drivers.
You need to enable the driver for your network card under the Network
device support menu.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
