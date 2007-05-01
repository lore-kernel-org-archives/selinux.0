Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l41DkIAS030140
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2007 09:46:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l41DkG1O003140
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2007 13:46:16 GMT
Subject: Re: amtu policy/used for MLS Test suite, needs to run in the field
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201930.l3KJUhev027327@redsox.boston.devel.redhat.com>
References: <200704201930.l3KJUhev027327@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 01 May 2007 09:45:55 -0400
Message-Id: <1178027155.3570.146.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:30 -0400, dwalsh@redhat.com wrote:
> +# Specific allow rules required for amtu
> +allow amtu_t self:capability { audit_write net_raw };
> +allow amtu_t self:netlink_audit_socket { create nlmsg_relay read write };
> +allow amtu_t self:packet_socket { bind create read write };
> +allow amtu_t self:udp_socket { create ioctl };

Seems to be missing some corenet rules?

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
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
