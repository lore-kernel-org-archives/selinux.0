Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IHgPgc000665
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:42:25 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IHgOoF014404
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 17:42:24 GMT
Message-ID: <4880D5FC.5030400@redhat.com>
Date: Fri, 18 Jul 2008 13:42:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mike Edenfield <kutulu@kutulu.org>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org>
In-Reply-To: <487BB78D.6080500@kutulu.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Edenfield wrote:
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
> 
> 
> Index: policy/modules/services/samba.if
> ===================================================================
> --- policy/modules/services/samba.if    (revision 2758)
> +++ policy/modules/services/samba.if    (working copy)
> @@ -484,17 +484,19 @@
>  ## </param>
>  #
>  interface(`samba_stream_connect_winbind',`
> -    ifdef(`distro_redhat',`
> -        gen_require(`
> -            type samba_var_t, winbind_t, winbind_var_run_t;
> -        ')
> +    gen_require(`
> +        type samba_var_t, winbind_t, winbind_var_run_t;
> +    ')
> 
> -        files_search_pids($1)
> -        allow $1 samba_var_t:dir search_dir_perms;
> -       
> stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
> -    ',`
> +    files_search_pids($1)
> +    allow $1 samba_var_t:dir search_dir_perms;
> +   
> stream_connect_pattern($1,winbind_var_run_t,winbind_var_run_t,winbind_t)
> +   
> +    ifdef(`distro_redhat',`', `
>          gen_require(`
> -            type winbind_t, winbind_tmp_t;
> +            type winbind_tmp_t;
>          ')
> 
>          # the default for the socket is (poorly named):
> Index: policy/modules/services/samba.te
> ===================================================================
> --- policy/modules/services/samba.te    (revision 2758)
> +++ policy/modules/services/samba.te    (working copy)
> @@ -59,6 +59,13 @@
>  ## </desc>
>  gen_tunable(samba_share_nfs,false)
> 
> +## <desc>
> +## <p>
> +## Allow samba to create new home directories (e.g. via PAM)
> +## </p>
> +## </desc>
> +gen_tunable(samba_create_home_dirs,false)
> +
>  type nmbd_t;
>  type nmbd_exec_t;
>  init_daemon_domain(nmbd_t,nmbd_exec_t)
> @@ -379,6 +386,14 @@
>      unprivuser_home_dir_filetrans_home_content(nmbd_t, { file dir })
>  ')
> 
> +tunable_policy(`samba_create_home_dirs',`
> +    unprivuser_home_filetrans_home_dir(smbd_t)
> +    unprivuser_manage_home_dirs(smbd_t)
> +
> +    allow smbd_t self:capability chown;
> +')
>  ########################################
>  #
>  # nmbd Local policy
> @@ -404,7 +419,7 @@
>  read_files_pattern(nmbd_t,samba_etc_t,samba_etc_t)
> 
>  manage_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
> -append_files_pattern(nmbd_t,samba_log_t,samba_log_t)
> +manage_files_pattern(nmbd_t,samba_log_t,samba_log_t)
>  allow nmbd_t samba_log_t:file unlink;
> 
>  read_files_pattern(nmbd_t,samba_log_t,samba_log_t)
> @@ -675,6 +690,7 @@
> 
>  manage_dirs_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
>  manage_files_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
> +manage_sock_files_pattern(winbind_t,winbind_tmp_t,winbind_tmp_t)
>  files_tmp_filetrans(winbind_t, winbind_tmp_t, { file dir })
> 
>  manage_files_pattern(winbind_t,winbind_var_run_t,winbind_var_run_t)
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Could you do this with pam_oddjob_mkhomedir without having to add the
privs.  I think this is a better solution.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiA1fwACgkQrlYvE4MpobNGsACfUVTxg3r9Z5BWOcDvyFhhbdyt
QKMAoJHXtwqhlM2dAIsizZ2bhvjnKtrz
=E5Av
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
