Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA16363
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 20:39:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA14802
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 00:38:22 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
        by jazzband.ncsc.mil  with ESMTP id AAA14798 for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 00:38:19 GMT
Date: Fri, 24 May 2002 10:39:21 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Is this a module bug?
In-Reply-To: <20020522072017.AF7376E90@lyta.coker.com.au>
Message-ID: <Mutt.LNX.4.44.0205241026400.25187-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 May 2002, Russell Coker wrote:

> May 22 08:42:57 lyta kernel: IPv6 v0.8 for NET4.0
> May 22 08:42:57 lyta kernel:
> May 22 08:42:57 lyta kernel: avc:  denied  { net_raw } for  pid=71 
> exe=/sbin/insmod capability=13 scontext=system_u:system_r:insmod_t 
> tcontext=system_u:system_r:insmod_t tclass=capability
> May 22 08:42:57 lyta kernel: IPv6 over IPv4 tunneling driver
> 
> The above is a cut from my syslog while booting.  It appears to me that the 
> kernel code for the IPv6 module is still being registered as insmod_t domain.

You're seeing this message because the IPv6 module needs to register some 
kernel control sockets when it is loaded.  As these control sockets are 
raw, they require CAP_NET_RAW during creation, which happens in this case 
in the context of insmod.

> Is this a bug in the IPv6 module?

No.


- James
-- 
James Morris
<jmorris@intercode.com.au>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
