Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6RDCAb7009283
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 09:12:10 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6RDC9pA029913
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 13:12:10 GMT
Subject: Re: alsactl policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <selinux@martinorr.name>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46A5065B.8050709@martinorr.name>
References: <46A5065B.8050709@martinorr.name>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 13:11:57 +0000
Message-Id: <1185541917.24951.51.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-23 at 15:49 -0400, Martin Orr wrote:
> The alsa policy doesn't address alsactl, run from an init script and
> via a
> udev rule whenever a sound device is loaded to set volumes.  This
> patch
> addresses this.

> @@ -541,6 +541,10 @@
>  ')
>  
>  optional_policy(`
> +	alsa_domtrans(initrc_t)
> +')
> +
> +optional_policy(`
>  	amavis_search_lib(initrc_t)
>  	amavis_setattr_pid_files(initrc_t)
>  ')

This should be init_system_domain() in alsa.te instead.

> @@ -176,6 +176,10 @@
>  ')
>  
>  optional_policy(`
> +	alsa_domtrans(udev_t)
> +')
> +
> +optional_policy(`
>  	consoletype_exec(udev_t)
>  ')

What causes udev to run this (might it be debian-specific)?
 
> @@ -14,6 +14,9 @@
>  type alsa_etc_rw_t;
>  files_type(alsa_etc_rw_t)
>  
> +type alsa_var_lib_t;
> +files_type(alsa_var_lib_t)
> +
[...]
> +# asound.state: lives in /var/lib/alsa on Debian, /etc elsewhere
> +files_etc_filetrans(alsa_t,alsa_etc_rw_t,file)
> +files_search_var_lib(alsa_t)
> +manage_files_pattern(alsa_t,alsa_var_lib_t,alsa_var_lib_t)

This is the problem with encoding paths into the type names.  It might
be in different paths, but its the same file, with the same security
attributes, so there isn't a need for a new type.  Since the /var/lib
stuff is debian-specific, it should be in a ifdef(`distro_debian'.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
