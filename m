Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h915YJsJ023050
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 01:34:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h915WVZt005475
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 05:32:31 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h915WUM3005472
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 05:32:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill Laut <wlsel@verizon.net>
Subject: Re: X Windows discussion
Date: Wed, 1 Oct 2003 15:34:09 +1000
Cc: selinux@tycho.nsa.gov
References: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil> <200309301631.12831.wlsel@verizon.net>
In-Reply-To: <200309301631.12831.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310011534.09826.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 06:31, Bill Laut wrote:
> I do have a concern about the effects on system performance.  Unlike
> general policy enforcement decisions, the X system presents a scenario
> where multiple tests may have to be made before a decision can be rendered
> and/or where multiple tests may have to be interleaved to reach a
> "composite" decision (a screen snapshot, for example, comes immediately to
> mind in both cases).

Are many people running systems where screen capture speed is a bottleneck?

> > The existing SELinux policy in the kernel controls who can connect to
> > the X server.
>
> I was under the impression that the existing SELinux policy only had 
> granularity to the IP/port address, not to the client's source context 
> (unless labeled networking is in effect).  Has this changed?

For local connections we control access to the Unix domain socket and to the 
TCP port.  For remote connections the only sensible thing to do is to use ssh 
tunneling.  You just have to avoid doing "ssh -X untrusted-host" (you would 
be amazed how many people try to do X forwarding from my play machine).

As for labeled networking, requiring IPSEC is a difficult issue, many people 
have deployed networks with other systems and are not in a hurry to change.  
The incompatabilities for administration tools for the different 
implementations of IPSEC in the Linux kernel make this more difficult.  Also 
there's the issue of firewalls that block IPSEC.

If we demand that all networked SE-X users have IPSEC and labeled networking 
running then we'll greatly delay any use of the technology.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
