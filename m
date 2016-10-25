Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9P5lJCv015359
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 01:47:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id 79so245589wmy.4
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 22:47:15 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id o62sm1566411wmg.9.2016.10.24.22.47.13
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Oct 2016 22:47:13 -0700 (PDT)
Subject: Re: [RFC] Split up policycoreutils
To: selinux@tycho.nsa.gov
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
 <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
 <48da99c2-e674-36c5-68d2-fcd2b9911801@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <55b2b6a8-04fa-5a6b-795b-72d87de60eb4@gmail.com>
Date: Tue, 25 Oct 2016 07:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <48da99c2-e674-36c5-68d2-fcd2b9911801@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bq1u4aEadCo4IDenL5l3R7a6fVnwd0Wc2"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bq1u4aEadCo4IDenL5l3R7a6fVnwd0Wc2
Content-Type: multipart/mixed; boundary="QsaFVG6RaaSXvJ01sMOljgtqW4Vj1InV3";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <55b2b6a8-04fa-5a6b-795b-72d87de60eb4@gmail.com>
Subject: Re: [RFC] Split up policycoreutils
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
 <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
 <48da99c2-e674-36c5-68d2-fcd2b9911801@redhat.com>
In-Reply-To: <48da99c2-e674-36c5-68d2-fcd2b9911801@redhat.com>

--QsaFVG6RaaSXvJ01sMOljgtqW4Vj1InV3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/24/2016 11:15 PM, Daniel J Walsh wrote:
>=20
>=20
> On 10/24/2016 09:21 AM, Stephen Smalley wrote:
>> On 10/24/2016 09:13 AM, Stephen Smalley wrote:
>>> On 10/22/2016 09:44 AM, Chris PeBenito wrote:
>>>> On 10/21/16 13:47, Stephen Smalley wrote:
>>>>> policycoreutils started life as a small set of utilities that were
>>>>> necessary or at least widely used in production on a SELinux system=
=2E
>>>>> Over time though it has grown to include many optional components, =
and
>>>>> even within a given subdirectory (e.g. sepolicy) there seem to be a=

>>>>> number of components that should be optional (e.g. the dbus service=
).
>>>>> I'd like to propose that we move a number of components out of
>>>>> policycoreutils into their own top-level subdirectory (possibly gro=
uping
>>>>> some of the related ones together).
>>>> I'm not sure where the main part of sepolicy should go, but it would=
 be
>>>> nice to split it out since it depends on setools which has heavier
>>>> dependencies than a core system package should typically have IMO
>>>> (NetworkX, which pulls in scipy, numpy, matplotlib, etc.)
>>> I would be in favor of that too, but hesitated to do so because it wo=
uld
>>> require moving audit2allow and semanage out of policycoreutils as wel=
l.
>>> Fedora does package those as part of policycoreutils-python (along wi=
th
>>> sepolgen).  Arguably audit2allow isn't necessary for production (but
>>> many users of SELinux in Linux distributions rely on it), but semanag=
e
>>> is more fundamental these days.
>>>
>>> However, if people are open to moving sepolicy, audit2allow, and
>>> semanage, possibly combining them with sepolgen in a new
>>> subdirectory/package, then we could explore that.
>> We'd also need to move chcat, since it imports seobject.  However, on
>> that topic, is there any reason to retain chcat?  It was created for t=
he
>> original discretionary MCS model and I'm not sure it is used anymore b=
y
>> anyone.
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
>>
>>
> I would suggest we remove it.

I would not mind terribly removing it either but I prefer that we first
see if we can fit this in somewhere else. I do not see this as a core
utility but if someone wants to implement the old MCS model then one
should be able to do so.

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


--QsaFVG6RaaSXvJ01sMOljgtqW4Vj1InV3--

--Bq1u4aEadCo4IDenL5l3R7a6fVnwd0Wc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYDvHbAAoJECV0jlU3+UdpbfwMAJ7rO1aqD6xbbgtSnU4sSlkU
RriCZSQu9wWpTljoR2dxBOQNLYvyeTzuXuS620/XaYCub9dE6CRpOV3cMWhLGXGj
QWsuPC3jjPsyn2dyThJ4KxoNGsmFtXw06ZZiVcJlUO3gHIhryNnA2IutH2Sn4FRc
jdTfZwBAWi1P+4pF0xKKHRcX4k3F3ja+FcYw1vb8zQtrsWXJ9JirNLwnfUD+xVry
RogWYMCB5PWT1jY6YXaG6ug7hQr4h6lYc51phAGuz5y3fZs2aIOlHSpt/w5NPTw2
WENXc51R5aEsfvps9EWuYUSlDxdTgKic+nkdTsBz7FGsiPVnbbFo7vSdLzKGlO5Z
PP06vm1ZXBB5OH2FUjBo96hanXzh1z1qilXbTJgEYPDMK7MLXfem0FlXgHxWd7qi
TXvD9HE6RatxTbRPDdGGsnR7sBg3JSLSHBi0AiPiisBhXi/9gqmj2ff335GQ/fZg
Qu4Mh/82Anig5PWjt1FhGsP35M4aD2AzRsFylB2ugQ==
=GKqu
-----END PGP SIGNATURE-----

--Bq1u4aEadCo4IDenL5l3R7a6fVnwd0Wc2--
