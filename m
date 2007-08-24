Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7OJ2Ido015735
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 15:02:18 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7OJ2GLL022608
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 19:02:16 GMT
Date: Fri, 24 Aug 2007 12:02:00 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200708241231.23793.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <454500.99769.qm@web36612.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> For those of you who are still paying attention to this thread you may have 
> been wondering why it went quiet all of a sudden; well, the thread didn't go 
> quiet, it went off-list.

Boo.

> ...
> 
>  * Packet labels (one or two)
> 
> ... voting to continue with the two packet labels as they currently 
> exist.

For SELinux this appears prudent. For those using other schemes
the difference may be less obvious, but I see you discuss that
more below.

> One thing that did arise during the discussion was the slow realization that 
> the names for the two packet labels are probably not as descriptive as they 
> should be and that has most likely led to a certain amount of confusion.  In 
> an effort to help make the two different label types more clear it was 
> decided to start calling the external labels "peer labels" as the external 
> label always represents the label of the peer who originated the packet and 
> it's data.  It was also decided to start calling the internal labels "secmark
> 
> labels", while the compat_net mechanism still exists it is deprecated in 
> favor of the SECMARK mechanism which is the only way to set/manipulate the 
> internal label.

Hmm. In one case the name reflects the purpose (label of peer) and
in the other the name reflects the mechanism (label used in SECMARK).
I like the clarification of the former as it tells an LSM writer
what to use the label for, while I dislike the latter because it
does nothing to help me understand the intent of the mechanism.
 
> As a reminder, below is a definition of the two types of labels.
> 
> Secmark, or internal, labels are essentially a means for integrating the 
> traditional firewall rules with SELinux mandatory access controls.

Is it really intended that Secmark is an SELinux specific mechanism?
Yes, yes, I understand that SELinux is the only upstream LSM and all
that. If it is intended only as a component of SELinux going forward
regardless of alternative LSM availability maybe that should be more
explicit in the related documentation. I would personally be
disappointed if the mechanism were unavailable to other LSMs, but that
is of course your call.

> The 
> secmark labels allow policy writers and security administrators to meet 
> security goals similar to the following:
>  "Only allow Apache to accept connections over tcp/80 from 
>   192.168.0.0/24, restricting it to my local network and not
>   the Big-Bad-Internet."
>  -- or --
>  "Only allow a particular instance of Firefox to connect to
>   1.2.3.4 over tcp/443, restricting it to my online banking
>   site."
> 
> Peer, or external, labels, furnished by NetLabel or labeled IPsec/XFRM, 
> provide the domain/context/label of the process which generated the 
> packet/data.

As I mentioned earlier, I like this definition because it describes
the intent of the facility and provides guidance to those who would
extend the facility or use it to other ends.

> The external labels allow policy writers and security 
> administrators to meet security goals similar to the following:
>  "This instance of Apache serves sensitive financial data and
>   I only want specific clients/peers/domains to be able to access
>   the data from this Apache instance."
>  -- or --
>  "I want to ensure that users connecting to the login server over
>   a Secret connection run in a Secret domain."
> 
>  * Splitting the SECMARK field
> 
> After it was agreed to continue using both the peer and secmark labels the 
> discussion turned to how best to propagate those labels with the packet.  As 
> you probably know there is a 32 bit field already in the packet/sk_buff 
> structure which is currently used exclusively by the secmark label.  Once 
> again, there were two approaches considered.  The first was the continuation 
> of the status quo where the secmark label is determined by looking directly 
> at the secmark field in the sk_buff, "sk_buff.secmark", and the peer label is
> 
> determined through a function call with the sk_buff as an 
> argument, "peer_label(sk_buff)".

Would that be netlbl_peer_label(sk_buff), selinux_peer_label(sk_buff),
or security_peer_label(sk_buff)?

> The second idea was to divide the secmark ... the potential for
> introducing compatibility problems.

Yup.

>  * Loopback/Localhost peer packet labeling
> 
> This has been a long standing requirement which at first glance seems like it
> 
> would be simple to achieve but in practice it has proven quiet difficult to 
> implement.  Current solutions to the problem involve using either 
> NetLabel/CIPSO or labeled IPsec over loopback to provide peer labels, 
> unfortunately both have drawbacks.  NetLabel/CIPSO is currently limited to 
> only conveying the MLS sensitivity label over the wire and only then for IPv4
> 
> packets.  Labeled IPsec can convey the full SELinux label/context of the peer
> 
> for both IPv4 and IPv6 but is difficult to configure and introduces 
> unnecessary overhead for packets that never leave the machine.

In the early Smack development I experimented with a scheme that
was very like CIPSO with the exception that it carried the MAC
information directly. That would be a smack_t for me, but it
would do u32s just fine. I abandoned it in favor of CIPSO to
reduce the changes outside of the LSM, but it would be easy to
resurrect. It has the disadvantage that you have to be careful
to avoid going off the box since there's no RFC supporting it.
I seem to recall there is an "approved" scheme lurking in the
networking header files, but I never persued that.

> The solution for this problem is tightly coupled with the decision to 
> split/not-split the secmark field in the sk_buff structure.  If the secmark 
> field were split then the peer label could be set directly in the packet to 
> the originating socket and then preserved across the loopback 
> pseudo-interface for use on the receiving/inbound side.  However, this does 
> require splitting the secmark field and all that goes along with it (see 
> above).  If the secmark field were not split then the solution is to continue
> 
> to develop the peer labeling mechanisms to support loopback labeling.  Joy 
> Latten from IBM has been working on better support for IPsec over loopback 
> (although I'm not sure of it's current status) and I am steadily working 
> towards a more full featured NetLabel which would be able to convey a full 
> SELinux context over the wire/loopback.

So how big is a "full" context?

>  * Packet flow control
> 
> ... 
> 
>  * Fallback labels
> 
> The simple idea that started this whole discussion.  The need for a usable 
> peer label fallback mechanism is understood by everyone but the granularity 
> with which peer fallback labels are assigned are still a source of debate.  
> The idea is wether the granularity proposed in this NetLabel patchset which 
> allows per-host/subnet granularity for each interface is enough, and if not 
> is a very granular iptables/netfilter peer label assignment of fallback 
> labels required?  This topic did come up briefly some time ago on the public 
> mailing list between Joshua Brindle and myself and we agreed that the 
> granularity presented in this patchset is sufficient, however, not everyone 
> feels this way so we are still discussing the best solution.
> 
> As part of the peer fallback label discussion it became apparent to everyone 
> that better integration/cooperation between the NetLabel and XFRM labeling 
> mechanisms is needed.  The strict separation worked well in the beginning but
> 
> as we start to develop a richer set of functionality the two labeling 
> mechanisms need to work better together to ensure the consistency of the 
> network access controls.  If the approach put forward in this patch set is 
> agreed upon as the right way to solve the peer fallback problem I will be 
> modifying it to take into account XFRM labels so that the NetLabel provided 
> fallback peer label will only be used when there is no XFRM or NetLabel/CIPSO
> 
> label on the packet.  Further, work will be done to ensure that when both a 
> XFRM and NetLabel/CIPSO label are present on an incoming packet that the 
> labels are the same, otherwise the packet will be dropped/rejected.

It makes me uncomfortable to hear you say that XFRM is SELinux specific
and that it needs to be integrated with NetLabel, which currently isn't.
I know that Smack isn't upstream yet. Nonetheless, I would hate to see
underlying mechanisms that currently provide useful facilities become
SELinux specific.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
