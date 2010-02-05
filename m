Subject: Re: MLS and network
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>
In-Reply-To: <20100205051921.GM1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
	 <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
	 <20100205051921.GM1750@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Fri, 05 Feb 2010 08:54:46 -0500
Message-Id: <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-05 at 06:19 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > If you want network enforcement, you need to configure labeled
> > networking - that isn't enabled by default.
> 
> Thanks. I have two more questions. First, why does MLS require this, but
> for TE it is sufficient to have labeled ports? And second, I have
> managed to label my network to s0, but still, if I try to connect as s1
> user, the outbound connection gets through, only the response (ie.
> syn/ack) is denied. This still violates BLP; is this a matter of how the
> refpolicy is set up?

(cc'd the labeled networking maintainer)

1) Regardless of security policy model (TE or MLS), the newer networking
checks (peer send/recv, netif egress/ingress, node recvfrom/sendto) were
made conditional on configuration of labeled networking to minimize
performance overhead and ensure backward compatibility for users who
have no interest in network enforcement.  MLS is concerned with
information flow among levels, and is thus concerned about the peer
relationships, which can only be known if using labeled networking.  The
port-based checks (e.g. name_bind, name_connect) are not relevant to MLS
and there are no MLS constraints written on them.

2) Can you provide more details about your configuration and your test
case (e.g. your exact netlabel configuration, the policy package you are
using, the context in which your process runs)?  If you have enabled
labeled networking and have labeled your network interface as
s0/SystemLow, then I would expect that you would trigger the following
constraint on outbound traffic:
mlsconstrain { netif } { egress }
        ((( l1 dom l2 ) and ( l1 domby h2 )) or
         ( t1 == mlsnetoutbound ));
which in English says "Only allow netif egress permission if the peer's
low level dominates the netif's low level and the peer's high level is
dominated by the netif's high level i.e. the peer's range is contained
by the netif's range", and thus egress permission would be removed from
the allowed vector if the process was running at s1 and sending outbound
traffic on a netif that was only labeled s0.

Paul, am I missing anything above?

If you build libselinux from source and install the utils (mostly
omitted from the Fedora package), you'll find a utility called
compute_av that you can use to query the actively loaded policy, e.g.
compute_av staff_u:staff_r:staff_t:s1 system_u:object_r:netif_t:s0 netif


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
