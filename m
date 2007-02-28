Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFZpcv015481
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:35:51 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SFbE2d000293
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:37:14 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Changees to inetd to handle setting MLS network levels
Date: Wed, 28 Feb 2007 10:37:32 -0500
Message-ID: <1172677053.11157.62.camel@sgc>
In-Reply-To: <200702261725.l1QHP6Rd030607@localhost.localdomain>
References: <200702261725.l1QHP6Rd030607@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:25 -0500, dwalsh@localhost.localdomain wrote:
> 
> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_inetd.patch===
> --- nsaserefpolicy/policy/modules/services/inetd.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/inetd.te	2007-02-26 11:02:34.000000000 -0500
> @@ -140,8 +140,8 @@
>  mls_fd_use_all_levels(inetd_t)
>  mls_fd_share_all_levels(inetd_t)
>  mls_socket_read_to_clearance(inetd_t)
> +mls_socket_write_to_clearance(inetd_t)
>  mls_process_set_level(inetd_t)
> -mls_socket_read_to_clearance(inetd_t)
>  
>  sysnet_read_config(inetd_t)
>  
> @@ -192,6 +192,9 @@
>  # for identd
>  allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
>  allow inetd_child_t self:capability { setuid setgid };
> +allow inetd_child_t self:dir search;
> +allow inetd_child_t self:{ lnk_file file } { getattr read };
> +
>  files_search_home(inetd_child_t)
>  
>  manage_dirs_pattern(inetd_child_t,inetd_child_tmp_t,inetd_child_tmp_t)
> ============================================================

mls_socket_write_to_clearance() does not exist.  Also, the second hunk
isn't needed as it has those perms as a result of being a domain.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
