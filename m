Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PFSPSI002447
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 11:28:25 -0400
Subject: Re: selinux network control question
To: selinux@tycho.nsa.gov
References: <20150925151543.GA29665@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560567F4.8010800@tycho.nsa.gov>
Date: Fri, 25 Sep 2015 11:27:48 -0400
MIME-Version: 1.0
In-Reply-To: <20150925151543.GA29665@x250>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 11:15 AM, Dominick Grift wrote:
> I am trying to clean up my network policy module but some things are
> unclear. Could anyone shine some light (or correct me) on the below:
> 
> 1.
> network interface labels are no longer checked in any scenario (secmark,
> netlabel, labeled-ipsec) and the netif isid is no longer used.
> 
> So i can remove my netif types and associate the netif isid with a
> context reserved for unused isids?

netif SIDs are used by the egress/ingress permission checks (which are only active if using peer labeling).

> 2.
> Above also applies to node labels (ie. nodes are no longer checked in
> any scenarion (secmark, netlabel, labeled-ipset)
> 
> The question is then why is the node isid still working. And why do i
> need to allow some processes to bind to nodes with the context
> associated with the node isid?
> 
> why is the node isid still used?

node SIDs are used in checks on bind(2) and for sendto/recvfrom checks (also only if using peer labeling).

> 3. packets are checked with secmark, and you can associate different
> packet types with different packets)

secmark allows local/internal labeling of packets via iptables and access control over them based on those labels.

> 4. peers are checked with netlabel, but you only need on peer type
> (ie. you can't associate different peer types with different peers)

peer labeling can be based on labeled IPSEC or netlabel.
NetLabel can only pass MLS labels across the network, although it can convey full contexts locally (see the selinux-testsuite for a configured example under tests/inet_socket or the SELinux Notebook for further examples).
Labeled IPSEC can pass full labels locally or across the network (ditto).
