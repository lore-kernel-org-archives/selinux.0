Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
 <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
 <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>
 <0636797a-8bdf-3f02-14a6-3b2ce69a1253@gmail.com>
 <a8c2f5fa-8a6d-196a-2518-7b33d3979e42@tycho.nsa.gov>
Cc: jwcart2@epoch.ncsc.mil
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <5a7649ee-ef5e-afad-1291-e246ee916853@gmail.com>
Date: Sat, 15 Oct 2016 10:17:48 +0200
MIME-Version: 1.0
In-Reply-To: <a8c2f5fa-8a6d-196a-2518-7b33d3979e42@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kax55IVwiDxrKj3QDF5RO37af3qopPu9s"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kax55IVwiDxrKj3QDF5RO37af3qopPu9s
Content-Type: multipart/mixed; boundary="C5BeEs9tNOTLV5CQOLvqReh8PFan4Uq0d";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: jwcart2@epoch.ncsc.mil
Message-ID: <5a7649ee-ef5e-afad-1291-e246ee916853@gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
 <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
 <3540f86a-ddd6-6be0-a02e-a642cd01c951@gmail.com>
 <0636797a-8bdf-3f02-14a6-3b2ce69a1253@gmail.com>
 <a8c2f5fa-8a6d-196a-2518-7b33d3979e42@tycho.nsa.gov>
In-Reply-To: <a8c2f5fa-8a6d-196a-2518-7b33d3979e42@tycho.nsa.gov>

--C5BeEs9tNOTLV5CQOLvqReh8PFan4Uq0d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 09:54 PM, James Carter wrote:
> On 10/14/2016 03:26 PM, Dominick Grift wrote:
>> On 10/14/2016 09:17 PM, Dominick Grift wrote:
>>> On 10/14/2016 09:09 PM, Dominick Grift wrote:
>>>> On 10/14/2016 09:08 PM, Stephen Smalley wrote:
>>>>> On 10/14/2016 02:58 PM, Dominick Grift wrote:
>>>>>> On 10/14/2016 08:52 PM, Dominick Grift wrote:
>>>>>>> On 10/14/2016 07:40 PM, Stephen Smalley wrote:
>>>>>>>> When a non-MLS policy was used with genhomedircon
>>>>>>>> context_from_record() in sepol would report an error because an
>>>>>>>> MLS level was present when MLS is disabled.  Based on a patch
>>>>>>>> by Gary Tierney, amended to use sepol_policydb_mls_enabled
>>>>>>>> rather than semanage_mls_enabled because we are testing the
>>>>>>>> temporary working policy, not the active policy.
>>>>>>>>
>>>>>>>> Reported-by: Jason Zaman <jason@perfinion.com> Signed-off-by:
>>>>>>>> Stephen Smalley <sds@tycho.nsa.gov> ---
>>>>>>>> libsemanage/src/genhomedircon.c | 6 +++++- 1 file changed, 5
>>>>>>>> insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/libsemanage/src/genhomedircon.c
>>>>>>>> b/libsemanage/src/genhomedircon.c index 6991fff..5e9d722
>>>>>>>> 100644 --- a/libsemanage/src/genhomedircon.c +++
>>>>>>>> b/libsemanage/src/genhomedircon.c @@ -638,7 +638,11 @@ static
>>>>>>>> int write_contexts(genhomedircon_settings_t *s, FILE *out, goto
>>>>>>>> fail; }
>>>>>>>>
>>>>>>>> -        if (sepol_context_set_user(sepolh, context,
>>>>>>>> user->sename) <
>>>>>>>> 0 || +        if (sepol_context_set_user(sepolh, context,
>>>>>>>> user->sename) < 0) { +            goto fail; +        } +
>>>>>>>> +        if
>>>>>>>> (sepol_policydb_mls_enabled(s->policydb) &&
>>>>>>>> sepol_context_set_mls(sepolh, context, user->level) < 0) { goto
>>>>>>>> fail; }
>>>>>>>>
>>>>>>>
>>>>>>> I could not get this to work:
>>>>>>>
>>>>>>> libsemanage.validate_handler: seuser mapping [kcinimod ->
>>>>>>> (wheel.id, s0-s0:c0.c1023)] is invalid (No such file or
>>>>>>> directory). libsemanage.dbase_llist_iterate: could not iterate
>>>>>>> over records (No such file or directory) semodule: failed!
>>>>>>>
>>>>>>
>>>>>> for reference:
>>>>>>
>>>>>> https://www.youtube.com/watch?v=3DyUAikbw5BSQ
>>>>>
>>>>> Not sure about that, but with this patch, I could successfully do t=
he
>>>>> following:
>>>>> $ cd refpolicy
>>>>> $ make conf
>>>>> $ make
>>>>> $ sudo make install
>>>>> $ sudo make load
>>>>>
>>>>> And genhomedircon ran without complaint, and I have the expected
>>>>> entries in file_contexts.homedirs.
>>>>> That's with the standard policy.
>>>>>
>>>>
>>>> Ok thats good enough for me. I admit i just upgraded my systems, and=

>>>> made major changes to my policy so it may just be me.
>>>>
>>>>
>>>
>>> I might just be wrong though but i think it has to do with how cil
>>> allows you deal with seusers in policy (defaultselinuxuser and
>>> selinuxuser)
>>>
>>> I think that is where it conflicts. basically i suspect that it hasnt=

>>> dealt with generating the seusers file yet. and so it looks there and=

>>> sees a range in a non mcs policy.
>>>
>>> So i suspect that this is an issue, its just not a noticable with
>>> refpolicy becuase refpolicy copies its own seusers file
>>>
>>
>> I think the CIL people might be able to shed some light on this so CCi=
ng
>> jwcart2
>>
>> In particular how "selinuxuser and defaultselinuxuser" could affect or=

>> be affected by this patch
>>
>=20
> They won't be effected. cil_selinuxusers_to_string() will only print th=
e
> mls parts if a MLS policy is specified.
>=20
> Jim
>

Thanks. I thought about this and I think i see now what the issue is.
and i suppose i can live with this "limitation"

It is indeed choking on seusers{.local}

if i manually remove /etc/selinux/SELINUXTYPE/seusers and
/var/lib/selinux/SELINUXTYPE/seusers{.local} then it works


The problem is that i am switching model without switching SELINUXTYPE.
libsemanage can't deal with that and I suppose there never was a need
for this because It never was possible to switch models with semodule alo=
ne

So on the one hand the patch above works, but on the other hand it
raises the question about whether libsemanage should support switching
modules without switcing SELINUXTYPE.


>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--C5BeEs9tNOTLV5CQOLvqReh8PFan4Uq0d--

--kax55IVwiDxrKj3QDF5RO37af3qopPu9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYAeYxAAoJECV0jlU3+UdpjcMMALwi2+ECVT4cTiP6HB3bF3rP
2x8dZ2RhGyGSGQxLCIWIAHyIxv6H2PPOUR4vwA2jPDS4rg/2Ae3Ubca9wRZYfQrg
EVBlYtq5njzuigHKBgaVjMriQUttwHqtw/mMFemwE3FUZ8MFv4Afe5qTx3lWsdsA
41ZX1BqS4CdzWIycRAZ08lsroGfni9MZIslubQt/jqR9WpYPV4k7bCnFTkLTMBXN
oexFIDBJPTCKau3hm8JQ321bb4OSq+2M4hngvKTeimSyY4gm5WP8yg2QxuHphd61
yccZ6RUle1bE5UrzUGtX0k1vH+zgl6QwNRruyq8Je4P3xC10T8dQBKo2pgfwgl7k
Lo92/CcPtC1CfMYFgREogXmIb78U0p/YMfLhWJ46cmASL0VtakzZJW4g7FFo6l8b
YlxONIUIAyFKJYasL0pj8kmZsfXhHlW7j0XN2rSQUO6lGQKArv/5cq6dq43prnSo
o2JR7RT4zlYorXhM0vunnKGIUUAd380R0EOrpJUgjw==
=Vt2U
-----END PGP SIGNATURE-----

--kax55IVwiDxrKj3QDF5RO37af3qopPu9s--
