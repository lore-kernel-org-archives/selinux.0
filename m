From: w9ya <w9ya@amsat.org>
Reply-To: w9ya@amsat.org
To: Russell Coker <russell@coker.com.au>, "Joshua Brindle" <JBrindle@snu.edu>,
        <kayo@pyra.ca>, <bam@snoopy.apana.org.au>
Subject: Re: user transparent encryption
Date: Mon, 17 Feb 2003 10:28:59 -0500
Cc: <SELinux@tycho.nsa.gov>
References: <se502174.064@atlas.snu.edu> <200302171018.25601.russell@coker.com.au>
In-Reply-To: <200302171018.25601.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302171028.59818.w9ya@amsat.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One comment before this discussion goes "off-list" please.

The Knoppix linux distro is an example of at least part of the "solution" 
mentioned below.

Bob Finch

On Monday 17 February 2003 04:18 am, Russell Coker wrote:
> On Mon, 17 Feb 2003 06:40, Joshua Brindle wrote:
> > I've pondered this myself, suppose you have a great selinux setup
> > very secure, no easy way to compromise it, but the machine itself
> > was in a hostile environment (not able to be protected from others
> > well). What is to stop someone from booting up a non-selinux kernel
> > and having at it with your filesystems? Nothing. I've often wondered
> > if there is a way to lock down the drive contents so it is not
> > accessible
> > (at least easily) by a non-selinux kernel, or even the encrypted fs
>
> The solution is to have a kernel and initrd on removable media and use that
> to setup an encrypted loopback device for root.
>
> The encryption key has to be on removable media for obvious reasons, and
> the kernel and initrd have to be on removable media so that an attacker
> can't trojan them.
>
> Of course a trojan in a flash BIOS could still get past this, but it would
> be a lot more difficult.  TCPA is supposed to address these issues (if you
> trust TCPA).  Also the LinuxBIOS people are working on similar schemes but
> their work in this regard was classified last time I checked their web
> site.
>
>
> Now once the machine is running the administrator can ptrace all programs
> and get at all the user's data, I don't think that there is any way around
> this.
>
> This discussion is probably getting off-topic for this list.  If we are to
> continue it I'll have to resurrect my SE Linux list for it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
