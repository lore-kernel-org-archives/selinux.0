Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASLjhRb028510
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 16:45:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hASLjgqY015200
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 21:45:42 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hASLje0o015197 for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 21:45:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Josh McCormack <joshmccormack@travelersdiary.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: uCLinux &/or Snapgear Linux
Date: Sat, 29 Nov 2003 08:45:30 +1100
References: <3FC7AA3E.5030500@travelersdiary.com>
In-Reply-To: <3FC7AA3E.5030500@travelersdiary.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311290845.30914.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Nov 2003 07:04, Josh McCormack <joshmccormack@travelersdiary.com> 
wrote:
> Has anyone applied the SELinux security features to an embedded distro,
> such as uCLinux or Snapgear Linux (based on uCLinux)? On the wireless
> lists people are always finding ways of hacking into APs and Routers, so
> as long as the policies wouldn't take up too much space, or slow things
> down too much, I think it would be very desireable.

I have got it working on the Familiar distribution for iPaQ PDAs (ARM CPU, 64M 
of RAM, 48M of flash).

http://www.coker.com.au/selinux/talks/ols2003/
See the above URL for some info on the iPaQ work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
