Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EK8r8027813
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:20:09 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l77EK7Va000040
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:20:07 GMT
Subject: Re: [PATCH] refpolicy: kernel_terminal changes new terminal device
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022012.l72KCs5c029959@redsox.boston.devel.redhat.com>
References: <200708022012.l72KCs5c029959@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 10:19:38 -0400
Message-Id: <1186496378.18881.21.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:12 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/kernel/terminal.fc    2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/kernel/terminal.fc 2007-08-02 11:02:02.000000000 -0400
> @@ -8,6 +8,7 @@
>  /dev/dcbri[0-9]+       -c      gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/hvc.*             -c      gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/hvsi.*            -c      gen_context(system_u:object_r:tty_device_t,s0)
> +/dev/i2c[^/]*          -c      gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/ircomm[0-9]+      -c      gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/ip2[^/]*          -c      gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/isdn.*            -c      gen_context(system_u:object_r:tty_device_t,s0)

I don't think this is correct, not all i2c devices are ttys.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
