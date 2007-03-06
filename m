Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26EFwB2030571
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 09:15:58 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l26EHOF8018057
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 14:17:24 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: dev_delete to be used by lvm tools
Date: Tue, 6 Mar 2007 09:17:25 -0500
Message-ID: <1173190645.15853.5.camel@sgc>
In-Reply-To: <200702261953.l1QJrc8v031897@localhost.localdomain>
References: <200702261953.l1QJrc8v031897@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:53 -0500, dwalsh@localhost.localdomain wrote:

dev_delete_generic_dirs() already exists.

> ===File /tmp/patches/nsaserefpolicy_policy_modules_kernel_devices.if===
> --- nsaserefpolicy/policy/modules/kernel/devices.if	2007-01-02 12:57:13.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/kernel/devices.if	2007-02-26 11:04:23.000000000 -0500
> @@ -3173,3 +3173,21 @@
>  
>  	typeattribute $1 devices_unconfined_type;
>  ')
> +
> +########################################
> +## <summary>
> +##	delete entries from directories in /dev.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed to delete entries.
> +##	</summary>
> +## </param>
> +#
> +interface(`dev_delete',`
> +	gen_require(`
> +		type device_t;
> +	')
> +
> +	allow $1 device_t:dir delete_dir_perms;
> +')
> ============================================================
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
