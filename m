Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <e2180a23-2942-4aec-b781-eee700f057b4@gmail.com>
Date: Sat, 21 Jan 2017 17:22:43 +0100
MIME-Version: 1.0
In-Reply-To: <1484846495.28584.13.camel@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l9HhuRf5G3TQpi2AFi7D1ha9Ovb85J7FP"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l9HhuRf5G3TQpi2AFi7D1ha9Ovb85J7FP
Content-Type: multipart/mixed; boundary="390VLV8n4obCG6vMLmoIQfSxCMl3sqgib";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <e2180a23-2942-4aec-b781-eee700f057b4@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
In-Reply-To: <1484846495.28584.13.camel@tycho.nsa.gov>

--390VLV8n4obCG6vMLmoIQfSxCMl3sqgib
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
>=20

I beg to differ. optionals would not be useless if they would not allow
declarations IMHO.

In my view it makes little sense to declare anything in an optional.
Optionals are a modularity feature.

So lets look at that. For example the apache_content_template() and how
it is currently used.

For example the git module calls the apache_content_template() in an
optional. So the httpd_git_content_t type is declared if the apache
module is available, and not if it is not available. Same goes for a
bunch of other modules.

But that does not make things all that "modular". Because I cannot have
the git module and the apache module without  the httpd_git_content_t.

What would make more sense if the apache_content_template(git) would be
put in a separate module (example apache_git). Then i could have the git
module , the apache module and not the "apache_git" module. That is
modularity IMHO.


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


--390VLV8n4obCG6vMLmoIQfSxCMl3sqgib--

--l9HhuRf5G3TQpi2AFi7D1ha9Ovb85J7FP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYg4rXAAoJECV0jlU3+UdpAXUL+gMVTdkgaCuHyY8eZe+NuMHn
97EYbs+yVCpiMXtKT3wrslo25FjSeNLikU/naQZXPbgyDfXDtyH63bBcxvSWwg6t
Sx2om1Cutdb+XSypUpvUMv05tygbcBPMUUU7tuPGMCqya6fa6IUaa4sLRiz9ZdkY
UadjX60EwjUHSoWjYgN6wObKFUkIf/Q1+qL82g6j7SskfJfvmobHqZpLgY9SqAFq
96U04lgDFyNYxey63m8oRXHb2Di3hLvgdtKB0aLD8yudjAGTvPShnVFDnlLCSM5T
V6t1ZG7QqN7WTC2pPMHXBBF3JpXfkvJ8YQR8+mbJE6wWcsNL/jOkQz1PIrC7ScOF
kpRvajXr9qbauwMTHZZvt02wcYQ38u2u91Ao9QCY9OxDKA+YTlb6xueGX4Vwi584
MOnd2iG8r0DaAJEu2mchc5xBRYlY+bUeMphFZdX7P4pcHcDFK/Fto/vSNlDRedHm
NEDbC+eVfl2gWITwMP0T5u+MOE23Y9W5jnngdAVGgA==
=A6lg
-----END PGP SIGNATURE-----

--l9HhuRf5G3TQpi2AFi7D1ha9Ovb85J7FP--
