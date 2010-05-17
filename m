Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4HCS22O001111
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 08:28:03 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4HCTG4q002736
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 12:29:16 GMT
Date: Mon, 17 May 2010 14:27:50 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
Subject: Re: [refpolicy] A strange usecase
Message-ID: <20100517122750.GC27060@myhost.felk.cvut.cz>
References: <AANLkTims07JUhAD9T2KvEGHZauBW6etkgCUQFKTAD1OP@mail.gmail.com>
 <1274098502.2093.2.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
In-Reply-To: <1274098502.2093.2.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Christopher J. PeBenito wrote:
> It is not possible.  That info comes out of the /proc/net/dev proc file.
> All interfaces are in the same file, so you can either see all of the
> interfaces or none of the interfaces.  This can be controlled by
> allowing or denying access to proc_net_t files.

Unless you create your own application that filters the info.


Michal Svoboda

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvxNkYACgkQg/fU9pp1uX4hUQCeO0TOLTM6l+9PXzugt3XRPce3
zm8AoJQnch0E2tijdF0IUvWE78aMayrO
=BVYj
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
