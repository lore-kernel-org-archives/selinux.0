Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEdJ3p030930
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:39:19 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UEdHid027578
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:39:17 GMT
Subject: Re: misc fixes for netutils
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201929.l3KJTrNg027302@redsox.boston.devel.redhat.com>
References: <200704201929.l3KJTrNg027302@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 10:38:58 -0400
Message-Id: <1177943938.3570.88.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:29 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/admin/netutils.te	2007-03-26 16:24:13.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/admin/netutils.te	2007-04-11 17:07:34.000000000 -0400
> @@ -40,6 +41,7 @@
>  
>  # Perform network administration operations and have raw access to the network.
>  allow netutils_t self:capability { net_admin net_raw setuid setgid };
> +dontaudit netutils_t self:capability sys_tty_config;
>  allow netutils_t self:process { sigkill sigstop signull signal };
>  allow netutils_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write };
>  allow netutils_t self:packet_socket create_socket_perms;
> @@ -50,6 +52,8 @@
>  manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
>  files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
>  
> +dev_read_sysfs(netutils_t)
> +
>  kernel_search_proc(netutils_t)
>  
>  corenet_non_ipsec_sendrecv(netutils_t)
> @@ -132,6 +136,8 @@
>  
>  logging_send_syslog_msg(ping_t)
>  
> +miscfiles_read_localization(ping_t)
> +
>  sysnet_read_config(ping_t)
>  sysnet_dns_name_resolve(ping_t)

Merged, except for the middle hunk, which is redundant.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
