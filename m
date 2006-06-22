Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5MDhtZ4014798
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 09:43:55 -0400
Received: from ccerelrim03.cce.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5MDhruc027528
	for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2006 13:43:54 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC 3/7] NetLabel: CIPSOv4 engine
Date: Thu, 22 Jun 2006 09:43:10 -0400
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        sds@epoch.ncsc.mil, jmorris@redhat.com, sgrubb@redhat.com
References: <20060621194234.979661000@flek.zko.hp.com> <20060621200031.589235000@flek.zko.hp.com> <20060622.021223.125894633.davem@davemloft.net>
In-Reply-To: <20060622.021223.125894633.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606220943.11185.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 June 2006 5:12 am, David Miller wrote:
> From: paul.moore@hp.com
> Date: Wed, 21 Jun 2006 15:42:38 -0400
>
> > Add support for the Commercial IP Security Option (CIPSO) to the
> > IPv4 network stack.  CIPSO has become a de-facto standard for
> > trusted/labeled networking amongst existing Trusted Operating
> > Systems such as Trusted Solaris, HP-UX CMW, etc.  This
> > implementation is designed to be used with the NetLabel subsystem to
> > provide explicit packet labeling to LSM developers.
>
> The thing that concerns me most about CIPSO is that even once users
> migrate to a more SELINUX native approach from this CIPSO stuff, the
> CIPSO code, it's bloat, and it's maintainence burdon will remain.
>
> It's easy to put stuff it, it's impossible to take stuff out even
> once it's largely unused by even it's original target audience.
>
> And that's what I see happening here.
>
> This is why, to be perfectly honest with you, I'd much rather
> something like this stay out-of-tree and people are strongly
> encouraged to use the more native stuff under Linux.

Well, not exactly the response I was hoping for, but let me plead my case one 
more time :)

Traditional MLS CIPSO is a niche "protocol", I won't try to argue that point, 
and I also won't try to argue that the NetLabel patch is late to the party, 
the IPsec/XFRM labeling approach has already been accepted as "the" SELinux 
packet labeling mechanism.  However, the XFRM labeling mechanism in not 
currently supported by any OS other than Linux/SELinux.  I have spoken with 
users that need CIPSO to interoperate with their other trusted systems, the 
XFRM approach is simply not a viable solution for them.  I strongly believe 
that failure to support an interoperable packet labeling mechanism on Linux 
will seriously restrict Linux's deployment in trusted networks.

It's all about compatibility and enabling Linux to be used in places it can't 
be used now.  True, other OS vendors might support the SELinux/IPsec packet 
labeling approach, but I see very little in the way of motivation for them to 
do the work.

If it makes you feel any better I do intend to support the Selopt approach (or 
at least something very similar) for CIPSO as envisioned by James Morris for 
the SELinux networking hooks of long ago.  This will allow CIPSO to carry the 
full SELinux context making it a more "SELINUX native approach" than 
traditional MLS CIPSO.  I just wanted to keep this initial patch set as small 
as possible (you can see how well that worked out) ... :)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
