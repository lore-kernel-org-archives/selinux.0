Message-ID: <D709A20F2164C84E8B7014B0301F5EF852116C@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Mon, 27 Aug 2007 08:44:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Friday, August 24, 2007 11:31 AM
> To: selinux@tycho.nsa.gov
> Cc: James Morris; Darrel Goeddel; Stephen Smalley; 
> kaigai@ak.jp.nec.com;
> joe@nall.com; Eric Paris
> Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
> 
> 
> For those of you who are still paying attention to this 
> thread you may have 
> been wondering why it went quiet all of a sudden; well, the 
> thread didn't go 
> quiet, it went off-list.  Needless to say, we'd like to bring 
> the discussion 
> back on-list so that others can participate, or at the very 
> least get some 
> cheap entertainment on a Friday afternoon.  The discussion 
> was pretty lively 
> so it's not really practical to replay the entire off-list 
> thread here but 
> I'll try to hit upon where we are currently at as well as some of the 
> highlights that brought us to this point.
> 
> If anyone who was a part of the discussion has anything to 
> add to these notes, 
> feel free.
> 
>  * Packet labels (one or two)
> 
> There was quite a bit of debate about the possibility of 
> going from the two 
> packet labels we have currently, external and internal, to a 
> single packet 
> label.  In order to consolidate the two labels there were two 
> approaches 
> considered: a form of "reconciliation" similar to what was 
> discussed earlier 
> this year, and the elimination of internal labels so that 
> only the external 
> label would be used.  After much discussion it was deemed 
> that the two 
> labels, as currently defined/used, are truly independent 
> labels used for two 
> different purposes and that "reconciliation" was still a bad 
> idea and should 
> not be pursued.  Further, while SECMARK and internal labeling 
> have been slow 
> to be adopted in the major distributions it still serves a 
> useful purpose and 
> should not be eliminated.  The end result was the majority, 
> including Stephen 
> and James, voting to continue with the two packet labels as 
> they currently 
> exist.
> 
> One thing that did arise during the discussion was the slow 
> realization that 
> the names for the two packet labels are probably not as 
> descriptive as they 
> should be and that has most likely led to a certain amount of 
> confusion.  In 
> an effort to help make the two different label types more 
> clear it was 
> decided to start calling the external labels "peer labels" as 
> the external 
> label always represents the label of the peer who originated 
> the packet and 
> it's data.  It was also decided to start calling the internal 
> labels "secmark 
> labels", while the compat_net mechanism still exists it is 
> deprecated in 
> favor of the SECMARK mechanism which is the only way to 
> set/manipulate the 
> internal label.
> 
> As a reminder, below is a definition of the two types of labels.
> 
> Secmark, or internal, labels are essentially a means for 
> integrating the 
> traditional firewall rules with SELinux mandatory access 
> controls.  The 
> secmark labels allow policy writers and security 
> administrators to meet 
> security goals similar to the following:
>  "Only allow Apache to accept connections over tcp/80 from 
>   192.168.0.0/24, restricting it to my local network and not
>   the Big-Bad-Internet."
>  -- or --
>  "Only allow a particular instance of Firefox to connect to
>   1.2.3.4 over tcp/443, restricting it to my online banking
>   site."
> 
> Peer, or external, labels, furnished by NetLabel or labeled 
> IPsec/XFRM, 
> provide the domain/context/label of the process which generated the 
> packet/data.  The external labels allow policy writers and security 
> administrators to meet security goals similar to the following:
>  "This instance of Apache serves sensitive financial data and
>   I only want specific clients/peers/domains to be able to access
>   the data from this Apache instance."
>  -- or --
>  "I want to ensure that users connecting to the login server over
>   a Secret connection run in a Secret domain."

Good description (and I am finally with you guys here).

> 
>  * Splitting the SECMARK field
> 
> After it was agreed to continue using both the peer and 
> secmark labels the 
> discussion turned to how best to propagate those labels with 
> the packet.  As 
> you probably know there is a 32 bit field already in the 
> packet/sk_buff 
> structure which is currently used exclusively by the secmark 
> label.  Once 
> again, there were two approaches considered.  The first was 
> the continuation 
> of the status quo where the secmark label is determined by 
> looking directly 
> at the secmark field in the sk_buff, "sk_buff.secmark", and 
> the peer label is 
> determined through a function call with the sk_buff as an 
> argument, "peer_label(sk_buff)".

This should be possible, with the obvious drawback that of a
performance overhead of "resolving" all the different "peer"
labels each time we need it (for example at each filter point).

Also, in the forwarding case, while the original xfrm-label should
still be around in the labeled-IPSec to non-labeled-IPSec case, I
would imagine in the NetLabel case, the option field would lose the
"original" label in a DOI gateway instance (if and when NateLabel
does this), right?

>  The second idea was to 
> divide the secmark 
> field in the sk_buff into two 16 bit sub-fields effectively 
> shortening peer 
> and secmark SIDs to 16 bits.

I would vote for this (or some variant). This has 2 advantages:

1. Resolve the external labels just once and plant it in the
   split secmark.

2. Also use this for a loopback packet labeling (as also pointed
   out by you later).

> 
> While there is still no final agreement on the best way 
> forward, there does 
> seem to be agreement that the split secmark field offers a 
> good deal of 
> implementation convenience/cleanliness but it requires either 
> a reduction in 
> the system's SID space from 32 bits to 16 bits (4.<mumble> 
> billion unique 
> labels down to 65 thousand unique labels for all 
> subjects/objects on the 
> system) or some sort of additional internal SID mapping 
> mechanism which has 
> yet to be defined.  Both of which have the potential for introducing 
> compatibility problems.
> 
>  * Loopback/Localhost peer packet labeling
> 
> This has been a long standing requirement which at first 
> glance seems like it 
> would be simple to achieve but in practice it has proven 
> quiet difficult to 
> implement.  Current solutions to the problem involve using either 
> NetLabel/CIPSO or labeled IPsec over loopback to provide peer labels, 
> unfortunately both have drawbacks.  NetLabel/CIPSO is 
> currently limited to 
> only conveying the MLS sensitivity label over the wire and 
> only then for IPv4 
> packets.

This can perhaps be worked-around by passing the sid verbatim
using a special IP option (I believe suggested by Pete looking
at the Symposium minutes).

>  Labeled IPsec can convey the full SELinux 
> label/context of the peer 
> for both IPv4 and IPv6 but is difficult to configure and introduces 
> unnecessary overhead for packets that never leave the machine.

(snip)

>  * Packet flow control
> 
> Another long standing goal that has not seen much success 
> over the years.  The 
> two approaches currently being considered are: per-interface 
> checks against 
> the peer label with the possibility of an additional 
> forwarding hook/check if 
> needed for labeling purposes, as well as an iptables based filtering 
> mechanism which has already been discussed off and on on the 
> public SELinux 
> and LSPP mailing lists (SECFILTER/SECPOINT).  The idea behind 
> the iptables 
> based filtering mechanism is that "filter points" could be 
> defined using 
> iptables/netfilter which would provide very granular access 
> control checks.  
> The big question that is currently being debated is how much 
> granularity is 
> needed and how much makes sense? 

I believe this is hard to predict for the general case.

While in some cases you could get away with the use of fine-grained
labeling of packets and then subjecting them to interface-only
controls, I would imagine an approach that can scale from coarse to
granular would make the most sense for the general case.

For the MLS-case, we seem to need at least node-level granularity.

> 
>  * Fallback labels
> 
> The simple idea that started this whole discussion.  The need 
> for a usable 
> peer label fallback mechanism is understood by everyone but 
> the granularity 
> with which peer fallback labels are assigned are still a 
> source of debate.  
> The idea is wether the granularity proposed in this NetLabel 
> patchset which 
> allows per-host/subnet granularity for each interface is 
> enough, and if not 
> is a very granular iptables/netfilter peer label assignment 
> of fallback 
> labels required?  This topic did come up briefly some time 
> ago on the public 
> mailing list between Joshua Brindle and myself and we agreed that the 
> granularity presented in this patchset is sufficient, 
> however, not everyone 
> feels this way so we are still discussing the best solution.

Well, there may be a case, where there's a need to identify an
sshd_t peer different from a httpd_t peer. Or a http_client_t
peer from an rss_aggregator_t peer. Scalability from coarse to
granular should meet the entire spectrum of general cases. 

> 
> As part of the peer fallback label discussion it became 
> apparent to everyone 
> that better integration/cooperation between the NetLabel and 
> XFRM labeling 
> mechanisms is needed.  The strict separation worked well in 
> the beginning but 
> as we start to develop a richer set of functionality the two labeling 
> mechanisms need to work better together to ensure the 
> consistency of the 
> network access controls.  If the approach put forward in this 
> patch set is 
> agreed upon as the right way to solve the peer fallback 
> problem I will be 
> modifying it to take into account XFRM labels so that the 
> NetLabel provided 
> fallback peer label will only be used when there is no XFRM 
> or NetLabel/CIPSO 
> label on the packet.  Further, work will be done to ensure 
> that when both a 
> XFRM and NetLabel/CIPSO label are present on an incoming 
> packet that the 
> labels are the same, otherwise the packet will be dropped/rejected.

Yep.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
