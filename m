Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD62QX031014
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:06:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgr027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:06:01 GMT
Subject: Re: ccs uses tmp files.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46043312.7050105@redhat.com>
References: <46043312.7050105@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:41 -0400
Message-Id: <1176210401.9840.17.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:05 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/ccs.te       2007-03-20 23:38:06.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/ccs.te   2007-03-22 15:06:59.000000000 -0400
> @@ -10,10 +10,14 @@
>  type ccs_exec_t;
>  init_daemon_domain(ccs_t, ccs_exec_t)
>  
> -# pid files
> +# conf files
>  type cluster_conf_t;
>  files_type(cluster_conf_t)
>  
> +# tmp files
> +type ccs_tmp_t;
> +files_tmp_file(ccs_tmp_t)
> +
>  # log files
>  type ccs_var_log_t;
>  logging_log_file(ccs_var_log_t)
> @@ -45,6 +49,12 @@
>  
>  manage_files_pattern(ccs_t,cluster_conf_t,cluster_conf_t)
>  
> +# tmp file
> +allow ccs_t ccs_tmp_t:dir manage_dir_perms;
> +manage_dirs_pattern(ccs_t,ccs_tmp_t,ccs_tmp_t)
> +manage_files_pattern(ccs_t,ccs_tmp_t,ccs_tmp_t)
> +files_tmp_filetrans(ccs_t, ccs_tmp_t, { file dir })
> +
>  # log files
>  manage_files_pattern(ccs_t,ccs_var_log_t,ccs_var_log_t)
>  manage_sock_files_pattern(ccs_t,ccs_var_log_t,ccs_var_log_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
