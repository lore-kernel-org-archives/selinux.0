Subject: Re: load_policy fails to load policy with ENOENT
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
 <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
Date: Tue, 15 Nov 2016 16:02:36 +0100
MIME-Version: 1.0
In-Reply-To: <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ugk6K6NtoJC5UlkbtMJRvX47mRgbBMV3k"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ugk6K6NtoJC5UlkbtMJRvX47mRgbBMV3k
Content-Type: multipart/mixed; boundary="3JO3A8Fes80aduG4uHRUJEnQdVKRJeQkG";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
Subject: Re: load_policy fails to load policy with ENOENT
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
 <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
In-Reply-To: <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>

--3JO3A8Fes80aduG4uHRUJEnQdVKRJeQkG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2016 03:58 PM, Stephen Smalley wrote:
> On 11/15/2016 07:19 AM, Dominick Grift wrote:
>> I finished porting dssp-base to dssp1-base, however when i try
>> testing it load_policy fails with ENOENT.
>>
>> Even though load_policy returns error status the policy seems to
>> be loaded, except that it is not (or so it seems). When i reboot
>> the system freezes for whatever reason. Whether it is due to
>> systemd refusing due to load_policy failure or anything else i am
>> not sure.
>>
>> I have double checked the policy.
>>
>> 1. secilc has no problems with it 2. the initial sids are declared
>> and ordered 3. the classes are there (and the linux classes are
>> ordered)
>>
>> I cannot think of anything that might cause this and i am looking
>> for suggestions.
>>
>> It is easy to reproduce:
>>
>> 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
>> dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
>> /etc/selinux/targeted/policy/policy.30=20
>> /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
>> /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
>> sestatus, seinfo, ps uaxZ
>>
>> I have also uploaded a demo:
>>
>> https://youtu.be/8NCME9dLZd4
>>
>> Suggestions and help are appreciated
>=20
> Any dmesg output at the time of the failed load?
> What does strace load_policy show?
>=20

write(4, "\214\377|\371\10\0\0\0SE
Linux\36\0\0\0\1\0\0\0\10\0\0\0\7\0\0\0"..., 296645) =3D -1 ENOENT (No
such file or directory)

dmesg shows exactly what it would show on a successful policy load AFAICT=


=46rom dmesg there is no indication that anything went wrong (all the
expected output is there (the stats the unmapped/invalidated contexts.
also sestatus shows that the policy is loaded). It *seems* that only
load policy throws this error. However as i said the system freezes on
boot and i cannot tell whether that is due to systemd, the policy or
load_policy.

following the steps to reproduce will take less than five minutes:

>> 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
>> dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
>> /etc/selinux/targeted/policy/policy.30
>> /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
>> /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
>> sestatus, seinfo, ps uaxZ

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--3JO3A8Fes80aduG4uHRUJEnQdVKRJeQkG--

--Ugk6K6NtoJC5UlkbtMJRvX47mRgbBMV3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYKyOMAAoJECV0jlU3+UdpIK8MAJWDyxUFOirwBMRg6fP5BvK5
3YGH8LQ/cTC3sIarz7ee5Ux2PiLo2mpbq1kPUPZtUj8AB2Nh84vZbSMtsks+MUfR
N75u367+PzK5TLjVVX1fToCf/1N00aEJ/h669tdct3jPNu7FKiU324RT7Ub27uHQ
96L9sFXCi5Jmxmr/9Exd9gRF+/kk1zRIfQ8l4UavrLBhIBkMVh/dfmVV7Gccbb0y
VR5F7EUDUspIMVKr58zoSDb0AFNuupIdhi8bMSgPaQARUP/hI8vLNfvC8WO81zn0
qv575jyfm5aPPHrtowHAu2IexvRa+znPm43bI1PPk7Zv3IEt/sLlSV8ETH0Xudc4
efEf5ktEVhdoJbvvIx1drFlaEci2LlAQV1A4avRrdzT7JhcPSUnYrw5eaNA1aTpP
NmiD6fRnI1C612veOMKOYIxiJuJ5Ihi7Qwp/AMVuaz2IeXfMFyYN1Rt5FMRsVArz
RRbRTDCfdaP5cuPG5KrDOniPSNo6EP+oxCbwmUuGkA==
=Wlcz
-----END PGP SIGNATURE-----

--Ugk6K6NtoJC5UlkbtMJRvX47mRgbBMV3k--
