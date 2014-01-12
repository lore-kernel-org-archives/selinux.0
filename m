Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0CJgdEc017022
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 14:42:39 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id 27B10261237
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 20:42:36 +0100 (CET)
Date: Sun, 12 Jan 2014 20:42:23 +0100
From: <luis@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Waiting for programs to stop
Message-ID: <20140112204223.707d3b4b@gentp.lnet>
In-Reply-To: <70061389380178@web5j.yandex.ru>
References: <70061389380178@web5j.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/xbi+mE.HNU9h35wmI/YB0re"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/xbi+mE.HNU9h35wmI/YB0re
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2014 20:56:18 +0200
Victor Porton <porton@narod.ru> wrote:

> I remind that we discuss sandboxing of untrusted programs.
>=20
> My application needs to receive a signal when ALL direct and indirect
> children of a process (including this process itself) started in a
> sandbox exit (it should work even when they call setsid()).
>=20
> Can this be done with the current kernel?


This is completely unrelated to SELinux, so please don't discuss it on
this list. Have a look into cgroups ("notify_on_release").


--=20
Luis Ressel <aranea@aixah.de>
GPG fpr: F08D 2AF6 655E 25DE 52BC  E53D 08F5 7F90 3029 B5BD

--Sig_/xbi+mE.HNU9h35wmI/YB0re
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS0vAsXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpT9gQAM/s67aW64yq6y9zoZSlvXbF
QhyROy6em3zRXm6mXon4DPfqvBM7oIz3f/x4OSXCsIvjhDOhDOgtWGPey72hItJJ
GvgtQSMeVggka1JegqLjQFF0fWDHzJ/AGiINxw2ssDifuDCFVXrMJ8kjkeOQ5tO8
7JCPBqGSIHxQUebpYczRIjD6fLtKNAfZaRlEgF95A8WAadvDryxlvR7n+UmI3VPy
8ZPa3RAwzhOH3/3XhjM3lyaQ5Ay38nSjA4+eb9+driVFEMJfsYASLDHlsTzPVFUN
oglsoW2FoA1yzLfW0rV1edk3o4VoRlQc+jVKtKOdqERlhHwcJEH/GO8KQLkUJYZh
5nHnNZ28Yi/UxGezpqKjN9lXHsmCkpax4v508wodpRCrpIHzWMDg66Im6YOb+V4E
cL0UQ3sVxucp7EmPz2jyV1brUCYQaR/LltEOOFmLha7RKuE5adXi8GsMAyIxHAlR
gZTm28EPwgLrTGNWZTXiu00/Bnkt/G797wZJPfF+ENSIklKQ6dWTE6hpYbadnxWB
Q42rCzsZs1Gvyy/6CVM1rwFpYiMuTIiytf1j+x2n9ybC7uhHMAD33xAQLKzwSUpJ
QGLAUXpa4si42iMgPG+C/OLmdcF4No30VwICA7Gyobpn99U81tpL3dc5QIAVmD8P
YvqKZw8VulsLNO6W1BnH
=tpCM
-----END PGP SIGNATURE-----

--Sig_/xbi+mE.HNU9h35wmI/YB0re--
