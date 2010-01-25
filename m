Subject: RE: [refpolicy] Bootup problem with refpolicy-2.20091117 - 3:
 MAKEDEV ok but /var/lock/subsys/ broken
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: refpolicy@oss1.tresys.com, selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>
	 , , ,,<4B53CEB9.3050207@gmail.com>
	 ,<BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>
	 , , ,,<4B543977.40007@gmail.com>
	 ,<BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
	 , , ,,<4B550EB9.50806@gmail.com>
	 ,<BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>
	 , ,,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>
	 ,,<BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>
	 ,,<1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>
	 ,<BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>
	 <BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 10:35:45 -0500
Message-Id: <1264433745.4297.159.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-25 at 09:32 +0000, TaurusHarry wrote:
> Hi Stephen and Justin,
> 
> I have got some new findings after I sent out the previous email. The
> weird error messages about /var/lock/subsys/ turns out to be hard disk
> inconsistency problem and could be fixed by fsck.ext2, after that,
> find and touch performed by rc.sysinit or /etc/rc3.d/* would have no
> problem at all :-)
> 
> However, my console still hangs at "INIT: Id "0" respawning too fast:
> disabled for 5 minutes", although so far I think I have fixed all
> those obvious problems with SELinux during boot up and I could no
> longer find fishy AVC denied message except something like:
> 
> type=1400 audit(1264435478.992:5): avc:  denied  { rawip_send } for
> pid=5 comm="sirq-timer/0"
> saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> scontext=system_u:system_r:kernel_t:s15:c0.c255
> tcontext=system_u:object_r:netif_t:s0-s15:c0.c255 tclass=netif
> type=1400 audit(1264435478.992:6): avc:  denied  {! rawip_send } for
> pid=5 comm="sirq-timer/0"
> saddr=fe80:0000:0000:0000:0203:baff:fef1:73e3
> daddr=ff02:0000:0000:0000:0000:0000:0000:0002 netif=eth5
> scontext=system_u:system_r:kernel_t:s15:c0.c255
> tcontext=system_u:object_r:node_t:s0-s15:c0.c255 tclass=node

Hmm..so you don't have secmark enabled by default?  Kernel config?

> But I don't think they could be the reason /sbin/init would fail to
> run /sbin/mingetty.
> 
> Then I came up with the idea to toggle SELinux state into Permissive
> mode in the rc.local and finally the console on longer hangs and I
> could login normally:
> 
> 
> 
> root@cp3020:/root> cat /proc/cmdline 
> 
> root=/dev/sda1 rw console=ttyS0,115200n8 ip=dhcp selinux=1
> BOOT_IMAGE=/vlm-boards/12885/qcao/kernel 
> 
> root@cp3020:/root> getenforce 
> 
> Permissive
> 
> root@cp3020:/root>
> 
> root@cp3020:/root> cat /var/log/messages
> 
> ...
> 
> Jan 25 16:59:15 cp3020 /etc/rc3.d/S95atd: atd startup - OK
> 
> Jan 25 16:59:15 cp3020 boot: Starting cracklibd
> 
> Jan 25 16:59:16 cp3020 boot: Starting local
> 
> Jan 25 16:59:16 cp3020 kernel: type=1404 audit(1264438756.016:4):
> enforcing=0 ol
> 
> d_enforcing=1 auid=4294967295 ses=4294967295
> 
> ...
> 
> root@cp3020:/root>
> 
> 
> We can see selinux does boot up WITH enforcing=1 but toggled into
> enforcing=0 at rc.local, which proves that all my left problem focused
> on /sbin/mingetty
> 0:2345:respawn:/sbin/mingetty console  (in my /etc/inittab)
> 
> Maybe I need to identify the changes from refpolicy-2.20081210 to
> refpolicy-2.20091117 related with getty_t.

Rebuild policy with dontaudits removed (semodule -DB) and retry, then
look for audit messages involving getty.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
