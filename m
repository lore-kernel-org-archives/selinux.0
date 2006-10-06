Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96JhW24006569
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:43:32 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96Jgtru002217
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 19:42:55 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFCE4@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 15:43:14 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Joshua Brindle wrote:
> > I grabbed Erics new kernel builds and installed them and got some
> > interesting denials. I started with no secmark rules 
> whatsoever on the
> > machine.
> 
> Okay, some more data for everybody to chew on.  For my tests 
> I used the lspp.51
> kernel as well as the kernel and MLS policy generated from 
> the source RPMs
> posted here:
> 
>  * http://free.linux.hp.com/~pmoore/files
> 
> The only differences between these source RPMs are the 
> original is the removal
> of the NetLabel/secid patch in the kernel and the addition of
> "network_t:s0-s15:c0.c255" to the netmsg initial SID.
> 
> The summary is that I see no difference between the kernel with the
> NetLabel/secid patch and the one without.
> 
>  * flow_out permission
> 
> Joshua reported:
> 
> > avc:  denied  { flow_out } for  pid=1815 comm="avahi-daemon"
> > saddr=10.1.13.105 daddr=224.0.0.22 netif=eth0
> > scontext=system_u:object_r:unlabeled_t:s0
> > tcontext=system_u:object_r:unlabeled_t:s0 tclass=packet
> 
> With the lspp.51 kernel I see:
> 
> type=AVC msg=audit(1160160485.587:61): avc:  denied  { 
> flow_out } for  pid=2297
> comm="avahi-daemon" saddr=10.0.0.255 src=5353 
> daddr=224.0.0.251 dest=5353
> netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
> tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet
> 
> With the lspp.51 kernel w/o NetLabel/secid I see:
> 
> type=AVC msg=audit(1160160670.049:61): avc:  denied  { 
> flow_out } for  pid=2289
> comm="avahi-daemon" saddr=10.0.0.255 src=5353 
> daddr=224.0.0.251 dest=5353
> netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
> tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet
> 
> * flow_in permission
> 
> Joshua reported:
> 
> > avc:  denied  { flow_in } for  pid=1815 comm="avahi-daemon" 
> > scontext=system_u:object_r:unlabeled_t:s0
> > tcontext=system_u:system_r:avahi_t:s0 tclass=packet

I see you aren't seeing what Joshua reported.

Joshua, what policy version are you using and what patches
have been applied to it? Are you still seeing the above flow_in
with the target saying "avahi_t"?

> 
> With the lspp.51 kernel I see:
> 
> type=AVC msg=audit(1160160485.587:61): avc:  denied  { 
> flow_in } for  pid=2297
> comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
> tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet
> 
> With the lspp.51 kernel w/o NetLabel/secid I see:
> 
> type=AVC msg=audit(1160160670.049:61): avc:  denied  { 
> flow_in } for  pid=2289
> comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
> tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet
> 
>  * recv permission
> 
> Joshua reported:
> 
> > avc:  denied  { recv } for  pid=1815 comm="avahi-daemon"
> > src=5353 dest=5353 netif=eth0
> > scontext=system_u:system_r:avahi_t:s0
> > tcontext=system_u:system_r:avahi_t:s0 tclass=packet
> 
> I still get nothing as reported before.
> 
> -- 
> paul moore
> linux security @ hp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
