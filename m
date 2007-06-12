Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD1C1q017681
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:01:12 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD18gs003219
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:01:11 GMT
Subject: Re: services_networkmanager changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301544.l4UFiHN3011890@localhost.localdomain>
References: <200705301544.l4UFiHN3011890@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:59:27 -0400
Message-Id: <1181653167.16029.65.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:44 -0400, dwalsh@redhat.com wrote:
> Additional transition rule so uncofnined_t can transition to network manager, requested by networkmanager maintainers
> --- nsaserefpolicy/policy/modules/services/networkmanager.if	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/networkmanager.if	2007-05-30 09:25:53.000000000 -0400
> @@ -78,3 +78,22 @@
>  	allow $1 NetworkManager_t:dbus send_msg;
>  	allow NetworkManager_t $1:dbus send_msg;
>  ')
> +
> +########################################
> +## <summary>
> +##	Transition to NetworkManager 
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`networkmanager_domtrans',`
> +	gen_require(`
> +		type NetworkManager_t, NetworkManager_exec_t;
> +	')
> +	corecmd_search_bin($1)
> +	domtrans_pattern($1,NetworkManager_exec_t,NetworkManager_t)
> +
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
