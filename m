Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MLe7rT005260
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 17:40:07 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MLe6WF027951
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 21:40:06 GMT
Date: Wed, 22 Sep 2004 22:51:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux  Doesn't Complete Initialization
Message-ID: <20040922215111.GH7308@lkcl.net>
References: <A52BEA1D8EE8634B9196A136333637B1DADF@maat.darkhonor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B1DADF@maat.darkhonor.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 22, 2004 at 02:27:48PM -0400, Alex Ackerman wrote:

> /boot/grub/grub.conf:
> default=0
> timeout=10
> splashimage=(hd0,0)/grub/splash.xpm.gz
> 
> title SELinux (2.6.8-1.521)
>         root (hd0,0)
>         kernel /vmlinuz-2.6.8-1.521 ro root=LABEL=/ quiet vga=792 selinux=1 enforcing=0

	add "audit=1" to this and you will see some loovely debug messages.

	[auditing was introduced around 2.6.6 or so]

    can't tell you about the options below but from what i understand
	if you didn't have enforcing=0 above then the option
	SELINUX=permissive would be read and used instead.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
