Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAOBQga2017012
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 06:26:42 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so5295309wid.9
 for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2014 03:26:39 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id d5sm20584976wjb.34.2014.11.24.03.26.38
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 24 Nov 2014 03:26:39 -0800 (PST)
Date: Mon, 24 Nov 2014 12:26:37 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux Userspace Release: 20140826-rc6
Message-ID: <20141124112636.GA6200@e145.network2>
References: <5463658D.7050702@tresys.com>
 <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2014 at 11:15:42AM +0100, Sven Vermeulen wrote:

>=20
> Now, I tried to remove the "object_r" role from one of my test VMs but
> that totally screwed up the image (system froze, and reboot failed).
> I'm not sure if I'm allowed to remove it or not now. If I should, I'll
> investigate it further and see if I can get denials or other
> information from it.

object_r should be associated with all security identitiers i believe (incl=
uding selinux user identities)

What you are seeing is expected, and you should not try to remove it

--=20
Dominick Grift

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUcxXmAAoJENAR6kfG5xmcqp4L/Rex9IPGTNchao8/7SN9eoK9
9PcnTVyLt5BCedB6Q028T5yxHBb5coem5qc/1IPTig5XpP+vG19TsJfVDvVdh4oA
CEwuQzx7LRDi2Fan7qOzzeijy5TLUtw3kvSKToP+4otlxaBKxbRrqlIlRRt6o+LB
I9e7Y4AFN1nUTuPvfGTT6j+UJCBERv2SFas1w8FWGIlNxe1vh5hx201XlMbUVfED
WAxAhEK6ZojwQaC2z7a7Mp6lWyr2p1xIH/HG3G5PewWuy6XtcVfL8i6IYaIvE5Fs
OHepFpp53EIAov6MLsyT0k+LHyO5Lg7uog/ax7E67vA4zAgj/EfGteEtU8h6Uesq
TidLXOwVVFVdx3pmbTZIy4whYqORbHij0y8889GWuYmy1caECDdXakdDl1NZBb4R
S9IJSYdT3j6R3L7/ofqILZArwAw6AE/ZQz8Q6i4zAdqLxL2sRcwsMoAdquQA6CRI
akyzSZtSPRN8x9PrLpTteAoMcX3aM9xKwkXCF5NeLg==
=IFBr
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
