Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AHdTE5012814
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:39:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AHdRjD027642
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 17:39:28 GMT
Subject: Re: Added a patch so third party policy makers can identify ports
	as port_types
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460425D1.8090002@comcast.net>
References: <460425D1.8090002@comcast.net>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 13:40:06 -0400
Message-Id: <1176226807.9840.25.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:09 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/kernel/corenetwork.if.in      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/kernel/corenetwork.if.in  2007-03-22 15:06:58.000000000 -0400
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

Merged, but dropped _type out of the interface names.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
