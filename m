Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LF22Sl014437
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 11:02:02 -0400
Message-ID: <36282A1733C57546BE392885C0618592015732E3@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle
	 <jbrindle@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        sds
	 <sds@epoch.ncsc.mil>, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Thu, 21 Sep 2006 11:01:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[CC'ing selinux]

> -----Original Message-----
> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> Sent: Thursday, September 21, 2006 9:38 AM
> To: Joshua Brindle
> Cc: Venkat Yekkirala; Paul Moore; latten@austin.ibm.com; sds;
> jmorris@redhat.com; dwalsh@redhat.com; Darrel Goeddel; Chad Hanson
> Subject: RE: Labeled networking packets
> 
> 
> On Thu, 2006-09-21 at 07:18 -0400, Joshua Brindle wrote:
> > > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > > 
> > > > We really need this in if we expect useful network labeling 
> > > in rhel5 
> > > > but I'm still skeptical about reconciling cipso + ipsec 
> > > together with 
> > > > secmark.
> > > > From what I can tell cipso is taking priority and is 
> > > getting the type 
> > > > transition calculated and ipsec isn't.
> > > 
> > > It would actually be the other way around. A transition is 
> > > computed only in the labeled IPSec case. In the cipso case, 
> > > only a "flow in" check happens (this would obviously change 
> > > when whole SELinux contexts are transmitted using options, as 
> > > Paul is understood to be looking into, in the future).
> > > 
> > 
> > Eh, I knew that, sorry, I don't know what I was thinking..
> > 
> > > > I'm not sure
> > > > if this is
> > > > the desirable behavior.
> > > 
> > > Could you lay out an example; perhaps there's a 
> > > misunderstanding somewhere?
> > > 
> > 
> > In one of my first emails I pointed out that an app doing 
> getpeercon()
> > is really expecting the context of the domain on the other side of a
> > connection (peer?). With unix domain sockets that would still happen
> > (unless they were relabeled) but with ipsec connections you 
> are getting
> > a strange combination of the secmark label and the ipsec 
> label. It seems
> > strange to me that getpeercon() would care at all about the secmark
> > label, that's just for enforcement. I guess what I'm 
> getting to is why
> > is it so hard to just get the context of the domain on the 
> other side
> > (like the developer probably expects). Secmark and ipsec should be
> > entirely orthogonal it seems, maybe I haven't thought about 
> this hard
> > enough...
> 
> This discussion should be on the public list I think.
> 
> I agree about what getpeercon should return, even to the point of
> returning nothing or error if only secmark is being used.

And why should that be the case? Everything has a label on a MAC system
and why should apps care about the configuration (explicit IPSec label
Vs. implicit via secmark)?

> 
> In general, the packet label needs to represent only 1 thing 
> and here it
> is being overloaded to represent either the packet label or the remote
> domain. Note that the transition rules don't help - you still end up
> with the packet object controls referring to the incorrect type or
> getpeercon returning the wrong thing. There is simply no way 
> to satisfy
> both of these needs with 1 label.

You will want to deal with only 1 label at the app level, and it should be
the label that was used in determining whether the socket could read
the skb or not.

Can you give any examples on where differentiation is needed?

> 
> More fundamental I think is that the ipsec labeling in the 
> current form
> is useful only for selinux aware applications, which I think 
> is a major
> shortcoming. I want the policy on the remote machine (and perhaps
> trusted apps) to be able to label the _packet_ in addition to passing
> the domain for the sending process. A single domain should be able to
> send multiple packet labels (e.g., a bind process might want to send
> dns_packet_t and zone_transfer_packet_t or a multi-level trusted app).
> Passing both the packet context and the domain context allows 
> the local
> machine to make decisions based on the packet type, the 
> domain type, and
> the combination (e.g., do I trust the remote domain to send 
> the packet).

Isn't this trust enforceable in the network layout, perhaps in conjunction
with IPSec? If you aren't trusting one label from the other machine, why
would you trust 2?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
