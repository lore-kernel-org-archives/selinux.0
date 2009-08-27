Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7RDtxbO026358
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 09:55:59 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7RDvAsC028832
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 13:57:11 GMT
Subject: Re: [refpolicy] [RFC PATCH v1 2/2] refpol: Policy for the new TUN
 driver  access	controls
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
In-Reply-To: <200908261032.10377.paul.moore@hp.com>
References: <20090825210647.6250.56266.stgit@flek.lan>
	 <20090825211238.6250.38852.stgit@flek.lan>
	 <1251290954.8357.14.camel@gorn.columbia.tresys.com>
	 <200908261032.10377.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 09:54:28 -0400
Message-Id: <1251381268.8357.43.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-26 at 10:32 -0400, Paul Moore wrote:
> On Wednesday 26 August 2009 08:49:14 am Christopher J. PeBenito wrote:
> > On Tue, 2009-08-25 at 17:12 -0400, Paul Moore wrote:
> > > Add policy for the new TUN driver access controls which allow policy to
> > > control which domains have the ability to create and attach to TUN/TAP
> > > devices.

> > > +########################################
> > > +## <summary>
> > > +##	Allow domain to attach to admin created TUN devices
> > > +## </summary>
> > > +## <param name="domain">
> > > +##	<summary>
> > > +##	Domain allowed access.
> > > +##	</summary>
> > > +## </param>
> > > +#
> > > +interface(`userdom_tun_attach',`
> > > +	gen_require(`
> > > +		attribute admin_tun_type;
> > > +	')
> > > +
> > > +	allow $1 admin_tun_type:tun_socket relabelfrom;
> > > +	allow $1 self:tun_socket relabelto;
> > > +')
> >
> > Why are only admin roles allowed to create tun_sockets?  Either the
> > interface name should be changed to reflect that its not all user
> > domains, or it should be expanded to cover all user domains.
> 
> Considering the nature of TUN/TAP devices and the fact that you must have 
> CAP_NET_ADMIN to create a new device it seemed reasonable to restrict the 
> tun_socket/create permission to admin roles.  However, we do want to allow 
> non-admin roles the ability to attach (tun_socket/relabel{from,to} 
> permissions) to existing persistent TUN/TAP devices - this is why the 
> interface above does not have "admin" anywhere in the name.
> 
> Does that make sense?

I'm fine with only attaching to admin domains, but the interface name
needs to be changed.  Its critical that the interface names are
consistent with the interface implementation.  So if the implementation
is only for attaching to admin domains, the interface name has to
reflect that.

> > > diff --git a/policy/modules/system/xen.te b/policy/modules/system/xen.te
> > > index 40410a7..6c4b06d 100644
> > > --- a/policy/modules/system/xen.te
> > > +++ b/policy/modules/system/xen.te
> > > @@ -88,6 +88,7 @@ allow xend_t self:unix_dgram_socket
> > > create_socket_perms; allow xend_t self:netlink_route_socket
> > > r_netlink_socket_perms;
> > >  allow xend_t self:tcp_socket create_stream_socket_perms;
> > >  allow xend_t self:packet_socket create_socket_perms;
> > > +allow xend_t self:tun_socket create;
> > >
> > >  allow xend_t xen_image_t:dir list_dir_perms;
> > >  manage_dirs_pattern(xend_t, xen_image_t, xen_image_t)
> >
> > No attach?
> 
> I'm not a Xen expert, but I assumed from discussions with some virtualization 
> folks that if you are running Xen then the xend_t domain would handle the 
> creation of any TUN/TAP devices it may need, hence no need to attach to an 
> existing TUN/TAP device created by another domain.  Yes?  No?

I'd rather wait on adding this rule until we can get confirmation on if
its needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
