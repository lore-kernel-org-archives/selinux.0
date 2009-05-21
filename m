Subject: Re: Incorrect avc logs for the packet object class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Marshall Miller <mmiller@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1242840195.22878.339.camel@hostmachine.tresys.com>
References: <1242840195.22878.339.camel@hostmachine.tresys.com>
Content-Type: text/plain
Date: Thu, 21 May 2009 10:14:40 -0400
Message-Id: <1242915280.20082.463.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 13:23 -0400, Marshall Miller wrote:
> I first noticed this bug on a RHEL 5 system, and I also noticed it on
> Ubuntu Jaunty.  I tested this out on Fedora 11 Preview and it was there
> also.
> 
> The avc messages for the packet object class sporadically report
> incorrect comm/pid info.  It is most apparent when multiple processes
> are sending/receiving packets at the same time.  To demonstrate this, I
> added an iptables rule such that every packet being sent is labeled
> system_u:object_r:dns_client_packet_t:s0 (arbitrarily chosen from
> existing types).  I then created and inserted a module that auditallows
> all packet perms for subj == domain and obj == dns_client_packet_t.
> Then I started the Software Updater, and when it started downloading
> packages I ran firefox.

This has always been an issue for the low level networking permission
checks that may happen outside of process context; unfortunately,
"current" is still defined in that situation and thus avc_audit() cannot
distinguish the cases where it has a relevant process context from these
situations.  Options for fixing:
- Have the callers of avc_has_perm() pass a flag (e.g. via
avc_audit_data) when no relevant process context is available, and use
that flag within avc_audit() to omit the comm= and pid= information and
to pass a NULL audit_context to audit_log_start().
- Have avc_audit() internally check for certain classes and permissions
(e.g. SECCLASS_PACKET, SECCLASS_PEER, SECCLASS_NETIF, SECCLASS_NODE)
known to have this behavior, and likewise omit the comm= and pid=
information and pass a NULL context to audit_log_start() in that case.
Concern with this approach is that a given class/permission may be used
from multiple call sites, some of which may have a valid process context
and some of which may not.

> Distribution:
> Fedora 11 Preview
> 
> Output of uname -r:
> 2.6.29.2-126.fc11.i586
> 
> Package versions:
> libselinux-2.0.80-1
> libsemanage-2.0.31-4
> libselinux-2.0.80-1
> libsepol-2.0.36-1
> policycoreutils-2.0.62-12.2
> selinux-policy-targeted-3.6.12-34
> 
> Here are some sample log messages:
> 
> type=AVC msg=audit(1242832297.363:16691): avc:  granted  { send } for
> pid=2025 comm="firefox" saddr=10.1.13.199 src=41508 daddr=204.152.191.39
> dest=80 netif=eth0 scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet
> 
> type=AVC msg=audit(1242832297.363:16692): avc:  granted  { send } for
> pid=1787 comm="gnome-volume-co" saddr=10.1.13.199 src=41508
> daddr=204.152.191.39 dest=80 netif=eth0
> scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet
> 
> type=SYSCALL msg=audit(1242832297.363:16692): arch=40000003 syscall=39
> success=yes exit=0 a0=8ddc638 a1=1c0 a2=52311d8 a3=8ddc64e items=0
> ppid=1648 pid=1787 auid=500 uid=500 gid=500 euid=500 suid=500 fsuid=500
> egid=500 sgid=500 fsgid=500 tty=(none) ses=1 comm="gnome-volume-co"
> exe="/usr/bin/gnome-volume-control-applet"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> 
> type=AVC msg=audit(1242832297.365:16693): avc:  granted  { send } for
> pid=1015 comm="auditd" saddr=10.1.13.199 src=41508 daddr=204.152.191.39
> dest=80 netif=eth0 scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet
> 
> 
> Firefox is actually running as unconfined_execmem_t and
> gnome-volume-control-applet is running as unconfined_t, as can been seen
> by output from ps:
> 
> unconfined_u:unconfined_r:unconfined_execmem_t:SystemLow-SystemHigh
> mmiller 2025 2010  1 11:10 ? 00:00:10 /usr/lib/firefox-3.5b4/firefox
> 
> unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh mmiller 1787
> 1648  1 11:09 ? 00:00:39 gnome-volume-control-applet
> 
> 
> It is also strange that event 16692 has a packet AVC message and also a
> SYSCALL message for the mkdir syscall.  I don't see how these messages
> are related.

They aren't related - this is a bug due to the fact that avc_audit()
always uses current->audit_context and thus causes a syscall audit
record to be emitted upon exit of whatever process happens to be current
when the avc occurred.  Would also be fixed using the approaches above.

> 
> 
> Contents of policy module:
> policy_module(auditallow_packets,1.0.0)
> gen_require(`
> 	class packet all_packet_perms;
> 	attribute domain;
> 	type dns_client_packet_t;
> ')
> auditallow domain dns_client_packet_t:packet *;
> 
> 
> Contents of /etc/sysconfig/iptables:
> *mangle
> :PREROUTING ACCEPT [0:0]
> :INPUT ACCEPT [0:0]
> :FORWARD ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> :POSTROUTING ACCEPT [0:0]
> -A OUTPUT -j SECMARK --selctx system_u:object_r:dns_client_packet_t:s0 
> COMMIT
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
