Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8HEaC53006707
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 10:36:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8HEa7wJ028350
	for <selinux@tycho.nsa.gov>; Mon, 17 Sep 2007 14:36:07 GMT
Message-ID: <46EE8D70.2080804@redhat.com>
Date: Mon, 17 Sep 2007 10:21:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Martin Orr <martin@martinorr.name>
CC: selinux@tycho.nsa.gov
Subject: Re: alsactl policy
References: <20070916201319.GA2705@tiberius.martinorr.name>
In-Reply-To: <20070916201319.GA2705@tiberius.martinorr.name>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin Orr wrote:
> Here's a new version of the patch I sent a while ago to add policy for
> alsactl.  This is run from an init script to set set volume levels on
> boot.  At least on Debian and Fedora, it is also run by udev when a
> sound card is detected.
> 
> Index: policy/modules/admin/alsa.te
> ===================================================================
> --- policy/modules/admin/alsa.te	(revision 2411)
> +++ policy/modules/admin/alsa.te	(working copy)
> @@ -8,12 +8,18 @@
>  
>  type alsa_t;
>  type alsa_exec_t;
> -application_domain(alsa_t, alsa_exec_t)
> +init_system_domain(alsa_t, alsa_exec_t)
>  role system_r types alsa_t;
>  
>  type alsa_etc_rw_t;
>  files_type(alsa_etc_rw_t)
>  
> +type alsa_var_lib_t;
> +files_type(alsa_var_lib_t)
> +
> +type alsa_state_t;
> +files_type(alsa_state_t)
> +
We already have alsa_etc_rw_t for this.  So we could either change
alsa_etc_rw_t to this context and typealias it or leave it as rw_t.
Or alternatively just allow alsa to write to alsa_var_lib_t,

Fedora stores asound.state under etc.  Although it probably would be
better in var/lib

I have opened a bugzilla for Fedora to write their asound.state file there.

https://bugzilla.redhat.com/show_bug.cgi?id=293301

>  ########################################
>  #
>  # Local policy
> @@ -30,9 +36,23 @@
>  manage_lnk_files_pattern(alsa_t,alsa_etc_rw_t,alsa_etc_rw_t)
>  
>  files_read_etc_files(alsa_t)
> +files_read_usr_files(alsa_t)
> +files_search_pids(alsa_t)
>  
> +allow alsa_t alsa_state_t:file manage_file_perms;
> +ifdef(`distro_debian',`
> +	files_search_var_lib(alsa_t)
> +	filetrans_pattern(alsa_t,alsa_var_lib_t,alsa_state_t,file)
> +',`
> +	files_etc_filetrans(alsa_t,alsa_state_t,file)
> +')
> +
> +dev_read_sound(alsa_t)
> +dev_write_sound(alsa_t)
> +
>  term_use_generic_ptys(alsa_t)
>  term_dontaudit_use_unallocated_ttys(alsa_t)
> +init_dontaudit_use_fds(alsa_t)
>  
>  libs_use_ld_so(alsa_t)
>  libs_use_shared_libs(alsa_t)
> @@ -43,6 +63,7 @@
>  
>  userdom_manage_unpriv_user_semaphores(alsa_t)
>  userdom_manage_unpriv_user_shared_mem(alsa_t)
> +userdom_search_generic_user_home_dirs(alsa_t)
Probably wrong interface moving forward.  You probably need to allow it
to search all non prived user home dirs.
>  
>  optional_policy(`
>  	nscd_socket_use(alsa_t)
> Index: policy/modules/admin/alsa.if
> ===================================================================
> --- policy/modules/admin/alsa.if	(revision 2411)
> +++ policy/modules/admin/alsa.if	(working copy)
> @@ -74,3 +74,26 @@
>  	read_files_pattern($1,alsa_etc_rw_t,alsa_etc_rw_t)
>  	read_lnk_files_pattern($1,alsa_etc_rw_t,alsa_etc_rw_t)
>  ')
> +
> +########################################
> +## <summary>
> +##	Read alsa state file.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`alsa_read_state',`
> +	gen_require(`
> +		type alsa_state_t, alsa_var_lib_t;
> +	')
> +	ifdef(`distro_debian',`
> +		files_search_var_lib($1)
> +		read_files_pattern($1,alsa_var_lib_t,alsa_state_t)
> +	',`
> +		files_search_etc($1)
> +		allow $1 alsa_state_t:file read_file_perms;
> +	')
> +')
This should change to read lib if you eliminate state_t.


> Index: policy/modules/admin/alsa.fc
> ===================================================================
> --- policy/modules/admin/alsa.fc	(revision 2411)
> +++ policy/modules/admin/alsa.fc	(working copy)
> @@ -1,4 +1,10 @@
>  
>  /etc/alsa/pcm(/.*)?		gen_context(system_u:object_r:alsa_etc_rw_t,s0)
>  
> +/etc/(alsa/)?asound\.state --	gen_context(system_u:object_r:alsa_state_t,s0)
> +/var/lib/alsa		-d	gen_context(system_u:object_r:alsa_var_lib_t,s0)
> +/var/lib/alsa/asound.state --	gen_context(system_u:object_r:alsa_state_t,s0)
> +
/var/lib/alsa(/.*)?	gen_context(system_u:object_r:alsa_var_lib_t,s0)
Would be a lot less error prone.
>  /usr/bin/ainit 		--	gen_context(system_u:object_r:alsa_exec_t,s0)
> +/usr/sbin/alsactl	--	gen_context(system_u:object_r:alsa_exec_t,s0)
/sbin/alsactl on Fedora

> +/usr/bin/amixer		--	gen_context(system_u:object_r:alsa_exec_t,s0)

> Index: policy/modules/system/udev.te
> ===================================================================
> --- policy/modules/system/udev.te	(revision 2411)
> +++ policy/modules/system/udev.te	(working copy)
> @@ -190,6 +190,11 @@
>  ')
>  
>  optional_policy(`
> +	alsa_domtrans(udev_t)
> +	alsa_read_state(udev_t)
> +')
> +
> +optional_policy(`
>  	brctl_domtrans(udev_t)
>  ')
>  
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG7o1wrlYvE4MpobMRApLpAJsEDfZaayv9e1+cULOZpebxwf0qMQCg1Mn9
3l5j9MGDoafTx8oXRjFAK7s=
=u/Cr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
