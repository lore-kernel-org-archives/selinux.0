Date: Thu, 28 Mar 2002 16:49:27 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Walker, Jason" <Jason.Walker@csoconline.com>
cc: "'SeLinux@tycho.nsa.gov'" <SeLinux@tycho.nsa.gov>
Subject: Re: Troubles with 2.4.18 kernel
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A106C52D23@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0203281644060.18452-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 28 Mar 2002, Walker, Jason wrote:

> My VMWare installation is having some problems with the 2.4.18 kernel.
> Specifically, the IDE CD-ROM drive is causing lockups in the virtual
> machine.  This is happening with both a 'stock' 2.4.18 kernel and with the
> SELinux version.
>
> Problem is, I can't find older releases of LSM/SELinux on the nsa.gov
> website...where are older releases kept?

You can pull older versions from the CVS repository on sourceforge.
The prior release is tagged nsa_2002011718.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
