Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AE7Zoe016002
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 10:07:35 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AE6uTb027923
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:06:56 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD65@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CFD65@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 10:07:54 -0400
Message-Id: <1160489274.20774.56.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-09 at 19:40 -0400, Venkat Yekkirala wrote:
> > I'm still getting some strange denials. I know some of these are
> > probably from the patches you've put that that eric hasn't picked up,
> > I'll try to filter those out. 
> > 
> > audit(1160324043.201:242): avc:  denied  { flow_out } for  
> > pid=1822 comm="yum-updatesd" 
> > scontext=system_u:object_r:client_packet_t:s0 
> > tcontext=system_u:object_r:http_client_packet_t:s0 tclass=packet
> > 
> > I don't even know what these mean at all. What is the source? What is
> > the target? The secmark rules that will give these types are: 
> > -A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > -A selinux_new_output -p tcp --dport 443 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > -A selinux_new_output -p tcp --dport 488 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > -A selinux_new_output -p tcp --dport 8008 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > -A selinux_new_output -p tcp --dport 8009 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > -A selinux_new_output -p tcp --dport 8443 -j SECMARK --selctx 
> > system_u:object_r:http_client_packet_t:s0
> > and
> > -A selinux_new_output -j SECMARK --selctx 
> > system_u:object_r:client_packet_t:s0
> > (which is the first rule incase no others match)
> 
> It seems like the SECMARK target on the last rule (client_packet_t)
> got executed BEFORE the port 80 one, causing the packet (yum-updatesd_t?)
> to
> 
> 1. be flow-controlled first against client_packet_t
> 2. assume the client_packet_t label overriding yum-updatesd_t
> 3. be flow-controlled against http_client_packet_t
> 4. assume http_client_packet_t
> 5. be flow-controlled against network_t
> 
> It seems like you saw 1,2 and 3 here and 4 & 5 later when you
> mention you were finally seeing the expected denials.
> 
> > 
> > So I guess maybe this is getting the target from the outgoing port
> > (which is probably 80) and then the source from the local port (which
> 
> No, the "source" here is whatever domain the packet is carrying at the point
> it hits the secmark rule that specifies the target.

I don't think this is a desired behavior for a couple reasons.  First,
this means that every domain that has access to a specific packet, for
example, http_client_packet_t, but not to client_packet_t, will have to
dontaudit the client_packet_t access.  Thats a lot of dontauditing, and
also it will cover up legitimate denials on client_packet_t.  Second,
this will cause permissive to have a different behavior than enforcing.
This makes development in permissive more difficult, since you'll get
spurious denials that you wouldn't get in enforcing.

> > (PeBenito changed the netmsg initial sid to no_extlabel_t, he 
> > didn't like network_t I guess).
> 
> This is scary to my eyes at least. I had already laid out the
> intended usage of these controls in terms of peer "domains" as
> opposed to "packet types".

The refpolicy interfaces should be able to make this abstraction.
Network_t wasn't clear in my opinion, since you only needed that access
for non labeled networking.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
