Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7OKgIbg022347
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 16:42:18 -0400
Received: from web36602.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7OKgHBK016829
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 20:42:17 GMT
Date: Fri, 24 Aug 2007 13:42:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
To: Paul Moore <paul.moore@hp.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200708241549.05839.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <905414.86820.qm@web36602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:


> > Hmm. In one case the name reflects the purpose (label of peer) and
> > in the other the name reflects the mechanism (label used in SECMARK).
> > I like the clarification of the former as it tells an LSM writer
> > what to use the label for, while I dislike the latter because it
> > does nothing to help me understand the intent of the mechanism.
> 
> Feel free to suggest something better, I don't think anyone was ever really
> in 
> love with the term "secmark label".  I believe at one point Stephen 
> suggested "iptables label", does that sound any better?

It does because it describes the intended use.

> 
> > > As a reminder, below is a definition of the two types of labels.
> > >
> > > Secmark, or internal, labels are essentially a means for integrating the
> > > traditional firewall rules with SELinux mandatory access controls.
> >
> > Is it really intended that Secmark is an SELinux specific mechanism?
> 
> I don't see why it _has_ to be a SELinux specific mechanism.  I understand 
> that some of the netfilter code is SELinux specific (mostly the part dealing 
> with SELinux secctx/secid conversions) but you could either change that to 
> the more generic LSM secctx/secid conversion API or simply augment it for 
> SMACK (I even see some nice case statements already in place to make things 
> easy for you).

I can see where the mechanism is intended for generality and
where there is strong SELinux influence. I always get nervous
when what looks like a general mechanism is described in terms
of a specific use to which it gets put.

> However, all of this assumes that the LSM has a functional 
> label-to-32bit-token mapping mechanism similar to what SELinux has with the 
> SID concept.  I know, and understand why, you are not a big fan of this for 
> SMACK but secids/tokens are a reality in several parts of the kernel and I 
> don't expect that to change anytime soon.  You don't have to implement a 
> label/token mapping mechanism I guess, but you won't be able to make use of 
> kernel subsystems which require it.

Having come to that realization myself while trying to deal with
the audit code (which would be easily repairable were it not for xfrm)
I've been working on accomodating this particularily.

> > Yes, yes, I understand that SELinux is the only upstream LSM and all
> > that. If it is intended only as a component of SELinux going forward
> > regardless of alternative LSM availability maybe that should be more
> > explicit in the related documentation.
> 
> Documentation?  Who has documentation?!  ;)
> 
> You make a good point, one that became clear to me over the course of the 
> discussion is that we need better documentation about the SELinux/LSM network
> 
> access controls work in the kernel.  Josh wrote up a nice blog entry a while 
> ago about how to make some of it work in userspace (no NetLabel instructions,
> 
> though ... tsk tsk <g>!) but we don't have anyting for kernel hack[er]s.  One
> 
> of the things that made it on to my todo list (but I haven't shared this with
> 
> anyone until now) is a document/wiki-entry describing how things work in the 
> kernel, and I'll be sure to point out which things are SELinux specific 
> (which is pretty few, if any).

I expect that the actual dependencies are isolated. Where they
exist it would be nice for them to be explicit.

> > I would personally be 
> > disappointed if the mechanism were unavailable to other LSMs, but that
> > is of course your call.
> 
> As long as their is an LSM my opinion is that all mechanisms which live 
> outside the LSM and/or provide services to LSM modules should be agnostic of 
> any one particular LSM.  However, this does not mean that the is must deal 
> only with binary/string/secctx labels; if it makes sense to deal strictly 
> with secid tokens then so be it.

Maybe we can fix that in 3.0. That is, I'll accept it for now,
but someday we really ought to revisit the decision.

> > >  * Splitting the SECMARK field
> > >
> > > After it was agreed to continue using both the peer and secmark labels
> > > the discussion turned to how best to propagate those labels with the
> > > packet.  As you probably know there is a 32 bit field already in the
> > > packet/sk_buff structure which is currently used exclusively by the
> > > secmark label.  Once again, there were two approaches considered.  The
> > > first was the continuation of the status quo where the secmark label is
> > > determined by looking directly at the secmark field in the sk_buff,
> > > "sk_buff.secmark", and the peer label is
> > >
> > > determined through a function call with the sk_buff as an
> > > argument, "peer_label(sk_buff)".
> >
> > Would that be netlbl_peer_label(sk_buff), selinux_peer_label(sk_buff),
> > or security_peer_label(sk_buff)?
> 
> At this point I'm thinking this would be internal/specific to the LSM; SMACK 
> and other LSMs cand devise whatever internal mechanism they want.  SMACK for 
> example only has one labeling mechanism that I can see so this is kind of a 
> moot point for you, just make use of the NetLabel API to get the security 
> attributes/label of a packet.  For SELinux it's not quite so simple as both 
> NetLabel and XFRM can provide peer label information, in order to make it 
> easier I was suggesting providing a single wrapper function that would take 
> into account all peer labeling mechanisms and return the correct peer label.

Sound.

> > >  * Loopback/Localhost peer packet labeling
> > >
> > > This has been a long standing requirement which at first glance seems
> > > like it
> > >
> > > would be simple to achieve but in practice it has proven quiet difficult
> > > to implement.  Current solutions to the problem involve using either
> > > NetLabel/CIPSO or labeled IPsec over loopback to provide peer labels,
> > > unfortunately both have drawbacks.  NetLabel/CIPSO is currently limited
> > > to only conveying the MLS sensitivity label over the wire and only then
> > > for IPv4
> > >
> > > packets.  Labeled IPsec can convey the full SELinux label/context of the
> > > peer
> > >
> > > for both IPv4 and IPv6 but is difficult to configure and introduces
> > > unnecessary overhead for packets that never leave the machine.
> >
> > In the early Smack development I experimented with a scheme that
> > was very like CIPSO with the exception that it carried the MAC
> > information directly.
> 
> I am thinking along the same lines for NetLabel/CIPSO, similar to the old 
> Selopt concept.  I'm also considering adding some additional fields/info to 
> carry additional information that used to passed along via MaxSix/SAMP; more 
> on that when I get to that work item.
> 
> > That would be a smack_t for me, but it would do u32s just fine.
> 
> While having to deal only with secids would make life easier, it might be 
> possible to offer alternate option formats for different LSMs (as long as 
> they were in mainline).

Well, you could define the interface to take a pointer and length,
thereby leaving it up to the LSM. Heck, SELinux could use it to
pass two sids instead of one that way.

> > It has the disadvantage that you have to be careful 
> > to avoid going off the box since there's no RFC supporting it.
> 
> Yes, indeed.  Although in the case of NetLabel/CIPSO we have the wonderful 
> (well, not so wonderful if your a router vendor) FIPS defined "freeform" tag 
> which would allow us to stuff whatever we want so long as it fits in the IP 
> header length limitations.  That said, I'm currently tossing around ways to 
> leverage the ip_build_options() routine to provide destination specific 
> NetLabel labeling in conjunction with the existing per-domain labeling.
> 
> IPv6 is of course, a different story.

Indeed.

> > I seem to recall there is an "approved" scheme lurking in the
> > networking header files, but I never persued that.
> 
> I have absolutely no idea what you are talking about here.

It might even have been selopt. 
 
> > > The solution for this problem is tightly coupled with the decision to
> > > split/not-split the secmark field in the sk_buff structure.  If the
> > > secmark field were split then the peer label could be set directly in the
> > > packet to the originating socket and then preserved across the loopback
> > > pseudo-interface for use on the receiving/inbound side.  However, this
> > > does require splitting the secmark field and all that goes along with it
> > > (see above).  If the secmark field were not split then the solution is to
> > > continue
> > >
> > > to develop the peer labeling mechanisms to support loopback labeling. 
> > > Joy Latten from IBM has been working on better support for IPsec over
> > > loopback (although I'm not sure of it's current status) and I am steadily
> > > working towards a more full featured NetLabel which would be able to
> > > convey a full SELinux context over the wire/loopback.
> >
> > So how big is a "full" context?
> 
> See my comments above.  In the case of SELinux I would probably simply just 
> pass the SID directly over loopback for performance reasons.

Yup.

> 
> > >  * Fallback labels
> > >
> > > ...
> > >
> > > label on the packet.  Further, work will be done to ensure that when both
> > > a XFRM and NetLabel/CIPSO label are present on an incoming packet that
> > > the labels are the same, otherwise the packet will be dropped/rejected.
> >
> > It makes me uncomfortable to hear you say that XFRM is SELinux specific
> > and that it needs to be integrated with NetLabel, which currently isn't.
> 
> Relax, I plan on making the integration/cooperation within SELinux.  I'm
> still 
> working on the patches (just started thinking/coding yesterday) but as it 
> stands the only real change to NetLabel will be the addition of label source 
> information in the netlbl_lsm_secattr struct, i.e. is this a CIPSO label, a 
> unlabeled/fallback label, etc.

Ok. I've relaxed.
 
> > I know that Smack isn't upstream yet.
> 
> Slacker :)

Sometimes the Rock Star Lifestyle gets in the way.

> > Nonetheless, I would hate to see 
> > underlying mechanisms that currently provide useful facilities become
> > SELinux specific.
> 
> As long as the LSM is in place, so would I.

Carefully worded.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
