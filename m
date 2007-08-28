From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <sedgoeddel@gmail.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 11:16:06 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <46C37F99.1060406@trustedcs.com> <200708241231.23793.paul.moore@hp.com> <46D42B15.6080205@gmail.com>
In-Reply-To: <46D42B15.6080205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281116.06571.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 28 2007 10:03:01 am Darrel Goeddel wrote:
> Paul Moore wrote:
>
> <snip>
>
> >  * Loopback/Localhost peer packet labeling
> >
> > This has been a long standing requirement which at first glance seems
> > like it would be simple to achieve but in practice it has proven quiet
> > difficult to implement.  Current solutions to the problem involve using
> > either NetLabel/CIPSO or labeled IPsec over loopback to provide peer
> > labels, unfortunately both have drawbacks.  NetLabel/CIPSO is currently
> > limited to only conveying the MLS sensitivity label over the wire and
> > only then for IPv4 packets.  Labeled IPsec can convey the full SELinux
> > label/context of the peer for both IPv4 and IPv6 but is difficult to
> > configure and introduces unnecessary overhead for packets that never
> > leave the machine.
> >
> > The solution for this problem is tightly coupled with the decision to
> > split/not-split the secmark field in the sk_buff structure.  If the
> > secmark field were split then the peer label could be set directly in the
> > packet to the originating socket and then preserved across the loopback
> > pseudo-interface for use on the receiving/inbound side.  However, this
> > does require splitting the secmark field and all that goes along with it
> > (see above).  If the secmark field were not split then the solution is to
> > continue to develop the peer labeling mechanisms to support loopback
> > labeling.  Joy Latten from IBM has been working on better support for
> > IPsec over loopback (although I'm not sure of it's current status) and I
> > am steadily working towards a more full featured NetLabel which would be
> > able to convey a full SELinux context over the wire/loopback.
>
> I just want to note that there are a few associated changes that should
> go along with this.  Once we have the concept of the sender's context in
> in/associated with (I prefer in :)) the skb, we should use that when
> applying on-the-wire labels.  For the case fo locally generated packets,
> this end up doing the same thing since the socket's label is in the skb
> as the peer label.  The real difference in behavior is the added
> functionality of putting labels on the wire for forwarded packets (if
> prescribed by the on-the-wire policy).  For instance, a packet which
> receives a fallback label of SECRET (because it came in a interface we
> treat as SECRET) would be given the opportunity to exit a different
> interface with that SECRET label on-the-wire.  This gives us the ability
> to "consolidate" single level networks into a single network that uses
> explicit labeling.  Should work nicely for cipso and labeled ipsec This
> is something we currently employ with a patched kernel.

Yes.  For locally generated packets the peer label of the packet is the label 
of the socket which generated the packet, for forwarded packets the peer 
label is the peer label that was associated with the packet when it arrived 
at the system.  On-the-wire labeling should always be based on the peer label 
of the packet as defined above.

On-the-wire labeling for forwarded packets was discussed just recently in a 
few messages between Venkat and myself on this thread.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
