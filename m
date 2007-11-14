Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAEK6ojS022881
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 15:06:50 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAEK6nNT003028
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 20:06:49 GMT
Subject: Re: duplicit fc on Debian for /lib/usb/devices
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071114165447.GA20094@bobek.pm.i.cz>
References: <20071114165447.GA20094@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 14 Nov 2007 15:06:36 -0500
Message-Id: <1195070796.13737.43.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-11-14 at 17:54 +0100, Václav Ovsík wrote:
> Hello,
> I'm starting to experiment with the refpolicy 20070928 on Debian Etch.
> First thing I noticed (beside many many other messages :-) is
> 
> /etc/selinux/refpolicy-strict/contexts/files/file_contexts: Multiple same specifications for /lib/udev/devices.

Fixed in refpolicy trunk.

> diff --git a/policy/modules/kernel/devices.fc b/policy/modules/kernel/devices.fc
> index 12a7d22..1489e16 100644
> --- a/policy/modules/kernel/devices.fc
> +++ b/policy/modules/kernel/devices.fc
> @@ -125,11 +125,6 @@ ifdef(`distro_suse', `
>  
>  /lib/udev/devices -d	gen_context(system_u:object_r:device_t,s0)
>  
> -ifdef(`distro_debian',`
> -# used by udev init script as temporary mount point
> -/lib/udev/devices	-d		gen_context(system_u:object_r:device_t,s0)
> -')
> -
>  ifdef(`distro_gentoo',`
>  # used by init scripts to initally populate udev /dev
>  /lib/udev/devices/null	-c	gen_context(system_u:object_r:null_device_t,s0)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
