Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBF4bXMA016684
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 23:37:34 -0500 (EST)
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBF4agiU019681
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 04:36:42 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBF4bW37022720
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 23:37:32 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBF4afp9131330
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 21:36:41 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBF4bWnt003623
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 21:37:32 -0700
Date: Wed, 14 Dec 2005 22:37:31 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: sharp <steven.harp@adventiumlabs.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux performance
Message-ID: <20051215043730.GA8546@sergelap.austin.ibm.com>
References: <1134590934.2630.207.camel@faith.austin.ibm.com> <Pine.LNX.4.63.0512141946090.21033@excalibur.intercode> <200512141931.49278.steven.harp@adventiumlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200512141931.49278.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting sharp (steven.harp@adventiumlabs.org):
> On Wednesday 14 December 2005 06:47 pm, James Morris wrote:
> > On Wed, 14 Dec 2005, Joy Latten wrote:
> > > A while back I took up some SELinux performance work that a colleague of
> > > mine, Kylie Hall had done. The patch added ipv4 address, ipv6 address
> > > and port caches to SELinux. I believe I sent the patch a while back
> > > also, but can do so again if anyone is interested. The caches are
> > > exercised in such SELinux hooks as socket_bind(), socket_connect() and
> > > socket_sock_rcv_skb(). Bandwidth has allowed me some time to work on
> > > this. Can anyone recommend a benchmark that will exercise this code?  I
> > > figured something that utilized many ip addresses or ports.
> >
> > apachebench is a good basic test, and you can also try webstone, lmbench
> > and iperf.
> >
> > Not sure how to realistically simulate large numbers of IP addresses.
> 
> You might consider, budget permitting, something like Net Avalanche
> <spirentcom>. Rack mountable thingy designed for stress testing using
> realistic traffic: "simulates up to 50,000 simultaneously-connected 
> users with unique IP addresses".  (Every home should have one.)

Nifty.  If someone has one of these sitting around and wants to try
out Joy's (/Kylie's) patchset, that sounds like a very good test indeed.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
