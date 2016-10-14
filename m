Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9EG2uVj031178
 for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2016 12:02:58 -0400
Received: by mail-wm0-f46.google.com with SMTP id d128so6159165wmf.1
 for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2016 09:02:45 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id 17sm32682266wju.44.2016.10.14.09.02.43
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Oct 2016 09:02:43 -0700 (PDT)
Subject: Re: ANN: SELinux userspace release
To: selinux@tycho.nsa.gov
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
Date: Fri, 14 Oct 2016 18:02:33 +0200
MIME-Version: 1.0
In-Reply-To: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IHdpsbmX366Eh7seRMDsS3KHthjKSo4Uv"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHdpsbmX366Eh7seRMDsS3KHthjKSo4Uv
Content-Type: multipart/mixed; boundary="LQdGiVHAvG63Loeqde0OJBlST9v4gN73m";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <23249b84-09fa-1e38-a391-9b37ad6a5457@gmail.com>
Subject: Re: ANN: SELinux userspace release
References: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>
In-Reply-To: <8ab31077-8e8a-6467-374a-d1b5cadae2bb@tycho.nsa.gov>

--LQdGiVHAvG63Loeqde0OJBlST9v4gN73m
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 05:55 PM, Stephen Smalley wrote:
> The 2016-10-14 / 2.6 release for the SELinux userspace is now available=
 at:
> https://github.com/SELinuxProject/selinux/wiki/Releases
>=20
> This has been tagged as 20161014 in the git repository.
>=20
> Below are some notes on this release for packagers of the SELinux
> userspace.  Please see the individual ChangeLog files for a detailed
> list of changes.
>=20
> 1) sepolicy converted to setools4:
> - sepolicy and its users now depend on setools4 instead of setools3.
>=20
> - Please convert any remaining users of setools3 to setools4 since
> setools3 is no longer being developed.
>=20
> 2) genhomedircon enhancements and behavior changes:
> - genhomedircon supports the %{USERID} template for substituting the
> user's uid. %{USERNAME} has also been added as a new template for
> substituting the user's username.  The USER template is still supported=

> for backward compatibility but is deprecated.
>=20
> - genhomedircon supports generating home directory contexts for login
> mappings using the %group syntax.  This may produce an error if the use=
r
> belongs to multiple groups specified in the login mapping, which can be=

> resolved by adding an explicit mapping for the user to override the
> group-based mapping.
>=20
> - genhomedircon will fully replace the SELinux user and range fields in=

> each templated security context rather than only substituting for the
> hardcoded strings "system_u" and "s0".  As a side effect, genhomedircon=

> no longer has special handling of "system_u" and will therefore trigger=

> a warning if there is a "system_u" entry in seusers:
>     libsemanage.add_user: user system_u not in password file
> This warning is not fatal, but it would be preferable to remove system_=
u
> from the seusers file.
> See https://bugzilla.redhat.com/show_bug.cgi?id=3D1378204
>=20
> - genhomedircon will replace the role field in each templated security
> context with the user prefix for the user if the user prefix is the
> identifier of a role valid for the given user, or if it is "object_r".
> This enables configuring RBACSEP (i.e. role-based separation of user
> home directories) in policy.  If the user prefix is not a valid role,
> then genhomedircon will leave the role field unmodified as before.
>=20

An issue was reported about genhomedircon with standard policy model
(non-mls), where no contexts were generated.

I was able to reproduce this issue, and Gary produced a patch to fix
this. However the patch does not fully address the issue, as it requires
that one runs an additional semodule -B to rerun genhomedircon.
genhomedircon does not generate the contexts the first time around.

> - genhomedircon will generate entries for logins mapped to the default
> user.  Previously no entries were generated for such logins, which coul=
d
> lead to no matching file_contexts.homedirs entries for users with home
> directories outside of LU_HOMEDIRECTORY in the absence of usepasswd=3DT=
rue.
>=20
> 3) libselinux pcre2 support:
> - libselinux supports either pcre1 or pcre2 but not both at the same
> time. The default remains pcre1.
>=20
> - To use pcre2, build libselinux and sefcontext_compile with 'make
> USE_PCRE2=3Dy". You must also rebuild your file_contexts.bin files with=

> the rebuilt sefcontext_compile.
>=20
> - With pcre2, file_contexts.bin is no longer architecture-neutral. The
> relevant architecture properties are endianness, pointer width, and
> PCRE2_SIZE type.  libselinux will automatically detect an architecture
> mismatch and ignore the stored precompiled regexes in that case,
> recompiling them instead at runtime.  sefcontext_compile -i will report=

> the pcre version and architecture strings that it will include in the
> file_contexts.bin file.
>=20
> - With pcre2, file_contexts.bin is substantially larger than for pcre1.=

> With the Fedora policy, we see the following sizes:
> 383165	file_contexts (text)
> 1507941 file_contexts.bin (binary with pcre1 regexes)
> 8304105 file_contexts.bin (binary with pcre2 regexes)
>=20
> - If you know that you will be generating file_contexts.bin for a targe=
t
> with a different architecture string or if you do not wish to pay the
> additional storage cost, you can use the -r option to sefcontext_compil=
e
> to omit the compiled regexes.
> With the Fedora policy, this yields a much smaller file:
> 540540 file_contexts.bin (binary omitting pcre2 regexes)
> You can make this the default when libsemanage invokes
> sefcontext_compile by adding the following stanza to semanage.conf:
> [sefcontext_compile]
> path =3D /usr/sbin/sefcontext_compile
> args =3D -r $@
> [end]
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


--LQdGiVHAvG63Loeqde0OJBlST9v4gN73m--

--IHdpsbmX366Eh7seRMDsS3KHthjKSo4Uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYAQGeAAoJECV0jlU3+UdpKgIMAJhWL1ypmmgrxJX3O9uab6tE
R9+Wa1JraK09PjmD2z3a3lKvhNsO5cJKQr2UzDfYmNZ9OmMKxJ3ZznRPAxs5HeE/
9ctaylAXZfg4eZhxbQFwR2emA4TMvpToec8MOUuBfzR8l8BXTUC9x0RSkUh0dxSo
X0JkoaydSi+EEg8nzDV1X5ekJ3zQd2/tl82rMMTvvvaKNFBQ2EoUqXgMXl2d3zet
svX4CJlNiMnf1OuhOMARYY7Ac7xwZ0rFEq4ZRgbX/VgF8nSVZFTuY349ISb7yNGB
jS2y58x0qWKCnGOvELzwIeflMnHhVXstLdrpRqbJRoPnqMf5xzcq5EQ0X4IP/MFb
V7Snawwjtby37BS62Ev8mJeUJ/C30KWDugPQqRviroYRUucl1OWdhc8DVruTy9jj
jQnxpH7VojorBRdZuXlahMs/lZoqrurqzLoSGOpKxEy+uNdC0A9zJrf/0t3HumYO
PkxmKfLahlo8neoCRqq+xIcoqNoOYWq3AsJM4Ey3Qg==
=orFe
-----END PGP SIGNATURE-----

--IHdpsbmX366Eh7seRMDsS3KHthjKSo4Uv--
