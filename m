Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DYnSO016485
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:34:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87DYaZt003163
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:34:46 GMT
Subject: Re: [PATCH] refpolicy: apps_ada changes add ada_run policy for
	unconfined user
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021955.l72Jt0ri029372@redsox.boston.devel.redhat.com>
References: <200708021955.l72Jt0ri029372@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:33:18 -0400
Message-Id: <1189171998.3664.61.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:55 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/apps/ada.if   2007-05-29
> 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/ada.if        2007-08-02
> 11:02:02.000000000 -0400
> @@ -18,3 +18,34 @@
>         corecmd_search_bin($1)
>         domtrans_pattern($1, ada_exec_t, ada_t)
>  ')
> +
> +########################################
> +## <summary>
> +##     Execute ada in the ada domain, and
> +##     allow the specified role the ada domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +## <param name="role">
> +##     <summary>
> +##     The role to be allowed the ada domain.
> +##     </summary>
> +## </param>
> +## <param name="terminal">
> +##     <summary>
> +##     The type of the terminal allow the ada domain to use.
> +##     </summary>
> +## </param>
> +#
> +interface(`ada_run',`
> +       gen_require(`
> +               type ada_t;
> +       ')
> +
> +       ada_domtrans($1)
> +       role $2 types ada_t;
> +       allow ada_t $3:chr_file rw_term_perms;
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
