Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home> <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
 <994efc50-c8c2-f7b3-41d3-85286114f3d7@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <a6313548-2538-86c5-874a-6099bd808797@gmail.com>
Date: Wed, 7 Sep 2016 14:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <994efc50-c8c2-f7b3-41d3-85286114f3d7@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ARfTI8HiAxLsqgE0rNsKAp1X1E5Q1npiS"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARfTI8HiAxLsqgE0rNsKAp1X1E5Q1npiS
Content-Type: multipart/mixed; boundary="jedkBsB0RqmsqXSuxuab5VsI8MOSX6xv4"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <a6313548-2538-86c5-874a-6099bd808797@gmail.com>
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home> <d6692a63-fd95-86f1-7ec9-641bab44efef@gmail.com>
 <994efc50-c8c2-f7b3-41d3-85286114f3d7@tycho.nsa.gov>
In-Reply-To: <994efc50-c8c2-f7b3-41d3-85286114f3d7@tycho.nsa.gov>

--jedkBsB0RqmsqXSuxuab5VsI8MOSX6xv4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 02:45 PM, Stephen Smalley wrote:
> On 09/07/2016 03:15 AM, Dominick Grift wrote:
>> On 09/07/2016 06:42 AM, Gary Tierney wrote:
>>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>>> @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t=20
>>>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name,
>>>>> DEFAULT_LOGIN) =3D=3D 0) continue;
>>>>>
>>>>> -        if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0) -
>>>>> continue; -
>>>>
>>>> This yields a warning/error on Fedora: $ sudo semodule -B=20
>>>> libsemanage.add_user: user system_u not in password file
>>>>
>>>
>>> I can re-add this conditional to prevent outputting the warning,
>>> though is there a reason for a login named "system_u" ?
>>>
>>
>> Is that warning really useful in the first place though? My
>> requirement to create a gdm selinux id also causes these messages
>> for user gdm when ever semodule -B is run on systems that do not
>> have the gdm user.
>=20
> Why do you need a gdm selinux id?
>=20

PAM related

Because systemd spawns a --user instance for gdm and that in turn runs a
gdm --session bus.

In order to run the gdm --session bus in gdm.subj this was needed.

Basically gdm is sort of treated as a real user in some ways. E.g. It
has a /run/user/42 and it has a systemd --user instance


>> Can we not just print that message only when semodule is run with
>> -v instead?
>=20
> Presently -v only affects output from semodule itself; it isn't
> propagated to libsemanage in any way.  And libsemanage logging only
> defines three levels presently: error, warning, info.  So we don't
> presently have the support for making a libsemanage log message
> verbose-only, even if we wanted to do so.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--jedkBsB0RqmsqXSuxuab5VsI8MOSX6xv4--

--ARfTI8HiAxLsqgE0rNsKAp1X1E5Q1npiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX0Av/AAoJECV0jlU3+UdpQ4wL/3WmnbnESvEX/HixT3nfTHYn
WJmeJ7jRPBU9genUc3zneDgD+KUVhrpxDqJsCIhAj0JYaVyUe7XZ3IPL8e0w+teO
gqKCqjKCA25VpAvtGsozajTrmOkDiSLRiJ5onybL4sPjRFDJyN+FZZsrq7D8UDSW
TdUQOIiOLx7lyzAqqlVumJ7cswqlCYYlIiJsGtpJ3rI4Oedj4rPyW4AIGSBYDMR2
nFfLJtqDZvfC91uwmwMCW6aUY6yyLs1zWCySz/iRBHcRbfjlxApeeqYrgA9kb3Ru
hzoYTW22Ii8gmdNDJH6bBomroy2QdWUBHPwx753M2BtCpC54xKltPYAF29hpni8X
ULhkHCvwjrpnnE2HetSQ4jMLQkLumu+Fnl22iiv8FqXSflCtUVxX/1buckCMiTgS
SxvA1Ri8vhwZQwT+BElPmQlATnldZCcY/w/qeY4DMwKJqjR/SM2gsSDVQN7JT5C3
4EHjFMlWv9lZEpMmizC7LckbjyYdh9czrHzFqVEuAg==
=CLJY
-----END PGP SIGNATURE-----

--ARfTI8HiAxLsqgE0rNsKAp1X1E5Q1npiS--
