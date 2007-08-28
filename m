Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SE3QIL002901
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 10:03:26 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SE3PM5016495
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 14:03:25 GMT
Received: by wx-out-0506.google.com with SMTP id t8so1998856wxc
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 07:03:22 -0700 (PDT)
Message-ID: <46D42B15.6080205@gmail.com>
Date: Tue, 28 Aug 2007 09:03:01 -0500
From: Darrel Goeddel <sedgoeddel@gmail.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <46C37F99.1060406@trustedcs.com> <Xine.LNX.4.64.0708160711280.30949@us.intercode.com.au> <200708241231.23793.paul.moore@hp.com>
In-Reply-To: <200708241231.23793.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:

<snip>

>  * Loopback/Localhost peer packet labeling
> 
> This has been a long standing requirement which at first glance seems like it 
> would be simple to achieve but in practice it has proven quiet difficult to 
> implement.  Current solutions to the problem involve using either 
> NetLabel/CIPSO or labeled IPsec over loopback to provide peer labels, 
> unfortunately both have drawbacks.  NetLabel/CIPSO is currently limited to 
> only conveying the MLS sensitivity label over the wire and only then for IPv4 
> packets.  Labeled IPsec can convey the full SELinux label/context of the peer 
> for both IPv4 and IPv6 but is difficult to configure and introduces 
> unnecessary overhead for packets that never leave the machine.
> 
> The solution for this problem is tightly coupled with the decision to 
> split/not-split the secmark field in the sk_buff structure.  If the secmark 
> field were split then the peer label could be set directly in the packet to 
> the originating socket and then preserved across the loopback 
> pseudo-interface for use on the receiving/inbound side.  However, this does 
> require splitting the secmark field and all that goes along with it (see 
> above).  If the secmark field were not split then the solution is to continue 
> to develop the peer labeling mechanisms to support loopback labeling.  Joy 
> Latten from IBM has been working on better support for IPsec over loopback 
> (although I'm not sure of it's current status) and I am steadily working 
> towards a more full featured NetLabel which would be able to convey a full 
> SELinux context over the wire/loopback.

I just want to note that there are a few associated changes that should 
go along with this.  Once we have the concept of the sender's context in 
in/associated with (I prefer in :)) the skb, we should use that when 
applying on-the-wire labels.  For the case fo locally generated packets, 
this end up doing the same thing since the socket's label is in the skb 
as the peer label.  The real difference in behavior is the added 
functionality of putting labels on the wire for forwarded packets (if 
prescribed by the on-the-wire policy).  For instance, a packet which 
receives a fallback label of SECRET (because it came in a interface we 
treat as SECRET) would be given the opportunity to exit a different 
interface with that SECRET label on-the-wire.  This gives us the ability 
to "consolidate" single level networks into a single network that uses 
explicit labeling.  Should work nicely for cipso and labeled ipsec This 
is something we currently employ with a patched kernel.

--

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
