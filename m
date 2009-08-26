Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7QFIYV0010351
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 11:18:34 -0400
Received: from g5t0009.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7QFI0Ax026316
	for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2009 15:18:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [refpolicy] [RFC PATCH v1 2/2] refpol: Policy for the new TUN driver
 =?iso-8859-15?q?access=09controls?=
Date: Wed, 26 Aug 2009 10:32:10 -0400
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
References: <20090825210647.6250.56266.stgit@flek.lan> <20090825211238.6250.38852.stgit@flek.lan> <1251290954.8357.14.camel@gorn.columbia.tresys.com>
In-Reply-To: <1251290954.8357.14.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200908261032.10377.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 August 2009 08:49:14 am Christopher J. PeBenito wrote:
> On Tue, 2009-08-25 at 17:12 -0400, Paul Moore wrote:
> > Add policy for the new TUN driver access controls which allow policy to
> > control which domains have the ability to create and attach to TUN/TAP
> > devices.

...

> > diff --git a/policy/modules/apps/qemu.if b/policy/modules/apps/qemu.if
> > index d258f1d..ee7e214 100644
> > --- a/policy/modules/apps/qemu.if
> > +++ b/policy/modules/apps/qemu.if
> > @@ -149,6 +149,7 @@ template(`qemu_domain_template',`
> >  	allow $1_t self:shm create_shm_perms;
> >  	allow $1_t self:unix_stream_socket create_stream_socket_perms;
> >  	allow $1_t self:tcp_socket create_stream_socket_perms;
> > +	allow $1_t self:tun_socket create;
> >
> >  	manage_dirs_pattern($1_t, $1_tmp_t, $1_tmp_t)
> >  	manage_files_pattern($1_t, $1_tmp_t, $1_tmp_t)
> > @@ -164,6 +165,8 @@ template(`qemu_domain_template',`
> >  	corenet_tcp_bind_generic_node($1_t)
> >  	corenet_tcp_bind_vnc_port($1_t)
> >  	corenet_rw_tun_tap_dev($1_t)
> > +	virt_tun_attach($1_t)
> > +	userdom_tun_attach($1_t)
>
> These should be moved to be with the other virt and userdom calls.

Fair enough.

> > diff --git a/policy/modules/apps/uml.te b/policy/modules/apps/uml.te
> > index 05e871c..902c226 100644
> > --- a/policy/modules/apps/uml.te
> > +++ b/policy/modules/apps/uml.te
> > @@ -60,6 +60,7 @@ allow uml_t self:unix_dgram_socket create_socket_perms;
> >  # Use the network.
> >  allow uml_t self:tcp_socket create_stream_socket_perms;
> >  allow uml_t self:udp_socket create_socket_perms;
> > +allow uml_t self:tun_socket create;
> >  # for mconsole
> >  allow uml_t self:unix_dgram_socket sendto;
> >
> > @@ -111,6 +112,8 @@ corenet_udp_sendrecv_all_ports(uml_t)
> >  corenet_tcp_connect_all_ports(uml_t)
> >  corenet_sendrecv_all_client_packets(uml_t)
> >  corenet_rw_tun_tap_dev(uml_t)
> > +virt_tun_attach(uml_t)
> > +userdom_tun_attach(uml_t)
>
> Same thing about moving these, as above.

Done.

> > diff --git a/policy/modules/system/userdomain.if
> > b/policy/modules/system/userdomain.if index 49ac3fd..22a952c 100644
> > --- a/policy/modules/system/userdomain.if
> > +++ b/policy/modules/system/userdomain.if
> > @@ -1042,6 +1042,7 @@ template(`userdom_unpriv_user_template', `
> >  #
> >  template(`userdom_admin_user_template',`
> >  	gen_require(`
> > +		attribute admin_tun_type;
> >  		class passwd { passwd chfn chsh rootok };
> >  	')
> >
> > @@ -1077,6 +1078,9 @@ template(`userdom_admin_user_template',`
> >
> >  	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
> >
> > +	allow $1_t self:tun_socket create;
> > +	typeattribute $1_t admin_tun_type;
> > +
> >  	kernel_read_software_raid_state($1_t)
> >  	kernel_getattr_core_if($1_t)
> >  	kernel_getattr_message_if($1_t)
> > @@ -3027,3 +3031,22 @@ interface(`userdom_dbus_send_all_users',`
> >
> >  	allow $1 userdomain:dbus send_msg;
> >  ')
> > +
> > +########################################
> > +## <summary>
> > +##	Allow domain to attach to admin created TUN devices
> > +## </summary>
> > +## <param name="domain">
> > +##	<summary>
> > +##	Domain allowed access.
> > +##	</summary>
> > +## </param>
> > +#
> > +interface(`userdom_tun_attach',`
> > +	gen_require(`
> > +		attribute admin_tun_type;
> > +	')
> > +
> > +	allow $1 admin_tun_type:tun_socket relabelfrom;
> > +	allow $1 self:tun_socket relabelto;
> > +')
>
> Why are only admin roles allowed to create tun_sockets?  Either the
> interface name should be changed to reflect that its not all user
> domains, or it should be expanded to cover all user domains.

Considering the nature of TUN/TAP devices and the fact that you must have 
CAP_NET_ADMIN to create a new device it seemed reasonable to restrict the 
tun_socket/create permission to admin roles.  However, we do want to allow 
non-admin roles the ability to attach (tun_socket/relabel{from,to} 
permissions) to existing persistent TUN/TAP devices - this is why the 
interface above does not have "admin" anywhere in the name.

Does that make sense?

> > diff --git a/policy/modules/system/userdomain.te
> > b/policy/modules/system/userdomain.te index 48e9070..aff080b 100644
> > --- a/policy/modules/system/userdomain.te
> > +++ b/policy/modules/system/userdomain.te
> > @@ -58,6 +58,8 @@ attribute unpriv_userdomain;
> >  attribute untrusted_content_type;
> >  attribute untrusted_content_tmp_type;
> >
> > +attribute admin_tun_type;
> > +
> >  type user_home_dir_t alias { staff_home_dir_t sysadm_home_dir_t
> > secadm_home_dir_t auditadm_home_dir_t unconfined_home_dir_t };
> > fs_associate_tmpfs(user_home_dir_t)
> >  files_type(user_home_dir_t)
> > diff --git a/policy/modules/system/xen.te b/policy/modules/system/xen.te
> > index 40410a7..6c4b06d 100644
> > --- a/policy/modules/system/xen.te
> > +++ b/policy/modules/system/xen.te
> > @@ -88,6 +88,7 @@ allow xend_t self:unix_dgram_socket
> > create_socket_perms; allow xend_t self:netlink_route_socket
> > r_netlink_socket_perms;
> >  allow xend_t self:tcp_socket create_stream_socket_perms;
> >  allow xend_t self:packet_socket create_socket_perms;
> > +allow xend_t self:tun_socket create;
> >
> >  allow xend_t xen_image_t:dir list_dir_perms;
> >  manage_dirs_pattern(xend_t, xen_image_t, xen_image_t)
>
> No attach?

I'm not a Xen expert, but I assumed from discussions with some virtualization 
folks that if you are running Xen then the xend_t domain would handle the 
creation of any TUN/TAP devices it may need, hence no need to attach to an 
existing TUN/TAP device created by another domain.  Yes?  No?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
