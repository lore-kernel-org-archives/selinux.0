Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0CH4nkF012381
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 12:04:49 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id 8C74A26B9CF
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 18:04:45 +0100 (CET)
Date: Sun, 12 Jan 2014 18:04:30 +0100
From: <luis@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Web Application access to files in /mnt/
Message-ID: <20140112180430.5e2c3006@gentp.lnet>
In-Reply-To: <1389390257.20258.71.camel@x220.localdomain>
References: <52D0613F.3030805@kensnet.org>
 <1389390257.20258.71.camel@x220.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//O=Z0wmTUT8ZttWRbHVuKk3"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_//O=Z0wmTUT8ZttWRbHVuKk3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Additionally, I'd mount /mnt/store0 with the mount option
context=3Dsystem_u:object_r:my_app_content_t and only grant your
application access on that, instead of file_t.

If you don't need the separation proposed by Dominick Grift (e.g.
because the video files are public anyway), you could even just do a
"mount -o context=3Dsystem_u:object_r:httpd_sys_content_t ?? /mnt/store0"
without having to create a custom policy.


Regards,
Luis Ressel


--=20
Luis Ressel <aranea@aixah.de>
GPG fpr: F08D 2AF6 655E 25DE 52BC  E53D 08F5 7F90 3029 B5BD

--Sig_//O=Z0wmTUT8ZttWRbHVuKk3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS0sstXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpZhwQAMIwWuSr3qWvIqMHhbPBbtSM
YcQbth5DgvNVfDPLc9BMpbrUbAruDmrjutw7/tOlM2KILrfb/Wnusm/OvCu0Uqkh
g3SdQ13Sueaiqtteb+WDspBkQu4xKwZvmsBoIQANQ8ipzO444DN/pz0f8jus7wf/
JMqRV0cmVKMT9trR1/JTN6ezOjFhQBzwLPeutg8xK8ojybjcToQVWJRgrQVc0CM4
RSWy28//YVminDv5bjOifKRpOH6f/oPFlt1nmMMVf3KHijoBou8YptXXqHhNhI9v
ueDnt657Rp8SgsFbcX+N/Ti04ynzOoDZveTv8FMbqIsLEPtBJGCXcsUIh0Efg4rg
4HNSs8XHviqUd9hSgXr56EZmt6iNOTWtldnV2C4FbWFo7/adxGBdw7mCkXnZN5Hu
DrVXIlh2l6oaoqkykULzc2V/9FqjUYz3/iwRgOgv2hSE1vvaJf+bnLBj6ul2ichC
smioI9HQm/UwOWT/fox0M1Ez10TEW1cpcT/guQhBh04+cASH4VbUorGrkHcyV8S8
6Lrag1ZV/d0SbEPV6JOxX6D8u3SY+US8xDOFU7pwE+vr0fiL5xLVhSDsmw3jw0mb
wkTauS8GRuQdMrv3dL20tvRC0N0pYV9txnLxPAew+zkJPqkBbOlmc7SWZFpWvPtk
mRn4GH6RY/A9STAeRWFT
=Uj2z
-----END PGP SIGNATURE-----

--Sig_//O=Z0wmTUT8ZttWRbHVuKk3--
