Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OMGerT001312
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:16:41 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OMGcCV021713
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 22:16:38 GMT
Date: Tue, 24 Aug 2004 23:23:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, Joshua Brindle <jbrindle@tresys.com>,
   Greg KH <greg@kroah.com>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040824222304.GE12140@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <412A74A6.9070206@tresys.com> <20040824092853.GD25356@lkcl.net> <200408242006.41591.russell@coker.com.au> <20040824141828.GA4698@lkcl.net> <20040824160126.GA19197@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040824160126.GA19197@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 05:01:26PM +0100, Luke Kenneth Casson Leighton wrote:

> diff -Naur 
> --- default.1.14/domains/program/udev.te	2004-08-02 08:28:37.000000000 +0100
> +++ current/domains/program/udev.te	2004-08-06 19:20:29.000000000 +0100
> @@ -79,3 +83,15 @@
>  domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
>  
>  dontaudit udev_t file_t:dir search;
> +
> +# hacked stuff...
> +
> +can_ps(udev_t, domain)
> +
> +# for /etc/dev.d/net/hotplug.dev
> +
> +allow udev_t etc_runtime_t:file { append lock write };
> +can_exec(udev_t hotplug_etc_t)
            ^^^^^^

	yes my policy _does_ really have this (spotted it just now)
	without the comma.

	no, the policy compiler _doesn't_ spot it.

	l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
