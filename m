Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27KRmIa004167
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:27:48 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l27KTD7i013801
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 20:29:15 GMT
Subject: Re: procmail changes for policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@localhost.localdomain
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200702261734.l1QHY06i030665@localhost.localdomain>
References: <200702261734.l1QHY06i030665@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 15:29:19 -0500
Message-Id: <1173299359.10747.26.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:34 -0500, dwalsh@localhost.localdomain wrote:
> procmail uses /tmp files
> 	 Wants to send signull to itself
> 	 Can exec ls
> 	 Read spamassinn_lib_dirs

Merged, with a little reorg.

> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_procmail.patch===
> --- nsaserefpolicy/policy/modules/services/procmail.te	2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/procmail.te	2007-02-26 11:02:34.000000000 -0500
> @@ -10,15 +10,19 @@
>  type procmail_exec_t;
>  domain_type(procmail_t)
>  domain_entry_file(procmail_t,procmail_exec_t)
> +userdom_executable_file(procmail_exec_t)
>  role system_r types procmail_t;
>  
> +type procmail_tmp_t;
> +files_tmp_file(procmail_tmp_t)
> +
>  ########################################
>  #
>  # Local policy
>  #
>  
>  allow procmail_t self:capability { sys_nice chown setuid setgid dac_override };
> -allow procmail_t self:process { setsched signal };
> +allow procmail_t self:process { setsched signal signull };
>  allow procmail_t self:fifo_file rw_fifo_file_perms;
>  allow procmail_t self:unix_stream_socket create_socket_perms;
>  allow procmail_t self:unix_dgram_socket create_socket_perms;
> @@ -50,6 +54,10 @@
>  corecmd_exec_bin(procmail_t)
>  corecmd_exec_shell(procmail_t)
>  corecmd_dontaudit_search_sbin(procmail_t)
> +corecmd_exec_ls(procmail_t)
> +
> +allow procmail_t procmail_tmp_t:file create_file_perms;
> +files_tmp_filetrans(procmail_t, procmail_tmp_t, file)
>  
>  files_read_etc_files(procmail_t)
>  files_read_etc_runtime_files(procmail_t)
> @@ -115,8 +123,7 @@
>  optional_policy(`
>  	corenet_udp_bind_generic_port(procmail_t)
>  
> -	files_getattr_tmp_dirs(procmail_t)
> -
>  	spamassassin_exec(procmail_t)
>  	spamassassin_exec_client(procmail_t)
> +	spamassassin_read_lib_files(procmail_t)
>  ')
> ============================================================
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
