Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
 <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
 <b1501c8b-2258-0ea3-36e9-a4d5acacb7bf@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <a0ce6bbe-5daf-0cea-f4ba-d0d7a3c6d63a@gmail.com>
Date: Wed, 7 Sep 2016 15:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <b1501c8b-2258-0ea3-36e9-a4d5acacb7bf@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hCBsfGic7NR1EAflMAbloRRMKex8u1UMx"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hCBsfGic7NR1EAflMAbloRRMKex8u1UMx
Content-Type: multipart/mixed; boundary="iIavHgaeQfr83W4CxT4lVsgVkPoCgsFx6"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <a0ce6bbe-5daf-0cea-f4ba-d0d7a3c6d63a@gmail.com>
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
 <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
 <b1501c8b-2258-0ea3-36e9-a4d5acacb7bf@tycho.nsa.gov>
In-Reply-To: <b1501c8b-2258-0ea3-36e9-a4d5acacb7bf@tycho.nsa.gov>

--iIavHgaeQfr83W4CxT4lVsgVkPoCgsFx6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 03:00 PM, Stephen Smalley wrote:
> On 09/07/2016 08:47 AM, Dominick Grift wrote:
>> On 09/07/2016 02:36 PM, Stephen Smalley wrote:
>>> On 09/07/2016 12:42 AM, Gary Tierney wrote:
>>>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley
>>>> wrote:
>>>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>>>> static int seuser_sort_func(const void *arg1, const void=20
>>>>>> *arg2) @@ -1074,9 +1130,6 @@ static
>>>>>> genhomedircon_user_entry_t=20
>>>>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name,=20
>>>>>> DEFAULT_LOGIN) =3D=3D 0) continue;
>>>>>>
>>>>>> -        if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0) -=20
>>>>>> continue; -
>>>>>
>>>>> This yields a warning/error on Fedora: $ sudo semodule -B=20
>>>>> libsemanage.add_user: user system_u not in password file
>>>>>
>>>>
>>>> I can re-add this conditional to prevent outputting the
>>>> warning, though is there a reason for a login named "system_u"
>>>> ?
>>>
>>> crond used to require one in order to look up the context for
>>> system cron jobs; I'm not sure if that is still required, but it
>>> is still present in Fedora.
>>
>> https://git.fedorahosted.org/cgit/cronie.git/commit/?id=3De52802358098=
44f54d5956ec281472b63dcfc3f4
>=20
> Ok,
>>
> so maybe someone should file a bug on policy to remove system_u
> from seusers?  After first testing that it doesn't break anything.
>=20
>=20
>=20

https://github.com/DefenSec/dssp/commit/08b73d7c79945bec0307aec76c04fccda=
9e336a6


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--iIavHgaeQfr83W4CxT4lVsgVkPoCgsFx6--

--hCBsfGic7NR1EAflMAbloRRMKex8u1UMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX0BBvAAoJECV0jlU3+UdpQcQL/RF5VatFyUzJpQGlviKjs39q
X7HxGWxc08TtrLRGAYS75WTogR0NInOjUZfqQtqjv/c078STGIDXtHL/upHK7ytj
HaXBc0kpdoYjpa2gabBy7HfE49kfMore7y6eO+XrIc5ZZJ31YVTzC6vdABuZBb64
u9Cjp+ZvRULzx48GL0IKutfi31rfpZQsfuVESadsIIx4QyArtGhRgFEwaPrDVfY3
s0Nm1/rlQn/Qd1Y1Ww/Z0SrDHL6dnaV6hKzq9rZ6talrbcwO26aXAHguP+4IcNOQ
fteyF3w/NerFl8avGPorT51uf3C0/2LtRqWn0ciwt3HpObj33U0SCV5q61BYqhhQ
Fu52p+u4Pm0GzvjnAu1vfbB9w7M5kc99cX8dWw/j/DxcLUwcrb+PggwHj6AfI0tA
RFgw/VhNFbDMfTBSzgwjzrmd4Qu96S8Q2GpWCptm2fZpfULuvOc+Wyt/uJ0ivvb/
ENdjyOVso090cUnymCIuLsnfuyFBT/0/emdf83FNZg==
=n62J
-----END PGP SIGNATURE-----

--hCBsfGic7NR1EAflMAbloRRMKex8u1UMx--
