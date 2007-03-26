Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJhZ2P023277
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:43:35 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJhXYx025290
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:43:33 GMT
Subject: Re: ipsec tools domtrans patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02D32.2040508@redhat.com>
References: <45F02D32.2040508@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 19:44:09 +0000
Message-Id: <1174938249.28830.74.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:35 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/ipsec.if       2007-01-02 12:57:49.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/ipsec.if    2007-03-08 10:31:24.000000000 -0500
> @@ -111,3 +111,103 @@
>         files_search_pids($1)
>         manage_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
>  ')
> +
> +########################################
> +## <summary>
> +##     Allow an IPsec SA to be used by an IPsec Policy.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`ipsec_labeled',`
> +       gen_require(`
> +               type ipsec_spd_t;
> +       ')
> +
> +       allow $1 ipsec_spd_t:association polmatch;
> +       domain_ipsec_labels($1)
> +')

Not so sure about this one.  I don't think we want to allow sending and
receiving to all domains.

> +########################################
> +## <summary>
> +##     Execute racoon in the racoon domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`ipsec_domtrans_racoon',`
> +       gen_require(`
> +               type racoon_t, racoon_exec_t;
> +       ')
> +
> +       domain_auto_trans($1,racoon_exec_t,racoon_t)
> +
> +       allow $1 racoon_t:fd use;
> +       allow racoon_t $1:fd use;
> +       allow racoon_t $1:fifo_file rw_file_perms;
> +       allow racoon_t $1:process sigchld;
> +')
> +
> +########################################
> +## <summary>
> +##     Execute setkey in the setkey domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`ipsec_domtrans_setkey',`
> +       gen_require(`
> +               type setkey_t, setkey_exec_t;
> +       ')
> +       domain_auto_trans($1,setkey_exec_t,setkey_t)
> +
> +       allow $1 setkey_t:fd use;
> +       allow setkey_t $1:fd use;
> +       allow setkey_t $1:fifo_file rw_file_perms;
> +       allow setkey_t $1:process sigchld;
> +')

Merged these

> +########################################
> +## <summary>
> +##     Execute ipsec-tools in the setkey and racoon domains
> +##     and allow the specified role the domains.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +## <param name="role">
> +##     <summary>
> +##     The role to be allowed the racoon and setkey domains.
> +##     </summary>
> +## </param>
> +## <param name="terminal">
> +##     <summary>
> +##     The type of the terminal allow the racoon and setkey domains to use.
> +##     </summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`ipsec_run_tools',`
> +       gen_require(`
> +               type racoon_t, setkey_t;
> +       ')
> +       ipsec_domtrans_racoon($1)
> +       role $2 types racoon_t;
> +       allow racoon_t $3:chr_file rw_term_perms;
> +       
> +       ipsec_domtrans_setkey($1)
> +       role $2 types setkey_t;
> +       allow setkey_t $3:chr_file rw_term_perms;
> +')

Turned this into ipsec run setkey.  Racoon is a daemon so it doesn't
make sense to be here.

> --- nsaserefpolicy/policy/modules/kernel/domain.if      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/domain.if   2007-03-08 08:42:36.000000000 -0500
> @@ -1254,3 +1254,21 @@
>         typeattribute $1 can_change_object_identity;
>         typeattribute $1 set_curr_context;
>  ')
> +
> +########################################
> +## <summary>
> +##     Allow specified type to associate ipsec packets from any domain
> +## </summary>
> +## <param name="type">
> +##     <summary>
> +##     Type of subject to be allowed this.
> +##     </summary>
> +## </param>
> +#
> +interface(`domain_ipsec_labels',`
> +       gen_require(`
> +               attribute domain;
> +       ')
> + 
> +       allow $1 domain:association { sendto recvfrom };
> +')
> --- nsaserefpolicy/policy/modules/system/userdomain.if  2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/userdomain.if       2007-03-08 10:30:10.000000000 -0500
> @@ -1313,6 +1318,8 @@
>  
>         init_exec($1)
>  
> +       ipsec_run_tools($1,$2,$3)
> +
>         logging_send_syslog_msg($1)
>         logging_read_audit_log($1)
>         logging_read_generic_logs($1) 

changed this do ipsec_run_setkey and made it optional.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
