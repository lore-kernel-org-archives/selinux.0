Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u388PZPo005723
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 04:25:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 672E546E
 for <selinux@tycho.nsa.gov>; Fri,  8 Apr 2016 08:25:32 +0000 (UTC)
Received: from hulk.lan (ovpn-204-100.brq.redhat.com [10.40.204.100])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u388PS4r002196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 04:25:30 -0400
Subject: Re: [PATCH 0/2 v2] Warn if module name different than output filename
To: selinux@tycho.nsa.gov
References: <1460041566-7173-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <57076AF2.6090507@redhat.com>
Date: Fri, 8 Apr 2016 10:25:22 +0200
MIME-Version: 1.0
In-Reply-To: <1460041566-7173-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M4GSXogoPdfJDOA5jWHKx8BlmdWTjgult"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M4GSXogoPdfJDOA5jWHKx8BlmdWTjgult
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/07/2016 05:06 PM, James Carter wrote:
> Since CIL treats files as modules and does not have a separate
> module statement it can cause confusion when a Refpolicy module
> has a name that is not the same as its base filename because older
> SELinux userspaces will refer to the module by its module name while
> a CIL-based userspace will refer to it by its filename.
>=20
> Because of this, provide a warning message when converting a policy
> package to CIL or compiling a module and the output filename is differe=
nt
> than the module name.

Would it be feasible to use a module statement name as a new base name
for CIL module instead of the original base pp filename, and warn users
that the new output filename is different from the original?

It would help to have same installed module names in 'semodule -l' list
in older and current userspace.


>=20
> Changes from v1:
> - Added a "Warning:" prefix
> - Removed checks against the input filename
> - Since there are now only two checks and the base filename is used in =
the
> warning message, it no longer made sense to create common helper functi=
ons
> in libsepol.
>=20
> James Carter (2):
>   policycoreutils/hll/pp: Warn if module name different than output
>     filename
>   checkpolicy: Warn if module name different than output filename
>=20
>  checkpolicy/checkmodule.c   | 15 +++++++++++++++
>  policycoreutils/hll/pp/pp.c | 28 ++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
>=20


--=20
Petr Lautrbach



--M4GSXogoPdfJDOA5jWHKx8BlmdWTjgult
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXB2r3AAoJEGOorUuYLENzf6EP/Avkjn0htWs76h7PxJYEaMZy
E86Lcrahi7L1gJgPDxx0eW8qUQ0AANwaUABdPCIF9+1x5lypAHpBugwtpu9Zl6/l
VnO9XQ5QYjXXtjRI3Xn5Tk7+TYUnXpReCUlcduoEXHRlp5aHw42M1TVa/zu9t/CR
z5wYsAOW0YKT/E8kpW+9slqp0RbL5wptd85WPwJS6tG1PPyWAhOX2N0/aaH/8PIZ
piQUTkodh123DFQkd2VhoAQMAm5diZ2KeUpJ/CWjlqwd3EFkpwxUGkOmRr5M6Rob
kIzzjxpUabhGNUxkiX5lu8niqrGvNbrnnMUWbQLMaoIQC/f9m99QvYFUmPqdlyej
9bvALuOUkEooN3/NsrygHXk3frUc9CyMTs9xWuvitKZ3Fi4/HBFOUF4yB/Jo9lfW
RXyxOuiTn+cRO9lTwq1HEG/4HynF8DT390w5m+OOEUQ3UQl+24VWY5zQj7VcncbI
SKKHMhSPGkDNlZP0XXFzgwBMsGYZp2ohWba/PSdYpz6MSOhsrYzNizZk5KNT4T9Q
0YjqyLppRjePXpT4OngUOzg4SJ8pP6LseaZ/cD7nZTMVhMHBKHl4kh/LEWKrTGVZ
OGQ+Vr83j70TRQAA2pVmxKvUPneLj22yyIsuUFq30m+2cYwIndY8WaXYkjt014tA
4GKfeWa3zEL8sakpym2S
=dnQA
-----END PGP SIGNATURE-----

--M4GSXogoPdfJDOA5jWHKx8BlmdWTjgult--
