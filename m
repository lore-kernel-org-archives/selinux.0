Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBIKbXow018030
 for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2013 15:37:35 -0500
References: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
 <4723476.XQtkhknjQL@sifl>
Message-ID: <1387399050.90718.YahooMailNeo@web163405.mail.gq1.yahoo.com>
Date: Wed, 18 Dec 2013 12:37:30 -0800 (PST)
From: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: selinux control for network interface using SOCK_RAW
To: Paul Moore <pmoore@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <4723476.XQtkhknjQL@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






> On Wednesday, December 18, 2013 1:21 PM, Paul Moore <pmoore@redhat.com> wrote:
> > On Wednesday, December 18, 2013 07:49:19 AM Andy Ruch wrote:
> 
>>  Hello,
>> 
>>  I'm trying to restrict an application to only have access to some 
> network
>>  interfaces. I'm running a custom policy on a RHEL 6.3 system. The
>>  application is opening the socket as AF_PACKET and SOCK_RAW. However,
>>  selinux doesn't seem to be controlling any raw access to the 
> interfaces.
> 
> SELinux does not provide any per-packet access controls for AF_PACKET sockets.  
> The basic problem is that AF_PACKET traffic is an opaque blob as far as the 
> kernel is concerned.  The application may carefully craft well formed IP 
> packets, but the kernel doesn't do any inspection/parsing of the data sent 
> down via a AF_PACKET socket, it is just a blob to passed off to the network 
> device.
> 
> I suppose we could do something with the netif:egress access control for 
> packet sockets, but that would require a new LSM hook and some SELinux glue as 
> AF_PACKET traffic isn't subject to the netfilter hooks SELinux currently 
> uses 
> (if I recall correctly).
> 
> -- 
> paul moore
> security and virtualization @ redhat
>


I'm not looking for any per-packet control. I was just hoping to restrict my application's use of the packet socket to a single interface, i.e. prevent access an out-of-band management network. The netif ingress/egress permissions are what I would have expected but I say that without knowing anything about how those are implemented.
