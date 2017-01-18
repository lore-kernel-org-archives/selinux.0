Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0ILZZxq008417
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 16:35:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id r144so7224040wme.0
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 13:35:32 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id l67sm7696961wmf.1.2017.01.18.13.35.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Jan 2017 13:35:30 -0800 (PST)
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
 <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <47c36656-8adf-366a-1f0e-299fc9c91b6f@gmail.com>
Date: Wed, 18 Jan 2017 22:35:25 +0100
MIME-Version: 1.0
In-Reply-To: <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E8HdDP6uCpOpMkps7bt4ugo767FTci09P"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8HdDP6uCpOpMkps7bt4ugo767FTci09P
Content-Type: multipart/mixed; boundary="oVvqtJOVs4Ew9hHIFwQI2dNreuFg5kx5c";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <47c36656-8adf-366a-1f0e-299fc9c91b6f@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
 <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>
In-Reply-To: <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>

--oVvqtJOVs4Ew9hHIFwQI2dNreuFg5kx5c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 10:15 PM, Dominick Grift wrote:
> On 01/18/2017 10:09 PM, James Carter wrote:
>> On 01/18/2017 03:58 PM, Dominick Grift wrote:
>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>> Nicolas Iooss discovered that requiring a type in an optional block
>>>> after the type has already been declared in another optional block
>>>> results in a duplicate declaration error.
>>>>
>>>
>>> from what i have been told and from experience, types cannot, reliabl=
y,
>>> be declared in optional blocks.
>>>
>>> if the above is true, then the compiler should not allow one to decla=
re
>>> a type in an optional block in the first place
>>>
>>
>> Well, this ordering issue reported by Nicolas would definitely cause
>> their declaration to be unreliable. ;)
>>
>> I hope to make declaring types in optional blocks reliable.
>=20
> That would be nice, but just so you know. This was not the issue i was
> encountering with declaring types in optionals. So even though this
> might have made things unreliable. It was not what made it unreliable
> for me.
>=20

Actually, sorry. I do actually recognize the second scenario (duplicate
declaration). So this might in fact be related. I can't believe that
this ancient bug would finally be fixed. Ive been lead to believe that
this was just a fundamental limitation of module policy all this time.
My whole policy was structured on the assumption that types cannot
reliably be declared in optionals....

>>
>> Jim
>>
>>>> The following policy will trigger the error.
>>>>
>>>> optional {
>>>>   type T1;
>>>> }
>>>>
>>>> optional {
>>>>   require { type T1; }
>>>> }
>>>>
>>>> In this case, although symtab_insert() in libsepol properly identifi=
es
>>>> that the first T1 is a declaration while the second is a require, it=

>>>> will return -2 which is the return value for a duplicate declaration=

>>>> and expect the calling code to properly handle the situation. The
>>>> caller is require_symbol() in checkpolicy and it checks if the previ=
ous
>>>> declaration is in the current scope. If it is, then the require can =
be
>>>> ignored. It also checks to see if the declaration is a type and the
>>>> require an attribute or vice versa which is an error. The problem is=

>>>> that -2 is returned if the declaration is not in scope which is
>>>> interpreted as a duplicate declaration error.
>>>>
>>>> The function should return 1 instead which means that they symbol wa=
s
>>>> not
>>>> added and needs to be freed later.
>>>>
>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>> ---
>>>>  checkpolicy/module_compiler.c | 16 +++-------------
>>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/checkpolicy/module_compiler.c
>>>> b/checkpolicy/module_compiler.c
>>>> index 6e5483c..bb60f34 100644
>>>> --- a/checkpolicy/module_compiler.c
>>>> +++ b/checkpolicy/module_compiler.c
>>>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>>>      } else if (retval =3D=3D -2) {
>>>>          /* ignore require statements if that symbol was
>>>>           * previously declared and is in current scope */
>>>> -        int prev_declaration_ok =3D 0;
>>>>          if (is_id_in_scope(symbol_type, key)) {
>>>>              if (symbol_type =3D=3D SYM_TYPES) {
>>>>                  /* check that previous symbol has same
>>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>>                                      table, key);
>>>>                  assert(old_datum !=3D NULL);
>>>>                  unsigned char old_isattr =3D old_datum->flavor;
>>>> -                prev_declaration_ok =3D
>>>> -                    (old_isattr =3D=3D new_isattr ? 1 : 0);
>>>> -            } else {
>>>> -                prev_declaration_ok =3D 1;
>>>> +                if (old_isattr !=3D new_isattr)
>>>> +                    return -2;
>>>>              }
>>>> -        }
>>>> -        if (prev_declaration_ok) {
>>>>              /* ignore this require statement because it
>>>>               * was already declared within my scope */
>>>>              stack_top->require_given =3D 1;
>>>> -            return 1;
>>>> -        } else {
>>>> -            /* previous declaration was not in scope or
>>>> -             * had a mismatched type/attribute, so
>>>> -             * generate an error */
>>>> -            return -2;
>>>>          }
>>>> +        return 1;
>>>>      } else if (retval < 0) {
>>>>          return -3;
>>>>      } else {        /* fall through possible if retval is 0 or 1 */=

>>>>
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--oVvqtJOVs4Ew9hHIFwQI2dNreuFg5kx5c--

--E8HdDP6uCpOpMkps7bt4ugo767FTci09P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYf9+dAAoJECV0jlU3+UdppWQMAI5TIthC8G+JKfLWaCUKD4NW
HTz+TYN5q5+seYjU8u8h8SP3i+BczXF91hgX60th6GC1huJofNyxH43QtV+QTcMt
mGKrWgJKOJ8Sa59ROH7gcAe6hDmDtVgoywhVXk4sm5Y6Lw+XUvaNRx17rWinaYWz
xsfBZDxkMbt0lfF1CTIT4tIaNHY4i7Hm4D0NOt5iuOe3rVr5AEJsDXvR4d2YEwaB
HW23Dj5Wxo2hK6s/B79aAUmN2LoC7EfudVXfoI8QpAfa14LalwAmSf+Po2gkuD+M
SlTTiehElEoW3YzEKlzB94Dcl4XQ65PRDvxH1QZcs0lntEqzdMtjGzKI8YUWr+eK
Q9TLb2jpf0lRmE41SeU0/7QTY3HDxF663iX1xZLUM7SVw9cucI5gkieFoSyjAI7e
ITO/eEQXa4CyNAt585Eq8cyX4lwVJj1kccu8Uu+PKuZBoJ3Kr94/IWJuRpdEEvmH
GeGf/he6A+xG4N7Ai3xu7n8dAUPblVN0GrRO2qxTRA==
=jmSF
-----END PGP SIGNATURE-----

--E8HdDP6uCpOpMkps7bt4ugo767FTci09P--
