Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CCDxIJ014747
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 08:13:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CCDvgo024906
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 12:13:57 GMT
Subject: Re: [RFC] use the netmsg initial SID for NetLabel connections
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <200706080958.17891.paul.moore@hp.com>
References: <20070607205808.935275285@hp.com>
	 <1181309811.6578.106.camel@sgc.columbia.tresys.com>
	 <200706080958.17891.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:12:16 -0400
Message-Id: <1181650336.16029.47.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-08 at 09:58 -0400, Paul Moore wrote:
> On Friday, June 8 2007 9:36:51 am Christopher J. PeBenito wrote:
> > On Thu, 2007-06-07 at 16:58 -0400, Paul Moore wrote:
> > > --- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
> > > +++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
> > > @@ -139,6 +139,13 @@ type sysctl_dev_t, sysctl_type;
> > >  genfscon proc /sys/dev gen_context(system_u:object_r:sysctl_dev_t,s0)
> > >
> > >  #
> > > +# The netmsg inital SID is used by the kernel's NetLabel subsystem for
> > > network +# connections which do not carry full SELinux contexts.
> > > +#
> > > +type netlabel_peer_t;
> > > +sid
> > > netmsg		gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh) +
> > > +#
> > >  # unlabeled_t is the type of unlabeled objects.
> > >  # Objects that have no known labeling information or that
> > >  # have labels that are no longer valid are treated as having this type.
> > > @@ -153,7 +160,6 @@ sid icmp_socket		gen_context(system_u:ob
> > >  sid
> > > igmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> > > sid init		gen_context(system_u:object_r:unlabeled_t,s0)
> > >  sid kmod		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> > > -sid netmsg		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> > >  sid policy		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> > >  sid
> > > scmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> > > sid sysctl_modprobe 	gen_context(system_u:object_r:unlabeled_t,s0)
> >
> > The type declaration and initial sid line should move over to
> > corenetwork (with corresponding interface changes).  The only reason
> > there were netlabel interfaces in the kernel module were because they
> > were using unlabeled_t.
> 
> Okay, that makes sense.
> 
> I still have a question about the best way to provide both labeled and 
> unlabeled NetLabel support to all of the user/application domains in the 
> policy.  I don't have a problem going through all the individual domains and 
> adding calls like these:
> 
>   corenet_{tcp,udp,raw}_recv_unlabeled(<domain>)
>   corenet_{tcp,udp,raw}_recv_netlabel(<domain>)
> 
> ... but I was wondering if there was another way I should go about making the 
> change?

No, that's the right method.  I've been thinking about if this is the
right vocabulary for the interfaces; I'd like to make it workable for
labeled ipsec too.  The problem is that ipsec is a little different,
where you might have interfaces like apache_tcp_recvfrom_user_script().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
