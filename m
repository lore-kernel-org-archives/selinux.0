Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SIH1ue024845
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 14:17:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2SIGxLB000869
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 18:17:00 GMT
Subject: Re: Samba guys reviewed samba policy and fixed some of the ports
	used by samba
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042767.8050508@redhat.com>
References: <46042767.8050508@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 14:17:36 -0400
Message-Id: <1175105856.29300.107.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:15 -0400, Daniel J Walsh wrote:
> Also added new ports for squid.

Looks like the wrong patch.

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (corenet_port_type.patch), "corenet_port_type.patch"
> 
> ---
> nsaserefpolicy/policy/modules/kernel/corenetwork.if.in      2007-02-19
> 11:32:51.000000000 -0500
> +++
> serefpolicy-2.5.10/policy/modules/kernel/corenetwork.if.in  2007-03-22
> 15:06:58.000000000 -0400
> @@ -1977,3 +1977,57 @@
>  
>         typeattribute $1 corenet_unconfined_type;
>  ')
> +
> +########################################
> +## <summary>
> +##     Define type to be a network port type
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Type to be used for network ports.
> +##     </summary>
> +## </param>
> +#
> +interface(`corenet_port_type',`
> +       gen_require(`
> +               attribute port_type;
> +       ')
> +
> +       typeattribute $1 port_type;
> +')
> +
> +########################################
> +## <summary>
> +##     Define network type to be a reserved port (lt 1024) 
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Type to be used for network ports.
> +##     </summary>
> +## </param>
> +#
> +interface(`corenet_reserved_port_type',`
> +       gen_require(`
> +               attribute reserved_port_type;
> +       ')
> +
> +       typeattribute $1 reserved_port_type;
> +')
> +
> +########################################
> +## <summary>
> +##     Define network type to be a rpc port ( 512 lt PORT lt 1024) 
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Type to be used for network ports.
> +##     </summary>
> +## </param>
> +#
> +interface(`corenet_rpc_port_type',`
> +       gen_require(`
> +               attribute rpc_port_type;
> +       ')
> +
> +       typeattribute $1 rpc_port_type;
> +')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
