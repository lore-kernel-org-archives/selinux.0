Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJtwvw019244
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:55:58 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJtvH3002104
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:55:57 GMT
Subject: Re: [PATCH] refpolicy: apps_vmware changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com>
References: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:02 -0400
Message-Id: <1187812502.13874.98.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:56 -0400, dwalsh@redhat.com wrote:
> Fixes for vmware
> --- nsaserefpolicy/policy/modules/apps/vmware.fc        2007-07-03 07:05:43.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.fc     2007-08-02 11:02:02.000000000 -0400
> @@ -23,6 +23,7 @@
>  /usr/bin/vmware-smbd           --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>  /usr/bin/vmware-smbpasswd      --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>  /usr/bin/vmware-smbpasswd\.bin --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
> +/usr/bin/vmware-vmx            --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
>  /usr/bin/vmware-wizard         --      gen_context(system_u:object_r:vmware_exec_t,s0)
>  /usr/bin/vmware                        --      gen_context(system_u:object_r:vmware_exec_t,s0)
> 
> --- nsaserefpolicy/policy/modules/apps/vmware.te        2007-07-25 10:37:37.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.te     2007-08-02 11:02:02.000000000 -0400
> @@ -29,7 +29,7 @@
> 
>  allow vmware_host_t self:capability { setuid net_raw };
>  dontaudit vmware_host_t self:capability sys_tty_config;
> -allow vmware_host_t self:process signal_perms;
> +allow vmware_host_t self:process { execstack execmem signal_perms };
>  allow vmware_host_t self:fifo_file rw_fifo_file_perms;
>  allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
>  allow vmware_host_t self:rawip_socket create_socket_perms;

Which version of vmware requires this?  Other parts merged.

> @@ -56,6 +56,8 @@
>  corenet_tcp_sendrecv_all_ports(vmware_host_t)
>  corenet_udp_sendrecv_all_ports(vmware_host_t)
>  corenet_raw_bind_all_nodes(vmware_host_t)
> +corenet_tcp_bind_all_nodes(vmware_host_t)
> +corenet_udp_bind_all_nodes(vmware_host_t)
>  corenet_tcp_connect_all_ports(vmware_host_t)
>  corenet_sendrecv_all_client_packets(vmware_host_t)
>  corenet_sendrecv_all_server_packets(vmware_host_t)
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
