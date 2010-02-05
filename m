Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o15KlQDG014458
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 15:47:30 -0500
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o15KlKkT014793
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 20:47:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Subject: Re: MLS and network
Date: Fri, 5 Feb 2010 15:47:27 -0500
Cc: selinux@tycho.nsa.gov
References: <20100204174901.GL1750@myhost.felk.cvut.cz> <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil> <20100205192806.GP1750@myhost.felk.cvut.cz>
In-Reply-To: <20100205192806.GP1750@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002051547.27944.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 February 2010 02:28:07 pm Michal Svoboda wrote:
> Stephen Smalley wrote:
> > tcp_socket write, read, and connect are checks between the process
> > security context and the (local) socket security context.
> > name_connect is between the process' context and the port context.
> > None of those are per-packet checks.
> 
> OK, just to be sure I understand: the local socket's context is copied
> from its owning process?

Yes, unless you change it via setsockcreate(); see the libselinux API 
documentation for more information.

> > At the risk of flooding your audit log, you might add the following
> > policy module to see all grantings of egress permission:
> 
> No problem, it's a VM, we can do anything.

...

> type=AVC msg=audit(1265396951.168:47): avc:  granted  { egress } for
> pid=1088 comm="ftp" saddr=10.0.2.15 src=53060 daddr=147.32.127.222
> dest=21 netif=eth0 scontext=user_u:user_r:user_t:s1
> tcontext=system_u:object_r:netif_t:s0-s15:c0.c1023 tclass=netif

Here you have a process, labeled "...:user_t:s1", sending traffic via a 
network interface which is labeled "...:netif_t:s0-s15:c0.c1023".  Looking 
at the mlsconstrain rule, which is specified as:

	mlsconstrain { netif } { egress }
	        ((( l1 dom l2 ) and ( l1 domby h2 )) or
	         ( t1 == mlsnetoutbound ));

... it would appear that any traffic with a label "between" (not really a 
BLP term, but I think you get the idea) the effective/low and cleared/high 
labels of the network interface is allowed.  So, this appears to be working 
correctly.

> type=AVC msg=audit(1265396951.171:48): avc:  denied  { ingress } for
> saddr=147.32.127.222 src=21 daddr=10.0.2.15 dest=53060 netif=eth0
> scontext=system_u:object_r:netlabel_peer_t:s0
> tcontext=system_u:object_r:netif_t:s0-s15:c0.c1023 tclass=netif

Not 100% sure about this, but I'm fairly certain this is SELinux type 
enforcement issue.  Have you tried adding some policy like the following:

	allow netlabel_peer_t netif_t:netif { ingress };

> I'm kinda puzzled as of what's going on. For the egress operation the
> user process is writing to the interface, but that has s0-s15. So maybe
> I need to semanage the interface?

I assume you want the "...:user_t:s1" traffic denied from leaving via the 
"...:netif_t:s0-s15:c0.c1023" interface?  Well you could always relabel the 
interface to operate at a single level.  The blog post below has some 
information on how to use semanage to manipulate the label assigned to 
network interfaces, note that unless explicitly specified the network 
interfaces will be labeled as you have seen ("...:netif_t:s0-s15:c0.c1023"):

 * http://paulmoore.livejournal.com/5536.html

> But why is the default so wide ...

Somebody decided to make it that way and no one has really complained.

> ... how can I semanage all interfaces?  I can't see a _default_ one...

The default setting is part of the SELinux policy using an "initial SID" and 
isn't something you probably want to modify.  I would recommend using 
semanage to set the interfaces individually.

> When I do it, I get a denied egress, but only as long as I have the
> netlabelctl in place. Why isn't labeling the interface sufficient? The
> netlabel type is not mentioned in the egress message at all...

Dynamic permission checks.  If you don't have any type of labeled networking 
configuration present the permission checks are disabled inside the kernel.  
It may seem odd right now, but trust me, this is a very good thing.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
