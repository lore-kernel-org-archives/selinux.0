Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
 <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <419042c4-2677-4ea1-2859-fc9fd8c596c5@gmail.com>
Date: Fri, 20 Jan 2017 16:53:41 +0100
MIME-Version: 1.0
In-Reply-To: <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eOa242w45D81np2MOO9q4WeXCAJdvhChJ"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eOa242w45D81np2MOO9q4WeXCAJdvhChJ
Content-Type: multipart/mixed; boundary="rT5QpQR2XBmcW6DQMkr31mbp9ocwPbqLO";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <419042c4-2677-4ea1-2859-fc9fd8c596c5@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
 <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
In-Reply-To: <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>

--rT5QpQR2XBmcW6DQMkr31mbp9ocwPbqLO
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 04:29 PM, Dominick Grift wrote:
> On 01/20/2017 04:16 PM, James Carter wrote:
>> On 01/19/2017 04:22 PM, Dominick Grift wrote:
>>> On 01/19/2017 06:21 PM, Stephen Smalley wrote:
>>>> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>>>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>>>>
>>>>>> Nicolas Iooss discovered that requiring a type in an optional bloc=
k
>>>>>> after the type has already been declared in another optional block=

>>>>>> results in a duplicate declaration error.
>>>>>>
>>>>>
>>>>> from what i have been told and from experience, types cannot,
>>>>> reliably,
>>>>> be declared in optional blocks.
>>>>
>>>> If true, that is likely a linker issue rather than a checkpolicy iss=
ue.
>>>> But that would make optionals rather useless if true.
>>>
>>> Let me present it in a different way then:
>>>
>>> Should one be able to, reliably, "blockinherit" in optionals?
>>>
>>> This is the commit in dssp1 where i hit the dead-end with declaring
>>> types in optionals:
>>>
>>> https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c267=
53e13a91f69411d022e
>>>
>>>
>>> I asked slawrence to have a look at the policy, and he indicated to m=
e
>>> that blocks cannot be inherited in optionals.
>>>
>>> The compiler accepts it but the policy becomes inconsistent
>>>
>>
>> By inconsistent, do you mean that an the binary policy produced is not=

>> valid, or something else?
>=20
> I used the word inconsistent because i actually forgot the details (it
> has been more than a year since I made this change and I tried hard to
> put this behind me, thinking that this was a fundamental limitation
> rather than a "bug").
>=20
> I suspect the following:
>=20
> Rules end up in the policy but they aren't actually recognized/enforced=
=2E
>=20
> Either the above or:
>=20
> Rules do *not* end up in the policy even though they are specified.
>=20
> Maybe slawrence remembers what the issue exactly was (added to recipien=
ts)
>=20

One thing is for sure, by moving my blockinherits out of the optional
blocks my problems were solved.

secilc did not disallow me to put the blockinherits in optionals, it did
not complain, it just did not give the expected results, and things were
fixed by moving the blocks out of the optionals


>>
>> Macro definitions are not allowed in optionals, so if you have a macro=

>> definition in a block, that should cause an error. Other than that, I
>> can't think of what would cause problems.
>=20
> That is mentioned in the secilc documentation. So why does secilc not
> disallow inheriting blocks in optionals?
>=20
> I might be wrong but I believe that i was not actually defining macros
> in my blocks back then, and still the behavior was "inconsistent".
>=20
>=20
>>
>> Jim
>>
>>>>
>>>>>
>>>>> if the above is true, then the compiler should not allow one to
>>>>> declare
>>>>> a type in an optional block in the first place
>>>>>
>>>>>>
>>>>>> The following policy will trigger the error.
>>>>>>
>>>>>> optional {
>>>>>>   type T1;
>>>>>> }
>>>>>>
>>>>>> optional {
>>>>>>   require { type T1; }
>>>>>> }
>>>>>>
>>>>>> In this case, although symtab_insert() in libsepol properly
>>>>>> identifies
>>>>>> that the first T1 is a declaration while the second is a require,
>>>>>> it
>>>>>> will return -2 which is the return value for a duplicate
>>>>>> declaration
>>>>>> and expect the calling code to properly handle the situation. The
>>>>>> caller is require_symbol() in checkpolicy and it checks if the
>>>>>> previous
>>>>>> declaration is in the current scope. If it is, then the require ca=
n
>>>>>> be
>>>>>> ignored. It also checks to see if the declaration is a type and th=
e
>>>>>> require an attribute or vice versa which is an error. The problem
>>>>>> is
>>>>>> that -2 is returned if the declaration is not in scope which is
>>>>>> interpreted as a duplicate declaration error.
>>>>>>
>>>>>> The function should return 1 instead which means that they symbol
>>>>>> was not
>>>>>> added and needs to be freed later.
>>>>>>
>>>>>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>>>>> ---
>>>>>>  checkpolicy/module_compiler.c | 16 +++-------------
>>>>>>  1 file changed, 3 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/checkpolicy/module_compiler.c
>>>>>> b/checkpolicy/module_compiler.c
>>>>>> index 6e5483c..bb60f34 100644
>>>>>> --- a/checkpolicy/module_compiler.c
>>>>>> +++ b/checkpolicy/module_compiler.c
>>>>>> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>>>>>>      } else if (retval =3D=3D -2) {
>>>>>>          /* ignore require statements if that symbol was
>>>>>>           * previously declared and is in current scope */
>>>>>> -        int prev_declaration_ok =3D 0;
>>>>>>          if (is_id_in_scope(symbol_type, key)) {
>>>>>>              if (symbol_type =3D=3D SYM_TYPES) {
>>>>>>                  /* check that previous symbol has
>>>>>> same
>>>>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>>>>                                =20
>>>>>>   table, key);
>>>>>>                  assert(old_datum !=3D NULL);
>>>>>>                  unsigned char old_isattr =3D
>>>>>> old_datum->flavor;
>>>>>> -                prev_declaration_ok =3D
>>>>>> -                    (old_isattr =3D=3D new_isattr ? 1
>>>>>> : 0);
>>>>>> -            } else {
>>>>>> -                prev_declaration_ok =3D 1;
>>>>>> +                if (old_isattr !=3D new_isattr)
>>>>>> +                    return -2;
>>>>>>              }
>>>>>> -        }
>>>>>> -        if (prev_declaration_ok) {
>>>>>>              /* ignore this require statement because
>>>>>> it
>>>>>>               * was already declared within my scope */
>>>>>>              stack_top->require_given =3D 1;
>>>>>> -            return 1;
>>>>>> -        } else {
>>>>>> -            /* previous declaration was not in scope
>>>>>> or
>>>>>> -             * had a mismatched type/attribute, so
>>>>>> -             * generate an error */
>>>>>> -            return -2;
>>>>>>          }
>>>>>> +        return 1;
>>>>>>      } else if (retval < 0) {
>>>>>>          return -3;
>>>>>>      } else {        /* fall through possible if retval
>>>>>> is 0 or 1 */
>>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Selinux mailing list
>>>>> Selinux@tycho.nsa.gov
>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>> To get help, send an email containing "help" to Selinux-request@tyc=
ho
>>>>> .nsa.gov.
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


--rT5QpQR2XBmcW6DQMkr31mbp9ocwPbqLO--

--eOa242w45D81np2MOO9q4WeXCAJdvhChJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYgjKFAAoJECV0jlU3+Udpy4YL/0dUR0e4W1QgZavLJM687qdR
Pk9wUhQ2EEWqFVnet0v2fH0I01eTgGhypT/9jkEYRychMBcI4KiCB1BdYaOFKksL
nHqYDyRBIepsEXB9ui/3rg3sQl1wjHz3yxbcBEriTtcUhP2ypYRqUnp0iPJqqJWo
9NOcHAfTddXfpvSt47inilT9+8tn/bxJ9PIfxF5DvQ0sBcPjFRSYxyXjAWFXP29c
xoGkYCzEnl2bl+NdOUrmWNsNlD44RiTaEM/8Yvvgl55THpnbw68R7gfbDSiD7Jdp
F6PQjLbkcxdnYc9sF5AhyLViquvjyAh7+QOznvFvwYJByAzw0vacH1a1hwCRfwmp
GNXARrRwxJjrLRCldmuvolAK8Zs9/WDZ8bfigtJ6kZJDy059dMy3RFYXQ1RfJRaf
6hxwAqznC4yGl4KpW9kHzad25vjvIES7bl89cTRdRoZbFuAWiA3NhuvPaJycmINH
Gdff1Mtmy+rVH9gt5JtNdRabNNP2BX6GW40Nf2j+KA==
=j80o
-----END PGP SIGNATURE-----

--eOa242w45D81np2MOO9q4WeXCAJdvhChJ--
