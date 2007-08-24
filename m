Message-ID: <D709A20F2164C84E8B7014B0301F5EF8481CD3@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Fri, 24 Aug 2007 14:11:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com]
> Sent: Friday, August 24, 2007 12:37 PM
> To: Paul Moore; selinux@tycho.nsa.gov
> Cc: James Morris; Darrel Goeddel; Stephen Smalley; 
> kaigai@ak.jp.nec.com;
> joe@nall.com; Eric Paris
> Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
> 
> 
> I will go ahead and offer my comments to the below in my
> personal capacity.
> 
> > -----Original Message-----
> > From: Paul Moore [mailto:paul.moore@hp.com]
> (snip)
> > As a reminder, below is a definition of the two types of labels.
> > 
> > Secmark, or internal, labels are essentially a means for 
> > integrating the 
> > traditional firewall rules with SELinux mandatory access 
> > controls.  The 
> > secmark labels allow policy writers and security 
> > administrators to meet 
> > security goals similar to the following:
> >  "Only allow Apache to accept connections over tcp/80 from 
> >   192.168.0.0/24, restricting it to my local network and not
> >   the Big-Bad-Internet."
> >  -- or --
> >  "Only allow a particular instance of Firefox to connect to
> >   1.2.3.4 over tcp/443, restricting it to my online banking
> >   site."
> > 
> 
> Secmark is currently playing the role of arbitrating between
> a socket and a packet, based on the internal knowledge of the
> packet. I don't see why this "internal" label of the packet
> couldn't be the internally defined peer label that MUST be
> the same as any external peer label coming in with the packet.
> 
> Thus the current socket Vs. packet.recv check would be 
> retained intact.
> 
> For the outgoing, the packet would get it's label from the socket
> and then the check would whether the label on the packet matches
> the "internally" defined "local" label. There can further be a
> socket Vs. packet.send, but this will typically boil down to
> can a httpd_t socket send a httpd_t packet (if and when the
> ability to write a packet to a socket with a label different
> from the socket's, the target of the check would then be
> that label).
> 
> Essentially, the following characterization:
> 
> One would define what peers are "expected" to come in with what
> characteristics using iptables selectors. Similarly, one would
> define what local domains are expected to go out with what
> characteristics using iptables selectors. A label coming in with
> a packet MUST match the "expected" label or the packet will 
> be dropped.
> For the outgoing also, a packet's label (domain label from the socket)
> MUST match the "expected" label (defined using iptables 
> selectors) or the
> packet will be dropped.
> 
> We also inherently have flow control in the above.

Also, this doesn't mean we couldn't have additional flow control
at the interface or node levels for added assurance and to meet
controlled interface requirements. Its just that even without these
additional flow-controls, we do have flow-control for forwarded packets
built-in.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
