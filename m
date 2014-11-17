Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAHMgUPw021521
 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2014 17:42:30 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so4368249wiv.2
 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2014 14:42:27 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id cq4sm9085492wjc.35.2014.11.17.14.42.26
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 17 Nov 2014 14:42:26 -0800 (PST)
Date: Mon, 17 Nov 2014 23:42:25 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Question on unconfined_t
Message-ID: <20141117224224.GB7768@e145.network2>
References: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
 <546A1634.1070900@tycho.nsa.gov> <546A5C6F.6030805@redhat.com>
 <CAOK12DarQLB3QcmRLd4xTWTDS0kBD+zAXfh_0oHK3_gYxnniiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <CAOK12DarQLB3QcmRLd4xTWTDS0kBD+zAXfh_0oHK3_gYxnniiQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 09:18:51PM +0000, Paddie O'Brien wrote:
> Thanks. I was under the mistaken impression that unconfined_t got
> something for free. My new understanding is that it's by convention
> that policy writers give access to unconfined_t to their domains and
> they do so by adding explicit rules.
>=20
> Also I was missing file_type(mytype_exec_t) although I had
> domain_type(mytpe_t). Is there a way to see what things like file_type
> and domain_type expand to? I want to know what's going on in the
> background.
>=20

Forgot the answer the actual question. You can look up what the various "ma=
cros" expand to by perusing /usr/share/selinux/devel/include if you have in=
stalled the selinux-policy-devel package
It might help a bit if you are familiar with m4. Its just macros that event=
ually expand to selinux policy language, sometimes the macros can nest pret=
ty deep before you end up with the raw rules.=20

macros are basically yet another way to group even more ...


--=20
Dominick Grift

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUannLAAoJENAR6kfG5xmc1FIL/iSGftzf3UdnqVKtDuIrITe7
OQGxADsGtgaDTRkoM6RTCzk1zqTTXOSUtD7AkbIJz0hEZCLyR2YRhPVdMe74ww08
21jOk1LY/Jt+Jq0SK4yTrohi0aiJxm/C5UmCKSp4ddg/cByuc2VtaG7lBIighIRn
lvpq6aqHbAI1IhzCDWMzp3MIffAHiybzAodwomlUaE3ClXuMAxOydGx9Bf7mOV82
wy+sQ3g1DVMlMKundiUhQrTmh9Ry6OjXP4MQG81siDVRZsA3NiCaamMHmKbbnaDj
bvoc6GghFp4IgfMvgeRV3t7fZSld09u24M5lGsnX8X8iyJi5XP5xk0OfJsAZJRZn
+LXeVqnCCDMzDw87OlBzrET2XcxbNfTr+fbl6Jqox6WD/SG+pTl9o1xtTBLFlfQw
ski3978yTP0U58i4jaGMy1xMG/f53UGGiFbf55k2Hb9cjZnHAJ558P+Zmv5X8AOv
0sjWolQ9/ARqtMEyjr+x9T9rDpwH8rxcpwIa8p6trw==
=J07R
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
