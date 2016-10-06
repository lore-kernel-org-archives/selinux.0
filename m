Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96FUACN024875
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 11:30:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id b201so4050856wmb.1
 for <selinux@tycho.nsa.gov>; Thu, 06 Oct 2016 08:29:36 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id gg10sm15063569wjd.4.2016.10.06.08.29.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Oct 2016 08:29:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
To: selinux@tycho.nsa.gov
References: <cover.1475590141.git.gary.tierney@gmx.com>
 <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
Date: Thu, 6 Oct 2016 17:29:27 +0200
MIME-Version: 1.0
In-Reply-To: <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IIPSwJBqa1LjR4s8qckC9HCQVtIi4vDkn"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIPSwJBqa1LjR4s8qckC9HCQVtIi4vDkn
Content-Type: multipart/mixed; boundary="qPX5cualrpCtBqueB2O0AmPisV3mExIOa";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <0b43fee1-1a0c-8269-ee2b-a51aecd4ea01@gmail.com>
Subject: Re: [PATCH v2 0/1] supporting RBACSEP in genhomedircon
References: <cover.1475590141.git.gary.tierney@gmx.com>
 <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>
In-Reply-To: <31a14a92-c2e5-ae4e-7366-e7d6177dc178@tycho.nsa.gov>

--qPX5cualrpCtBqueB2O0AmPisV3mExIOa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 04:56 PM, James Carter wrote:
> On 10/06/2016 07:09 AM, Gary Tierney wrote:
>> New version of the previous genhomedircon-rbacsep patch with some
>> changes.  A
>> bit of a delay as I had to get in a libsepol/cil fix which was
>> blocking this.
>>
>> 1. Remove semanage.conf option
>> 2. Drop unrelated change
>> 3. Adds a new homedir_role member to the genhomedircon_user struct.
>> 4. Sets homedir_role if the SELinux users prefix is a valid role for
>> that user.
>> 5. Replaces all roles with homedir_role in context specifications if
>> homedir_role is set.
>>
>> One issue that came up when writing these patches is that genhomedirco=
n
>> squashes logging [1] for some reason, which can result in no warning /=

>> info
>> messages and an empty file_contexts.homedirs file if policy has been
>> incorrectly configured.  Can we get rid of this behavior or add a flag=
 to
>> conditionally enable logging?
>>
>> Dominick Grift helpfully created some test images that demo DSSP
>> policy working
>> with both RBACSEP and non-RBACEP:
>> https://tfirg.asu.su/2016/10/03/garys-patches/
>>
>> There are still some rough edges though, for example in policy you
>> can't write a
>> statement like: (userprefix id role) and put it in an abstract namespa=
ce,
>> since it is interpreted as a literal:
>>
>> (block usersubj
>>     (blockabstract usersubj)
>>     (user id)
>>     (role role)
>>     (userrole id role)
>>     (userprefix id role))
>>
>> (block wheel
>>     (blockinherit usersubj))
>>
>> Which leaves us with a (userid, prefix) tuple of (wheel.id, role)
>> [wheel.id
>> might even just be id here, haven't checked if users are expanded or
>> also taken
>> as literals].
>>
>=20
> Users are fully qualified, so it is "wheel.id". It is true though that
> "role" in "(userprefix id role)" is taken as a string and is not
> expanded. The only identifiers that are fully qualified are those that
> will exist in the kernel policy and are stored in symbol tables.
>=20
> To get what you want you need to write:
>=20
> (block usersubj
>     (blockabstract usersubj)
>     (user id)
>     (userlevel id (SENS))
>     (userrange id ((SENS)(SENS (CAT))))
>     (role role)
>     (userrole id role))
>=20
> (block wheel
>     (blockinherit usersubj))
>=20
> (userprefix wheel.id wheel.role)
>=20
> which is inconvenient. It seems to me that if the userprefix statement
> is allowed in a block, then it makes sense to fully qualify it, but I
> tend to see the prefix as a string, so it would make more sense to me t=
o
> just not allow it in blocks.

It use to be a string, but that is no longer true with this patch. It is
a role now. In my view it should be treated as such

>=20
> This makes more sense in the following example.
>=20
> (block userdecl
>     (blockabstract userdecl)
>     (user u)
>     (userlevel u (SENS))
>     (userrange u ((SENS) (SENS (CAT))))
>     (role r)
>     (userrole u r))
>=20
> (block user
>     (blockinherit userdecl))
>=20
> (userprefix user.u user)
>=20
> Where user is acting like a true prefix for user user.u and role user.r=
=2E
>=20
> Jim
>=20
>=20
>> Though this is something I can look at later if all is well here.
>>
>> [1]
>> https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/=
genhomedircon.c#L568-L572
>>
>>
>> Gary Tierney (1):
>>   genhomedircon: use userprefix as the role for homedir content
>>
>>  libsemanage/src/genhomedircon.c | 38
>> +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--qPX5cualrpCtBqueB2O0AmPisV3mExIOa--

--IIPSwJBqa1LjR4s8qckC9HCQVtIi4vDkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX9m3XAAoJECV0jlU3+Udp0xoMAIpx3Xjosbx2dyqiofqxP4Bm
O3TebOFy4Lo5euIdOrPKYgFzp34sbKNQKRY4nlS1MVW9mU4Ip9h+PXp0Z7UHwzhO
NaH1QWbZshfqyiadTXDryrD29Y9BV3HcDRBW9sEJfddbC8qdSpB3rB3Cxr4kV9mM
iPh20wlrD8fKqf4ePcA1RvI2tuX69YXP8H3XBB5X8JCVG4IEg3dvasy46hqvbkjK
Qds8jQWz/5dlTKdIfRukTeRuCHYw93ahqUmdtty2AAds0YumIY4tWUzr9l50UHkk
FjzL9KXe8JXoytbNueNp1dfN8ydR8whmMBPr/pSPKjRzKr0YHyI+BqXwCSvLcF2j
7Egk73litfjkZcOjbo4sOL3GtsbKep8u0ByT31apRn0pHu9If4kJWI2uc/Q1+7uv
F/WK7qkctiJIh49GsEZV5rWP3NWzKMOoOrtj+asRHWC0DJEt3soqIXNpzRaQfCKV
Ugkq3CDjGVAPVkaq+IxqLNAzuxUJ1opqiTp7Z3WYQA==
=dTMN
-----END PGP SIGNATURE-----

--IIPSwJBqa1LjR4s8qckC9HCQVtIi4vDkn--
