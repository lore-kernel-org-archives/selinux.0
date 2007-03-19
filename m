Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JJ4cVT008910
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 15:04:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JJ4bRc011721
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 19:04:37 GMT
Subject: Re: amtu policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F01E16.5070002@redhat.com>
References: <45F01E16.5070002@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 19:05:10 +0000
Message-Id: <1174331110.16707.15.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:30 -0500, Daniel J Walsh wrote:
> Mostly written by Emily Ratliff <ratliff@ratliff.net>

I can merge this, but I don't see any users of this, so its essentially
a dead domain.

> --- nsaserefpolicy/policy/modules/admin/amtu.fc 1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/admin/amtu.fc      2007-03-08
> 08:42:36.000000000 -0500
> @@ -0,0 +1,3 @@
> +
> +/usr/bin/amtu    --    gen_context(system_u:object_r:amtu_exec_t,s0)
> +
> --- nsaserefpolicy/policy/modules/admin/amtu.if 1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/admin/amtu.if      2007-03-08
> 08:42:36.000000000 -0500
> @@ -0,0 +1,53 @@
> +## <summary>
> +##     abstract Machine Test Utility 
> +## </summary>
> +
> +########################################
> +## <summary>
> +##     Execute amtu in the amtu domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`amtu_domtrans',`
> +       gen_require(`
> +               type amtu_t, amtu_exec_t;
> +       ')
> +
> +       corecmd_search_sbin($1)
> +       domtrans_pattern($1,amtu_exec_t,amtu_t)
> +')
> +
> +########################################
> +## <summary>
> +##     Execute amtu in the amtu domain, and
> +##     allow the specified role the amtu domain.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +## <param name="role">
> +##     <summary>
> +##     The role to be allowed the amtu domain.
> +##     </summary>
> +## </param>
> +## <param name="terminal">
> +##     <summary>
> +##     The type of the terminal allow the amtu domain to use.
> +##     </summary>
> +## </param>
> +#
> +interface(`amtu_run',`
> +       gen_require(`
> +               type amtu_t;
> +       ')
> +
> +       amtu_domtrans($1)
> +       role $2 types amtu_t;
> +       allow amtu_t $3:chr_file rw_term_perms;
> +')
> --- nsaserefpolicy/policy/modules/admin/amtu.te 1969-12-31
> 19:00:00.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/admin/amtu.te      2007-03-08
> 08:42:36.000000000 -0500
> @@ -0,0 +1,56 @@
> +policy_module(amtu,1.0.23)
> +
> +########################################
> +#
> +# Declarations
> +#
> +
> +type amtu_t;
> +type amtu_exec_t;
> +domain_type(amtu_t)
> +domain_entry_file(amtu_t, amtu_exec_t)
> +
> +########################################
> +#
> +# amtu local policy
> +#
> +
> +# Specific allow rules required for amtu
> +allow amtu_t self:capability { audit_write net_raw };
> +allow amtu_t self:netlink_audit_socket { create nlmsg_relay read
> write };
> +allow amtu_t self:packet_socket { bind create read write };
> +allow amtu_t self:udp_socket { create ioctl };
> +
> +files_manage_boot_files(amtu_t)
> +files_read_etc_runtime_files(amtu_t)
> +files_read_etc_files(amtu_t)
> +
> +kernel_read_system_state(amtu_t)
> +
> +libs_use_ld_so(amtu_t)
> +libs_use_shared_libs(amtu_t)
> +
> +optional_policy(`
> +    seutil_use_newrole_fds(amtu_t)
> +');
> +
> +optional_policy(`
> +    userdom_use_sysadm_fds(amtu_t)
> +');
> +
> +optional_policy(`
> +    userdom_sigchld_sysadm(amtu_t)
> +');
> +
> +optional_policy(`
> +    nscd_dontaudit_search_pid(amtu_t)
> +');
> +
> +optional_policy(`
> +    kernel_dontaudit_read_system_state(amtu_t)
> +');
> +
> +optional_policy(`
> +    term_dontaudit_search_ptys(amtu_t)
> +');
> +
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
