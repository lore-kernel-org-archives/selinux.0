Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21Ec0wo001090
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 09:38:00 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l21EdEPD022510
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:39:23 GMT
Subject: Re: More textrel_shlib_t libraries
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261955.l1QJthJm031913@localhost.localdomain>
References: <200702261955.l1QJthJm031913@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 09:39:41 -0500
Message-Id: <1172759982.11157.89.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:55 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_system_libraries.fc===
> --- nsaserefpolicy/policy/modules/system/libraries.fc	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/system/libraries.fc	2007-02-26 11:04:23.000000000 -0500
> @@ -80,6 +80,7 @@
>  /opt/(.*/)?java/.+\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
>  /opt/(.*/)?jre/.+\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
>  /opt/ibm/java2-ppc64-50/jre/bin/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/opt/cxoffice/lib/wine/.+\.so      -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  ifdef(`distro_gentoo',`
>  # despite the extensions, they are actually libs
> @@ -276,7 +277,10 @@
>  /usr/(local/)?acroread/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/(local/)?Adobe/.*\.api		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/(local/)?lib/xchat/plugins/systray.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
> -/usr/local/matlab.*/bin/glnx86/libmwlapack\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?matlab.*/bin/glnx86/libmwlapack\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?matlab.*/sys/os/glnx86/libtermcap.so    -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?matlab.*/bin/glnx86/(libmw(lapack|mathutil|services)|lapack|libmkl).so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +
>  /usr/(.*/)?intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  /usr/lib/acroread/(.*/)?sidecars/*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)

Merged with some reorg.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
