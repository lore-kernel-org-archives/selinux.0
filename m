Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 4:login
 successfully finally!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: refpolicy@oss1.tresys.com, selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <BAY111-W103B9EF7D73E86CFDF3688AB5E0@phx.gbl>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>
	 ,, , ,,<4B53CEB9.3050207@gmail.com>
	 ,,<BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>
	 ,, , ,,<4B543977.40007@gmail.com>
	 ,,<BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
	 ,, , ,,<4B550EB9.50806@gmail.com>
	 ,,<BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
	 ,, ,,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
	 ,,,<BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>
	 ,,,<1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>
	 ,,<BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>
	 ,<BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>
	 ,<1264433745.4297.159.camel@moss-pluto.epoch.ncsc.mil>
	 <BAY111-W103B9EF7D73E86CFDF3688AB5E0@phx.gbl>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 08:36:55 -0500
Message-Id: <1264513015.19890.14.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 08:50 +0000, TaurusHarry wrote:
> Hi Stephen,
> 
> With all the kind help from you and Justin, I finally made the latest
> refpolicy-2.20091117 boot up successfully! Hat off for you two :-)
> 
> Please see my embedded replies, thanks!
> 
> > Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 -
> 3: MAKEDEV ok but /var/lock/subsys/ broken
> > From: sds@tycho.nsa.gov
> > To: harrytaurus2002@hotmail.com
> > CC: refpolicy@oss1.tresys.com; selinux@tycho.nsa.gov
> > Date: Mon, 25 Jan 2010 10:35:45 -0500
> > 
> > On Mon, 2010-01-25 at 09:32 +0000, TaurusHarry wrote:
> > > Hi Stephen and Justin,
> > > 
> > > I have got some new findings after I sent out the previous email.
> The
> > > weird error messages about /var/lock/subsys/ turns out to be hard
> disk
> > > inconsistency problem and could be fixed by fsck.ext2, after that,
> > > find and touch performed by rc.sysinit or /etc/rc3.d/* would have
> no
> > > problem at all :-)> > 
> > > However, my console still hangs at "INIT: Id "0" respawning too
> fast:
> > > disabled for 5 minutes", although so far I think I have fixed all
> > > those obvious problems with SELinux during boot up and I could no
> > > longer find fishy AVC denied message except something like:
> > > 
> > > type=1400 audit(1264435478.992:5): avc: denied { rawip_send } for
> > > pid=5 comm="sirq-timer/0"
> > > saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> > > daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> > > scontext=system_u:system_r:kernel_t:s15:c0.c255
> > > tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif
> > > type=1400 audit(1264435478.992:6): avc: denied {! rawip_send } for
> > > pid=5 comm="sirq-timer/0"
> > > saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> > > daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> > >! scontext=system_u:system_r:kernel_t:s15:c0.c255
> > > tcontext =system_u:object_r:node_t:s0-s15:c0.c255 tclass=node
> > 
> > Hmm..so you don't have secmark enabled by default? Kernel config?
> 
> $ grep SECMARK linux-sun_cp3020-cgl-build/.config
> CONFIG_NETWORK_SECMARK=y
> # CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
> $
> 
> More secmark options should I enable?

If you are still using a kernel < 2.6.29, then you also want:
SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
