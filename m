Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAIENim1008659
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 09:23:44 -0500
Received: by mail-wj0-f170.google.com with SMTP id mp19so1193925wjc.1
 for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2016 06:23:41 -0800 (PST)
Subject: Re: Policy disable error
To: cgzones <cgzones@googlemail.com>, Russell Coker <russell@coker.com.au>
References: <CA+=dQ-_wPGkCzK9EC0tdUbm+CTf2mLo9TY94fVaoJ5hCLR1gKw@mail.gmail.com>
 <20150915120820.GA18065@x250>
 <DC861750-BEA3-4585-AA17-DE55CEBF3995@coker.com.au>
 <CAJ2a_DermncJTrRusfZZU-9ui7V2=QbuCxg3ehGToiNV3OFuPg@mail.gmail.com>
Cc: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <7981205b-07e1-eabf-c331-59af6ecf834e@gmail.com>
Date: Fri, 18 Nov 2016 15:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DermncJTrRusfZZU-9ui7V2=QbuCxg3ehGToiNV3OFuPg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uQjXnxt5o4aq5O4KRGfFq5XNUwPFmXMhI"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uQjXnxt5o4aq5O4KRGfFq5XNUwPFmXMhI
Content-Type: multipart/mixed; boundary="kKNABsxDwpjoTiTPbHAkvD6MJKV9wWssD";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: cgzones <cgzones@googlemail.com>, Russell Coker <russell@coker.com.au>
Cc: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
Message-ID: <7981205b-07e1-eabf-c331-59af6ecf834e@gmail.com>
Subject: Re: Policy disable error
References: <CA+=dQ-_wPGkCzK9EC0tdUbm+CTf2mLo9TY94fVaoJ5hCLR1gKw@mail.gmail.com>
 <20150915120820.GA18065@x250>
 <DC861750-BEA3-4585-AA17-DE55CEBF3995@coker.com.au>
 <CAJ2a_DermncJTrRusfZZU-9ui7V2=QbuCxg3ehGToiNV3OFuPg@mail.gmail.com>
In-Reply-To: <CAJ2a_DermncJTrRusfZZU-9ui7V2=QbuCxg3ehGToiNV3OFuPg@mail.gmail.com>

--kKNABsxDwpjoTiTPbHAkvD6MJKV9wWssD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/18/2016 03:18 PM, cgzones wrote:
> I think the interface apache_content_template in apache.if
> (https://github.com/TresysTechnology/refpolicy-contrib/blob/1fd3562186c=
da3cf90495f0dc820ea59879bde31/apache.if#L14)
> is the root of this problem.
> For example the git module is using this interface, so when loading
> git, apache is also required.
>=20

I believe that the root of this problem is how refpolicy is structured.

the apache_content_template() declares types, and you cannot (properly)
declare types in optional policy.

In other words to fix this issues and other issues related to declaring
types in template that need to be optional, refpolicy would have to be
fundamentally restructured.

> 2016-11-13 10:49 GMT+01:00 Russell Coker <russell@coker.com.au>:
>> That sort of thing is a bug and should be fixed. If it can't be fixed =
then IMHO the Apache module should be linked in base.pp to make it explic=
it that it shouldn't be removed.
>>
>> On 15 September 2015 10:08:21 pm AEST, Dominick Grift <dac.override@gm=
ail.com> wrote:
> On Tue, Sep 15, 2015 at 05:25:58PM +0530, Divya Vyas wrote:
>>>>> Hi,
>>>>>
>>>>> I am getting below error while disabling the apache module policy
>>>>>
>>>>> semodule -d apache
>>>>> libsepol.context_from_record: type httpd_sys_content_t is not defin=
ed
> (No
>>>>> such file or directory).
>>>>> libsepol.context_from_record: could not create context structure
> (Invalid
>>>>> argument).
>>>>> libsemanage.validate_handler: invalid context
>>>>> system_u:object_r:httpd_sys_content_t:s0 specified for htdocs/ [all=

> files]
>>>>> (Invalid argument).
>>>>> libsemanage.dbase_llist_iterate: could not iterate over records
> (Invalid
>>>>> argument).
>>>>> semodule:  Failed!
>=20
> most likely a dependency issue. apache module is notorious for being
> essentially mandatory.
>=20
> You would have to identity all modules that depends on the apache
> module
> and then disable those as well in the same transaction. Be warned that
> those modules in turn may have dependencies of their own.
>=20
> kind of like "dll hell" in a sense
>=20
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>
>> --
>> Sent from my Nexus 6P with K-9 Mail.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--kKNABsxDwpjoTiTPbHAkvD6MJKV9wWssD--

--uQjXnxt5o4aq5O4KRGfFq5XNUwPFmXMhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYLw7lAAoJECV0jlU3+Udp+dkL/1xeiBaysWzcXJWFTpJagOKs
aOxIgQwboWFTbvvWC+ATA7bRvH5GJEBz98fdCp6hkQPuHveVa9+WECEnSn1fBJCR
jt+MDoiLO93t/v3JFUAa9LYPrmyi5OacFGobvFPyJ+KyRsrUeNKRrgVzQ0Sx0DjX
JGlAEkCz+4/qNDmnw6wBzProZfMNYc/iCKkzj3yWESNF6effDjEvOQIYRJXOo1fu
dezgiNyctWrNXzMW+Pm71NAM5HB5TVDykG8ceUfsmG2igGHGfpmYyX+kP5cVW3P1
Kj8mLeRUIWa88pO9cWceFPoJTi+e+c9rN8Hu9Lro/wAUhvZAb5EXpGtdcr6j6+8R
tbKllVpuCQZ4T7oFvL3wsZ41VrhKvBVLrFziuarjaXM1Osur+gQIpIL1ORX+mZri
7Zha+yv/aV/UFnTMGQaQ2aS3UiUkJXVlqC4dHCya4p4qZjFFyEc5BGRpv6qA+NW5
jp5U4IFbxEx0z5JYlwlbTS752AIdwoG3Bkcg7qyBRg==
=D7v4
-----END PGP SIGNATURE-----

--uQjXnxt5o4aq5O4KRGfFq5XNUwPFmXMhI--
