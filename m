Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IExVJR002713
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 10:59:31 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IExUAI028389
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:59:30 GMT
Subject: Re: refpolicy patch: samba enhancements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <487BB78D.6080500@kutulu.org>
References: <487BB78D.6080500@kutulu.org>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 10:59:03 -0400
Message-Id: <1216393143.21191.155.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-07-14 at 16:31 -0400, Mike Edenfield wrote:
> I apologize if I'm not doing this right, I'm kinda new at this...
> 
> I have made some changes to the SELinux policy for our intranet servers 
> that I thought might be useful to a broader audience.  Included below is 
> a patch to the latest refpolicy.  This has been tested on the Gentoo 
> systems we have here; I don't have easy access to other SELinux systems 
> at the moment.  It does the following:
> 
> * Updates samba_stream_connect_winbind to match the observed behavior of 
> winbind
> 
> * Gives winbind access to delete its own sockets
> 
> * Gives nmbd access to fully manage (i.e. rename) log files
> 
> * Adds a tunable that lets samba create home directories via pam_mkhomedir

A few notes:

> Index: policy/modules/services/samba.if
> ===================================================================
> --- policy/modules/services/samba.if	(revision 2758)
> +++ policy/modules/services/samba.if	(working copy)
> @@ -484,17 +484,19 @@
>   ## </param>
>   #
>   interface(`samba_stream_connect_winbind',`
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
> -		stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
> -	',`
> +	files_search_pids($1)
> +	allow $1 samba_var_t:dir search_dir_perms;
> +	stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
> +	
> +	ifdef(`distro_redhat',`', `

This can be ifndef(`distro_redhat',`


> +tunable_policy(`samba_create_home_dirs',`
> +    unprivuser_home_filetrans_home_dir(smbd_t)
> +    unprivuser_manage_home_dirs(smbd_t)

I think we want this to be unprivuser_create_home_dirs(), which would
need to be added.

> +
> +    allow smbd_t self:capability chown;
> +')



> @@ -404,7 +419,7 @@
>   read_files_pattern(nmbd_t,samba_etc_t,samba_etc_t)
> 
>   manage_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
> -append_files_pattern(nmbd_t,samba_log_t,samba_log_t)
> +manage_files_pattern(nmbd_t,samba_log_t,samba_log_t)
>   allow nmbd_t samba_log_t:file unlink;
> 
>   read_files_pattern(nmbd_t,samba_log_t,samba_log_t)

If the goal is just to add a rename permission onto nmbd, then that
permission should be added explicitly.  Manage will allow it to delete
the log, which we don't want, if we don't have to.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
