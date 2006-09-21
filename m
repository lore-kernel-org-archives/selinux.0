Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LEo52L013887
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:50:05 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LEnYRL011964
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:49:35 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k8LEo3Uq000272
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:50:03 -0400 (EDT)
Message-ID: <36282A1733C57546BE392885C0618592015732DC@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: FW: Labeled networking packets
Date: Thu, 21 Sep 2006 10:49:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I see selinux wasn't on the cc list...

-----Original Message-----
From: Joshua Brindle [mailto:jbrindle@tresys.com]
Sent: Thursday, September 21, 2006 6:18 AM
To: Venkat Yekkirala; Paul Moore
Cc: Karl MacMillan; latten@austin.ibm.com; sds; jmorris@redhat.com;
dwalsh@redhat.com; Darrel Goeddel; Chad Hanson
Subject: RE: Labeled networking packets


> From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> 
> > We really need this in if we expect useful network labeling 
> in rhel5 
> > but I'm still skeptical about reconciling cipso + ipsec 
> together with 
> > secmark.
> > From what I can tell cipso is taking priority and is 
> getting the type 
> > transition calculated and ipsec isn't.
> 
> It would actually be the other way around. A transition is 
> computed only in the labeled IPSec case. In the cipso case, 
> only a "flow in" check happens (this would obviously change 
> when whole SELinux contexts are transmitted using options, as 
> Paul is understood to be looking into, in the future).
> 

Eh, I knew that, sorry, I don't know what I was thinking..

> > I'm not sure
> > if this is
> > the desirable behavior.
> 
> Could you lay out an example; perhaps there's a 
> misunderstanding somewhere?
> 

In one of my first emails I pointed out that an app doing getpeercon()
is really expecting the context of the domain on the other side of a
connection (peer?). With unix domain sockets that would still happen
(unless they were relabeled) but with ipsec connections you are getting
a strange combination of the secmark label and the ipsec label. It seems
strange to me that getpeercon() would care at all about the secmark
label, that's just for enforcement. I guess what I'm getting to is why
is it so hard to just get the context of the domain on the other side
(like the developer probably expects). Secmark and ipsec should be
entirely orthogonal it seems, maybe I haven't thought about this hard
enough...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
