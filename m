Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1CGLr9019746
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 08:16:21 -0400
Received: by mail-wm0-f45.google.com with SMTP id p190so201837723wmp.1
 for <selinux@tycho.nsa.gov>; Tue, 01 Nov 2016 05:16:17 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id ff4sm35288287wjd.39.2016.11.01.05.16.15
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Nov 2016 05:16:16 -0700 (PDT)
Subject: Re: Discussion on setting the /proc/self/oom_score_adj file label.
To: selinux@tycho.nsa.gov
References: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <2291b8f8-57be-91a7-8019-ba60800e8c2d@gmail.com>
Date: Tue, 1 Nov 2016 13:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NOoKKJGQ6HEWRE30uHTNsQjBFlo6jrkIA"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NOoKKJGQ6HEWRE30uHTNsQjBFlo6jrkIA
Content-Type: multipart/mixed; boundary="5sGMx1grRR9UuSHGRvDhS3AITehR1nM7e";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <2291b8f8-57be-91a7-8019-ba60800e8c2d@gmail.com>
Subject: Re: Discussion on setting the /proc/self/oom_score_adj file label.
References: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>
In-Reply-To: <649de230-05ee-5b12-70dd-ac4f64cf9020@redhat.com>

--5sGMx1grRR9UuSHGRvDhS3AITehR1nM7e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/01/2016 12:50 PM, Daniel J Walsh wrote:
> I wrote a blog http://danwalsh.livejournal.com/75282.html which talks
> about chrome sandbox and its attempt to change its parents oom_score_ad=
j
> value.  Which is labeled unconfined_t, the question has come up on
> Twitter to be able to change the label on just this object.
>=20
> I think we discussed this before, but how difficult would it be to
> change individual file labels under /proc/self/?
>=20

In this case the solution would probably be to just associate a private
type with the parent chrome process, but I know you think that is
"impossible".

Regardless I agree that it would be a nice feature. If it was available
then i would probably use it to restrict access to /proc/self/mounts for
my confined user shells if possible.

>=20
>=20
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


--5sGMx1grRR9UuSHGRvDhS3AITehR1nM7e--

--NOoKKJGQ6HEWRE30uHTNsQjBFlo6jrkIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYGIeKAAoJECV0jlU3+UdpBxEL/Rqx7WPgC2CdWH6FfYhvvqLM
UtzTbJZef8VufHez10okCi7KVuBcCvD7yt5Gxrbh4xOsA68wSoE/nW6Z+1Q1eh29
62G8nS5Gd45A46moR6QEHD7Xijh7BN9oNfVPYAQc3OmXPM2RESTZ0O74hWn8Wx9I
MqVIk18VMlujWUg5nUe15lokV/j1v4afOze10TeIPLTCyCHnOdcNHI34//I5taFp
pQutvJnPiazCXVYh9atT6SPyG5Tfhmn0UwHto/GPoCVbgQKxCOZ5LgeSnUrJBOC0
cFoGq4M0D8iGQQ8TUgCioL2BxtXx+pmPHBTAtl+YQhTEewPFR2Xo1EM/WlZ6M8e3
f1/qPnhCRHCsvIHmbLw2YL5oPZf9NYW+8iw+u57SnKjsP+53mxAIaI8FYJiO1E+n
kDL+VacaoUl865srMzuA5FNZt3xNewoXYJDkzGdVRrQYrOQromXztXhoTh774JFv
a73mgJgqkyFq+RAnk7WlfFJUd9vr31kLnby0T4rKsw==
=PuXw
-----END PGP SIGNATURE-----

--NOoKKJGQ6HEWRE30uHTNsQjBFlo6jrkIA--
