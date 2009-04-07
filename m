Subject: Re: nc -l does not need permission name_bind to bind to a port!?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Sebastian Pfaff <sebastian.pfaff@gmail.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <49DB643E.4060907@redhat.com>
References: <DE3691C6-1C5C-4C6C-BC7C-DC0B41698A25@gmail.com>
	 <1239107410.29028.10.camel@localhost.localdomain>
	 <49DB643E.4060907@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 12:38:40 -0400
Message-Id: <1239122320.29028.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 10:33 -0400, Daniel J Walsh wrote:
> On 04/07/2009 08:30 AM, Stephen Smalley wrote:
> > On Sun, 2009-04-05 at 20:34 +0200, Sebastian Pfaff wrote:
> >> hello,
> >>
> >> i'm not sure about this: but afaik  to bind a socket to a port the
> >> name_bind is neccessary (please correct me, if this wrong).
> >>
> >> now try this:
> >> ==========
> >>
> >> policy_module(NETCAT, 0.0.1)
> >>
> >> require { type unconfined_t; }
> >>
> >> role unconfined_r types nc_t ;
> >>
> >> type nc_t;
> >> type nc_exec_t;
> >>
> >> application_domain(nc_t, nc_exec_t)
> >> domain_auto_transition_pattern(unconfined_t, nc_exec_t, nc_t)
> >> #EOF
> >>
> >> build load NETCAT.te:
> >> ==================
> >>
> >> make -f /usr/share/selinux/devel/Makefile
> >> sudo semodule -i NETCAT.pp
> >>
> >> then set domain nc_t permissive:
> >> ==========================
> >>
> >> sudo semanage permissive -a nc_t
> >>
> >> (temporarily) change type of nc:
> >> =========================
> >>
> >> sudo chcon -v -t nc_exec_t  /usr/bin/nc
> >>
> >> and then start a netcat "server" :
> >> =========================
> >>
> >> nc -l 44444
> >>
> >> here the verification that nc listens on 44444 for incoming connections:
> >> =======================================================
> >> [root@SecLab ~]# netstat -plntZ | grep 44444
> >> tcp        0      0 127.0.0.1:44444
> >> 0.0.0.0:*                   LISTEN      10279/nc
> >> unconfined_u:unconfined_r:nc_t:s0
> >>
> >> now we check audit.log:
> >> ===================
> >>
> >> [root@SecLab ~]# grep '^type=AVC' /var/log/audit/audit.log
> >> type=AVC msg=audit(1238954202.516:257): avc:  denied  { read write }
> >> for  pid=10279 comm="nc" name="1" dev=devpts ino=3
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:object_r:unconfined_devpts_t:s0 tclass=chr_file
> >> type=AVC msg=audit(1238954202.518:258): avc:  denied  { read } for
> >> pid=10279 comm="nc" name="ld.so.cache" dev=sda1 ino=34611
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:ld_so_cache_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.518:259): avc:  denied  { getattr } for
> >> pid=10279 comm="nc" path="/etc/ld.so.cache" dev=sda1 ino=34611
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:ld_so_cache_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.518:260): avc:  denied  { read } for
> >> pid=10279 comm="nc" name="libglib-2.0.so.0" dev=sda1 ino=229602
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:lib_t:s0 tclass=lnk_file
> >> type=AVC msg=audit(1238954202.518:260): avc:  denied  { read } for
> >> pid=10279 comm="nc" name="libglib-2.0.so.0.1800.4" dev=sda1 ino=229574
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:lib_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.519:261): avc:  denied  { getattr } for
> >> pid=10279 comm="nc" path="/lib/libglib-2.0.so.0.1800.4" dev=sda1
> >> ino=229574 scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:lib_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.519:262): avc:  denied  { execute } for
> >> pid=10279 comm="nc" path="/lib/libglib-2.0.so.0.1800.4" dev=sda1
> >> ino=229574 scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:lib_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.519:263): avc:  denied  { read } for
> >> pid=10279 comm="nc" path="/lib/ld-2.9.so" dev=sda1 ino=229558
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:ld_so_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.520:264): avc:  denied  { create } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.520:265): avc:  denied  { bind } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.520:266): avc:  denied  { getattr } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.520:267): avc:  denied  { write } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.520:267): avc:  denied  { nlmsg_read }
> >> for  pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.520:268): avc:  denied  { read } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=netlink_route_socket
> >> type=AVC msg=audit(1238954202.533:269): avc:  denied  { read } for
> >> pid=10279 comm="nc" name="nsswitch.conf" dev=sda1 ino=32805
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:etc_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.533:270): avc:  denied  { getattr } for
> >> pid=10279 comm="nc" path="/etc/nsswitch.conf" dev=sda1 ino=32805
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:etc_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.534:271): avc:  denied  { read } for
> >> pid=10279 comm="nc" name="resolv.conf" dev=sda1 ino=34021
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:net_conf_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.534:272): avc:  denied  { getattr } for
> >> pid=10279 comm="nc" path="/etc/resolv.conf" dev=sda1 ino=34021
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:net_conf_t:s0 tclass=file
> >> type=AVC msg=audit(1238954202.535:273): avc:  denied  { create } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=tcp_socket
> >> type=AVC msg=audit(1238954202.535:274): avc:  denied  { setopt } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=tcp_socket
> >> type=AVC msg=audit(1238954202.535:275): avc:  denied  { bind } for
> >> pid=10279 comm="nc" scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=tcp_socket
> >> type=AVC msg=audit(1238954202.535:275): avc:  denied  { node_bind }
> >> for  pid=10279 comm="nc" saddr=127.0.0.1 src=44444
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=system_u:object_r:lo_node_t:s0 tclass=tcp_socket
> >> type=AVC msg=audit(1238954202.535:276): avc:  denied  { listen } for
> >> pid=10279 comm="nc" laddr=127.0.0.1 lport=44444
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=tcp_socket
> >> type=AVC msg=audit(1238954202.535:277): avc:  denied  { accept } for
> >> pid=10279 comm="nc" laddr=127.0.0.1 lport=44444
> >> scontext=unconfined_u:unconfined_r:nc_t:s0
> >> tcontext=unconfined_u:unconfined_r:nc_t:s0 tclass=tcp_socket
> >>
> >> As everybody can see, there is no name_bind permission. why is this
> >> so? I always thought, that name_bind is necessary to bind a  port. An
> >> entry from dan's blog teached me,  that name_bind is always(?) needed.
> >> I'm relatively new to selinux, so i'm not sure about this. Hope
> >> someone can help me.
> >>
> >> I'm using fedora 10. Btw: sesearch --allow -s nc_t | grep name_bind
> >> finds nothing. if you need additional info, please let me know.
> >
> > name_bind is not checked when the port falls within the local port range
> > (cat /proc/sys/net/ipv4/ip_local_port_range), since ports in that range
> > are used for auto-binding of unbound sockets and thus aren't truly
> > controllable (unless we were to further modify the kernel to apply a
> > check when scanning that port range for auto-binding and to skip port
> > numbers in that range on a denial).  name_bind was primarily intended to
> > control the ability to bind to well known ports to prevent spoofing of a
> > given service by another process.
> >
> I think this is a mistake.  I think we should prevent name_bind of any 
> service, to ensure a user is not running malicious software in his 
> homedirectory that is listening on a port.  Obviously we are blocking 
> via firewall high level ports but we block the first 32000 ports now and 
> it makes no logical sense to not block all.

It doesn't make sense to use a port in the local port range as a
well-defined service port since such a port can be allocated at any time
for an unbound socket upon a send or connect.  Thus, it didn't seem
useful to try to control the name binding of such ports - the port
numbers in that range (should) have no inherent meaning tied to them,
and thus spoofing them is of no interest.  You can already prevent a
process from creating INET sockets altogether (create permission), or
prevent them from using bind(2) altogether (bind permission).  You can
also use secmark to e.g. label all packets destined for a given port
with a given type, and then use policy to prevent receipt of such
packets on sockets in certain domains.

Regardless, if you truly wanted name_bind applied to all ports and you
wanted to avoid trivial circumvention by way of calling send* on an
unbound socket, then someone would need to modify the TCP and UDP
get_port functions to invoke a LSM hook to filter/select the ports
returned for auto-binding.  Merely checking name_bind in
selinux_socket_bind() for such ports wouldn't be sufficient.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
