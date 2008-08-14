Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQXa6003926
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQIaK008181
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:18 GMT
Subject: Re: [patch 05/35] courier policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123735.341195390@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123735.341195390@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:22 -0400
Message-Id: <1218723922.8095.79.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_courier.patch)
> Adds a separate context for courier spooling dirs/files and a few
> new interfaces.

Comments inline

> Originally sent on Jul 19, received no comments, refreshed patch only
> 
> Index: refpolicy/policy/modules/services/courier.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/services/courier.fc	2008-08-03 13:09:39.000000000 +0200
> +++ refpolicy/policy/modules/services/courier.fc	2008-08-03 17:04:59.000000000 +0200
> @@ -19,3 +19,5 @@
>  /var/lib/courier(/.*)?			--	gen_context(system_u:object_r:courier_var_lib_t,s0)
>  
>  /var/run/courier(/.*)?			--	gen_context(system_u:object_r:courier_var_run_t,s0)
> +
> +/var/spool/courier(/.*)?		gen_context(system_u:object_r:courier_spool_t,s0)
> Index: refpolicy/policy/modules/services/courier.if
> ===================================================================
> --- refpolicy.orig/policy/modules/services/courier.if	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/courier.if	2008-08-03 17:05:41.000000000 +0200
> @@ -123,3 +123,77 @@
>  
>  	domtrans_pattern($1, courier_pop_exec_t, courier_pop_t)
>  ')
> +
> +
> +########################################
> +## <summary>
> +##	Allow domain to read courier config files
> +## </summary>
> +## <param name="prefix">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`courier_read_config',`
> +	gen_require(`
> +		type courier_etc_t;
> +	')
> +
> +	read_files_pattern($1, courier_etc_t, courier_etc_t)
> +')
> +
> +########################################
> +## <summary>
> +##	Allow domain to manage courier spool directories
> +## </summary>
> +## <param name="prefix">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`courier_manage_spool_dirs',`
> +	gen_require(`
> +		type courier_spool_t;
> +	')
> +
> +	manage_dirs_pattern($1, courier_spool_t, courier_spool_t)
> +')
> +
> +########################################
> +## <summary>
> +##	Allow domain to manage courier spool files
> +## </summary>
> +## <param name="prefix">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`courier_manage_spool_files',`
> +	gen_require(`
> +		type courier_spool_t;
> +	')
> +
> +	manage_files_pattern($1, courier_spool_t, courier_spool_t)
> +')
> +
> +########################################
> +## <summary>
> +##	Allow attempts to read and write to
> +##	courier unnamed pipes.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain to not audit.
> +##	</summary>
> +## </param>
> +#
> +interface(`courier_rw_pipes',`
> +	gen_require(`
> +		type courier_spool_t;
> +	')
> +
> +	allow $1 courier_spool_t:fifo_file rw_fifo_file_perms;
> +')
> Index: refpolicy/policy/modules/services/courier.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/courier.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/courier.te	2008-08-03 17:04:59.000000000 +0200
> @@ -9,7 +9,10 @@
>  courier_domain_template(authdaemon)
>  
>  type courier_etc_t;
> -files_type(courier_etc_t)
> +files_config_file(courier_etc_t)
> +
> +type courier_spool_t;
> +files_type(courier_spool_t)
>  
>  courier_domain_template(pcp)
>  
> @@ -25,6 +28,7 @@
>  
>  type courier_exec_t;
>  files_type(courier_exec_t)
> +mta_mailclient(courier_exec_t)

Interface does not exist.

>  courier_domain_template(sqwebmail)
>  typealias courier_sqwebmail_exec_t alias sqwebmail_cron_exec_t;
> @@ -97,12 +101,12 @@
>  courier_domtrans_authdaemon(courier_pop_t)
>  
>  # do the actual work (read the Maildir)
> -userdom_manage_unpriv_users_home_content_files(courier_pop_t)
> +unprivuser_manage_home_content_files(courier_pop_t)
>  # cjp: the fact that this is different for pop vs imap means that
>  # there should probably be a courier_pop_t and courier_imap_t
>  # this should also probably be a separate type too instead of
>  # the regular home dir
> -userdom_manage_unpriv_users_home_content_dirs(courier_pop_t)
> +unprivuser_manage_home_content_dirs(courier_pop_t)

User home dirs aren't collapsed upstream, so this doesn't make sense.


Merged the remainder.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
