Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75D0jP3000778
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 09:00:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m75D0d0u004658
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 13:00:39 GMT
Subject: Re: [refpolicy] corrected/rebased samba patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <48975B9A.3030400@kutulu.org>
References: <48975B9A.3030400@kutulu.org>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 09:00:14 -0400
Message-Id: <1217941214.4114.81.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 15:42 -0400, Mike Edenfield wrote:
> Previous patch was somehow malformed; here's a clean and rebased one.
> 
> ---
> 
> * Allow winbind to clean up its sockets on shutdown
> * Allow nmbd to rename log files
> * Update winbind interface to permit access to both sockets
> * Add interface to allow creation (only) of home directories
> * Add tunable to allow samba to create home directories on the fly.

Merged.


>   roles/unprivuser.if |   19 +++++++++++++++++++
>   services/samba.if   |   18 +++++++++---------
>   services/samba.te   |   17 +++++++++++++++--
>   3 files changed, 43 insertions(+), 11 deletions(-)
> 
> plain text document attachment (samba.patch)
> Index: policy/modules/services/samba.if
> ===================================================================
> --- policy/modules/services/samba.if	(revision 2770)
> +++ policy/modules/services/samba.if	(working copy)
> @@ -484,17 +484,17 @@
>  ## </param>
>  #
>  interface(`samba_stream_connect_winbind',`
> -	ifdef(`distro_redhat',`
> -		gen_require(`
> -			type samba_var_t, winbind_t, winbind_var_run_t;
> -		')
> +	gen_require(`
> +		type samba_var_t, winbind_t, winbind_var_run_t;
> +	')
>  
> -		files_search_pids($1)
> -		allow $1 samba_var_t:dir search_dir_perms;
> -		stream_connect_pattern($1, winbind_var_run_t, winbind_var_run_t, winbind_t)
> -	',`
> +	files_search_pids($1)
> +	allow $1 samba_var_t:dir search_dir_perms;
> +	stream_connect_pattern($1, winbind_var_run_t, winbind_var_run_t, winbind_t)
> +	
> +	ifndef(`distro_redhat', `
>  		gen_require(`
> -			type winbind_t, winbind_tmp_t;
> +		    type winbind_tmp_t;
>  		')
>  
>  		# the default for the socket is (poorly named):
> Index: policy/modules/services/samba.te
> ===================================================================
> --- policy/modules/services/samba.te	(revision 2770)
> +++ policy/modules/services/samba.te	(working copy)
> @@ -17,6 +17,13 @@
>  
>  ## <desc>
>  ## <p>
> +## Allow samba to create new home directories (e.g. via PAM)
> +## </p>
> +## </desc>
> +gen_tunable(samba_create_home_dirs, false)
> +
> +## <desc>
> +## <p>
>  ## Allow samba to act as the domain controller, add users,
>  ## groups and change passwords.
>  ## 
> @@ -379,6 +386,12 @@
>  	unprivuser_home_dir_filetrans_home_content(nmbd_t, { file dir })
>  ')
>  
> +tunable_policy(`samba_create_home_dirs',`
> +	unprivuser_home_filetrans_home_dir(smbd_t)
> +	unprivuser_create_home_dir(smbd_t)
> +	allow smbd_t self:capability chown;
> +')
> +
>  ########################################
>  #
>  # nmbd Local policy
> @@ -404,8 +417,7 @@
>  read_files_pattern(nmbd_t, samba_etc_t, samba_etc_t)
>  
>  manage_dirs_pattern(nmbd_t, samba_log_t, samba_log_t)
> -append_files_pattern(nmbd_t, samba_log_t, samba_log_t)
> -allow nmbd_t samba_log_t:file unlink;
> +manage_files_pattern(nmbd_t, samba_log_t, samba_log_t)
>  
>  read_files_pattern(nmbd_t, samba_log_t, samba_log_t)
>  create_files_pattern(nmbd_t, samba_log_t, samba_log_t)
> @@ -675,6 +687,7 @@
>  
>  manage_dirs_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
>  manage_files_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
> +manage_sock_files_pattern(winbind_t, winbind_tmp_t, winbind_tmp_t)
>  files_tmp_filetrans(winbind_t, winbind_tmp_t, { file dir })
>  
>  manage_files_pattern(winbind_t, winbind_var_run_t, winbind_var_run_t)
> Index: policy/modules/roles/unprivuser.if
> ===================================================================
> --- policy/modules/roles/unprivuser.if	(revision 2770)
> +++ policy/modules/roles/unprivuser.if	(working copy)
> @@ -126,6 +126,25 @@
>  
>  ########################################
>  ## <summary>
> +## Create generic user home directories
> +## </summary>
> +## <param name="domain">
> +##  <summary>
> +##  Domain allowed access.
> +##  </summary>
> +## </param>
> +#
> +interface(`unprivuser_create_home_dir',`
> +	gen_require(`
> +		type user_home_dir_t;
> +	')
> +
> +	files_search_home($1)
> +	allow $1 user_home_dir_t:dir create_dir_perms;
> +')
> +
> +########################################
> +## <summary>
>  ##	Create, read, write, and delete generic user
>  ##	home directories.
>  ## </summary>
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
