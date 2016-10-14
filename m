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
Message-ID: <c0699045-7bef-9bd8-d177-70d1d6e402da@gmail.com>
Date: Fri, 14 Oct 2016 22:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <a8c2f5fa-8a6d-196a-2518-7b33d3979e42@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HXBXOltcGueHEfaQvOJfl6KoTB8Ugeign"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HXBXOltcGueHEfaQvOJfl6KoTB8Ugeign
Content-Type: multipart/mixed; boundary="qlKvWwir9dUR3j6TL6AehB0wJfNpJ9mNp";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: jwcart2@epoch.ncsc.mil
Message-ID: <c0699045-7bef-9bd8-d177-70d1d6e402da@gmail.com>
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

--qlKvWwir9dUR3j6TL6AehB0wJfNpJ9mNp
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

And the other way around? Could the patch above cause things to break
because the seusers arent updated yet?

e.g. switching on the fly from an mls policy to a standard policy.

the seusers need to be processed. could it be that this patch makes it
fail because the seusers havent been processed yet

as you can see here:


 libsemanage.validate_handler: seuser mapping [kcinimod ->
(wheel.id, s0-s0:c0.c1023)] is invalid (No such file or
 directory). libsemanage.dbase_llist_iterate: could not iterate
 over records (No such file or directory) semodule: failed!

it is refereing to my seuser mapping. That mapping is from the initial
mls policy. So it hasnt been processed yet, because if it was then it
would not have mentioned the s0-s0:c0.c1023


> Jim
>=20
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


--qlKvWwir9dUR3j6TL6AehB0wJfNpJ9mNp--

--HXBXOltcGueHEfaQvOJfl6KoTB8Ugeign
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYATlCAAoJECV0jlU3+Udp9iwL/AsYfST5V8DFS/quTcSL5v1m
IgBuctHexUjaDn9Nr0HUdd3qAIrLRqMUMVCNESsXi6VNCPAqfLjClXoZHbp0yc4i
NDicbXu46jGxV1YCx809Xg6/DzVJfwA5nVxZjYFguDwGT7SNhdpM5jxabeDfjF/7
3wUbHzp2W9bpcb3pNo50LousT/K0H7UJmIssrDm8VTR/sUn7ODdMgG9+0wZKHg4j
nT4j+KNYKMslMqb6jPQ3ACuUQu4ydC2GxJXYY7yoNMHX90bNf7pbpeu8O7+vlrCD
Y7+FDAEzPybihMQ0b4ciNVo0FvfFfAbM7xUki4bsbl4879AKFXFeX2xBBszNVuJi
zIHStyxpLQeaG9wXHcJRjaVKsEre9RzsEJsG4HkcZ+jyyBqEt+VxBmoOWiitNv7G
J8sZhhpRXvKvAMxtSDA2hCkk9Vg2uqVkoze2l5Q/wmx9idFFTw0YjktWs7NuA7kS
WWWquJ2dlp4PMPAWhhIMWkWoI/1Z09ZSrWDMg+CwyQ==
=w/V9
-----END PGP SIGNATURE-----

--HXBXOltcGueHEfaQvOJfl6KoTB8Ugeign--
