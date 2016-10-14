Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
Date: Fri, 14 Oct 2016 20:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nMo82te9VT4qpGI28cRLdx1IlT18FdK7O"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nMo82te9VT4qpGI28cRLdx1IlT18FdK7O
Content-Type: multipart/mixed; boundary="8T4RgNI9jUn06kvDW0WXuadr1qua04hcW";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: gary.tierney@gmx.com
Message-ID: <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
In-Reply-To: <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>

--8T4RgNI9jUn06kvDW0WXuadr1qua04hcW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 08:52 PM, Dominick Grift wrote:
> On 10/14/2016 07:40 PM, Stephen Smalley wrote:
>> When a non-MLS policy was used with genhomedircon context_from_record(=
)
>> in sepol would report an error because an MLS level was present when M=
LS
>> is disabled.  Based on a patch by Gary Tierney, amended to use
>> sepol_policydb_mls_enabled rather than semanage_mls_enabled because
>> we are testing the temporary working policy, not the active policy.
>>
>> Reported-by: Jason Zaman <jason@perfinion.com>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  libsemanage/src/genhomedircon.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhome=
dircon.c
>> index 6991fff..5e9d722 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -638,7 +638,11 @@ static int write_contexts(genhomedircon_settings_=
t *s, FILE *out,
>>  			goto fail;
>>  		}
>> =20
>> -		if (sepol_context_set_user(sepolh, context, user->sename) < 0 ||
>> +		if (sepol_context_set_user(sepolh, context, user->sename) < 0) {
>> +			goto fail;
>> +		}
>> +
>> +		if (sepol_policydb_mls_enabled(s->policydb) &&
>>  		    sepol_context_set_mls(sepolh, context, user->level) < 0) {
>>  			goto fail;
>>  		}
>>
>=20
> I could not get this to work:
>=20
> libsemanage.validate_handler: seuser mapping [kcinimod -> (wheel.id,
> s0-s0:c0.c1023)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No suc=
h
> file or directory)
> semodule: failed!
>=20

for reference:

https://www.youtube.com/watch?v=3DyUAikbw5BSQ

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--8T4RgNI9jUn06kvDW0WXuadr1qua04hcW--

--nMo82te9VT4qpGI28cRLdx1IlT18FdK7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYASq9AAoJECV0jlU3+UdpuiYL/RCiuH7g2kQvgb3zKkNwYFn6
vTOny/dHEJRczExu4bxP5s6aL3cj+JbANrZNv572MWerb1HVQZZlNwvC+ITYfrTG
sf9g0l22vGJAWRoRPovU6cC3NlDc8wFqQa3IY0OlE0hV1IxFIQeAd7bO/NXXfSJD
xrskgrIvX1DsEYx7RhBez+7NMVxa5mtP+KmxIniYbXBbhgp4I48p6hbsAIpzRbcb
/HrQXnZV+crRqMqyvs4+FOwK0wGteFaKzpeYcaaKUmzmnLW1EWgYMMHYeGviqvlH
m3x7Bdflk6r4D2htIVSTc2ZKbxNKWy1xYNgQnvZpz4LeGmIKfIOYawNNNf0nRy8i
dwc6Hpn4CvK6PJ7qChHZNvn4AY4FhpPscFyc9+g7wOUn543wmzhJBA8310x/TEIO
atab46ZVf5qb26zyFt9MlkmYKG2VMzH0Ka9JYsCKrq9Dz8Qvr3JNC3i/OPCkfJSU
lynnhidf27NpEvEVF0Jy7rGxCDASeCIL5D6vCIjPPA==
=cbtK
-----END PGP SIGNATURE-----

--nMo82te9VT4qpGI28cRLdx1IlT18FdK7O--
