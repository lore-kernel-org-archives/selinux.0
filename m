Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u87CtOPC024487
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 08:55:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id j136so1132370wmj.0
 for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2016 05:55:15 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id f187sm4167011wmf.15.2016.09.07.05.55.11
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Sep 2016 05:55:11 -0700 (PDT)
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
 <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <22e16ed1-cb0c-66f8-593a-c1a24b040091@gmail.com>
Date: Wed, 7 Sep 2016 14:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8WOMaHnpXp1WPcDhqj6QAu5XlSPwVW6E0"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8WOMaHnpXp1WPcDhqj6QAu5XlSPwVW6E0
Content-Type: multipart/mixed; boundary="Uf6rvWThOBfPoh4oVeaJqiKqEFojP0Ktg"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <22e16ed1-cb0c-66f8-593a-c1a24b040091@gmail.com>
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
 <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
In-Reply-To: <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>

--Uf6rvWThOBfPoh4oVeaJqiKqEFojP0Ktg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 02:47 PM, Dominick Grift wrote:
> On 09/07/2016 02:36 PM, Stephen Smalley wrote:
>> On 09/07/2016 12:42 AM, Gary Tierney wrote:
>>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>>> static int seuser_sort_func(const void *arg1, const void
>>>>> *arg2) @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t=20
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
>>
>> crond used to require one in order to look up the context for system
>> cron jobs; I'm not sure if that is still required, but it is still
>> present in Fedora.
>=20
> https://git.fedorahosted.org/cgit/cronie.git/commit/?id=3De528023580984=
4f54d5956ec281472b63dcfc3f4
>=20

Basically crond is always associated with system_u because we now have
systemd to start it. So we no longer have this id issue that we had with
upstart/sysv

>=20
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--Uf6rvWThOBfPoh4oVeaJqiKqEFojP0Ktg--

--8WOMaHnpXp1WPcDhqj6QAu5XlSPwVW6E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX0A4rAAoJECV0jlU3+Udp60QL/3K8GBNruw2Ml85hM8nvBgIn
oALTMDFktBXys5ft9LalWg4boG8xujwUR1tKTDsz5cFbpUFD5L6ApIwasWyu336U
aT9f849cnSRJ7/xr+ckf4Mw8hEr9qxmzMZkWCjolI5ltjTRETJuiR9kbAvDaXimE
GHd4kZ4l3bHUl/X8UrdFl3T2BR44ezDrPQUXrJ4GmEC6ox1WA2r6SlFl8oNG8QiD
RVoB9FHBKPG+HYl+/uiEBDOJ+iUvuDm7toxQ+aP3itWlEbleW9s4YVayL3KQvdh+
SIM7psA+xlAPfn7rP4sRyGpP19MTLQq2gPmoszHGVoL1U3tB2/xeLRZScycuccIw
qN4f7r/WOeR6y2ksT3H+IVUGY6GIZObjhUjrJ8QADxGyonGzuQA2JVgq/Y2jOU4Q
SWxOoMwzpHuEOx68at3B0T/Yq6GGkUn+PEHrxon5od4vNjiWl9yvIh/2pIU7/oq6
WqVvc+6sGSpyKVqLEa2p2xBIaXSRF1M2Evd3g4McIw==
=7O3W
-----END PGP SIGNATURE-----

--8WOMaHnpXp1WPcDhqj6QAu5XlSPwVW6E0--
