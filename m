Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JGfHf3013247
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 12:41:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 41WfsK2vppzg46x
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 16:40:53 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 41WfsH5LbNzg47J
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 16:40:51 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id f23-v6so7563425edr.11
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 09:40:28 -0700 (PDT)
Date: Thu, 19 Jul 2018 18:40:25 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180719164025.GA26209@julius.enp8s0.d30>
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy wrote:
> Hi All,
>=20
> I found one thing in refpolicy which I don't completely understand.
>=20
> In "policy/support/misc_patterns.spt" there is definition of
> "domain_transition_pattern" and this contains line:
> allow $1 $2:file { getattr open read execute };
>=20
> There is missing map permission.
>=20
> However in "policy/support/misc_macros.spt" there is definition of
> "can_exec" and it contains allow rule:
> define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lock
> execute_no_trans };')

This should just use mmap_exec_file_perms

>=20
> There is a mmap_exec_file_perms which contains:
> define(`mmap_exec_file_perms',`{ getattr open map read execute ioctl }')
>=20
> Map is present in can_exec().
>=20
> So for domain transitions we don't allow map permission from calling
> domain on binary type but in can_exec macro there is map permission.
>=20
> I think this is a bug and in "domain_transition_pattern" there should be
> this line:
> allow $1 $2:file { getattr open read execute map };

This should just use mmap_exec_file_perms as well

>=20
> instead of:
> allow $1 $2:file { getattr open read execute };
>=20
> Am I right or missing something?
>=20
> Thanks for help!
> Lukas.

permission sets provide a single point of failure and should used as much a=
s possible

These were overlooked and because of this we now have a good example what t=
he purpose of permission sets and patterns is.

>=20
> --=20
> Lukas Vrabec
> Software Engineer, Security Technologies
> Red Hat, Inc.
>=20




> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAltQvvYACgkQJXSOVTf5
R2n4bAwAtGbx32p8fc1TbTgbDZWEv0Sg8+cOuP6zuOzKZhb3XJSfnLVFUB9zgdVr
vaukiC8BXo5FIjNvkVAk5+vYVWtqmc8gty0cxScSicuPzkd2p5V2cOnvFlnNuR4T
4e5P5+ogZSmXJF80yUTQcaA7B2kb4Lf43nURks1xBCyaaivnusaXSiYKw1RCjXKK
eDJgP/5UQnXI4/RFPYH3rRtbwZpV3ljrqDb+LGV2TgyImDYNStn3Ik2MSYjPNQJt
oUCEqTX9NwR5gfyCiQK7tgjO7QA1S+UDZ0TQ2jnJZwXwRQW8yEpOnoXwgcDZWYFZ
7vhqVr8N3WArwfuUOW/QlhFahl2SOJPWoEfylVW6jaZML+ZGG+n/+wF4+fWP1P0D
uLqi1ILMdTudiBwBhJtdpTtyfO0jKgluP9jnvwdoFAQCHbQS06yvQGL2u0ROLsJ+
3EOOULIb/ZqfKpoWzE0VK56Jkeu/zrwugKGgz0VrFCZ/O/s7g7KaYp07NZuESDkE
YbaNm2uZ
=9rjS
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
