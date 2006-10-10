Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AEJHQr016565
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 10:19:18 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AEHxib014412
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:18:00 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFDDA@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 10:18:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > It seems like the SECMARK target on the last rule 
> > (client_packet_t) got executed BEFORE the port 80 one, 
> > causing the packet (yum-updatesd_t?) to
> > 
> > 1. be flow-controlled first against client_packet_t 2. assume 
> > the client_packet_t label overriding yum-updatesd_t 3. be 
> > flow-controlled against http_client_packet_t 4. assume 
> > http_client_packet_t 5. be flow-controlled against network_t
> > 
> > It seems like you saw 1,2 and 3 here and 4 & 5 later when you 
> > mention you were finally seeing the expected denials.
> > 
> 
> Yep, the client_packet_t one is first, Chris was under the impression
> the last one would win and the others wouldn't matter so the fallback
> was specified as the first rule in the chain. Look at the

I will have to just refer you to the following to get an idea
as to what the developers had in mind :)
http://marc.theaimsgroup.com/?l=selinux&m=115876013220221&w=2
http://marc.theaimsgroup.com/?l=selinux&m=115876375201000&w=2

> netfilter_contexts file created when you build refpolicy and 
> insert all
> the modules (make load) 
> 
> That seems like a very strange way of doing access checks, I 
> guess I was
> also under the impression that the check would be done after 
> the mangle
> table was exited so that only the net result was tested.

We are currently unable to do that due to implementation
constraints. But you can to the most part avoid this situation
by heeding James' suggestions in the above, by jumping to
unique labeling chains that quickly end with a verdict.

Otherwise, you would have to have the more fine-grained security points
defined ahead of the less fine-grained. A very useful way to visualize
this is to think of smaller pipes protruding from bigger ones, with
network_t being the all-encompassing one.

> I'll 
> fix up my
> netfilter_contexts file and see how that affects the tests. Thanks.

I would really start looking at things in the realm of the peer domains
to make the best sense of the new controls.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
