Subject: Re: MLS and network
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>
In-Reply-To: <20100205160720.GN1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
	 <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
	 <20100205051921.GM1750@myhost.felk.cvut.cz>
	 <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
	 <20100205160720.GN1750@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Fri, 05 Feb 2010 11:49:50 -0500
Message-Id: <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-05 at 17:07 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > The port-based checks (e.g. name_bind, name_connect) are not relevant
> > to MLS and there are no MLS constraints written on them.
> 
> I see. In the refpolicy they say that name_bind/name_connect have no
> MLS restrictions. But they place restrictions on tcp_socket write and
> read, shouldn't those kick in?
> 
> BTW, what's the difference between connect and name_connect?

tcp_socket write, read, and connect are checks between the process
security context and the (local) socket security context.  name_connect
is between the process' context and the port context.  None of those are
per-packet checks.

> > 2) Can you provide more details about your configuration and your test
> > case (e.g. your exact netlabel configuration, the policy package you are
> > using, the context in which your process runs)?
> 
> Fedora 12 with latest updates; mls policy package. Base package
> description says:
> Based off of reference policy: Checked out revision  2.20090730
> 
> Context is user_u:user_r:user_t:s1
> 
> I did something like 
> netlabelctl unlbl add default address:0.0.0.0/0 \
> 	label:system_u:object_r:netlabel_peer_t:s0
> 
> I could see the packets on the outgoing interface.

Hmm...running that netlabelctl command was sufficient to kill my ssh
connection to my box even running targeted policy, as the requisite
permissions weren't allowed by the default policy.
$ /sbin/ausearch -m AVC -ts recent -i | audit2allow
allow netlabel_peer_t netif_t:netif ingress;
allow netlabel_peer_t node_t:node recvfrom;

egress permission was allowed, but I'd expect it to get denied by the
MLS constraint in your case.

At the risk of flooding your audit log, you might add the following
policy module to see all grantings of egress permission:

$ cat auditnetif.te
policy_module(auditnetif, 1.0)

require {
	attribute domain, netif_type;
}

auditallow domain netif_type:netif egress;

$ make -f /usr/share/selinux/devel/Makefile auditnetif.pp
$ sudo semodule -i auditnetif.pp

If you don't see avc:  granted messages in /var/log/messages
or /var/log/audit/audit.log, then it isn't performing the check at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
