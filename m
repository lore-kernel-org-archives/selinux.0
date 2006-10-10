Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9A0AGtq031841
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 20:10:16 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9A09aAK003048
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 00:09:36 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Denials from newest kernel
Date: Mon, 9 Oct 2006 20:10:05 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588444272@exchange.columbia.tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD65@chaos.tcs.tcs-sec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> 
> > Anyway, after installing the labeled-networking branch from svn co
> > 
> http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029
> > 
> > and rebooting onto erics kernel:
> > http://people.redhat.com/eparis/RHEL5_labeled_networking/kerne
> > l-PAE-2.6.18-1.2717.2.1.el5.lspp.51.i686.rpm
> > 
> > I'm still getting some strange denials. I know some of these are 
> > probably from the patches you've put that that eric hasn't 
> picked up, 
> > I'll try to filter those out.
> > 
> > audit(1160324043.201:242): avc:  denied  { flow_out } for
> > pid=1822 comm="yum-updatesd" 
> > scontext=system_u:object_r:client_packet_t:s0
> > tcontext=system_u:object_r:http_client_packet_t:s0 tclass=packet
> > 
> > I don't even know what these mean at all. What is the 
> source? What is 
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
> It seems like the SECMARK target on the last rule 
> (client_packet_t) got executed BEFORE the port 80 one, 
> causing the packet (yum-updatesd_t?) to
> 
> 1. be flow-controlled first against client_packet_t 2. assume 
> the client_packet_t label overriding yum-updatesd_t 3. be 
> flow-controlled against http_client_packet_t 4. assume 
> http_client_packet_t 5. be flow-controlled against network_t
> 
> It seems like you saw 1,2 and 3 here and 4 & 5 later when you 
> mention you were finally seeing the expected denials.
> 

Yep, the client_packet_t one is first, Chris was under the impression
the last one would win and the others wouldn't matter so the fallback
was specified as the first rule in the chain. Look at the
netfilter_contexts file created when you build refpolicy and insert all
the modules (make load) 

That seems like a very strange way of doing access checks, I guess I was
also under the impression that the check would be done after the mangle
table was exited so that only the net result was tested. I'll fix up my
netfilter_contexts file and see how that affects the tests. Thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
