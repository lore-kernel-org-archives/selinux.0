Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KJfSxl014531
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 15:41:28 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5KJfNe5005096
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 19:41:27 GMT
Subject: Re: kernel_files changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301520.l4UFKOD6010463@localhost.localdomain>
References: <200705301520.l4UFKOD6010463@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 15:39:36 -0400
Message-Id: <1182368376.16539.38.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:20 -0400, dwalsh@redhat.com wrote:
> asound.state used by actl
> Addtional etc_runtime
> Separate files_mounton_dirs from mounton_files (automount, mount)
> Change search to search_dir_perms 
> Additional missing interfaces manage_usr_files (Needed by prelink)
> Lots of additional file systems

Merged with some reordering.

> --- nsaserefpolicy/policy/modules/kernel/files.fc	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/files.fc	2007-05-30 09:25:53.000000000 -0400
> @@ -45,7 +45,6 @@
>  /etc			-d	gen_context(system_u:object_r:etc_t,s0)
>  /etc/.*				gen_context(system_u:object_r:etc_t,s0)
>  /etc/\.fstab\.hal\..+	--	gen_context(system_u:object_r:etc_runtime_t,s0)
> -/etc/asound\.state	--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/blkid(/.*)?		gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/fstab\.REVOKE	--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/HOSTNAME		--	gen_context(system_u:object_r:etc_runtime_t,s0)
> @@ -54,6 +53,7 @@
>  /etc/issue\.net		--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/localtime		-l	gen_context(system_u:object_r:etc_t,s0)
>  /etc/mtab		--	gen_context(system_u:object_r:etc_runtime_t,s0)
> +/etc/mtab\.fuselock	--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/motd		--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/nohotplug		--	gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/nologin.*		--	gen_context(system_u:object_r:etc_runtime_t,s0)
> --- nsaserefpolicy/policy/modules/kernel/files.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/files.if	2007-05-30 09:25:53.000000000 -0400
> @@ -343,8 +343,7 @@
>  
>  ########################################
>  ## <summary>
> -##	Mount a filesystem on all non-security
> -##	directories and files.
> +##	Mount a filesystem on all non-security directories.
>  ## </summary>
>  ## <param name="domain">
>  ##	<summary>
> @@ -352,12 +351,29 @@
>  ##	</summary>
>  ## </param>
>  #
> -interface(`files_mounton_non_security',`
> +interface(`files_mounton_non_security_dir',`
>  	gen_require(`
>  		attribute file_type, security_file_type;
>  	')
>  
>  	allow $1 { file_type -security_file_type }:dir mounton;
> +')
> +
> +########################################
> +## <summary>
> +##	Mount a filesystem on all non-security and files.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`files_mounton_non_security_files',`
> +	gen_require(`
> +		attribute file_type, security_file_type;
> +	')
> +
>  	allow $1 { file_type -security_file_type }:file mounton;
>  ')
>  
> @@ -376,7 +392,7 @@
>  		attribute file_type, security_file_type;
>  	')
>  
> -	allow $1 { file_type -security_file_type }:dir write;
> +	allow $1 { file_type -security_file_type }:dir rw_dir_perms;
>  ')
>  
>  ########################################
> @@ -987,7 +1003,7 @@
>  		attribute file_type;
>  	')
>  
> -	dontaudit $1 file_type:dir search;
> +	dontaudit $1 file_type:dir search_dir_perms;
>  ')
>  
>  ########################################
> @@ -1315,7 +1331,7 @@
>  		type boot_t;
>  	')
>  
> -	dontaudit $1 boot_t:dir search;
> +	dontaudit $1 boot_t:dir search_dir_perms;
>  ')
>  
>  ########################################
> @@ -3305,6 +3321,42 @@
>  
>  ########################################
>  ## <summary>
> +##	Add and remove entries from /usr directories.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`files_rw_usr_dirs',`
> +	gen_require(`
> +		type usr_t;
> +	')
> +
> +	allow $1 usr_t:dir rw_dir_perms;
> +')
> +
> +########################################
> +## <summary>
> +##	Create, read, write, and delete files in the /usr directory.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`files_manage_usr_files',`
> +	gen_require(`
> +		type usr_t;
> +	')
> +
> +	manage_files_pattern($1, usr_t, usr_t)
> +')
> +
> +########################################
> +## <summary>
>  ##	Get the attributes of files in /usr.
>  ## </summary>
>  ## <param name="domain">
> @@ -3632,7 +3684,7 @@
>  		type var_t;
>  	')
>  
> -	dontaudit $1 var_t:dir search;
> +	dontaudit $1 var_t:dir search_dir_perms;
>  ')
>  
>  ########################################
> @@ -3988,7 +4040,7 @@
>  		type var_lock_t;
>  	')
>  
> -	dontaudit $1 var_lock_t:dir search;
> +	dontaudit $1 var_lock_t:dir search_dir_perms;
>  ')
>  
>  ########################################
> @@ -4007,7 +4059,7 @@
>  		type var_t, var_lock_t;
>  	')
>  
> -	rw_dirs_pattern($1,var_t,var_lock_t)
> +	rw_files_pattern($1,var_t,var_lock_t)
>  ')
>  
>  ########################################
> @@ -4176,7 +4228,7 @@
>  		type var_run_t;
>  	')
>  
> -	dontaudit $1 var_run_t:dir search;
> +	dontaudit $1 var_run_t:dir search_dir_perms;
>  ')
>  
>  ########################################
> @@ -4524,6 +4576,8 @@
>  	# Need to give access to /selinux/member
>  	selinux_compute_member($1)
>  
> + 	files_search_home($1)
> +
>  	# Need sys_admin capability for mounting
>  	allow $1 self:capability { chown fsetid sys_admin };
>  
> @@ -4546,6 +4600,8 @@
>  	# Default type for mountpoints
>  	allow $1 poly_t:dir { create mounton };
>  	fs_unmount_xattr_fs($1)
> +	corecmd_exec_bin($1)
> +
>  ')
>  
>  ########################################
> @@ -4583,3 +4639,28 @@
>  
>  	allow $1 { file_type -security_file_type }:dir manage_dir_perms;
>  ')
> +
> +########################################
> +## <summary>
> +##	Create a core files in /
> +## </summary>
> +## <desc>
> +##	<p>
> +##	Create a core file in /,
> +##	</p>
> +## </desc>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`files_dump_core',`
> +	gen_require(`
> +		type root_t;
> +	')
> +
> +	allow $1 root_t:dir rw_dir_perms;
> +	allow $1 root_t:file { create getattr write };
> +')
> --- nsaserefpolicy/policy/modules/kernel/files.te	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/files.te	2007-05-30 09:25:53.000000000 -0400
> @@ -54,6 +54,7 @@
>  files_type(etc_t)
>  # compatibility aliases for removed types:
>  typealias etc_t alias automount_etc_t;
> +typealias etc_t alias snmpd_etc_t;
>  
>  #
>  # etc_runtime_t is the type of various
> --- nsaserefpolicy/policy/modules/kernel/filesystem.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/filesystem.if	2007-05-30 09:25:53.000000000 -0400
> @@ -1096,6 +1096,24 @@
>  
>  ########################################
>  ## <summary>
> +##	Search dosfs filesystem. 
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`fs_search_dos',`
> +	gen_require(`
> +		type dosfs_t;
> +	')
> +
> +	allow $1 dosfs_t:dir search_dir_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##	Read files on a DOS filesystem.
>  ## </summary>
>  ## <param name="domain">
> @@ -1291,6 +1309,26 @@
>  
>  ########################################
>  ## <summary>
> +##	Read files on an iso9660 filesystem, which
> +##	is usually used on CDs.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`fs_getattr_iso9660_files',`
> +	gen_require(`
> +		type iso9660_t;
> +	')
> +
> +	allow $1 iso9660_t:dir list_dir_perms;
> +	allow $1 iso9660_t:file getattr;
> +')
> +
> +########################################
> +## <summary>
>  ##	Mount a NFS filesystem.
>  ## </summary>
>  ## <param name="domain">
> @@ -3420,3 +3458,22 @@
>  	relabelfrom_blk_files_pattern($1,noxattrfs,noxattrfs)
>  	relabelfrom_chr_files_pattern($1,noxattrfs,noxattrfs)
>  ')
> +
> +
> +########################################
> +## <summary>
> +##      Mount an fuse filesystem.
> +## </summary>
> +## <param name="domain">
> +##      <summary>
> +##      Domain allowed access.
> +##      </summary>
> +## </param>
> +#
> +interface(`fs_mount_fusefs',`
> +        gen_require(`
> +                type fusefs_t;
> +        ')
> +
> +        allow $1 fusefs_t:filesystem mount;
> +')
> --- nsaserefpolicy/policy/modules/kernel/filesystem.te	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/filesystem.te	2007-05-30 09:25:53.000000000 -0400
> @@ -54,17 +54,29 @@
>  
>  type capifs_t;
>  fs_type(capifs_t)
> +files_mountpoint(capifs_t)
>  genfscon capifs / gen_context(system_u:object_r:capifs_t,s0)
>  
>  type configfs_t;
>  fs_type(configfs_t)
>  genfscon configfs / gen_context(system_u:object_r:configfs_t,s0)
>  
> +type cpusetfs_t;
> +fs_type(cpusetfs_t)
> +allow cpusetfs_t self:filesystem associate;
> +genfscon cpuset / gen_context(system_u:object_r:cpusetfs_t,s0)
> +
>  type eventpollfs_t;
>  fs_type(eventpollfs_t)
>  # change to task SID 20060628
>  #genfscon eventpollfs / gen_context(system_u:object_r:eventpollfs_t,s0)
>  
> +type fusefs_t;
> +fs_noxattr_type(fusefs_t)
> +allow fusefs_t self:filesystem associate;
> +genfscon fuse / gen_context(system_u:object_r:fusefs_t,s0)
> +genfscon fuseblk / gen_context(system_u:object_r:fusefs_t,s0)
> +
>  type futexfs_t;
>  fs_type(futexfs_t)
>  genfscon futexfs / gen_context(system_u:object_r:futexfs_t,s0)
> @@ -83,6 +95,11 @@
>  fs_type(inotifyfs_t)
>  genfscon inotifyfs / gen_context(system_u:object_r:inotifyfs_t,s0)
>  
> +type mvfs_t;
> +fs_noxattr_type(mvfs_t)
> +allow mvfs_t self:filesystem associate;
> +genfscon mvfs / gen_context(system_u:object_r:mvfs_t,s0)
> +
>  type nfsd_fs_t;
>  fs_type(nfsd_fs_t)
>  genfscon nfsd / gen_context(system_u:object_r:nfsd_fs_t,s0)
> @@ -105,6 +122,16 @@
>  genfscon rpc_pipefs / gen_context(system_u:object_r:rpc_pipefs_t,s0)
>  files_mountpoint(rpc_pipefs_t)
>  
> +type spufs_t;
> +fs_type(spufs_t)
> +genfscon spufs / gen_context(system_u:object_r:spufs_t,s0)
> +files_mountpoint(spufs_t)
> +
> +type vxfs_t;
> +fs_noxattr_type(vxfs_t)
> +files_mountpoint(vxfs_t)
> +genfscon vxfs / gen_context(system_u:object_r:vxfs_t,s0)
> +
>  #
>  # tmpfs_t is the type for tmpfs filesystems
>  #
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
