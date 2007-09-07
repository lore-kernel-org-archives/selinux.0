Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DYdSt016417
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:34:39 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87DYaZj003163
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:34:36 GMT
Subject: Re: [PATCH] refpolicy: services_lpd changes New interface for samba
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022051.l72Kpj70000490@redsox.boston.devel.redhat.com>
References: <200708022051.l72Kpj70000490@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 13:33:15 +0000
Message-Id: <1189171995.3664.56.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:51 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/lpd.if       2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/lpd.if    2007-08-02 11:02:02.000000000 -0400
> @@ -394,3 +394,22 @@
> 
>         domtrans_pattern($2, lpr_exec_t, $1_lpr_t)
>  ')
> +
> +########################################
> +## <summary>
> +##     Allow the specified domain to execute lpr
> +##     in the caller domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`lpd_exec_lpr',`
> +       gen_require(`
> +               type lpr_exec_t;
> +       ')
> +
> +       can_exec($1,lpr_exec_t)
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
