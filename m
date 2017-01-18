Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0ILFHKp002472
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 16:15:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id d140so7091417wmd.2
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 13:15:13 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id x135sm7483389wme.23.2017.01.18.13.15.11
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Jan 2017 13:15:11 -0800 (PST)
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>
Date: Wed, 18 Jan 2017 22:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dtI1QBJqj1uGvftS38dDmn5pWHcx151R0"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtI1QBJqj1uGvftS38dDmn5pWHcx151R0
Content-Type: multipart/mixed; boundary="Kv6V4jt0kfHJ3VPwpl8VeuKdEX8xeeFXp";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <be48ba6b-9548-9b72-c60b-d16e4d393b5a@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>
In-Reply-To: <7adea64c-9095-2728-1220-6428260c48a8@tycho.nsa.gov>

--Kv6V4jt0kfHJ3VPwpl8VeuKdEX8xeeFXp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 10:09 PM, James Carter wrote:
> On 01/18/2017 03:58 PM, Dominick Grift wrote:
>> On 01/18/2017 09:53 PM, James Carter wrote:
>>> Nicolas Iooss discovered that requiring a type in an optional block
>>> after the type has already been declared in another optional block
>>> results in a duplicate declaration error.
>>>
>>
>> from what i have been told and from experience, types cannot, reliably=
,
>> be declared in optional blocks.
>>
>> if the above is true, then the compiler should not allow one to declar=
e
>> a type in an optional block in the first place
>>
>=20
> Well, this ordering issue reported by Nicolas would definitely cause
> their declaration to be unreliable. ;)
>=20
> I hope to make declaring types in optional blocks reliable.

That would be nice, but just so you know. This was not the issue i was
encountering with declaring types in optionals. So even though this
might have made things unreliable. It was not what made it unreliable
for me.

>=20
> Jim
>=20
>>> The following policy will trigger the error.
>>>
>>> optional {
>>>   type T1;
>>> }
>>>
>>> optional {
>>>   require { type T1; }
>>> }
>>>
>>> In this case, although symtab_insert() in libsepol properly identifie=
s
>>> that the first T1 is a declaration while the second is a require, it
>>> will return -2 which is the return value for a duplicate declaration
>>> and expect the calling code to properly handle the situation. The
>>> caller is require_symbol() in checkpolicy and it checks if the previo=
us
>>> declaration is in the current scope. If it is, then the require can b=
e
>>> ignored. It also checks to see if the declaration is a type and the
>>> require an attribute or vice versa which is an error. The problem is
>>> that -2 is returned if the declaration is not in scope which is
>>> interpreted as a duplicate declaration error.
>>>
>>> The function should return 1 instead which means that they symbol was=

>>> not
>>> added and needs to be freed later.
>>>
>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>> ---
>>>  checkpolicy/module_compiler.c | 16 +++-------------
>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/checkpolicy/module_compiler.c
>>> b/checkpolicy/module_compiler.c
>>> index 6e5483c..bb60f34 100644
>>> --- a/checkpolicy/module_compiler.c
>>> +++ b/checkpolicy/module_compiler.c
>>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>>      } else if (retval =3D=3D -2) {
>>>          /* ignore require statements if that symbol was
>>>           * previously declared and is in current scope */
>>> -        int prev_declaration_ok =3D 0;
>>>          if (is_id_in_scope(symbol_type, key)) {
>>>              if (symbol_type =3D=3D SYM_TYPES) {
>>>                  /* check that previous symbol has same
>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>                                      table, key);
>>>                  assert(old_datum !=3D NULL);
>>>                  unsigned char old_isattr =3D old_datum->flavor;
>>> -                prev_declaration_ok =3D
>>> -                    (old_isattr =3D=3D new_isattr ? 1 : 0);
>>> -            } else {
>>> -                prev_declaration_ok =3D 1;
>>> +                if (old_isattr !=3D new_isattr)
>>> +                    return -2;
>>>              }
>>> -        }
>>> -        if (prev_declaration_ok) {
>>>              /* ignore this require statement because it
>>>               * was already declared within my scope */
>>>              stack_top->require_given =3D 1;
>>> -            return 1;
>>> -        } else {
>>> -            /* previous declaration was not in scope or
>>> -             * had a mismatched type/attribute, so
>>> -             * generate an error */
>>> -            return -2;
>>>          }
>>> +        return 1;
>>>      } else if (retval < 0) {
>>>          return -3;
>>>      } else {        /* fall through possible if retval is 0 or 1 */
>>>
>>
>>
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


--Kv6V4jt0kfHJ3VPwpl8VeuKdEX8xeeFXp--

--dtI1QBJqj1uGvftS38dDmn5pWHcx151R0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYf9raAAoJECV0jlU3+UdpsesL/jFS5X/2ag4hYZPyaMs9ik6M
eeroimgSEDGRcJwFDewLlAjqcWQ47l6xgyKPUavvUJ7wIGQqCCFmXOeliXTAE4xU
JHPcbMGQsERuKJ2BESBgF4yP+k2oYCkYkjjxSiEBFzVj6QYWqrRPGMm0QiPptGZZ
Ssl/5H8R1kSRTlteLerrBUOvm0c59OpFkieaMDrir51UkGFg3OGZ1Lt2yArvurlv
p94PczGI4KUv5JQFL3T4fxG19+vojAd7lszXeYAZIb2a6ukOzLH1oItceSjxEM9d
gfRJWjTE7pTRtIQoYKLMs4GIdW4lxZvAyIet1/gfpv7L6tfnbawxxh/o3jU/ZJ8T
hyZ//7yuD4UXabmFugaaoyigT6/KxejV4SAbWh7OzTtbkMQL0+a2cX3rov55LUxX
8D6hjTfnQZXATjC0vsXZ1Xw3Ymf1TzV9YJwvH6TOAeVFt12qEdc7/HSvR35tnVKo
zi/LsQQOdbE5Qay/vcBpDBHza8+sI9djLq+xCGgipA==
=VLVe
-----END PGP SIGNATURE-----

--dtI1QBJqj1uGvftS38dDmn5pWHcx151R0--
