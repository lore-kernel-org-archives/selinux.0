Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3JFY9fC001168
	for <selinux@tycho.nsa.gov>; Wed, 19 Apr 2006 11:34:09 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3JFY86v011573
	for <selinux@tycho.nsa.gov>; Wed, 19 Apr 2006 15:34:08 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4445AB7F.2000402@redhat.com>
References: <4445AB7F.2000402@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 11:34:54 -0400
Message-Id: <1145460894.13748.47.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-04-18 at 23:16 -0400, Daniel J Walsh wrote:
> Fix java domain,

Its not broken.

> Fix cups file context defs
> 
> ftp wants to use ldap to get users
> 
> postfix_map_t dontaudits
> 
> postgresql sometimes puts sock_file on /tmp
> 
> privoxy wants to connect to http_cache_ports
> 
> fix samb_net_t typo
> 
> samba needs access to ldap
> 
> samba wants to update utmp file
> 
> I believe sa-learn should be spamc_exec_t
> 
> pam_console needs to use certificates.
> 
> Additional textrel_shlib_t
> 
> Create new unconfined_mount_t to maintain /etc/mtab file context
> 
> useradd needs to be able to create user_home_dir_t.

@@ -4171,6 +4173,7 @@
>  		type user_home_dir_t;
>  	')
>  
> +	allow $1 user_home_dir_t:dir create_dir_perms;
>  	files_home_filetrans($1,user_home_dir_t,dir)
>  ')

This addition isn't appropriate for filetrans interfaces because it
doesn't give us the flexibility on how the domain can access the file,
for example, create vs create+unlink and create+write vs. create+append
won't be available, just create-write-unlink.

> customized types are not being created correctly.

Please apply relevant changes also to the Rules.monolithic, in the
future.

> @@ -60,6 +60,7 @@
>  
>  ifdef(`enable_mls',`
>  range_transition initrc_t auditd_exec_t s15:c0.c255;
> +range_transition secadm_t auditctl_exec_t s15:c0.c255;
>  range_transition kernel_t init_exec_t s0 - s15:c0.c255;
>  range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
>  ')

I still haven't heard a justification for why the regular mls interfaces
are not sufficient for this.

> +interface(`dev_dontaudit_getattr_all_device_nodes',`
> +	gen_require(`
> +		attribute device_node;
> +	')
> +
> +	dontaudit $1 device_t:dir_file_class_set getattr;
> +	dontaudit $1 device_node:dir_file_class_set getattr;
> +')

I still feel this is excessive, there shouldn't be an device_nodes that
aren't chr_files or blk_file, and if there are we need to know about it.

> +interface(`xserver_rw_xdm_sockets',`
> +	gen_require(`
> +		type xdm_xserver_tmp_t;
> +	')
> +
> +	allow $1 xdm_xserver_tmp_t:dir search;
> +	allow $1 xdm_xserver_tmp_t:sock_file { read write };
> +')

No one uses this interface.

> @@ -697,8 +697,8 @@
>  
>  	files_search_etc($1)
>  	allow $1 selinux_config_t:dir search;
> -	allow $1 file_context_t:dir r_dir_perms;
> -	allow $1 file_context_t:file rw_file_perms;
> +	allow $1 file_context_t:dir rw_dir_perms;
> +	allow $1 file_context_t:file create_file_perms;
>  	allow $1 file_context_t:lnk_file { getattr read };
>  ')

This is not appropriate as the interface is for read-write of file
contexts, not manage.

The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
