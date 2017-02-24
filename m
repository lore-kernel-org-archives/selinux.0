Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1OI0qNt027687
 for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2017 13:00:52 -0500
Received: by mail-wm0-f47.google.com with SMTP id r141so20491162wmg.1
 for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2017 10:00:50 -0800 (PST)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id e16sm11241613wra.36.2017.02.24.10.00.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Feb 2017 10:00:48 -0800 (PST)
Subject: Re: Support for multiple types in typeattribute
To: selinux@tycho.nsa.gov
References: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <334f2cb3-cbb4-4f9f-bbc6-63aa5828ed36@gmail.com>
Date: Fri, 24 Feb 2017 19:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IMRuqgr45on1SivFA8LtvBAuP4lf0nfA1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMRuqgr45on1SivFA8LtvBAuP4lf0nfA1
Content-Type: multipart/mixed; boundary="NSUGEuVOMPRpvwGFTqpjHPpHDW5uKdssQ";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <334f2cb3-cbb4-4f9f-bbc6-63aa5828ed36@gmail.com>
Subject: Re: Support for multiple types in typeattribute
References: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>
In-Reply-To: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>

--NSUGEuVOMPRpvwGFTqpjHPpHDW5uKdssQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 06:39 PM, Alex Klyubin wrote:
> Hi,
>=20
> typeattribute currently accepts only a single type as its first argumen=
t.
> It associates the provided type with the attribute provided as the seco=
nd
> argument. Is there a reason why typeattribute doesn't support multiple
> types specified as the first argument? The idea being that it would
> associate each of those types with the attribute.
>=20
> For example, the first argument to typeattribute could use the same syn=
tax
> as used for the first argument of allow and neverallow. typeattribute c=
ould
> then expand this set of types, attributes, and exclusions into the set =
of
> matching types and then associate each of the types with the provided
> attribute.
>=20
> The reason I'm asking is because in Android SELinux policy we're bumpin=
g
> against the need to associate attribute A with the set of types which a=
re
> grouped using attribute G. We could add a typeattribute for each type
> associated with G, but that (1) duplicates the grouping which is alread=
y
> expressed via G, and (2) makes it very cumbersome/brittle to keep both =
A
> and G associated with exactly the same set of types. In particular, bec=
ause
> Android SELinux policy source tree is distributed between a large numbe=
r of
> Android devices and organizations, requiring that any time you associat=
e a
> type with G you must also associate it with A is suboptimal, not to men=
tion
> that making such a change in the existing policies requires to change e=
ach
> policy.
>=20
> To make life more interesting, there's also a need to associate A with =
a
> subset of G, for example, G minus some type or two.
>=20

CIL is a bit more flexible. You can associate type attributes with type
attributes and do things like:

    (typeattributeset
        not_dyntransition_subj_type_or_unconfined_subj_type_attribute
            (not
                (
                    dyntransition_subj_type_attribute
                    unconfined_subj_type_attribute
                )
            )
    )

and:

    (typeattributeset except_obj_type_attribute
        (and
            (
                obj_type_attribute
            )
            (not
                (
                    auth_obj_type_attribute
                    exception_obj_type_attribute
                    sec_obj_type_attribute
                )
            )
        )
    )



> Kind Regards,
> Alex
>=20
>=20
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--NSUGEuVOMPRpvwGFTqpjHPpHDW5uKdssQ--

--IMRuqgr45on1SivFA8LtvBAuP4lf0nfA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYsHTKAAoJECV0jlU3+UdpFRYL/2c0RVO10lZXPB/PgIsbt2n7
3ncTohRtAkm1JarHNyRSlalkfwd173SY7n4VsxydiosJJyArlc+79TmmAWLEvQOk
UlBmt8o3cU+jxrm4zHOt1UT55bfUbKlAADhANsFH/AcTSwVEwl2idv8jSAkJwTFO
g9YdBdAC4p6ypAQktx8y/evG6GaJlwdKE3nAwamrismZx0Bt7O0neSV7o8pKrmNf
PX3RQ902XFJAMeiRF8FTSX7Bma9QY1Q64sRqceF6KQvXAH/L2YB4e7ebIXTl8rSj
fCj50jhuVQcL2laM0nh7aJ6TemZXkzg514zztjuK1LjPSWFnLC4DfD2pf/e4Y6RK
Y0u53DR39h/PPR+v4WrUjwYggYyM9MnURDdgjVXElL/3RP3cDEOkl3yJJQGBuETy
ZrXgMiLSnoVZMAL8kIqY736i2PcbvZ6u4PYfomVe2wD+OuNpcjX1oHK4aGti5TxF
yzOKe+bClYaWqiZUlgjKsFlFCpoxXn/9oJvz+NkemQ==
=ngYS
-----END PGP SIGNATURE-----

--IMRuqgr45on1SivFA8LtvBAuP4lf0nfA1--
