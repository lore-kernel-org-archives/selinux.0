Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7N0q8G6007647
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 20:52:08 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7N0q7sU019387
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 00:52:07 GMT
Received: by nf-out-0910.google.com with SMTP id k4so313357nfd
        for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 17:52:06 -0700 (PDT)
Message-ID: <4c4ba1530708221752q6ba5f9dy7a1ec67f9c6f8956@mail.gmail.com>
Date: Wed, 22 Aug 2007 17:52:06 -0700
From: "Tom London" <selinux@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [PATCH] refpolicy: apps_vmware changes
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <46CCAC4B.1060506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com>
	 <1187812502.13874.98.camel@gorn> <46CCAC4B.1060506@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/22/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Christopher J. PeBenito wrote:
> > On Thu, 2007-08-02 at 15:56 -0400, dwalsh@redhat.com wrote:
> >> Fixes for vmware
> >> --- nsaserefpolicy/policy/modules/apps/vmware.fc        2007-07-03 07:05:43.000000000 -0400
> >> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.fc     2007-08-02 11:02:02.000000000 -0400
> >> @@ -23,6 +23,7 @@
> >>  /usr/bin/vmware-smbd           --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
> >>  /usr/bin/vmware-smbpasswd      --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
> >>  /usr/bin/vmware-smbpasswd\.bin --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
> >> +/usr/bin/vmware-vmx            --      gen_context(system_u:object_r:vmware_host_exec_t,s0)
> >>  /usr/bin/vmware-wizard         --      gen_context(system_u:object_r:vmware_exec_t,s0)
> >>  /usr/bin/vmware                        --      gen_context(system_u:object_r:vmware_exec_t,s0)
> >>
> >> --- nsaserefpolicy/policy/modules/apps/vmware.te        2007-07-25 10:37:37.000000000 -0400
> >> +++ serefpolicy-3.0.5/policy/modules/apps/vmware.te     2007-08-02 11:02:02.000000000 -0400
> >> @@ -29,7 +29,7 @@
> >>
> >>  allow vmware_host_t self:capability { setuid net_raw };
> >>  dontaudit vmware_host_t self:capability sys_tty_config;
> >> -allow vmware_host_t self:process signal_perms;
> >> +allow vmware_host_t self:process { execstack execmem signal_perms };
> >>  allow vmware_host_t self:fifo_file rw_fifo_file_perms;
> >>  allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
> >>  allow vmware_host_t self:rawip_socket create_socket_perms;
> >
> > Which version of vmware requires this?  Other parts merged.
> >
> >> @@ -56,6 +56,8 @@
> >>  corenet_tcp_sendrecv_all_ports(vmware_host_t)
> >>  corenet_udp_sendrecv_all_ports(vmware_host_t)
> >>  corenet_raw_bind_all_nodes(vmware_host_t)
> >> +corenet_tcp_bind_all_nodes(vmware_host_t)
> >> +corenet_udp_bind_all_nodes(vmware_host_t)
> >>  corenet_tcp_connect_all_ports(vmware_host_t)
> >>  corenet_sendrecv_all_client_packets(vmware_host_t)
> >>  corenet_sendrecv_all_server_packets(vmware_host_t)
> >>
> >>
> I think these came from Tom?

I'm running VMWare Workstation 6.0.

Need me to recreate?

tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
