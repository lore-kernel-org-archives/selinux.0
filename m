Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8O8QOUD003879
 for <selinux@tycho.nsa.gov>; Sat, 24 Sep 2016 04:26:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so6001443wma.3
 for <selinux@tycho.nsa.gov>; Sat, 24 Sep 2016 01:26:17 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id p13sm6956376wmd.1.2016.09.24.01.26.15
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Sep 2016 01:26:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
To: selinux@tycho.nsa.gov
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <52a12ae5-ccbf-2545-1525-011d2c768c54@gmail.com>
Date: Sat, 24 Sep 2016 10:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vFKDlpvwIKScgAP9jN8VQ141AIu9fGJfg"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vFKDlpvwIKScgAP9jN8VQ141AIu9fGJfg
Content-Type: multipart/mixed; boundary="iDAXjcBQekNgGgOes9FTUQQkxqIICcw6G";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <52a12ae5-ccbf-2545-1525-011d2c768c54@gmail.com>
Subject: Re: [PATCH 1/1] genhomedircon: support policies using RBACSEP
References: <cover.1474639773.git.gary.tierney@gmx.com>
 <1062ebe32922aec79a0232acfdd0005e9ce124da.1474639773.git.gary.tierney@gmx.com>
 <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>
In-Reply-To: <7be4daef-ca03-da40-0fb0-79bf39e3ce18@tycho.nsa.gov>

--iDAXjcBQekNgGgOes9FTUQQkxqIICcw6G
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/23/2016 09:36 PM, Stephen Smalley wrote:
> On 09/23/2016 10:28 AM, Gary Tierney wrote:
>> Introduces support for generating homedir/user contexts for policies
>> that implement RBACSEP.  The support works by taking the prefix of a
>> logins seuser and replacing the role field in their context
>> specifications with the prefix.  A new option "genhomedircon-rbacsep"
>> was added to /etc/selinux/semanage.conf to allow toggling this behavio=
r.
>=20
> The user prefix was previously used as a prefix for types, e.g. you
> could have:
> HOME_DIR/\.gnupg(/.+)?  system_u:object_r:ROLE_gpg_secret_t
> and get it replaced with:
> /home/[^/]+/\.gnupg(/.+)?       system_u:object_r:user_gpg_secret_t
> /root/\.gnupg(/.+)?             system_u:object_r:sysadm_gpg_secret_t
>=20
> So I guess you could use it for the role field too, but for consistency=

> you would want it to be:
> HOME_DIR/\.gnupg(/.+)?  system_u:ROLE_r:ROLE_gpg_secret_t
>=20
> and the prefix would still just be "user".

No one is actually using that privsep functionality anymore. Reference
policy removed support for it.

Can we not instead just re-use that code for rbacsep?

The alternative would be to add code similar to the privsep code but
then for rbacsep.

Then we will have the issue that we can't reasonably rely on the
userprefix and prefix statements for rbacsep, because they might be used
for privsep (in theory at least)

I other words if we were to implement rbacsep code similar to the
privsep code, then we would need a new policy statement similar to
userprefix and prefix.

It seems much easier to me to just re-use the privsep code.

rbacsep is the successor to privsep after all.

>=20
>>
>> The user prefix can be set from both standard kernel policy and CIL:
>>
>> CIL:
>>     (user user_u)
>>     (role user_r)
>>     (userrole user_u user_r)
>>     (userprefix user_u user_r)
>>
>> kernel policy language:
>>     role user_r;
>>     user user_u roles { user_r } prefix user_r;
>>
>> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
>> ---
>>  libsemanage/src/conf-parse.y    | 14 +++++++++++++-
>>  libsemanage/src/conf-scan.l     |  1 +
>>  libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
>>  libsemanage/src/semanage_conf.h |  1 +
>>  4 files changed, 44 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhome=
dircon.c
>> index 3fc9e7a..98f9ebd 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -857,7 +866,7 @@ static int setup_fallback_user(genhomedircon_setti=
ngs_t * s)
>>  	int errors =3D 0;
>> =20
>>  	retval =3D semanage_seuser_list(s->h_semanage, &seuser_list, &nseuse=
rs);
>> -	if (retval < 0 || (nseusers < 1)) {
>> +	if (retval < 0 || (nseusers < 2)) {
>=20
> Why did this test change?
>=20
>>  		/* if there are no users, this function can't do any other work */
>>  		return errors;
>>  	}
>> @@ -886,6 +895,17 @@ static int setup_fallback_user(genhomedircon_sett=
ings_t * s)
>>  					level =3D FALLBACK_LEVEL;
>>  			}
>> =20
>> +			if (u && s->h_semanage->conf->genhomedircon_rbacsep &&
>> +			    !semanage_user_has_role(u, prefix)) {
>=20
> I don't think you want to use prefix alone here, since it may be a
> prefix rather than a role name.
>=20
> The kernel policy contains the list of authorized roles for the user, s=
o
> libsepol could export that, but that won't tell you anything about a
> default.
>=20
> libselinux get_default_context() and friends are context-sensitive (the=

> result depends on the caller's context, such that it may differ for
> login vs sshd vs gdm and even among multiple distinct instances of any
> of these, e.g. if they have different levels), so I don't think you can=

> use those.
>=20
> I don't think we presently provide a good way to find this information,=

> which is why we added the user prefix in the first place.  But it is
> intended to be a prefix, not a role.

Adding a rbacsep=3Dy option to semanage.conf might not be the prettiest
solution but it works, plus is that not what semanage.conf is for in the
first place?

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--iDAXjcBQekNgGgOes9FTUQQkxqIICcw6G--

--vFKDlpvwIKScgAP9jN8VQ141AIu9fGJfg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX5jihAAoJECV0jlU3+Udp2ZwL/jPmLfPfl+x+DL9x4h5Qit5V
CET8KfShzfAoVp7u6SDHnRRnlhLQx7pI77T7ic4RpPvZpizH0RTYfQDahMHknj5Z
KO/k+Kayg9wOuxj09aSm9+/Q1SPYbk1CUKGdX5X7fhf/91b0ZeggKCmNa3SthGdA
wbm5kr8M9umHywcHOf27ktt0Tp/sz+OaHHwU4dgNP/3NykqIkSCQnJrbyqDeUpQl
5AW6w2zRkETPgRIxp7hr58K/ossv5QK9sq4R42cuGq344AgajY8YWmxBI5pYNNay
dDB9wKlt9UgNOOaOylphjKeTj4jvv39MsK7Qxkf+2eA3YMZ73Yu5i69aQa/eGW5w
661gSPxOkxWzryHhN4lLn37aL3SSp34sAnLuTkCAm8E0jzKfodVCxEdLwLBIMzdm
MD+6jqcSJ6cLRbhfR3SgbVuzXqQsDjOskOsHVC0fpl6pe3NGdwjsjD3OWANf2Gkc
dhPioGN+hLVTw51N5sW4ZNqx1/QMqnCN5KyFWZT1JA==
=tso8
-----END PGP SIGNATURE-----

--vFKDlpvwIKScgAP9jN8VQ141AIu9fGJfg--
