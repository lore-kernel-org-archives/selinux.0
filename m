Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LHEY2f019642
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:14:34 -0400
Message-ID: <36282A1733C57546BE392885C06185920157333E@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
        Joshua Brindle
	 <jbrindle@tresys.com>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Thu, 21 Sep 2006 13:14:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > Callers of getpeercon() expect it to return a subject 
> label that they
> > > can use in a call to e.g. avc_has_perm() as the 
> source/subject context
> > > or setexeccon() or (shudder) setcon().  If it returns
> > > httpd_client_packet_lo_t, then the caller is going to run 
> into trouble
> > > upon trying to use the context as a subject label.
> > 
> > Yes, the caller is going to run into trouble here, but only 
> because your
> > policy
> > is wanting it, is it not? i.e., a trusted app can always 
> work in conjunction
> > with policy (via transitions and whatnot if need be) in 
> servicing the
> > request
> > at the appropriate label.
> 
> I doubt it will work in all cases. And returning a label when 
> in fact we
> don't have the information (e.g., when only using secmark)

The reality is that you DO have the information. The source of the info
has entirely to do with the network layout/configuration, resulting
in the use of externally labeled packets Vs. internal. E.g. All the data
coming thru a Secret interface is Secret. It doesn't matter whether the
data was labeled as such prior to entering which it may not for reasons
of performance, trust in the underlying network hardware, etc.

> changes the
> semantics of this call. The call should indicate what 
> information it has
> by returning an error without ipsec or netlabel.

You could simulate the error by letting httpd_client_packet_lo_t
run into trouble for example; or smartly handle it via policy
transitions, etc.

> 
> I also think this change is confusing which object class we 
> are dealing
> with. Packets are a separate object from a process. Yes packets may
> inherit the context of the process in some circumstances, but they
> remain distinct objects.

Agreed and I don't see where we are changing this.

> Making getpeercon return the packet label is
> returning the label of the wrong object.

If a packet arrived at the sock as Secret (the details of how it came
to assume that label is again to do with considerations of network
layout, trust, and such as mentioned earlier), it OUGHT to be treated
as having come from a Secret peer.

> 
> I started to write a long post on scenarios where the 
> distinction would
> be important, but honestly I think it comes down to what I said above.

I would like to look at a couple.

> We have two objects and each object should be labeled 
> independently. It
> might be possible to use transition rules to combine the information
> from the two labels into a third (which is essentially what would be
> happening), but it mis-represents the underlying system and 
> is going to
> be difficult to manage. It would require an explosion of types to not
> lose information (i.e., one type for every possible process / packet
> type pair).

Not necessarily, you would do the extra rules only when you ARE
using labeled IPSec and that too when you aren't interested in
your trusted app seeing the IPSec Type. That's the only time you
would do transitions. The reconciliation logic is about progressively
refining the label of the packet all the while making sure, secmark
and such have a say in it.

> 
> The reconciliation scheme currently changes the semantics of both
> getpeercon and the new packet object classes in what I see as
> non-intuitive ways. Apps and policy will have to take into 
> account which
> labeling mechanism is in use (e.g., the packet object class 
> checks will
> sometimes get packet types and sometimes get process types

Where are they getting the process types?

> - same for
> getpeercon). It seems like this will require additional 
> policy and code.

I would appreciate an example.
> 
> The simplest solution is to keep the labels separate as Josh 
> suggested.

The thing I am trying to understand is, why would an app want
to know the entry/exit point context? This context is now for
flow control checks. I believe a lot of the confusion here
might have to do with naming.

> However, I think that it would be better to pass packet and process
> labels over ipsec but that would likely be a fundamental change to the
> ipsec labeling model.

More info and checks are always good, but from a complexity and performance
standpoint
why couldn't we have the source machine worry about resolving the two
labels? 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
