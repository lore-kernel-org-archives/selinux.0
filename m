Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AEgQqY017493
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 10:42:26 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AEfkTb002861
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:41:46 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592015CFDDA@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CFDDA@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 10:42:48 -0400
Message-Id: <1160491368.20774.70.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-10 at 10:18 -0400, Venkat Yekkirala wrote:
> > > It seems like the SECMARK target on the last rule 
> > > (client_packet_t) got executed BEFORE the port 80 one, 
> > > causing the packet (yum-updatesd_t?) to
> > > 
> > > 1. be flow-controlled first against client_packet_t 2. assume 
> > > the client_packet_t label overriding yum-updatesd_t 3. be 
> > > flow-controlled against http_client_packet_t 4. assume 
> > > http_client_packet_t 5. be flow-controlled against network_t
> > > 
> > > It seems like you saw 1,2 and 3 here and 4 & 5 later when you 
> > > mention you were finally seeing the expected denials.
> > > 
> > 
> > Yep, the client_packet_t one is first, Chris was under the impression
> > the last one would win and the others wouldn't matter so the fallback
> > was specified as the first rule in the chain. Look at the
> 
> I will have to just refer you to the following to get an idea
> as to what the developers had in mind :)
> http://marc.theaimsgroup.com/?l=selinux&m=115876013220221&w=2
> http://marc.theaimsgroup.com/?l=selinux&m=115876375201000&w=2

Thats what was intended, but that doesn't mean its the only solution.
Netfilter is supposed to be flexible and works in many different ways,
otherwise everyone would have similar firewalls.  The netfilter
configuration currently provided by refpolicy provides the anticipated
behavior on mainline kernels, the same as if it were done the way James
suggested.  What you're describing breaks the current behavior.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
