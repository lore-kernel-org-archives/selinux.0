Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBF0u3MA015146
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 19:56:03 -0500 (EST)
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBF0u0Gj013091
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 00:56:00 GMT
Date: Wed, 14 Dec 2005 19:47:33 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Joy Latten <latten@austin.ibm.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: SELinux performance
In-Reply-To: <1134590934.2630.207.camel@faith.austin.ibm.com>
Message-ID: <Pine.LNX.4.63.0512141946090.21033@excalibur.intercode>
References: <1134590934.2630.207.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Dec 2005, Joy Latten wrote:

> A while back I took up some SELinux performance work that a colleague of
> mine, Kylie Hall had done. The patch added ipv4 address, ipv6 address
> and port caches to SELinux. I believe I sent the patch a while back
> also, but can do so again if anyone is interested. The caches are
> exercised in such SELinux hooks as socket_bind(), socket_connect() and
> socket_sock_rcv_skb(). Bandwidth has allowed me some time to work on
> this. Can anyone recommend a benchmark that will exercise this code?  I
> figured something that utilized many ip addresses or ports. 

apachebench is a good basic test, and you can also try webstone, lmbench 
and iperf.

Not sure how to realistically simulate large numbers of IP addresses.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
