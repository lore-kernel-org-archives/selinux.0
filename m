Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC2C32D.3010405@ak.jp.nec.com>
	 <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Sep 2009 08:53:35 -0400
Message-Id: <1254315215.30591.18.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-30 at 08:39 -0400, Stephen Smalley wrote:
> On Wed, 2009-09-30 at 11:32 +0900, KaiGai Kohei wrote:
> > Stephen Smalley wrote:
> > > There are several legacy permissions that are no longer used by SELinux.
> > > We could remove these from the kernel's classmap.h definitions without
> > > breaking anything (subsequent permissions would get mapped to policy
> > > values appropriately by the new logic), but removing them from the
> > > policy would be harder as it would break all kernels that predate these
> > > patches.  Thus, I'm not sure we benefit from removing them from
> > > classmap.h.
> > > 
> > > The unused permissions include:
> > > # LSM hook never merged to mainline
> > > file swapon
> > > # compat_net=1 checks
> > > socket { recv_msg send_msg }
> > > # Only added so that subsequent permissions (execmod) would get the same value as class file
> > > chr_file { execute_no_trans entrypoint }
> > > # Original socket controls; never merged to mainline
> > > tcp_socket { connectto newconn acceptfrom }
> > > # legacy network or compat_net=1 checks
> > > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send }
> > > # legacy network or compat_net=1 checks
> > > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
> > > # Original socket controls; never merged to mainline - only connectto is used
> > > unix_stream_socket { newconn acceptfrom }
> > > # Patches merged prematurely by Fedora, never merged to mainline
> > > packet { flow_in flow_out }
> > 
> > It is just a report. I could not reach origin of the matter yet.
> > 
> > When I applies your patch as is, build, install and reboot,
> > I could not find any *obvious* matter (such as boot failed). Good.
> > 
> > Then, I modified the classmap.h for the test purpose.
> > The object classes and access vectors are ramdomized as the
> > attached claasmap.h.
> > This patch enables to map value of them using text identifier,
> > so we can expect it works fine independent from the order of
> > classes and access vectors.
> > 
> > Did you already remove the unused kernel permissions?
> > 
> > -- kernel boot messages
> >    :
> > Creating initial device nodes
> > plymouthd used greatest stack depth: 6532 bytes left
> > async/0 used greatest stack depth: 6284 bytes left
> > async/1 used greatest stack depth: 5828 bytes left
> > input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > type=1404 audit(1254231627.600:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
> > SELinux:  Permission module_request in class system not defined in policy.
> > SELinux: the above unknown classes and permissions will be allowed
> > type=1403 audit(1254231628.088:3): policy loaded auid=4294967295 ses=4294967295
> > type=1400 audit(1254231628.100:4): avc:  denied  { transition } for  pid=58 comm="init" path="/bin/plymouth" dev=rootfs ino=3512 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:root_t:s0 tclass=process
> > type=1400 audit(1254231628.438:5): avc:  denied  { transition } for  pid=58 comm="init" path="/sbin/telinit" dev=sda5 ino=621655 scontext=system_u:object_r:init_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=process
> > type=1400 audit(1254231628.458:6): avc:  denied  { entrypoint } for  pid=58 comm="init" path="/sbin/telinit" dev=sda5 ino=621655 scontext=system_u:object_r:bin_t:s0 tcontext=system_u:object_r:bin_t:s0 tclass=file
> > init used greatest stack depth: 5684 bytes left
> > init: Not being executed as init
> > ------
> 
> Oh, I see why.  The security server internally uses a few class and
> permission symbolic definitions (e.g. SECCLASS_PROCESS,
> PROCESS__TRANSITION, ...), and it expects them to correspond to the
> policy values rather than the kernel-private indices.  So it needs to
> instead use string_to_security_class() and string_to_av_perm() to look
> them up.  Easy enough to fix.

Does anyone think we still need to support policy versions <
POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
dynamic remapping of netlink classes in the security server:
        if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
                if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
                    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
                        tclass = SECCLASS_NETLINK_SOCKET;

I think RHEL4 shipped with policy.18.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
