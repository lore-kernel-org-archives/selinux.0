Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5T7uw6w026707
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 03:56:58 -0400
Received: by wibdq8 with SMTP id dq8so64106531wib.1
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 00:56:54 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by mx.google.com with ESMTPSA id v3sm10890153wiz.14.2015.06.29.00.56.53
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2015 00:56:53 -0700 (PDT)
Date: Mon, 29 Jun 2015 09:56:52 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: type inheritance in CIL
Message-ID: <20150629075651.GA8191@x250>
References: <5590F3DE.8070202@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <5590F3DE.8070202@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2015 at 09:29:34AM +0200, Miroslav Grepl wrote:
> Trying to make sandbox working using CIL but I see it does not support
> typeinherit statement.

One of those features that really define CIL but that is currently not avai=
lable or fully working yet.

My suggestion is to study the "cilpolicy" (which is really just a snapshot =
of reference policy transformed to cil with hll i believe)

This will give you some pointers as to how to create an alternative impleme=
ntation that achieves a similar result.

When you write CIL policy, there are some "bugs" to take into account and t=
o workaround.

>=20
> --=20
> Miroslav Grepl
> Senior Software Engineer, SELinux Solutions
> Red Hat, Inc.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVkPo/AAoJENAR6kfG5xmclMoL/2G5nvyMZ1Y20aJzJV2ihp/o
6pGPu6e441l4Tg7iilncwCMF+F3HQXZ0nBjrZ3y77GvC1TFu6GX61jWFlC55u0hw
wz7onSK2Q9h4zUO5c66m5RcpUmQfBQO41JqljqIwvDeeqkY+XiDNrbPCE6RtopH5
LzEcbEKEyAaDbLNXrsMfgB3uPqEnzAut4OEXv+r0eJxboIWsOAprKSsnwtKHR7Ip
leBNQbpdVnhUyeWSKckpiWF5XQFxktZ+LnVcNEhP3RDiOI1hjoycorscI0lyTdnq
juVUIQlnUeSWUwLbv+g0HY90W4vcGJHeo79Em4UK4oRxfFExFYU4/uG/Dxt3gzSb
M4YUtqDAJGFlmDPESkiWmYqYtSPakOW2XhIs4bsFWhsaQ0u398yHPhdcV5K4X3NP
avUv68NrEBvxpZ7uwfkWXWhgdoIP80WCdO9hPNeajG0RrV14vO9tYBh632Rou2me
7ZOz/hb5si/VDX+SdueAVurlp/WS+AE5Je/hn6oC0g==
=iW5F
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
