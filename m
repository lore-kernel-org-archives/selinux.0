Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>
Date: Mon, 14 Nov 2016 11:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ExRtEeht6boveiaNb6JKRQ5ObRHmro3VB"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ExRtEeht6boveiaNb6JKRQ5ObRHmro3VB
Content-Type: multipart/mixed; boundary="9rhK2FEgg9dUkeAEq6Tuuu1cwjoAvQbR8";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>
Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
In-Reply-To: <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>

--9rhK2FEgg9dUkeAEq6Tuuu1cwjoAvQbR8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/09/2016 03:52 PM, James Carter wrote:
> On 11/09/2016 07:40 AM, Dominick Grift wrote:
>> I am in the process of a DSSP rewrite, taking a different approach thi=
s
>> time.
>>
>> However I encountered something that seems suboptimal:
>>
>> SECILC seems to not filter redundant attributes and rules
>>
>> Example i have a type attribute and it has rules associated with it.
>> However, the type attribute is not associated with any types.
>>
>> I was hoping that SECILC would be smart enough to determine that it
>> might as well filter both the type attribute as well as the rules
>> associated with it.
>>
>> To reproduce:
>>
>> git clone https://github.com/DefenSec/dssp1-base.git
>> cd dssp1-base
>> secilc `ls *.cil`
>> sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
>> seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30
>>
>>
>> Am i expecting the impossible by expecting SECILC to be smart enough t=
o
>> determine that something is redundant, and that it can be filtered out=

>> until it becomes applicable?
>>
>>
>=20
> I don't think that it would be too hard to remove attributes that have
> no types associated with them along with rules containing those
> attributes. I have this nagging feeling, though, that there is a reason=

> that we didn't do that. I'll have to think about it a bit.
>=20
> Jim

Have you given this some thought?

I suspect this could have significant impact.

consider the following:

CIL encourages the use of attributes to the fullest extent, and with
dssp1 i have taken this to heart.

This should make dssp1 very scale-able. The more an identifier is used
the greater the potential benefit.

Attributes and templates are at the heart of dssp1 and if the dssp1
model turns out to work (it is still a work in progress and I dont quite
see where this is eventually taking me) then this would be a very
welcome feature.

If you want to see the current state of dssp1:

git clone https://github.com/DefenSec/dssp1-base.git
cd dssp1-base
secilc `ls *.cil`
seinfo policy.30

>=20
>=20
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


--9rhK2FEgg9dUkeAEq6Tuuu1cwjoAvQbR8--

--ExRtEeht6boveiaNb6JKRQ5ObRHmro3VB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYKY3rAAoJECV0jlU3+UdpWkkL+wUZ3MXeKOelBolKiJ8Lqo6Z
BdCbLCSfRAzNUUExzg4jdD4REkoh73deXCqSwu88hjxt75xpTeSgzJP1Vbz+eKL0
wS/HCQbtMLd4RQSJrdiaCZnfQHVJ2g18aOaKCL/TKyXfI7vR4bs70/Sb0wrPjWUE
5gFC4eeuUtFRJD6t2UtX33wziDzVPF37x5uum/8lkmcaJmeeWesjc7BJ9G2pYgCy
mAlQ+yvvcPJm3U0q25JqTl+jv3M2vWU883XAsyN+XTR8kQH+YSO5KQeRkoHmCADT
kKbhj8G0tZSqNBGksIP96Fjz8gVD1jqFY2alPVqG5zTWtGmnO1WuqITITufqQLXW
pJdKYrqimSswNINO7iEzKiwt823TtjvmB4q2LiK9jn6KJQpMKxmAQNsgqifJwJtj
CNCZs6S0ls9BHCo9cShcjDsvK57Xc2Hu/yGS3jKJqvCJ98W6JkzyY9X7q4c2/g5B
bQTstsSHc8elquGeEzJrLcU8YkiUUayfjaGEgiqv7w==
=Fk+4
-----END PGP SIGNATURE-----

--ExRtEeht6boveiaNb6JKRQ5ObRHmro3VB--
