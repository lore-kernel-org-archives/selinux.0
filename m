Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7PCIAL5019818
 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2014 08:18:10 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so2431129wiv.7
 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2014 05:18:13 -0700 (PDT)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id fo19sm220789wic.1.2014.08.25.05.18.11
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 25 Aug 2014 05:18:12 -0700 (PDT)
Date: Mon, 25 Aug 2014 14:18:10 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: semanage interface has no effect
Message-ID: <20140825121808.GA2096@e145.network2>
References: <53FB19C7.1040500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <53FB19C7.1040500@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 03:11:03PM +0400, Stepan G. Fedorov wrote:
> Hello!
>=20
> Goal of this experiment is to see allow rules for netif class objects is
> working.
>=20
> I use debian wheezy whith MLS selinux policy, in enforced mode.
>=20
> eth0 is hte only netwotk interface, except lo.
>=20
> sesearch --allow -cnetif shows lots of allow rules for netif_t target typ=
e /
> netif target class.
>=20
> I do:
>  1) I add new type nginx_http_if_t with my own policy module;
>  2) semanage interface -a -t nginx_http_if_t -r s1:c0.c1023 eth0.
>=20
> I expect: to see all the processes in system unable to read/write packets
> from eth0 interface.
>=20
> I actually got: nothing changes - all networking is working as it was bef=
ore
> changing of interface context.
>=20
>=20
> What am I doing/understanding wrong?

I suspect that these controls may be legacy (net_compat?)

I may be wrong

>=20
> Thank you!
>=20
> --=20
> Stepan G. Fedorov <StFedorov@gmail.com>
> Tel: +7-965-750-91-91
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
http://subkeys.pgp.net:11371/pks/lookup?search=3D0x02DFF788&op=3Dindex
Dominick Grift

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJT+yl1AAoJENAR6kfG5xmc1zkL/Rqlz/+VAdELjkgXpaj3ykCo
Miq44I49Xn7+D6lTMXelydCElBOMNiqQKSdS+wEPdODfJlZraL82bzCykqR1fpkR
loAwRMZ0rjt+32Fz8+9jhoHdgHRNKTMHAOfbG3uqS652D2X59IZ1ASqYahdDxFj1
87bjcZC9Tc7ZRryWSPc2CzoOfxFqxO9mRaivR+WQ7rkHXEwXiW1ghxVt2GGLTXk5
vFxRrww+9ukyMf4vs4qYK+UoqmAbG+nrgMgRNtfDsPgiHNqoKeWegDu5lfcb6o5O
MOOQRGJfXpzBgP5PW56Iqs4vNn2in6stM8CO0FEChjxayTVa9kZ2lln4h7EQI/79
0FNXpzwTjgqdE5JGXmDFNbDTco/QGtVfFqAbK+v7t0FxTDzlfLqyn65QCrMtqMis
L9rXqrklxGxsLJTf0+tXG5Nh/RnsqPWZqHsDvKop41HdvLxuQ/k9AWn5/2FwGkN6
l6LTttwFhLVToKFI+g47qySi9hxTYo7iLXqArHGkjA==
=OHys
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
