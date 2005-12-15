Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBF1UpMA015402
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 20:30:51 -0500 (EST)
Received: from mail1.exo2.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id jBF1UnGj017022
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 01:30:49 GMT
From: sharp <steven.harp@adventiumlabs.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux performance
Date: Wed, 14 Dec 2005 19:31:42 -0600
References: <1134590934.2630.207.camel@faith.austin.ibm.com> <Pine.LNX.4.63.0512141946090.21033@excalibur.intercode>
In-Reply-To: <Pine.LNX.4.63.0512141946090.21033@excalibur.intercode>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11018709.0umIIYtAyG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200512141931.49278.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart11018709.0umIIYtAyG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 14 December 2005 06:47 pm, James Morris wrote:
> On Wed, 14 Dec 2005, Joy Latten wrote:
> > A while back I took up some SELinux performance work that a colleague of
> > mine, Kylie Hall had done. The patch added ipv4 address, ipv6 address
> > and port caches to SELinux. I believe I sent the patch a while back
> > also, but can do so again if anyone is interested. The caches are
> > exercised in such SELinux hooks as socket_bind(), socket_connect() and
> > socket_sock_rcv_skb(). Bandwidth has allowed me some time to work on
> > this. Can anyone recommend a benchmark that will exercise this code?  I
> > figured something that utilized many ip addresses or ports.
>
> apachebench is a good basic test, and you can also try webstone, lmbench
> and iperf.
>
> Not sure how to realistically simulate large numbers of IP addresses.

You might consider, budget permitting, something like Net Avalanche
<spirentcom>. Rack mountable thingy designed for stress testing using
realistic traffic: "simulates up to 50,000 simultaneously-connected=20
users with unique IP addresses".  (Every home should have one.)

=2D s harp


--nextPart11018709.0umIIYtAyG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDoMeFPcFX9H2zuSkRAn3rAJ483zMQqZmUDfEVxUxSPT0U6/BIMACfRAqI
mnz/DYTu+Zb6NXdJodulApU=
=ZbFS
-----END PGP SIGNATURE-----

--nextPart11018709.0umIIYtAyG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
