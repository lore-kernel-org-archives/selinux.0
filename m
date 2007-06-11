Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BErZ9R018591
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:53:35 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BErQDI019053
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:53:33 GMT
Subject: Re: kernel_devices changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301521.l4UFLQn1010479@localhost.localdomain>
References: <200705301521.l4UFLQn1010479@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:52:03 -0400
Message-Id: <1181573523.16029.26.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:21 -0400, dwalsh@redhat.com wrote:
> Additional devices
> Additional interfaces
> 
> --- nsaserefpolicy/policy/modules/kernel/devices.fc	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/devices.fc	2007-05-30 09:25:53.000000000 -0400
> @@ -19,6 +19,7 @@
>  /dev/evtchn		-c	gen_context(system_u:object_r:xen_device_t,s0)
>  /dev/fb[0-9]*		-c	gen_context(system_u:object_r:framebuf_device_t,s0)
>  /dev/full		-c	gen_context(system_u:object_r:null_device_t,s0)
> +/dev/fw.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/hiddev.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
>  /dev/hpet		-c	gen_context(system_u:object_r:clock_device_t,s0)
>  /dev/hw_random		-c	gen_context(system_u:object_r:random_device_t,s0)
> @@ -81,6 +82,8 @@
>  
>  /dev/bus/usb/.*/[0-9]+	-c	gen_context(system_u:object_r:usb_device_t,s0)
>  
> +/dev/cmx.*		-c	gen_context(system_u:object_r:smartcard_device_t,s0)
> +
>  /dev/cpu/.*		-c	gen_context(system_u:object_r:cpu_device_t,s0)
>  /dev/cpu/mtrr		-c	gen_context(system_u:object_r:mtrr_device_t,s0)
>  
> --- nsaserefpolicy/policy/modules/kernel/devices.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/devices.if	2007-05-30 09:25:53.000000000 -0400
> @@ -2729,6 +2729,24 @@
>  
>  ########################################
>  ## <summary>
> +##	Get the attributes of a directory in the usb filesystem.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_search_usbfs_dirs',`
> +	gen_require(`
> +		type usbfs_t;
> +	')
> +
> +	allow $1 usbfs_t:dir search_dir_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##	Do not audit attempts to get the attributes
>  ##	of a directory in the usb filesystem.
>  ## </summary>
> @@ -2939,6 +2957,24 @@
>  
>  ########################################
>  ## <summary>
> +##	Write the video4linux devices.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_write_video_dev',`
> +	gen_require(`
> +		type device_t, v4l_device_t;
> +	')
> +
> +	write_chr_files_pattern($1,device_t,v4l_device_t)
> +')
> +
> +########################################
> +## <summary>
>  ##	Read and write VMWare devices.
>  ## </summary>
>  ## <param name="domain">
> @@ -3192,3 +3228,78 @@
>  
>  	typeattribute $1 devices_unconfined_type;
>  ')
> +
> +########################################
> +## <summary>
> +##	Getattr on smartcard devices
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_getattr_smartcard',`
> +	gen_require(`
> +		type smartcard_device_t;
> +	')
> +
> +	allow $1 smartcard_device_t:chr_file getattr;
> +
> +')
> +
> +########################################
> +## <summary>
> +##	dontaudit getattr on smartcard devices
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_dontaudit_getattr_smartcard',`
> +	gen_require(`
> +		type smartcard_device_t;
> +	')
> +
> +	dontaudit $1 smartcard_device_t:chr_file getattr;
> +
> +')
> +
> +########################################
> +## <summary>
> +##	Read and write smartcard devices.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_rw_smartcard',`
> +	gen_require(`
> +		type device_t, smartcard_device_t;
> +	')
> +
> +	rw_chr_files_pattern($1,device_t,smartcard_device_t)
> +')
> +
> +########################################
> +## <summary>
> +##	Create, read, write, and delete smartcard devices.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_manage_smartcard',`
> +	gen_require(`
> +		type device_t, smartcard_device_t;
> +	')
> +
> +	manage_chr_files_pattern($1,device_t,smartcard_device_t)
> +')
> +
> --- nsaserefpolicy/policy/modules/kernel/devices.te	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/devices.te	2007-05-30 09:25:53.000000000 -0400
> @@ -1,5 +1,5 @@
>  
> -policy_module(devices,1.4.0)
> +policy_module(devices,1.4.1)
>  
>  ########################################
>  #

Please don't update the versions, I do that when appropriate when I
commit.  Other parts are merged.

> @@ -139,6 +139,12 @@
>  #
>  # Type for sound devices and mixers
>  #
> +type smartcard_device_t;
> +dev_node(smartcard_device_t)
> +
> +#
> +# Type for sound devices and mixers
> +#
>  type sound_device_t;
>  dev_node(sound_device_t)
>  
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
