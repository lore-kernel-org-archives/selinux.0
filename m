Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OCw4iE013782
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 07:58:04 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OCuMV1005680
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 12:56:23 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 24 Mar 2006 13:57:52 +0100
Date: Fri, 24 Mar 2006 13:57:51 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Install several policy modules at once?
Message-Id: <20060324125751.GC7306@thorium.jmh.mhn.de>
References: <20060324103805.GA7306@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
In-Reply-To: <20060324103805.GA7306@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2006-03-24 12:06]:
> I'm currently building a very modular policy so one compiled policy can
> be used on many different machines. However, installing new policy is
> very slow (This is on an otherwise idle system):
>=20
> # time (for i in $(semodule -l | awk '{print $1}'); do semodule -i ./$i.p=
p; done)
>=20
> real    1m38.796s
> user    1m1.645s
> sys     0m8.502s
> # semodule -l | wc -l
> 23
>=20
> (I don't use -u because I want to be sure I have exactly the policy
> loaded which I just compiled)
>=20
> Would it improve speed if semodule could process several modules at
> once? Currently semodule doesn't allow this and I don't know enough
> about its internals to estimate if it would be worth the effort.

Erich just gave me the helpful tip that it IS possible to install
several policy modules at once, you just need to say
	semodule -i sudo.pp -i cups.pp
instead of
	semodule -i sudo.pp cups.pp
which I tried.
So this just needs more documentation.

It's much faster, too:
# time semodule -b base.pp $(semodule -l | awk '{print "-i " $1 ".pp"}')

real    0m1.656s
user    0m1.339s
sys     0m0.287s

So consider this issue solved.

Thomas

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEI+zPD9qpeVMU938RAlgHAJ9iqDtOMbB3sN7Yof5QQ4V5DmCUQgCfYlVW
zHi0GC3KCQ0SLPDFGPOc6v4=
=MIr9
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
