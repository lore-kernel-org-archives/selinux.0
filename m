Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
	when upstart runs a shell
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 16:26:37 -0500
Message-Id: <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>
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

So what happens if one does a single user boot under upstart?
That's the motivation for the original transition there.

Also, I guess we need to distinguish Fedora 9 and later from older
distros here.

> 
> Index: policy/modules/system/init.te
> ===================================================================
> --- policy/modules/system/init.te	(revision 2631)
> +++ policy/modules/system/init.te	(working copy)
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
>  
>  optional_policy(`
>  	auth_rw_login_records(init_t)
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
