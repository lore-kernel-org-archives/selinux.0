Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
Date: Thu, 19 Jan 2017 22:22:25 +0100
MIME-Version: 1.0
In-Reply-To: <1484846495.28584.13.camel@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NpuK74odGFHfIenDkbQ8J2tJUk8pN7kOv"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NpuK74odGFHfIenDkbQ8J2tJUk8pN7kOv
Content-Type: multipart/mixed; boundary="rfVnMkhWJKP27fKFB6adPNcK0D0Q3HOjD";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
In-Reply-To: <1484846495.28584.13.camel@tycho.nsa.gov>

--rfVnMkhWJKP27fKFB6adPNcK0D0Q3HOjD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 06:21 PM, Stephen Smalley wrote:
> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>
>>> Nicolas Iooss discovered that requiring a type in an optional block
>>> after the type has already been declared in another optional block
>>> results in a duplicate declaration error.
>>>
>>
>> from what i have been told and from experience, types cannot,
>> reliably,
>> be declared in optional blocks.
>=20
> If true, that is likely a linker issue rather than a checkpolicy issue.=

> But that would make optionals rather useless if true.

Let me present it in a different way then:

Should one be able to, reliably, "blockinherit" in optionals?

This is the commit in dssp1 where i hit the dead-end with declaring
types in optionals:

https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c26753e1=
3a91f69411d022e

I asked slawrence to have a look at the policy, and he indicated to me
that blocks cannot be inherited in optionals.

The compiler accepts it but the policy becomes inconsistent

>=20
>>
>> if the above is true, then the compiler should not allow one to
>> declare
>> a type in an optional block in the first place
>>
>>>
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
>>> In this case, although symtab_insert() in libsepol properly
>>> identifies
>>> that the first T1 is a declaration while the second is a require,
>>> it
>>> will return -2 which is the return value for a duplicate
>>> declaration
>>> and expect the calling code to properly handle the situation. The
>>> caller is require_symbol() in checkpolicy and it checks if the
>>> previous
>>> declaration is in the current scope. If it is, then the require can
>>> be
>>> ignored. It also checks to see if the declaration is a type and the
>>> require an attribute or vice versa which is an error. The problem
>>> is
>>> that -2 is returned if the declaration is not in scope which is
>>> interpreted as a duplicate declaration error.
>>>
>>> The function should return 1 instead which means that they symbol
>>> was not
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
>>>  	} else if (retval =3D=3D -2) {
>>>  		/* ignore require statements if that symbol was
>>>  		 * previously declared and is in current scope */
>>> -		int prev_declaration_ok =3D 0;
>>>  		if (is_id_in_scope(symbol_type, key)) {
>>>  			if (symbol_type =3D=3D SYM_TYPES) {
>>>  				/* check that previous symbol has
>>> same
>>> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>>>  								 =20
>>>   table, key);
>>>  				assert(old_datum !=3D NULL);
>>>  				unsigned char old_isattr =3D
>>> old_datum->flavor;
>>> -				prev_declaration_ok =3D
>>> -				    (old_isattr =3D=3D new_isattr ? 1
>>> : 0);
>>> -			} else {
>>> -				prev_declaration_ok =3D 1;
>>> +				if (old_isattr !=3D new_isattr)
>>> +					return -2;
>>>  			}
>>> -		}
>>> -		if (prev_declaration_ok) {
>>>  			/* ignore this require statement because
>>> it
>>>  			 * was already declared within my scope */
>>>  			stack_top->require_given =3D 1;
>>> -			return 1;
>>> -		} else {
>>> -			/* previous declaration was not in scope
>>> or
>>> -			 * had a mismatched type/attribute, so
>>> -			 * generate an error */
>>> -			return -2;
>>>  		}
>>> +		return 1;
>>>  	} else if (retval < 0) {
>>>  		return -3;
>>>  	} else {		/* fall through possible if retval
>>> is 0 or 1 */
>>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho
>> .nsa.gov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--rfVnMkhWJKP27fKFB6adPNcK0D0Q3HOjD--

--NpuK74odGFHfIenDkbQ8J2tJUk8pN7kOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYgS4WAAoJECV0jlU3+UdphE0MAJznz/bW/WX8OsVVOpJVqlqE
WO9hfO2xX7oVxYmjnRn4NWICkNIi1fC+Qxyod3alBXY9R9EiKv64ZwATn7j4umIV
bMh2qTqX08owyVjF3NpiVoJqiskGpCIN/14WqsHyghIEw38E0IPYRm2Yyv/hWpW3
fZK2hZfKDRTppUWoP7Z/ojRq6O9FFPCbA71aJLFuVphA5YgF6rh4vzFMxfFhOin1
OFafzskoLO5OCTod+GDC3rKLw81TCmTE1ibL1BWCwiYNdR/fF049syxJzevxoCiw
2co75JvS0POvEyrrIem9d/u0I+cKlNpXP7ujPZftclc5IaesHKIJr4A8xWaHWXxs
7oWsXUXT1uCfW5VYN/TDmigO9ZMIusbri3S599RYsI+g7DrOzBAUognfWbwCbw2U
EhTZOtT2z2LyCNlrG0prSZ87B3Gyu3i+A0zwOJtHaImMUNnzrbrfMHckx+4VaxjJ
tDn8ELV+lSyB8fHoYN/jlXI50/GBWT5bsDI/EHGlww==
=fxxD
-----END PGP SIGNATURE-----

--NpuK74odGFHfIenDkbQ8J2tJUk8pN7kOv--
