Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LEocGa013932
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:50:38 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LEnbSR019853
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:49:39 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k8LEoYHd009650
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 10:50:34 -0400 (EDT)
Message-ID: <36282A1733C57546BE392885C0618592015732DD@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: FW: Labeled networking packets
Date: Thu, 21 Sep 2006 10:50:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI-

-----Original Message-----
From: Venkat Yekkirala 
Sent: Thursday, September 21, 2006 9:46 AM
To: 'Joshua Brindle'; Venkat Yekkirala; Paul Moore
Cc: Karl MacMillan; latten@austin.ibm.com; sds; jmorris@redhat.com;
dwalsh@redhat.com; Darrel Goeddel; Chad Hanson
Subject: RE: Labeled networking packets


> In one of my first emails I pointed out that an app doing getpeercon()
> is really expecting the context of the domain on the other side of a
> connection (peer?). With unix domain sockets that would still happen
> (unless they were relabeled) but with ipsec connections you 
> are getting
> a strange combination of the secmark label and the ipsec 
> label.

The peercon would by default (i.e. no applicable transition rules)
be the ipsec label, when a labeled-ipsec SA is used. So no extra
rules are needed to get this context. But let's say you want to
service the connection request at the label of the secmark or
a "common label" that's applicable to several incoming labels, then
you could have some fancy transition rules.

> It seems
> strange to me that getpeercon() would care at all about the secmark
> label, that's just for enforcement.

Not quite. It ought to be left to policy entirely to determine what
the label of the connection request is. Let's take the following
example where sshd needs to process a connection at the label of
the peer. Now the "peer" could be configured (on the server) in
one of the following ways:

a. a labeled-ipsec client; i.e. we have a sort of a trusted client
   that is able to "convey" the appropriate label of the connection
   request by using "labeled" IPSec SAs, one for Secret, another
   for Top Secret for example.

b. a non-(labeled)ipsec client: i.e. you have to treat/service the client
   at "a" level (most likely at a single level no matter what the
   type of the connection is), Secret for example, on the server.
   This you would do by using an iptables rule in conjunction with
  (CONN)SECMARK. This would be analogous to taking the label from
   a nodecon rule in the compat case (which we didn't get around to doing).

> I guess what I'm getting to is why
> is it so hard to just get the context of the domain on the other side
> (like the developer probably expects).

Not hard at all. The IPSec label is returned by default. No extra rules
needed as explained above.

> Secmark and ipsec should be
> entirely orthogonal it seems, maybe I haven't thought about this hard
> enough...

There's actually a relationship. You could do the following now:

1. Specify a range (Unclassified - Secret) for a network "entry/exit point"
   using iptables rules.

2. Any externally labeled data (labeled-ipsec/cipso) would then be subject
to the
   entry/exit point range.

3. You could further have "ranged" IPSec SAs (Confidential - Secret or
Secret - Secret with
   all the compartments applicable for Secret) that could
   constrain the cipso labeled data to be within that range.

I think the problem is that secmark is still being looked at as a marking
scheme when, in the new paradigm, it's a flow control mechanism with a
"side-effect" of externally unlabeled data being labeled with the label
of the data BUT ONLY BY VIRTUE OF THE DATA COMING IN THRU THAT ENTRY POINT.

I am almost tempted to rename the secmark module to SECPOINT or SECGATE
if that will help convey the above.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
