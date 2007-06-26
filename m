Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5QJ77sl024451
	for <selinux@tycho.nsa.gov>; Tue, 26 Jun 2007 15:07:07 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5QJ76X4008426
	for <selinux@tycho.nsa.gov>; Tue, 26 Jun 2007 19:07:06 GMT
Subject: Re: Clamd creates files in amavis_var_run_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301503.l4UF31BJ009240@localhost.localdomain>
References: <200705301503.l4UF31BJ009240@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 15:05:18 -0400
Message-Id: <1182884718.14634.3.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:03 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/clamav.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/clamav.te	2007-05-30 07:35:54.000000000 -0400
> @@ -121,6 +121,7 @@
>  	amavis_read_lib_files(clamd_t)
>  	amavis_read_spool_files(clamd_t)
>  	amavis_spool_filetrans(clamd_t,clamd_var_run_t,sock_file)
> +	amavis_create_pid_files(clamd_t)
>  ')
>  
>  ########################################
> --- nsaserefpolicy/policy/modules/services/amavis.if	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/amavis.if	2007-05-30 09:25:53.000000000 -0400
> @@ -167,3 +167,22 @@
>  	allow $1 amavis_var_run_t:file setattr;
>  	files_search_pids($1)
>  ')
> +
> +########################################
> +## <summary>
> +##	Set the create of amavis var run files.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`amavis_create_pid_files',`
> +	gen_require(`
> +		type amavis_var_run_t;
> +	')
> +
> +	allow $1 amavis_var_run_t:file create_file_perms;
> +	files_search_pids($1)
> +')

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
