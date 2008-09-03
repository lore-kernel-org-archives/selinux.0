Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m839P0Zm026046
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 05:25:00 -0400
Received: from ey-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m839OxK8012491
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 09:25:00 GMT
Received: by ey-out-1920.google.com with SMTP id 4so1590342eyg.30
        for <selinux@tycho.nsa.gov>; Wed, 03 Sep 2008 02:24:59 -0700 (PDT)
Subject: Re: user guide draft: "Targeted Policy" review
From: Dominick Grift <domg472@gmail.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BE3FB4.8020003@redhat.com>
References: <48BE3FB4.8020003@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-taXbR5fo/JD1Nstv4B6U"
Date: Wed, 03 Sep 2008 11:24:56 +0200
Message-Id: <1220433896.26646.4.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-taXbR5fo/JD1Nstv4B6U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-09-03 at 17:41 +1000, Murray McAllister wrote:
> Hi,

> Are there any SELinux restrictions on what users can do when they run=20
> unconfined?

Yes i think unconfined users cannot do execmem, execstack, execheap by
default.
Otherwise they're exempted from policy enforcement i think.

--=20
Dominick Grift <domg472@gmail.com>

--=-taXbR5fo/JD1Nstv4B6U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAki+V+AACgkQL00QnzrVtlzwQwCgpMBMw04v7X8G/hlouNYUTO0s
/zYAoIsra12iQabq1R41Y1y5MC3kbvoj
=sYaX
-----END PGP SIGNATURE-----

--=-taXbR5fo/JD1Nstv4B6U--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
