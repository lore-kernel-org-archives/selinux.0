Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LKe5FX015470
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 15:40:05 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0LKe75L005814
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 20:40:07 GMT
Subject: Re: [Fwd: New policy patch]
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <41E57081.4090500@redhat.com>
References: <41E57081.4090500@redhat.com>
Content-Type: text/plain
Message-Id: <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 15:36:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Finally merged.  Some comments below.

On Wed, 2005-01-12 at 10:44, Daniel J Walsh wrote: 
> 
> ______________________________________________________________________
> diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.21.1/file_contexts/program/udev.fc
> --- nsapolicy/file_contexts/program/udev.fc	2005-01-12 08:14:48.813492366 -0500
> +++ policy-1.21.1/file_contexts/program/udev.fc	2005-01-12 09:18:27.204382758 -0500
> @@ -8,5 +8,5 @@
>  /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
>  /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
>  /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
> -/dev/\.udev\.tdb	--	system_u:object_r:udev_tdb_t
> +/dev/\.udev\.tdb/.*	--	system_u:object_r:udev_tdb_t
>  /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
This is a directory on Rawhide but a file on FC3, so I would prefer to
keep it more general for now.

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.1/macros/base_user_macros.te
> --- nsapolicy/macros/base_user_macros.te	2004-12-09 10:26:10.000000000 -0500
> +++ policy-1.21.1/macros/base_user_macros.te	2005-01-12 09:18:27.205382646 -0500
> @@ -38,6 +44,7 @@
>  
>  # Allow text relocations on system shared libraries, e.g. libGL.
>  allow $1_t shlib_t:file execmod;
> +allow $1_t ld_so_t:file execmod;
>  
>  #
>  # kdeinit wants this access
We don't want to do this

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.1/macros/program/mozilla_macros.te
> --- nsapolicy/macros/program/mozilla_macros.te	2004-12-21 10:59:59.000000000 -0500
> +++ policy-1.21.1/macros/program/mozilla_macros.te	2005-01-12 09:18:27.211381972 -0500
> @@ -25,7 +25,7 @@
>  allow $1_mozilla_t $1_t:process signull;
>  
>  # Set resource limits and scheduling info.
> -allow $1_mozilla_t self:process { setrlimit setsched };
> +allow $1_mozilla_t self:process { execmem setrlimit setsched };
>  
>  allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
>  allow $1_mozilla_t var_lib_t:file { getattr read };
We don't want to do this either.

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/samba_macros.te policy-1.21.1/macros/program/samba_macros.te
> --- nsapolicy/macros/program/samba_macros.te	1969-12-31 19:00:00.000000000 -0500
> +++ policy-1.21.1/macros/program/samba_macros.te	2005-01-12 09:18:27.213381748 -0500
> @@ -0,0 +1,28 @@
> +#
> +# Macros for samba domains.
> +#
> +
> +#
> +# Authors:  Dan Walsh <dwalsh@redhat.com>
> +#
> +
> +# 
> +# samba_domain(domain_prefix)
> +#
> +# Define a derived domain for the samba program when executed
> +# by a user domain.
> +#
> +# The type declaration for the executable type for this program is
> +# provided separately in domains/program/samba.te. 
> +#
> +undefine(`samba_domain')
> +ifdef(`samba.te', `
> +define(`samba_domain',`
> +if ( samba_enable_home_dirs ) {
> +file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
> +}
> +')
> +', `
> +define(`samba_domain',`')
> +
> +')dnl end if samba.te
The file_type_auto_trans rule conflicts with the following rule in the
user_domain macro in user_macros.te:
file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
There is a conflict because smbd_t has the privhome attribute.
For now I removed the privhome attribute from smbd_t.  Does it really
need it?  NFS doesn't have that attribute.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
