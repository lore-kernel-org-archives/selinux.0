Date: Tue, 6 Dec 2016 21:32:16 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov
Subject: Re: Filtering an avtab in libsepol
Message-ID: <20161206213216.GA6753@home-pc>
References: <20161206170055.GA30914@workstation>
 <a351189a-cf18-0345-ec36-f2978f563c4a@tycho.nsa.gov>
 <f9410858-b9c1-d641-41b6-837c8b42f144@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <f9410858-b9c1-d641-41b6-837c8b42f144@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 01:06:28PM -0500, Stephen Smalley wrote:
>On 12/06/2016 12:53 PM, Stephen Smalley wrote:
>> On 12/06/2016 12:00 PM, Gary Tierney wrote:
>>> Hi,
>>>
>>> I've been working on optimizing out AV rules with no applicable
>>> types as well as unused attributes to trim down the size of a
>>> policy which uses CIL blocks and attributes extensively.  Looking
>>> into the avtab code (and how creating a new avtab is implemented in
>>> expand.c) I have a question:
>>>
>>> Does the following suffice for taking an existing avtab and
>>> creating a new one with all of its elements?  Or do I need to
>>> consider avtab_insert_nonunique() like expand.c does?  If I'm
>>> following the expand_avtab() code correctly, I'd think I'd need to
>>> consider conditional avtabs in the following code:
>>>
>>> static int copy_avtab_map_fn(avtab_key_t *key, avtab_datum_t
>>> *datum, void *args) { avtab_t *avtab =3D (avtab_t *) args;
>>>
>>> return avtab_insert(avtab, key, datum); }
>>>
>>> static int copy_avtab(avtab_t *avtab, avtab_t **out) { avtab_t *tmp
>>> =3D NULL; if (avtab_init(tmp)) { return POLICYDB_ERROR; }
>>>
>>> if (avtab_alloc(tmp, MAX_AVTAB_SIZE)) { return POLICYDB_ERROR; }
>>>
>>> if (avtab_map(avtab, copy_avtab_map_fn, tmp)) { return
>>> POLICYDB_ERROR; }
>>>
>>> *out =3D tmp; return POLICYDB_SUCCESS; }
>>>
>>> Is that the right idea?
>>>
>>> Thanks.
>>
>> Did you consider doing this at the CIL layer instead, given that CIL
>> already does similar optimizations and has more semantic information
>> available?  Note that CIL used to be more aggressive about removing
>> unused attributes but backed off because some attributes are used in
>> neverallows and we want to preserve those for neverallow checking in CTS.
>>
>> Conditional rules can indeed have non-unique entries, and so can
>> xperms rules.
>
>The other thing to remember about the conditional rules is that the
>te_cond_avtab is only used for lookups; the "real" list of conditional
>rules is what is in cond_list, and it is cond_list that is written out
>to the kernel policy file.  So filtering the contents of te_cond_avtab
>won't alter what is written to the kernel policy.
>

I'd skimmed over the write_cond_av_list() code, but wasn't aware that's=20
what was going on.  Thanks for the clarification.  I suppose with that=20
in mind then it is best to just go ahead and make these changes in=20
libsepol/cil where we're dealing with high-level constructs than in the=20
kernel policy writing code.

--=20
Gary Tierney
=20
GPG fingerprint: 412C 0EF9 C305 68E6 B660BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8=
=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBCgAGBQJYRy5aAAoJEHBu12WFqnnYcYkH9iuVFC1tLgl5/dG7f0/oNHJc
J+BRgug4RJZInbxGNob4qXv6uDvtH/MDstuaK0VCQ7DcSbHs/hHctbP2wLju34QP
CMSgzlalnAvNPbQc+4MnIioGNueUfgL31wIjWd0WN1pJqZhu2rBX0S6oO/drFuyI
YuLWlThFl4BudfnQOefQ1IShCgnvWOgt1egYJ9DI/WVp1MgkzVnX/ae5l7EU6WLM
OkqsmWkD8KKKPFnBD8+7qn8M2SQ1fvcE6kDpoezytvEk83kMzeWqMPXal3J3jNAJ
B5/RnRj50c/SW4WyHDFu0P4DdHAu+6RxENNgetsT4HPecMbFmjcncPk+90fuPw==
=yzeY
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
