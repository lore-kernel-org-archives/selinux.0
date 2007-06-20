Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KJfUO9014545
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 15:41:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5KJfNe7005096
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 19:41:29 GMT
Subject: Re: kernel_corecommands changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301540.l4UFeMx8011828@localhost.localdomain>
References: <200705301540.l4UFeMx8011828@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 15:39:38 -0400
Message-Id: <1182368378.16539.39.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:40 -0400, dwalsh@redhat.com wrote:
> Additional bin_t files

Merged.

> --- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/corecommands.fc	2007-05-30 09:25:53.000000000 -0400
> @@ -36,6 +36,11 @@
>  /etc/cipe/ip-up.*		--	gen_context(system_u:object_r:bin_t,s0)
>  /etc/cipe/ip-down.*		--	gen_context(system_u:object_r:bin_t,s0)
>  
> +/etc/cron.daily/.*		--	gen_context(system_u:object_r:bin_t,s0)
> +/etc/cron.hourly/.*		--	gen_context(system_u:object_r:bin_t,s0)
> +/etc/cron.weekly/.*		--	gen_context(system_u:object_r:bin_t,s0)
> +/etc/cron.monthly/.*		--	gen_context(system_u:object_r:bin_t,s0)
> +
>  /etc/hotplug/.*agent		--	gen_context(system_u:object_r:bin_t,s0)
>  /etc/hotplug/.*rc		-- 	gen_context(system_u:object_r:bin_t,s0)
>  /etc/hotplug/hotplug\.functions --	gen_context(system_u:object_r:bin_t,s0)
> @@ -244,6 +253,7 @@
>  /var/ftp/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
>  
>  /usr/lib/yp/.+			--	gen_context(system_u:object_r:bin_t,s0)
> +/usr/lib64/yp/.+		--	gen_context(system_u:object_r:bin_t,s0)
>  
>  /var/qmail/bin                  -d      gen_context(system_u:object_r:bin_t,s0)
>  /var/qmail/bin(/.*)?                    gen_context(system_u:object_r:bin_t,s0)
> @@ -252,3 +262,5 @@
>  ifdef(`distro_suse',`
>  /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
>  ')
> +/usr/lib/vmware-tools/sbin32(/.*)?      gen_context(system_u:object_r:bin_t,s0)
> +
> --- nsaserefpolicy/policy/modules/kernel/corecommands.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/corecommands.if	2007-05-30 09:25:53.000000000 -0400
> @@ -980,3 +980,23 @@
>  
>  	mmap_files_pattern($1,bin_t,exec_type)
>  ')
> +
> +########################################
> +## <summary>
> +##	dontaudit checking for execute privs on all executables
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`corecmd_dontaudit_exec_all_executables',`
> +	gen_require(`
> +		attribute exec_type;
> +	')
> +
> +	dontaudit $1 exec_type:file execute;
> +')
> +
> +
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
