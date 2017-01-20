Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
Date: Fri, 20 Jan 2017 16:29:11 +0100
MIME-Version: 1.0
In-Reply-To: <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PxitJi5pBcE0No2972hBeMvKP1pgMct5D"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxitJi5pBcE0No2972hBeMvKP1pgMct5D
Content-Type: multipart/mixed; boundary="ouh5kpalO30o9pMHcDnMGxbLc3HWhf2ng";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
In-Reply-To: <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>

--ouh5kpalO30o9pMHcDnMGxbLc3HWhf2ng
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 04:16 PM, James Carter wrote:
> On 01/19/2017 04:22 PM, Dominick Grift wrote:
>> On 01/19/2017 06:21 PM, Stephen Smalley wrote:
>>> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>>>
>>>>> Nicolas Iooss discovered that requiring a type in an optional block=

>>>>> after the type has already been declared in another optional block
>>>>> results in a duplicate declaration error.
>>>>>
>>>>
>>>> from what i have been told and from experience, types cannot,
>>>> reliably,
>>>> be declared in optional blocks.
>>>
>>> If true, that is likely a linker issue rather than a checkpolicy issu=
e.
>>> But that would make optionals rather useless if true.
>>
>> Let me present it in a different way then:
>>
>> Should one be able to, reliably, "blockinherit" in optionals?
>>
>> This is the commit in dssp1 where i hit the dead-end with declaring
>> types in optionals:
>>
>> https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c2675=
3e13a91f69411d022e
>>
>>
>> I asked slawrence to have a look at the policy, and he indicated to me=

>> that blocks cannot be inherited in optionals.
>>
>> The compiler accepts it but the policy becomes inconsistent
>>
>=20
> By inconsistent, do you mean that an the binary policy produced is not
> valid, or something else?

I used the word inconsistent because i actually forgot the details (it
has been more than a year since I made this change and I tried hard to
put this behind me, thinking that this was a fundamental limitation
rather than a "bug").

I suspect the following:

Rules end up in the policy but they aren't actually recognized/enforced.

Either the above or:

Rules do *not* end up in the policy even though they are specified.

Maybe slawrence remembers what the issue exactly was (added to recipients=
)

>=20
> Macro definitions are not allowed in optionals, so if you have a macro
> definition in a block, that should cause an error. Other than that, I
> can't think of what would cause problems.

That is mentioned in the secilc documentation. So why does secilc not
disallow inheriting blocks in optionals?

I might be wrong but I believe that i was not actually defining macros
in my blocks back then, and still the behavior was "inconsistent".


>=20
> Jim
>=20
>>>
>>>>
>>>> if the above is true, then the compiler should not allow one to
>>>> declare
>>>> a type in an optional block in the first place
>>>>
>>>>>
>>>>> The following policy will trigger the error.
>>>>>
>>>>> optional {
>>>>>   type T1;
>>>>> }
>>>>>
>>>>> optional {
>>>>>   require { type T1; }
>>>>> }
>>>>>
>>>>> In this case, although symtab_insert() in libsepol properly
>>>>> identifies
>>>>> that the first T1 is a declaration while the second is a require,
>>>>> it
>>>>> will return -2 which is the return value for a duplicate
>>>>> declaration
>>>>> and expect the calling code to properly handle the situation. The
>>>>> caller is require_symbol() in checkpolicy and it checks if the
>>>>> previous
>>>>> declaration is in the current scope. If it is, then the require can=

>>>>> be
>>>>> ignored. It also checks to see if the declaration is a type and the=

>>>>> require an attribute or vice versa which is an error. The problem
>>>>> is
>>>>> that -2 is returned if the declaration is not in scope which is
>>>>> interpreted as a duplicate declaration error.
>>>>>
>>>>> The function should return 1 instead which means that they symbol
>>>>> was not
>>>>> added and needs to be freed later.
>>>>>
>>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>>> ---
>>>>>  checkpolicy/module_compiler.c | 16 +++-------------
>>>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/checkpolicy/module_compiler.c
>>>>> b/checkpolicy/module_compiler.c
>>>>> index 6e5483c..bb60f34 100644
>>>>> --- a/checkpolicy/module_compiler.c
>>>>> +++ b/checkpolicy/module_compiler.c
>>>>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>>>>      } else if (retval =3D=3D -2) {
>>>>>          /* ignore require statements if that symbol was
>>>>>           * previously declared and is in current scope */
>>>>> -        int prev_declaration_ok =3D 0;
>>>>>          if (is_id_in_scope(symbol_type, key)) {
>>>>>              if (symbol_type =3D=3D SYM_TYPES) {
>>>>>                  /* check that previous symbol has
>>>>> same
>>>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>>>                                =20
>>>>>   table, key);
>>>>>                  assert(old_datum !=3D NULL);
>>>>>                  unsigned char old_isattr =3D
>>>>> old_datum->flavor;
>>>>> -                prev_declaration_ok =3D
>>>>> -                    (old_isattr =3D=3D new_isattr ? 1
>>>>> : 0);
>>>>> -            } else {
>>>>> -                prev_declaration_ok =3D 1;
>>>>> +                if (old_isattr !=3D new_isattr)
>>>>> +                    return -2;
>>>>>              }
>>>>> -        }
>>>>> -        if (prev_declaration_ok) {
>>>>>              /* ignore this require statement because
>>>>> it
>>>>>               * was already declared within my scope */
>>>>>              stack_top->require_given =3D 1;
>>>>> -            return 1;
>>>>> -        } else {
>>>>> -            /* previous declaration was not in scope
>>>>> or
>>>>> -             * had a mismatched type/attribute, so
>>>>> -             * generate an error */
>>>>> -            return -2;
>>>>>          }
>>>>> +        return 1;
>>>>>      } else if (retval < 0) {
>>>>>          return -3;
>>>>>      } else {        /* fall through possible if retval
>>>>> is 0 or 1 */
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to Selinux-request@tych=
o
>>>> .nsa.gov.
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


--ouh5kpalO30o9pMHcDnMGxbLc3HWhf2ng--

--PxitJi5pBcE0No2972hBeMvKP1pgMct5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYgizNAAoJECV0jlU3+Udp0gcMALoE9LqtbVT04LH1Mrw4cko5
yVjt5rm4Brp/wqelni4ZaNBwQbnm2BYoG3PSyuMliI6CVBecdTF9HEs9xPqarlps
Wc8fxtmgKLp8HuRsZHqDfknctZXEcGlSVRfXzFyM9VBvJ7PDQCC/p3SXAUtd/+9g
hdwEjSQCqyKp4dVdvIPCSVtCjIcRHPqVgOwdbEWIGeSmi7PGXENqADv69Da47vGc
C1FbcK176OPljbpqK9i33OOiV5peDZH1A5niV9cAKo5C0KFDJzcR/5y1SjvX4zyk
VIO2OoWKSM8WITXBTfV48z6pfUw0j3GsKs0anWQ/1vDP1agNgNXU3rp0qGz9Js3r
MolUHa2rB+sgib2oXCjheDBVoLnZB/zak/+VRYFMkStC256eHNSqO63rLRpLGMCA
eZPJH0ZP8TA0wvMYHINJaaDcHznCFa8QDpEsBn/VIwX9rVBjT4GXbq0uRRrH/HSW
xJ2Ch/pzKVGZa6X0husbez1hivrbA1ykN4j18SNHRA==
=mVw7
-----END PGP SIGNATURE-----

--PxitJi5pBcE0No2972hBeMvKP1pgMct5D--
