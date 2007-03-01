Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21EbqQ6001036
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:37:53 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEP3022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:15 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Additional Device definitions.
Date: Thu, 1 Mar 2007 09:39:32 -0500
Message-ID: <1172759972.11157.84.camel@sgc.columbia.tresys.com>
In-Reply-To: <200702261952.l1QJqsq1031888@localhost.localdomain>
References: <200702261952.l1QJqsq1031888@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:52 -0500, dwalsh@localhost.localdomain wrote:
> 
> ===File /tmp/patches/nsaserefpolicy_policy_modules_kernel_devices.fc===
> --- nsaserefpolicy/policy/modules/kernel/devices.fc	2007-01-02 12:57:13.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/kernel/devices.fc	2007-02-26 11:04:23.000000000 -0500
> @@ -28,9 +28,11 @@
>  /dev/js.*		-c	gen_context(system_u:object_r:mouse_device_t,s0)
>  /dev/kmem		-c	gen_context(system_u:object_r:memory_device_t,mls_systemhigh)
>  /dev/kmsg		-c	gen_context(system_u:object_r:kmsg_device_t,mls_systemhigh)
> +/dev/mcelog		-c	gen_context(system_u:object_r:kmsg_device_t,mls_systemhigh)
>  /dev/logibm		-c	gen_context(system_u:object_r:mouse_device_t,s0)
>  /dev/lp.*		-c	gen_context(system_u:object_r:printer_device_t,s0)
>  /dev/mem		-c	gen_context(system_u:object_r:memory_device_t,mls_systemhigh)
> +/dev/oldmem		-c	gen_context(system_u:object_r:memory_device_t,mls_systemhigh)
>  /dev/mice		-c	gen_context(system_u:object_r:mouse_device_t,s0)
>  /dev/microcode		-c	gen_context(system_u:object_r:cpu_device_t,s0)
>  /dev/midi.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
> @@ -58,6 +60,7 @@
>  /dev/srnd[0-7]		-c	gen_context(system_u:object_r:sound_device_t,s0)
>  /dev/snapshot		-c	gen_context(system_u:object_r:apm_bios_t,s0)
>  /dev/sndstat		-c	gen_context(system_u:object_r:sound_device_t,s0)
> +/dev/sonypi		-c	gen_context(system_u:object_r:v4l_device_t,s0)
>  /dev/tlk[0-3]		-c	gen_context(system_u:object_r:v4l_device_t,s0)
>  /dev/urandom		-c	gen_context(system_u:object_r:urandom_device_t,s0)
>  /dev/usbdev.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
> ============================================================

Merged with some reorganization.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
