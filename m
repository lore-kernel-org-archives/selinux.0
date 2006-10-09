Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99NfVUU031353
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 19:41:31 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99NeDtS021651
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 23:40:15 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFD65@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Mon, 9 Oct 2006 19:40:51 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Anyway, after installing the labeled-networking branch from 
> svn co
> http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029
> 
> and rebooting onto erics kernel:
> http://people.redhat.com/eparis/RHEL5_labeled_networking/kerne
> l-PAE-2.6.18-1.2717.2.1.el5.lspp.51.i686.rpm
> 
> I'm still getting some strange denials. I know some of these are
> probably from the patches you've put that that eric hasn't picked up,
> I'll try to filter those out. 
> 
> audit(1160324043.201:242): avc:  denied  { flow_out } for  
> pid=1822 comm="yum-updatesd" 
> scontext=system_u:object_r:client_packet_t:s0 
> tcontext=system_u:object_r:http_client_packet_t:s0 tclass=packet
> 
> I don't even know what these mean at all. What is the source? What is
> the target? The secmark rules that will give these types are: 
> -A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> -A selinux_new_output -p tcp --dport 443 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> -A selinux_new_output -p tcp --dport 488 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> -A selinux_new_output -p tcp --dport 8008 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> -A selinux_new_output -p tcp --dport 8009 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> -A selinux_new_output -p tcp --dport 8443 -j SECMARK --selctx 
> system_u:object_r:http_client_packet_t:s0
> and
> -A selinux_new_output -j SECMARK --selctx 
> system_u:object_r:client_packet_t:s0
> (which is the first rule incase no others match)

It seems like the SECMARK target on the last rule (client_packet_t)
got executed BEFORE the port 80 one, causing the packet (yum-updatesd_t?)
to

1. be flow-controlled first against client_packet_t
2. assume the client_packet_t label overriding yum-updatesd_t
3. be flow-controlled against http_client_packet_t
4. assume http_client_packet_t
5. be flow-controlled against network_t

It seems like you saw 1,2 and 3 here and 4 & 5 later when you
mention you were finally seeing the expected denials.

> 
> So I guess maybe this is getting the target from the outgoing port
> (which is probably 80) and then the source from the local port (which

No, the "source" here is whatever domain the packet is carrying at the point
it hits the secmark rule that specifies the target.

> hit the fallback). This doesn't sound like the access checks we wanted
> at all. 
> 
> on the bright side I did manage to see some that looked 
> semi-valid (only
> with ping between 2 selinux machines though) 
> audit(1160317777.866:171): avc:  denied  { flow_out } for  
> saddr=10.1.13.105 daddr=10.1.13.30 netif=eth0 
> scontext=system_u:object_r:server_packet_t:s0 
> tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet
>

I will have to look at the policy (BTW what file has these secmark
rules?), but the thing to look to see is if the documented behavior
matches up with the actual as driven by policy. IOW, should the
packet have been carrying "server_packet_t" when it hit this check?
(The document I posted this morning for policy writers is hopefully
explanatory enough).

> (PeBenito changed the netmsg initial sid to no_extlabel_t, he 
> didn't like network_t I guess).

This is scary to my eyes at least. I had already laid out the
intended usage of these controls in terms of peer "domains" as
opposed to "packet types".

> 
> I added these rules 
> auditallow { packet_type domain } { unlabeled_t no_extlabel_t 
> domain packet_type } : association *;
> auditallow { packet_type domain } { unlabeled_t no_extlabel_t 
> domain packet_type } : packet *;
> 
> but am not seeing polmatches and other permissions that I expect. For
> example, the first denials in this email had no accompanying polmatch
> denials (even after switching to enforcing and allowing the packet
> flow_out)

No polmatch denials show up unless you have spd rules that specify
explicit contexts.

> 
> ah! after a few reloads I just got 
> audit(1160329607.081:254): avc:  denied  { flow_out } for  
> pid=2517 comm="yum" saddr=10.1.13.105 src=51656 
> daddr=152.3.220.166 dest=80 netif=eth0 
> scontext=system_u:object_r:http_client_packet_t:s0 
> tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet
> audit(1160329610.061:255): avc:  denied  { flow_out } for  
> saddr=10.1.13.105 src=51656 daddr=152.3.220.166 dest=80 
> netif=eth0 scontext=system_u:object_r:http_client_packet_t:s0 
> tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet
> 
> audit(1160330449.365:370): avc:  granted  { flow_out } for  
> pid=2453 comm="sshd" saddr=10.1.13.105 src=22 
> daddr=10.1.13.126 dest=58972 netif=eth0 
> scontext=system_u:object_r:ssh_server_packet_t:s0 
> tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet
> 
> which looks alot closer to what I expected (not sure why it 
> didn't show

See items 4&5 toward the top.

> up the first several times I tried it). Still no polmatch 
> rules though.

No spd rules with explicit contexts, no polmatch denials.

> 
> I also got this one
> audit(1160330449.365:369): avc:  granted  { flow_out } for  
> pid=2453 comm="sshd" 
> scontext=system_u:system_r:unconfined_t:s0 
> tcontext=system_u:object_r:ssh_server_packet_t:s0 tclass=packet
> 
> So that is the same weirdness, how can the exact same object 
> class/perm
> be used for a domain -> secmark check _and_ for a secmark -> 
> association

No "association" exists in the sense of IPSec SAs. Did you mean
network_t here?

> check.. this is very confusing

Indeed. The way to avoid the confusion is to define peer domains
using secmark, with network_t or such representing the network domain.

> 
> 
> (that was all with no ipsec)
> 
> After loading up some spd rules (all spd's labeled ipsec_spd_t)
> 
> audit(1160329985.116:279): avc:  denied  { polmatch } for  
> pid=2607 scontext=root:system_r:semanage_t:s0-s0:c0.c1023 
> tcontext=system_u:object_r:ipsec_spd_t:s0 tclass=association
> 
> there is our expected polmatch denial
> 
> audit(1160329985.124:281): avc:  denied  { flow_out } for  
> pid=2607 scontext=system_u:object_r:client_packet_t:s0 
> tcontext=system_u:object_r:client_packet_t:s0 tclass=packet
> 
> not sure here, was this an attempt to go out the unlabeled 
> association once the other was denied?

Seems like the secmark rule(s) with client_packet_t defined
as the context are being hit in succession. Most likely a
policy issue.

> 
> and here are some more when racoon tries to run (after I 
> allow the above polmatch)
> audit(1160330873.428:1629): avc:  granted  { flow_out } for  
> pid=2785 comm="racoon" 
> scontext=root:system_r:unconfined_t:s0-s0:c0.c1023 
> tcontext=system_u:object_r:client_packet_t:s0 tclass=packet
> audit(1160330873.428:1631): avc:  granted  { flow_out } for  
> pid=2785 comm="racoon" saddr=10.1.13.105 src=500 
> daddr=10.1.13.30 dest=500 netif=eth0 
> scontext=system_u:object_r:isakmp_client_packet_t:s0 
> tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet

The latter seems like what one would expect to see per the policy
you are using.

Please see if the doc I posted today helps explain things.

I will try to use test using your policy and such tomorrow.

Thanks.

<snip>
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
