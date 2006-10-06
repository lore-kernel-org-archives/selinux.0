Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96J2FKP004921
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:02:15 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96J11QW012225
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 19:01:02 GMT
Message-ID: <4526A836.4000302@hp.com>
Date: Fri, 06 Oct 2006 15:02:14 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Denials from newest kernel
References: <1160141519.16462.33.camel@twoface.columbia.tresys.com>
In-Reply-To: <1160141519.16462.33.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> I grabbed Erics new kernel builds and installed them and got some
> interesting denials. I started with no secmark rules whatsoever on the
> machine.

Okay, some more data for everybody to chew on.  For my tests I used the lspp.51
kernel as well as the kernel and MLS policy generated from the source RPMs
posted here:

 * http://free.linux.hp.com/~pmoore/files

The only differences between these source RPMs are the original is the removal
of the NetLabel/secid patch in the kernel and the addition of
"network_t:s0-s15:c0.c255" to the netmsg initial SID.

The summary is that I see no difference between the kernel with the
NetLabel/secid patch and the one without.

 * flow_out permission

Joshua reported:

> avc:  denied  { flow_out } for  pid=1815 comm="avahi-daemon"
> saddr=10.1.13.105 daddr=224.0.0.22 netif=eth0
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=packet

With the lspp.51 kernel I see:

type=AVC msg=audit(1160160485.587:61): avc:  denied  { flow_out } for  pid=2297
comm="avahi-daemon" saddr=10.0.0.255 src=5353 daddr=224.0.0.251 dest=5353
netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet

With the lspp.51 kernel w/o NetLabel/secid I see:

type=AVC msg=audit(1160160670.049:61): avc:  denied  { flow_out } for  pid=2289
comm="avahi-daemon" saddr=10.0.0.255 src=5353 daddr=224.0.0.251 dest=5353
netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet

* flow_in permission

Joshua reported:

> avc:  denied  { flow_in } for  pid=1815 comm="avahi-daemon" 
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:system_r:avahi_t:s0 tclass=packet

With the lspp.51 kernel I see:

type=AVC msg=audit(1160160485.587:61): avc:  denied  { flow_in } for  pid=2297
comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet

With the lspp.51 kernel w/o NetLabel/secid I see:

type=AVC msg=audit(1160160670.049:61): avc:  denied  { flow_in } for  pid=2289
comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
tcontext=system_u:object_r:network_t:s0-s15:c0.c255 tclass=packet

 * recv permission

Joshua reported:

> avc:  denied  { recv } for  pid=1815 comm="avahi-daemon"
> src=5353 dest=5353 netif=eth0
> scontext=system_u:system_r:avahi_t:s0
> tcontext=system_u:system_r:avahi_t:s0 tclass=packet

I still get nothing as reported before.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
