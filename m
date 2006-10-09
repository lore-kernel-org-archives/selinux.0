Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99E3G6G017781
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 10:03:16 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99E2bjU026782
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 14:02:38 GMT
Subject: RE: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD1E@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015CFD1E@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 10:03:15 -0400
Message-Id: <1160402595.16814.22.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 17:17 -0400, Venkat Yekkirala wrote: 
> Venkat Yekkirala wrote:
> > Venkat Yekkirala wrote:
> > > Joshua Brindle wrote:
> > > > I grabbed Erics new kernel builds and installed them and got some
> > > > interesting denials. I started with no secmark rules 
> > > whatsoever on the
> > > > machine.
> > > > 
> > > 
> > > Taking a fresh look again...
> > > 
> > > 1. What policy (with what patches) were you using when you 
> > > saw these errors?
> > > 
> > > 2. What is the avahi daemon doing in the below? The reason I 
> > > ask is that
> > >    if the packet originated on the local machine itself and 
> > > some how flowed back in,
> > >    we would obviously see the avahi_t context as the target 
> > > since that's what the
> > >    packet was carrying.
> > > 
> > 
> > Seeing that avahi is sending to a multicast address, it seems like
> > it's receiving a copy of the message, THAT HAS THE avahi_t originating
> > domain still tied to it. I am going to send a patch out shortly that
> > will nullout this tie-up to the originating domain in postroute_last.
> > This *should* take care of denials 2 &3 below. They will still appear,
> > but with network_t (or unlabeled_t in Joshua's case since he seems to
> > have his netmsg initsid context set to unlabeled_t:s0 as also 
> > the unlabeled
> > initsid) in the target.
> BTW, Joshua probably knows that the machine needs to be rebooted for
> any initsid changes to take effect.

I knew it, whether I did it or not is a whole nother story :)

Anyway, after installing the labeled-networking branch from 
svn co
http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029

and rebooting onto erics kernel:
http://people.redhat.com/eparis/RHEL5_labeled_networking/kernel-PAE-2.6.18-1.2717.2.1.el5.lspp.51.i686.rpm

I'm still getting some strange denials. I know some of these are
probably from the patches you've put that that eric hasn't picked up,
I'll try to filter those out. 

audit(1160324043.201:242): avc:  denied  { flow_out } for  pid=1822 comm="yum-updatesd" scontext=system_u:object_r:client_packet_t:s0 tcontext=system_u:object_r:http_client_packet_t:s0 tclass=packet

I don't even know what these mean at all. What is the source? What is
the target? The secmark rules that will give these types are: 
-A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
-A selinux_new_output -p tcp --dport 443 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
-A selinux_new_output -p tcp --dport 488 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
-A selinux_new_output -p tcp --dport 8008 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
-A selinux_new_output -p tcp --dport 8009 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
-A selinux_new_output -p tcp --dport 8443 -j SECMARK --selctx system_u:object_r:http_client_packet_t:s0
and
-A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t:s0
(which is the first rule incase no others match)

So I guess maybe this is getting the target from the outgoing port
(which is probably 80) and then the source from the local port (which
hit the fallback). This doesn't sound like the access checks we wanted
at all. 

on the bright side I did manage to see some that looked semi-valid (only
with ping between 2 selinux machines though) 
audit(1160317777.866:171): avc:  denied  { flow_out } for  saddr=10.1.13.105 daddr=10.1.13.30 netif=eth0 scontext=system_u:object_r:server_packet_t:s0 tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet

(PeBenito changed the netmsg initial sid to no_extlabel_t, he didn't like network_t I guess).

I added these rules 
auditallow { packet_type domain } { unlabeled_t no_extlabel_t domain packet_type } : association *;
auditallow { packet_type domain } { unlabeled_t no_extlabel_t domain packet_type } : packet *;

but am not seeing polmatches and other permissions that I expect. For
example, the first denials in this email had no accompanying polmatch
denials (even after switching to enforcing and allowing the packet
flow_out)

ah! after a few reloads I just got 
audit(1160329607.081:254): avc:  denied  { flow_out } for  pid=2517 comm="yum" saddr=10.1.13.105 src=51656 daddr=152.3.220.166 dest=80 netif=eth0 scontext=system_u:object_r:http_client_packet_t:s0 tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet
audit(1160329610.061:255): avc:  denied  { flow_out } for  saddr=10.1.13.105 src=51656 daddr=152.3.220.166 dest=80 netif=eth0 scontext=system_u:object_r:http_client_packet_t:s0 tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet

audit(1160330449.365:370): avc:  granted  { flow_out } for  pid=2453 comm="sshd" saddr=10.1.13.105 src=22 daddr=10.1.13.126 dest=58972 netif=eth0 scontext=system_u:object_r:ssh_server_packet_t:s0 tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet

which looks alot closer to what I expected (not sure why it didn't show
up the first several times I tried it). Still no polmatch rules though.

I also got this one
audit(1160330449.365:369): avc:  granted  { flow_out } for  pid=2453 comm="sshd" scontext=system_u:system_r:unconfined_t:s0 tcontext=system_u:object_r:ssh_server_packet_t:s0 tclass=packet

So that is the same weirdness, how can the exact same object class/perm
be used for a domain -> secmark check _and_ for a secmark -> association
check.. this is very confusing


(that was all with no ipsec)

After loading up some spd rules (all spd's labeled ipsec_spd_t)

audit(1160329985.116:279): avc:  denied  { polmatch } for  pid=2607 scontext=root:system_r:semanage_t:s0-s0:c0.c1023 tcontext=system_u:object_r:ipsec_spd_t:s0 tclass=association

there is our expected polmatch denial

audit(1160329985.124:281): avc:  denied  { flow_out } for  pid=2607 scontext=system_u:object_r:client_packet_t:s0 tcontext=system_u:object_r:client_packet_t:s0 tclass=packet

not sure here, was this an attempt to go out the unlabeled association once the other was denied?

and here are some more when racoon tries to run (after I allow the above polmatch)
audit(1160330873.428:1629): avc:  granted  { flow_out } for  pid=2785 comm="racoon" scontext=root:system_r:unconfined_t:s0-s0:c0.c1023 tcontext=system_u:object_r:client_packet_t:s0 tclass=packet
audit(1160330873.428:1631): avc:  granted  { flow_out } for  pid=2785 comm="racoon" saddr=10.1.13.105 src=500 daddr=10.1.13.30 dest=500 netif=eth0 scontext=system_u:object_r:isakmp_client_packet_t:s0 tcontext=system_u:object_r:no_extlabel_t:s0 tclass=packet

these are basically the same as the others where the objclass/perm were
the same for different checks except there is another that I'm not sure
about: 
audit(1160330873.428:1630): avc:  granted  { flow_out } for  pid=2785 comm="racoon" scontext=system_u:object_r:client_packet_t:s0 tcontext=system_u:object_r:isakmp_client_packet_t:s0 tclass=packet

so we finally have the client trying to talk to the server racoon, on the server side I get something interesting:

audit(1160331421.382:49): avc:  denied  { flow_in } for  scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:object_r:isakmp_server_packet_t:s0 tclass=packet

And I'm not sure why, I have reboot for sure this time, and the policy
says the initial sid is no_extlabel_t: 
sid 11 -> scontext system_u:object_r:no_extlabel_t:s0

So I don't know where the unlabeled there is coming from. Once I allow
it I get a similar one on the client side: 
audit(1160332410.064:1700): avc:  denied  { flow_in } for  scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:object_r:isakmp_client_packet_t:s0 tclass=packet


switching to semanage_t on the client side

Now I get this from racoon on the server:
racoon:  denied  { 0x8 } for  scontext=root:system_r:semanage_t:s0-s0:c0.c1023 tcontext=system_u:object_r:ipsec_spd_t:s0:c0.c1023 tclass=association

not sure what it is so i'll add semanage_t ipsec_spd_t:association * ;)

Ok, so after all this I get:
Received: Hello, root:system_r:semanage_t:s0-s0:c0.c1023 from root:system_r:semanage_t:s0-s0:c0.c1023

So getpeercon() on both sides is returning
root:system_r:semanage_t:s0-s0:c0.c1023 even though the server is
running as root:system_r:unconfined_t:s0-s0:c0.c1023 which still isn't
correct I don't think.


In addition to the kernel and policy above here are the modules, and the
client/server source:

http://securityblog.org/~method/labeled_networking/server.c
http://securityblog.org/~method/labeled_networking/client.c
http://securityblog.org/~method/labeled_networking/client_packet.te
http://securityblog.org/~method/labeled_networking/server_packet.te




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
