Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
Date: Fri, 14 Oct 2016 21:09:02 +0200
MIME-Version: 1.0
In-Reply-To: <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3DXaJS7eMcoopiGaQPRM1S5um0bhEAkkF"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3DXaJS7eMcoopiGaQPRM1S5um0bhEAkkF
Content-Type: multipart/mixed; boundary="9qKdGOhx5PL32bAnDdq8X4NPDDDxUDg3i";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <f51484c2-e109-39db-a48a-bc532fe120a8@gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
 <99ce0ba7-430c-f1ab-89cd-15bea87dde22@gmail.com>
 <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>
In-Reply-To: <eac8a00a-f5e3-bf00-44ca-db909883e841@tycho.nsa.gov>

--9qKdGOhx5PL32bAnDdq8X4NPDDDxUDg3i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 09:08 PM, Stephen Smalley wrote:
> On 10/14/2016 02:58 PM, Dominick Grift wrote:
>> On 10/14/2016 08:52 PM, Dominick Grift wrote:
>>> On 10/14/2016 07:40 PM, Stephen Smalley wrote:
>>>> When a non-MLS policy was used with genhomedircon
>>>> context_from_record() in sepol would report an error because an
>>>> MLS level was present when MLS is disabled.  Based on a patch
>>>> by Gary Tierney, amended to use sepol_policydb_mls_enabled
>>>> rather than semanage_mls_enabled because we are testing the
>>>> temporary working policy, not the active policy.
>>>>
>>>> Reported-by: Jason Zaman <jason@perfinion.com> Signed-off-by:
>>>> Stephen Smalley <sds@tycho.nsa.gov> ---=20
>>>> libsemanage/src/genhomedircon.c | 6 +++++- 1 file changed, 5
>>>> insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/libsemanage/src/genhomedircon.c
>>>> b/libsemanage/src/genhomedircon.c index 6991fff..5e9d722
>>>> 100644 --- a/libsemanage/src/genhomedircon.c +++
>>>> b/libsemanage/src/genhomedircon.c @@ -638,7 +638,11 @@ static
>>>> int write_contexts(genhomedircon_settings_t *s, FILE *out, goto
>>>> fail; }
>>>>
>>>> -		if (sepol_context_set_user(sepolh, context, user->sename) <
>>>> 0 || +		if (sepol_context_set_user(sepolh, context,
>>>> user->sename) < 0) { +			goto fail; +		} + +		if
>>>> (sepol_policydb_mls_enabled(s->policydb) &&=20
>>>> sepol_context_set_mls(sepolh, context, user->level) < 0) { goto
>>>> fail; }
>>>>
>>>
>>> I could not get this to work:
>>>
>>> libsemanage.validate_handler: seuser mapping [kcinimod ->
>>> (wheel.id, s0-s0:c0.c1023)] is invalid (No such file or
>>> directory). libsemanage.dbase_llist_iterate: could not iterate
>>> over records (No such file or directory) semodule: failed!
>>>
>>
>> for reference:
>>
>> https://www.youtube.com/watch?v=3DyUAikbw5BSQ
>=20
> Not sure about that, but with this patch, I could successfully do the
> following:
> $ cd refpolicy
> $ make conf
> $ make
> $ sudo make install
> $ sudo make load
>=20
> And genhomedircon ran without complaint, and I have the expected
> entries in file_contexts.homedirs.
> That's with the standard policy.
>=20

Ok thats good enough for me. I admit i just upgraded my systems, and
made major changes to my policy so it may just be me.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--9qKdGOhx5PL32bAnDdq8X4NPDDDxUDg3i--

--3DXaJS7eMcoopiGaQPRM1S5um0bhEAkkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYAS1OAAoJECV0jlU3+UdpyfsL/2xQjZwlugqUwWDtl678sql7
GXVrTeBXrdAUoEGbcBiMCIqDP/1DWYSoYUl+ECdxHc+051JxhFOtlYPmBUl7T62K
cH+YRY8bx3hyARlt1FVbkIlWtB/zmHJ3f7xap3BEqlzqACnMqpBnT5V9/11JmYB5
4U03qzHmx+6Pxm0S7IpQxXeUYM2MQw8BULGdFd8pKu5APEqRQa45NUvzYOPswbAg
NWViKH8YN/ywb3Aevt30kfwwUPepttYWZCJy0gyvDfe+TxWbKurjvC331iSpgGUF
v8ChAiZmCV5VOqNp521k+3intnmj7qv+ufLz/sVJ50cSWDLrrfUwk0EDc7w+nsKL
C8OJZNQ2Vcwjxs+nSdypkQCS9wu5munAjXE9ZWndJdzMVgDMUR3QImehO65hfNTF
syNlH3aND9IzZEeGB0IeIr/qurC9DURw8NJPpxZ5Y/qYlCPNpqczUo23/uT/A5/M
BVuWFLHsctbxWCzScAp9Aq++k4S2uj1nPANjQfIrJw==
=ZFt0
-----END PGP SIGNATURE-----

--3DXaJS7eMcoopiGaQPRM1S5um0bhEAkkF--
