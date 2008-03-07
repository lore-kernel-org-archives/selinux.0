Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
	when upstart runs a shell
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 14:13:15 -0500
Message-Id: <1204917195.20251.51.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
> Upstart spawns a shell during boot and, without this patch, it will
> transition to the sysadm_t domain, but remain in the system_r role.
> Services started by that shell will fail to start, even in permissive
> mode, if system_u:system_r:sysadm_someservice_t is an invalid context.
> We really don't want to be starting services from the sysadm_t domain
> during boot.

Instead of doing this, perhaps we should switch it to positive logic?
Its much more verbose, but its significantly clearer.  Though we're
going to have to add a distro_rhel5 in that case.  Another option might
be to make an init_sysvinit or init_upstart tunable.

> @@ -164,10 +164,12 @@
>  ')
>  
>  ifndef(`distro_ubuntu',`
> +ifndef(`distro_redhat',`
>  	# Run the shell in the sysadm role for single-user mode.
>  	# causes problems with upstart
>  	userdom_shell_domtrans_sysadm(init_t)
>  ')
> +')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
