Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
 <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
 <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>
Cc: jwcart2@epoch.ncsc.mil
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <0636797a-8bdf-3f02-14a6-3b2ce69a1253@gmail.com>
Date: Fri, 14 Oct 2016 21:26:58 +0200
MIME-Version: 1.0
In-Reply-To: <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4CpAW89tKGpAkULnpD9iXRFGtaJOQFFbE"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4CpAW89tKGpAkULnpD9iXRFGtaJOQFFbE
Content-Type: multipart/mixed; boundary="wgfAW0Fo1a0IjfOTLsNFEsS5mVMC4dBjv";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: jwcart2@epoch.ncsc.mil
Message-ID: <0636797a-8bdf-3f02-14a6-3b2ce69a1253@gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
 <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
 <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>
In-Reply-To: <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>

--wgfAW0Fo1a0IjfOTLsNFEsS5mVMC4dBjv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 09:17 PM, Dominick Grift wrote:
> On 10/14/2016 09:09 PM, Dominick Grift wrote:
>> On 10/14/2016 09:08 PM, Stephen Smalley wrote:
>>> On 10/14/2016 02:58 PM, Dominick Grift wrote:
>>>> On 10/14/2016 08:52 PM, Dominick Grift wrote:
>>>>> On 10/14/2016 07:40 PM, Stephen Smalley wrote:
>>>>>> When a non-MLS policy was used with genhomedircon
>>>>>> context_from_record() in sepol would report an error because an
>>>>>> MLS level was present when MLS is disabled.  Based on a patch
>>>>>> by Gary Tierney, amended to use sepol_policydb_mls_enabled
>>>>>> rather than semanage_mls_enabled because we are testing the
>>>>>> temporary working policy, not the active policy.
>>>>>>
>>>>>> Reported-by: Jason Zaman <jason@perfinion.com> Signed-off-by:
>>>>>> Stephen Smalley <sds@tycho.nsa.gov> ---=20
>>>>>> libsemanage/src/genhomedircon.c | 6 +++++- 1 file changed, 5
>>>>>> insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/libsemanage/src/genhomedircon.c
>>>>>> b/libsemanage/src/genhomedircon.c index 6991fff..5e9d722
>>>>>> 100644 --- a/libsemanage/src/genhomedircon.c +++
>>>>>> b/libsemanage/src/genhomedircon.c @@ -638,7 +638,11 @@ static
>>>>>> int write_contexts(genhomedircon_settings_t *s, FILE *out, goto
>>>>>> fail; }
>>>>>>
>>>>>> -		if (sepol_context_set_user(sepolh, context, user->sename) <
>>>>>> 0 || +		if (sepol_context_set_user(sepolh, context,
>>>>>> user->sename) < 0) { +			goto fail; +		} + +		if
>>>>>> (sepol_policydb_mls_enabled(s->policydb) &&=20
>>>>>> sepol_context_set_mls(sepolh, context, user->level) < 0) { goto
>>>>>> fail; }
>>>>>>
>>>>>
>>>>> I could not get this to work:
>>>>>
>>>>> libsemanage.validate_handler: seuser mapping [kcinimod ->
>>>>> (wheel.id, s0-s0:c0.c1023)] is invalid (No such file or
>>>>> directory). libsemanage.dbase_llist_iterate: could not iterate
>>>>> over records (No such file or directory) semodule: failed!
>>>>>
>>>>
>>>> for reference:
>>>>
>>>> https://www.youtube.com/watch?v=3DyUAikbw5BSQ
>>>
>>> Not sure about that, but with this patch, I could successfully do the=

>>> following:
>>> $ cd refpolicy
>>> $ make conf
>>> $ make
>>> $ sudo make install
>>> $ sudo make load
>>>
>>> And genhomedircon ran without complaint, and I have the expected
>>> entries in file_contexts.homedirs.
>>> That's with the standard policy.
>>>
>>
>> Ok thats good enough for me. I admit i just upgraded my systems, and
>> made major changes to my policy so it may just be me.
>>
>>
>=20
> I might just be wrong though but i think it has to do with how cil
> allows you deal with seusers in policy (defaultselinuxuser and selinuxu=
ser)
>=20
> I think that is where it conflicts. basically i suspect that it hasnt
> dealt with generating the seusers file yet. and so it looks there and
> sees a range in a non mcs policy.
>=20
> So i suspect that this is an issue, its just not a noticable with
> refpolicy becuase refpolicy copies its own seusers file
>=20

I think the CIL people might be able to shed some light on this so CCing
jwcart2

In particular how "selinuxuser and defaultselinuxuser" could affect or
be affected by this patch

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--wgfAW0Fo1a0IjfOTLsNFEsS5mVMC4dBjv--

--4CpAW89tKGpAkULnpD9iXRFGtaJOQFFbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYATGCAAoJECV0jlU3+UdptIIL/2Ha2eUZSe0UQE3z8FkM0DZ4
oi8hZCbq9emUoLCtX8YR3ppohG48HWPUem7+fmN9xR1wzIXd3UewmF/TtoRGJIhr
mVGzi0it3WHLFmxhZvxlPVTDpDbH6uZcyfm7bQ4toE9sa3sagePwHpB+sA0uIHHl
ywpJJSvCBNeApOOfV3Rh8WgtcnSk/hsMhQjg72anctHmyjotAyPqFPjCWsyFXTT2
1tDIiE0iQR8nR/aaIKlbJAjLB1N4QYyk1Ik67GdpKoRA5louoo+No4naNweHIUv/
C6HHdvqJzcyw3L/o/hhzzTHSAU6WTQfkq77e8zEabf90ARS+IN3Rs2as+U2BQNra
D/Ye8J4n/tPiyu3I0TxV31ySDp/KH6kmrpj0JGZmZfhx72TWpFpw8VhxIXj2s+vQ
DJa/PWMoRJdzcxrqWav6ZXVNlXUnihwp1S2wnDOTC18jr95bnY6exVV+5i8Vtsol
yuvEkmTKQJrlJBoubhOjs7FeTi3a51o1iVtiNmD28A==
=j/yN
-----END PGP SIGNATURE-----

--4CpAW89tKGpAkULnpD9iXRFGtaJOQFFbE--
