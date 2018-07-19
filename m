Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JHskgt023713
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 13:54:46 -0400
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>,
 selinux@tycho.nsa.gov
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
 <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
 <20180719174713.GC26209@julius.enp8s0.d30>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <a1d08e17-773d-0234-8b38-d0608384b239@redhat.com>
Date: Thu, 19 Jul 2018 19:54:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180719174713.GC26209@julius.enp8s0.d30>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xhckzBNd19sTo8ZidTkecmqRxVJ3nFxLt"
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhckzBNd19sTo8ZidTkecmqRxVJ3nFxLt
Content-Type: multipart/mixed; boundary="4kq1pZK2AANzQmbosMvLsLpe2d1EPCzAj";
 protected-headers="v1"
From: Lukas Vrabec <lvrabec@redhat.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>,
 selinux@tycho.nsa.gov
Message-ID: <a1d08e17-773d-0234-8b38-d0608384b239@redhat.com>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
 <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
 <20180719174713.GC26209@julius.enp8s0.d30>
In-Reply-To: <20180719174713.GC26209@julius.enp8s0.d30>

--4kq1pZK2AANzQmbosMvLsLpe2d1EPCzAj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/19/2018 07:47 PM, Dominick Grift wrote:
> On Thu, Jul 19, 2018 at 07:42:53PM +0200, Lukas Vrabec via refpolicy wr=
ote:
>> On 07/19/2018 06:51 PM, Dominick Grift via refpolicy wrote:
>>> On Thu, Jul 19, 2018 at 06:40:25PM +0200, Dominick Grift wrote:
>>>> On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy=
 wrote:
>>>>> Hi All,
>>>>>
>>>>> I found one thing in refpolicy which I don't completely understand.=

>>>>>
>>>>> In "policy/support/misc_patterns.spt" there is definition of
>>>>> "domain_transition_pattern" and this contains line:
>>>>> allow $1 $2:file { getattr open read execute };
>>>>>
>>>>> There is missing map permission.
>>>>>
>>>>> However in "policy/support/misc_macros.spt" there is definition of
>>>>> "can_exec" and it contains allow rule:
>>>>> define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lo=
ck
>>>>> execute_no_trans };')
>>>
>>> Sorry can_exec() should just use exec_file_perms which would should b=
e mmap_exec_file_perms + execute_no_trans IMHO
>>>
>>>>
>>>> This should just use mmap_exec_file_perms
>>>>
>>
>> Should we remove lock permission?
>=20
> I would say yes, but i am not sure why it was added in the first place
>=20

It could be dangerous to remove it in such general macro. Let's test it
before.

>>
>>>>>
>>>>> There is a mmap_exec_file_perms which contains:
>>>>> define(`mmap_exec_file_perms',`{ getattr open map read execute ioct=
l }')
>>>>>
>>>>> Map is present in can_exec().
>>>>>
>>>>> So for domain transitions we don't allow map permission from callin=
g
>>>>> domain on binary type but in can_exec macro there is map permission=
=2E
>>>>>
>>>>> I think this is a bug and in "domain_transition_pattern" there shou=
ld be
>>>>> this line:
>>>>> allow $1 $2:file { getattr open read execute map };
>>>>
>>>> This should just use mmap_exec_file_perms as well
>>>>
>>>>>
>>>>> instead of:
>>>>> allow $1 $2:file { getattr open read execute };
>>>>>
>>>>> Am I right or missing something?
>>>>>
>>>>> Thanks for help!
>>>>> Lukas.
>>>>
>>>> permission sets provide a single point of failure and should used as=
 much as possible
>>>>
>>>> These were overlooked and because of this we now have a good example=
 what the purpose of permission sets and patterns is.
>>>>
>>
>> Thanks, I'll prepare patch.
>>
>> Lukas.
>>
>>>>>
>>>>> --=20
>>>>> Lukas Vrabec
>>>>> Software Engineer, Security Technologies
>>>>> Red Hat, Inc.
>>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> _______________________________________________
>>>>> refpolicy mailing list
>>>>> refpolicy@oss.tresys.com
>>>>> http://oss.tresys.com/mailman/listinfo/refpolicy
>>>>
>>>>
>>>> --=20
>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B=
02
>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02
>>>> Dominick Grift
>>>
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> refpolicy mailing list
>>> refpolicy@oss.tresys.com
>>> http://oss.tresys.com/mailman/listinfo/refpolicy
>>>
>>
>>
>> --=20
>> Lukas Vrabec
>> Software Engineer, Security Technologies
>> Red Hat, Inc.
>>
>=20
>=20
>=20
>=20
>> _______________________________________________
>> refpolicy mailing list
>> refpolicy@oss.tresys.com
>> http://oss.tresys.com/mailman/listinfo/refpolicy
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
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.


--4kq1pZK2AANzQmbosMvLsLpe2d1EPCzAj--

--xhckzBNd19sTo8ZidTkecmqRxVJ3nFxLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE3wrP3ArXoyYgAS7LRyAaxC8pzgYFAltQ0E4ACgkQRyAaxC8p
zgYEjwf/eiFEwmkEESBK68GHCwntj440gJxdmNfL7sS46w0Ipe6x2P7Kx3MQem0+
rCqXpKemEmwK4jbfBq75h1KYRH50bgi/lCSJcyBdaQi3JLfj2pKyDS1enXbR2hUZ
9cV1GYJbjUVFN+Jg9fcvXmkDb19eYfa7j57Zd+Aj3QWuMMzrYw0iCT0DTgs02qDZ
o+rkwOLiNqQjf84AiMyUTYgIiaFgho+qIOD1j69QjfKAeBUwj0buacM136f15fQc
HnUO2JreR4Q552czVBnasDMwjMFfwRutNShgDr9fFi9S+mFZn9GMfrwQr/F1SNaq
/4JjqXn8Oa2cW7dEjrUXFB1clIGSxQ==
=Pfjs
-----END PGP SIGNATURE-----

--xhckzBNd19sTo8ZidTkecmqRxVJ3nFxLt--
