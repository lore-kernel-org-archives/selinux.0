Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHpAmE003434
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:51:10 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BHp6GS010590
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:51:09 GMT
Subject: Re: sasl authd uses kerberos
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042E2C.8030807@redhat.com>
References: <46042E2C.8030807@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 13:51:55 -0400
Message-Id: <1176313915.9840.47.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:44 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/sasl.te      2007-03-20 23:38:13.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/sasl.te  2007-03-22 15:06:59.000000000 -0400
> @@ -10,6 +10,9 @@
>  type saslauthd_exec_t;
>  init_daemon_domain(saslauthd_t,saslauthd_exec_t)
>  
> +type saslauthd_tmp_t;
> +files_tmp_file(saslauthd_tmp_t)
> +
>  type saslauthd_var_run_t;
>  files_pid_file(saslauthd_var_run_t)
>  
> @@ -26,6 +29,10 @@
>  allow saslauthd_t self:unix_stream_socket create_stream_socket_perms;
>  allow saslauthd_t self:tcp_socket create_socket_perms;
>  
> +manage_files_pattern(saslauthd_t,saslauthd_tmp_t,saslauthd_tmp_t)
> +allow saslauthd_t saslauthd_tmp_t:dir setattr;
> +files_tmp_filetrans(saslauthd_t,saslauthd_tmp_t,file)
> +
>  manage_files_pattern(saslauthd_t,saslauthd_var_run_t,saslauthd_var_run_t)
>  manage_sock_files_pattern(saslauthd_t,saslauthd_var_run_t,saslauthd_var_run_t)
>  files_pid_filetrans(saslauthd_t,saslauthd_var_run_t,file)
> @@ -89,6 +96,10 @@
>  ')
>  
>  optional_policy(`
> +       kerberos_read_keytab(saslauthd_t)
> +')
> +
> +optional_policy(`
>         mysql_search_db(saslauthd_t)
>         mysql_stream_connect(saslauthd_t)
>  ')

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
