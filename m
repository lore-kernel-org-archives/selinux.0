Date: Mon, 29 Jul 2002 12:54:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: security context of kapmd and others
In-Reply-To: <200207291631.QAA11082@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207291248560.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Jul 2002, Carsten Grohmann wrote:

> After  a ps ax --context, I see that some kernel daemons don't run in the
> kernel_t domain. On my SuSE are this kreiserfsd, keventd and kapmd.
>
> Where can I change the settings to move this daemons to the kernel_t
> domain. I don't found any settings for this.

The initial task (pid 0) is assigned the kernel_t domain.  When it forks
and executes /sbin/init, pid 1 transitions to the init_t domain due to
the domain transition rule.  Any kernel threads created directly by pid 0
inherit the kernel_t domain.  Any kernel threads created directly by pid 1
inherit the init_t domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
