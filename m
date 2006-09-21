Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LGm3hE018462
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 12:48:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LGlXcD029679
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 16:47:34 GMT
Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C061859201573327@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201573327@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 12:47:46 -0400
Message-Id: <1158857266.28640.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 12:27 -0400, Venkat Yekkirala wrote:
> > On Thu, 2006-09-21 at 11:01 -0400, Venkat Yekkirala wrote:
> > > > I agree about what getpeercon should return, even to the point of
> > > > returning nothing or error if only secmark is being used.
> > > 
> > > And why should that be the case? Everything has a label on 
> > a MAC system
> > > and why should apps care about the configuration (explicit 
> > IPSec label
> > > Vs. implicit via secmark)?
> > <snip>
> > > You will want to deal with only 1 label at the app level, 
> > and it should be
> > > the label that was used in determining whether the socket could read
> > > the skb or not.
> > > 
> > > Can you give any examples on where differentiation is needed?
> > 
> > Callers of getpeercon() expect it to return a subject label that they
> > can use in a call to e.g. avc_has_perm() as the source/subject context
> > or setexeccon() or (shudder) setcon().  If it returns
> > httpd_client_packet_lo_t, then the caller is going to run into trouble
> > upon trying to use the context as a subject label.
> 
> Yes, the caller is going to run into trouble here, but only because your
> policy
> is wanting it, is it not? i.e., a trusted app can always work in conjunction
> with policy (via transitions and whatnot if need be) in servicing the
> request
> at the appropriate label.

I doubt it will work in all cases. And returning a label when in fact we
don't have the information (e.g., when only using secmark) changes the
semantics of this call. The call should indicate what information it has
by returning an error without ipsec or netlabel.

I also think this change is confusing which object class we are dealing
with. Packets are a separate object from a process. Yes packets may
inherit the context of the process in some circumstances, but they
remain distinct objects. Making getpeercon return the packet label is
returning the label of the wrong object.

I started to write a long post on scenarios where the distinction would
be important, but honestly I think it comes down to what I said above.
We have two objects and each object should be labeled independently. It
might be possible to use transition rules to combine the information
from the two labels into a third (which is essentially what would be
happening), but it mis-represents the underlying system and is going to
be difficult to manage. It would require an explosion of types to not
lose information (i.e., one type for every possible process / packet
type pair).

The reconciliation scheme currently changes the semantics of both
getpeercon and the new packet object classes in what I see as
non-intuitive ways. Apps and policy will have to take into account which
labeling mechanism is in use (e.g., the packet object class checks will
sometimes get packet types and sometimes get process types - same for
getpeercon). It seems like this will require additional policy and code.

The simplest solution is to keep the labels separate as Josh suggested.
However, I think that it would be better to pass packet and process
labels over ipsec but that would likely be a fundamental change to the
ipsec labeling model.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
