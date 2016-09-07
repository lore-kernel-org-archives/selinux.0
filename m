Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u87ClLbe023550
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 08:47:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id w12so2841877wmf.1
 for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2016 05:47:19 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id q137sm4114915wmd.19.2016.09.07.05.47.17
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Sep 2016 05:47:17 -0700 (PDT)
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
To: selinux@tycho.nsa.gov
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
Date: Wed, 7 Sep 2016 14:47:12 +0200
MIME-Version: 1.0
In-Reply-To: <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sgjIJLLnqXoufBAQ77jknDFJCV7c822ch"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sgjIJLLnqXoufBAQ77jknDFJCV7c822ch
Content-Type: multipart/mixed; boundary="tPCGAsqGPvr9i4SpM1Bwm7KqwXiuSxdcP"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <e596dff5-58cc-a7d6-81b0-f263b44098e4@gmail.com>
Subject: Re: [PATCH] genhomedircon: remove hardcoded refpolicy strings
References: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
 <1473169701-9179-2-git-send-email-gary.tierney@gmx.com>
 <045d3758-8c82-b12a-3cee-f31611161ac6@tycho.nsa.gov>
 <20160907044233.GA3000@home>
 <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>
In-Reply-To: <6550b4ea-b1bf-3b55-0829-a3f683c9170c@tycho.nsa.gov>

--tPCGAsqGPvr9i4SpM1Bwm7KqwXiuSxdcP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/07/2016 02:36 PM, Stephen Smalley wrote:
> On 09/07/2016 12:42 AM, Gary Tierney wrote:
>> On Tue, Sep 06, 2016 at 03:13:17PM -0400, Stephen Smalley wrote:
>>> On 09/06/2016 09:48 AM, Gary Tierney wrote:
>>>> static int seuser_sort_func(const void *arg1, const void
>>>> *arg2) @@ -1074,9 +1130,6 @@ static genhomedircon_user_entry_t=20
>>>> *get_users(genhomedircon_settings_t * s, if (strcmp(name,
>>>> DEFAULT_LOGIN) =3D=3D 0) continue;
>>>>
>>>> -        if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0) -
>>>> continue; -
>>>
>>> This yields a warning/error on Fedora: $ sudo semodule -B=20
>>> libsemanage.add_user: user system_u not in password file
>>>
>>
>> I can re-add this conditional to prevent outputting the warning,
>> though is there a reason for a login named "system_u" ?
>=20
> crond used to require one in order to look up the context for system
> cron jobs; I'm not sure if that is still required, but it is still
> present in Fedora.

https://git.fedorahosted.org/cgit/cronie.git/commit/?id=3De5280235809844f=
54d5956ec281472b63dcfc3f4


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


--tPCGAsqGPvr9i4SpM1Bwm7KqwXiuSxdcP--

--sgjIJLLnqXoufBAQ77jknDFJCV7c822ch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX0AxQAAoJECV0jlU3+Udpn/cL/0/zs86Aly8EvU5bjBDRVA/g
mV6oTNtutDxxHb+DmYWWennsHNfkAR49LskOWJQ+wIeoVA4mbW5NT5fCv5ztZkyC
bwfJS/TTpOyamuNc+VyrQttUn1ZNN/tA8QKg+EDcSh3VaBAWeY8c6XR7m+V5U4pL
OoDDq+MoVyMXpT0E6H0aCeroUbCBWWcMSVWI++XNVWkni+Oa/7/GLB3dkfuu0pFW
YlkrwTeAPPj4cbU2OIXkxhIo93+sJhwK4l5/EJH/vd+dJT89S0Z/4L6j5nlgvlGu
aBzkK4f7q1HX5Uur4HJFcw2PIZaCLp3BE9psaP5kXjv2fCvt3KgzhbZHW8mMvm5j
GCMZtK2hIoCq5EyZv15DvX9Vfl7muIMaCGVeWEac53nmPUOZCBWjng4BXhESSb2p
E0YeeARvBJww4iOIu6v9PRuEKzTHB4/7ezfU5yMadZwno+nfYv/FS4LLICmRhXAW
1QxTjqbbX1uOLGPBfYCbX0u1U1D40cEn3NM0hy8rSA==
=LwRs
-----END PGP SIGNATURE-----

--sgjIJLLnqXoufBAQ77jknDFJCV7c822ch--
