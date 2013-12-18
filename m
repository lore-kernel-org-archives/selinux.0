Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBILFGDL020609
 for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2013 16:15:16 -0500
From: Paul Moore <pmoore@redhat.com>
To: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: selinux control for network interface using SOCK_RAW
Date: Wed, 18 Dec 2013 16:14:47 -0500
Message-ID: <1762865.mJVkh9reke@sifl>
In-Reply-To: <1387399050.90718.YahooMailNeo@web163405.mail.gq1.yahoo.com>
References: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
 <4723476.XQtkhknjQL@sifl>
 <1387399050.90718.YahooMailNeo@web163405.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, December 18, 2013 12:37:30 PM Andy Ruch wrote:
> > On Wednesday, December 18, 2013 1:21 PM, Paul Moore <pmoore@redhat.com> 
wrote:
> > > On Wednesday, December 18, 2013 07:49:19 AM Andy Ruch wrote:
> >>  Hello,
> >>  
> >>  I'm trying to restrict an application to only have access to some
> >>  network interfaces. I'm running a custom policy on a RHEL 6.3 system.
> >>  The application is opening the socket as AF_PACKET and SOCK_RAW.
> >>  However, selinux doesn't seem to be controlling any raw access to the
> >>  interfaces.
> > 
> > SELinux does not provide any per-packet access controls for AF_PACKET
> > sockets.  The basic problem is that AF_PACKET traffic is an opaque blob
> > as far as the kernel is concerned.  The application may carefully craft
> > well formed IP packets, but the kernel doesn't do any inspection/parsing
> > of the data sent down via a AF_PACKET socket, it is just a blob to passed
> > off to the network device.
> > 
> > I suppose we could do something with the netif:egress access control for
> > packet sockets, but that would require a new LSM hook and some SELinux
> > glue as AF_PACKET traffic isn't subject to the netfilter hooks SELinux
> > currently uses (if I recall correctly).
> 
> I'm not looking for any per-packet control. I was just hoping to restrict my
> application's use of the packet socket to a single interface, i.e. prevent
> access an out-of-band management network. The netif ingress/egress
> permissions are what I would have expected but I say that without knowing
> anything about how those are implemented.

Unfortunately, it is per-packet access control and currently we only provide 
per-packet access control for IP based sockets.

-- 
paul moore
security and virtualization @ redhat
