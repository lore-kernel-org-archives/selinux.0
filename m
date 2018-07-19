Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JHhCbb023560
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 13:43:12 -0400
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>,
 selinux@tycho.nsa.gov
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
Date: Thu, 19 Jul 2018 19:42:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180719165139.GB26209@julius.enp8s0.d30>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qzxiXzHvETII10HTG2SseikN3KuN2MIbu"
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qzxiXzHvETII10HTG2SseikN3KuN2MIbu
Content-Type: multipart/mixed; boundary="d9umagv8a3IgWIdtXRyIqWjPgueA2ZuhT";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>,
 selinux@tycho.nsa.gov
Message-ID: <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
In-Reply-To: <20180719165139.GB26209@julius.enp8s0.d30>

--d9umagv8a3IgWIdtXRyIqWjPgueA2ZuhT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/19/2018 06:51 PM, Dominick Grift via refpolicy wrote:
> On Thu, Jul 19, 2018 at 06:40:25PM +0200, Dominick Grift wrote:
>> On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy w=
rote:
>>> Hi All,
>>>
>>> I found one thing in refpolicy which I don't completely understand.
>>>
>>> In "policy/support/misc_patterns.spt" there is definition of
>>> "domain_transition_pattern" and this contains line:
>>> allow $1 $2:file { getattr open read execute };
>>>
>>> There is missing map permission.
>>>
>>> However in "policy/support/misc_macros.spt" there is definition of
>>> "can_exec" and it contains allow rule:
>>> define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lock=

>>> execute_no_trans };')
>=20
> Sorry can_exec() should just use exec_file_perms which would should be =
mmap_exec_file_perms + execute_no_trans IMHO
>=20
>>
>> This should just use mmap_exec_file_perms
>>

Should we remove lock permission?

>>>
>>> There is a mmap_exec_file_perms which contains:
>>> define(`mmap_exec_file_perms',`{ getattr open map read execute ioctl =
}')
>>>
>>> Map is present in can_exec().
>>>
>>> So for domain transitions we don't allow map permission from calling
>>> domain on binary type but in can_exec macro there is map permission.
>>>
>>> I think this is a bug and in "domain_transition_pattern" there should=
 be
>>> this line:
>>> allow $1 $2:file { getattr open read execute map };
>>
>> This should just use mmap_exec_file_perms as well
>>
>>>
>>> instead of:
>>> allow $1 $2:file { getattr open read execute };
>>>
>>> Am I right or missing something?
>>>
>>> Thanks for help!
>>> Lukas.
>>
>> permission sets provide a single point of failure and should used as m=
uch as possible
>>
>> These were overlooked and because of this we now have a good example w=
hat the purpose of permission sets and patterns is.
>>

Thanks, I'll prepare patch.

Lukas.

>>>
>>> --=20
>>> Lukas Vrabec
>>> Software Engineer, Security Technologies
>>> Red Hat, Inc.
>>>
>>
>>
>>
>>
>>> _______________________________________________
>>> refpolicy mailing list
>>> refpolicy@oss.tresys.com
>>> http://oss.tresys.com/mailman/listinfo/refpolicy
>>
>>
>> --=20
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02=

>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
>> Dominick Grift
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy
>=20


--=20
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--d9umagv8a3IgWIdtXRyIqWjPgueA2ZuhT--

--qzxiXzHvETII10HTG2SseikN3KuN2MIbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAltQzZ0ACgkQRyAaxC8p
zgZN2QgAs+kIFlwpyxDDFYvTtj3V28Srjye6YfokGICumKB0p/19LxVXqoW1QKM+
mB7ng1pr+VjGGoZE2eDig1sVr9M/aPYaJLDfGf2Lrz8IiLnq2fcZyf1oZuQGySOP
IA3FYtD0HkmNc4vPIdxI+7VEaIiycfY5v0ovCH+ggp9lu44bHliLnX6yIBDBtBpt
Ur6iz6a9M1M00CbeLhIpyFZ58xngA4V0q5RKQynkUZKWWolme3YtczgXozHn9BQ4
aqDg6iWNB918pyQ1T2upEOeZDmJ7PA0vxF3lHfm4O1oHuRkcbOCQlOwm6uDLAA23
6rqntI7AKtxytxBZNoArwD1JYMwr1g==
=iQNO
-----END PGP SIGNATURE-----

--qzxiXzHvETII10HTG2SseikN3KuN2MIbu--
