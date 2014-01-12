Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0CH5Nrw012406
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 12:05:23 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id A80C226B9CE
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 18:05:20 +0100 (CET)
Date: Sun, 12 Jan 2014 18:05:20 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Web Application access to files in /mnt/
Message-ID: <20140112180520.32098337@gentp.lnet>
In-Reply-To: <1389390257.20258.71.camel@x220.localdomain>
References: <52D0613F.3030805@kensnet.org>
 <1389390257.20258.71.camel@x220.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/k6hMLQUbxKNdNVA6uxJ7dIn"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/k6hMLQUbxKNdNVA6uxJ7dIn
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

--Sig_/k6hMLQUbxKNdNVA6uxJ7dIn
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS0stQXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpb7cP/339Vf6+syHOQLbhwRvT9QEQ
+vN2AvZ1L0CN36In3+Bs+djkMAyWbkJnbOlT6e1mjQq43TgP0j6VHOqOXGcPwp3E
RopBUVuZJbTDdY+9cExlhMw6kSTNJNUhGy/wjsunCqgZObIlt4tYvXVW6OiUnHoc
sXRuZdAOBKeUDLty4JI7HNyx9Mz/gcFe//07QDVGvQfIrxDvyCpBdc7N313kBtYr
lvSXdgI3oxr5Vqe9blTri9ypqCLg68JIwXOn/7KuZz0keSKMZee+X8AeFQKJe4z4
Ea02bKioGG0SIIhH46P6O8xEGJ3hR4SwalISeU2QViJzGcQjtFK7K/4d/6ZkZzEW
ALJOvstfP31Yb7LzrXvbi4cw0D7iePFGXCOHCqzni7eI1497ftN5zurI1lIoRfjy
Atm2poXLioZ+rLRbccGPsoKIr9RxG1HOO3xg+StXtd6KttUiGjdp6pg0TIxWEAwb
4tTGYd7dx6rCJ7QtR1KoTLQweNqfMlzmbEwdUV9XFyqMaKJzvjYMnbwqMLZ2zeJD
zGO9LbMff+y9ObYagoYhZ5N9/j9wtH96eiY7H1ZrjAjzzw2Q/2EV9bgUuV5Byw7I
T5qoFzZd/nbg9mPu+3OGh9fA2qfVU2NCaKMITkPf+dBLL4+kPoHZ62YMx5tKhGbB
0i4W7QYU16CAIpdYVa2M
=SPXe
-----END PGP SIGNATURE-----

--Sig_/k6hMLQUbxKNdNVA6uxJ7dIn--
