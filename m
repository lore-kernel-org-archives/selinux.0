Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8T7kdNg003051
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 03:46:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id b4so9513774wmb.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 00:46:33 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id a84sm26809903wme.6.2016.09.29.00.46.31
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Sep 2016 00:46:31 -0700 (PDT)
Subject: Re: Question on restricting file access
To: selinux@tycho.nsa.gov
References: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <1cf62e3d-c674-97ce-e598-aff042f4e877@gmail.com>
Date: Thu, 29 Sep 2016 09:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fwpJh91xjm48khQWJNeJORDnjSDLMmAQr"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwpJh91xjm48khQWJNeJORDnjSDLMmAQr
Content-Type: multipart/mixed; boundary="Le2DM4ogFtCpMTgC5JHdtCABe6QSlD32R";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <1cf62e3d-c674-97ce-e598-aff042f4e877@gmail.com>
Subject: Re: Question on restricting file access
References: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>
In-Reply-To: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>

--Le2DM4ogFtCpMTgC5JHdtCABe6QSlD32R
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/28/2016 09:05 PM, Raj Srinivasan wrote:
> Hi,
>=20
> I have just started with Selinux, and was trying (unsuccessfully) to re=
strict the sysadm role as my first exercise.
>=20
> I am using RHEL 7.1, and running Selinux with the minimum configuration=
 in enforcing mode.
>=20

Hi, This is not the optimal list for reference policy related questions.
refpolicy@oss.tresys.com is the list for reference policy

> I have a user called "admin" with the context "sysadm_u:sysadm_r:sysadm=
_t:s0-s0:c0.c1023", and uid 1000. When I login as admin and use su to bec=
ome root, the context still remains the same, as one would expect.
>=20
> I created a simple policy to restrict the sysadm_r role for testing pur=
poses, and was able to compile and load it.
>=20
> policy_module(localpolicy, 1.0.0)
>=20
> gen_require(`
>   type sysadm_t;
>   type sshd_key_t;
> ')
>=20
> allow sysadm_t sshd_key_t:file { create_file_perms write_file_perms };
>=20
> The idea was to prevent the sysadm_r role from being able to read a fil=
e with the sshd_key_t type even if the uid is changed to root via the su =
command, by allowing "create" and "write" permissions, but not "read" per=
mission.
>=20
> I would appreciate it very much if anyone could let me know what I am m=
issing, or if there is an easy way to troubleshoot. I tried to use the "n=
everallow" directive (with "read" permission) but after waiting for 10 mi=
nutes, the policy did not even load. I suspect there is some other rule i=
n effect that grants read permission that I am not able to see using "ses=
earch -A".
>=20

The above is not easily possible currently. This is mainly due to
limitations of the module policy language and due the reference policy mo=
del

SELinux is a denial-by-default access control framework. That means that
access is denied unless it is explicitly allowed. In this case sysadm is
explicitly allowed access to all non-auth files
(https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules=
/system/userdomain.if#L1233).
Ideally you would have to start by removing that rule (if you wish to
not break the reference policy model).

In theory it should have been possible to remove the rule by replacing
the userdomain module with a version that does not include the above
rule (at a minimum). However this, i believe, is currently not possible
due to aforementioned limitations, and if it would be possible then it
would be hard to maintain over time.

There is a new (intermediate) policy language that should make things
like this possible, but it is not available in RHEL7 yet, and even when
it becomes available then it still requires a policy written in a new
additional high-level language that takes advantage of the new
(intermediate) policy language to be able to take advantage of the
features that it brings.

The alternative would be to create a new set of rules and identifiers,
possibly based on the existing sysadm set of rules and identifiers, that
is then tailored to your specific requirements.

The above is however a non-trivial task, and not easy to explain in a
e-mail thread.

My advice to you is:

You are clearly interested in taking advantage of SELinux. It may be
worth it for you to learn more about the SELinux framework, security
models, and language(s).

Once you have enough knowledge of the aforementioned then you will find
how to achieve your goals, and you will be able to implement solutions
for a wide array of access control requirements with SELinux

> Thanks,
> Raj
>=20
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


--Le2DM4ogFtCpMTgC5JHdtCABe6QSlD32R--

--fwpJh91xjm48khQWJNeJORDnjSDLMmAQr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX7MbRAAoJECV0jlU3+UdpFg4L/j2jP7aNFXOTC9cQIPbH2o2x
TtOTL+q8+ZuAkIpI36p6yCeq6Sic/j1shLEj14+Gz/9jO8zmCqSIfI7/F8nSIwMM
bGG2mm/fhaIGZb8/VQIJb5gUJQ2EjLss7E+EZule0eVqMDTk7WzL2qf4QwYBBoba
seSeHvTRWI7+WVTkNgqcvgg0sLBab02FnsZyDc1juQXoOAxUEv2w0Ss9bt+u0lWy
odUxj5AK7e5eVrnydEduwy5N2Yr9CyjW86jvy3Ly6fEQLlnOpBKv3AGYYL0dCV4r
GYnTdEwxRDQ7Qc0HWt9hjGlpGl/4jf3DsgXwQsAnt4YzKLJ4uEA9Piu4DVTmKyLh
AcBRcuZKoxe1hI3a00ykeNFmrlkVVNqSEzgVkEi5ZOTzdYeln1TI0cCzGeHeEVvU
/P/VEgYdybX14jRdyFVnLsRJFRQzz7L4r5EUPn0ZS6c4Alt3Q5QPRtxTHj3UGY9j
G2GuZV/CGTKBwBudgL0Wk67hmgtzec4D2AgxhizYsA==
=rI1R
-----END PGP SIGNATURE-----

--fwpJh91xjm48khQWJNeJORDnjSDLMmAQr--
