Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MCE1le017985
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 08:14:01 -0400
Received: by wguu7 with SMTP id u7so67546044wgu.3
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 05:13:58 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id v4sm3782394wiy.5.2015.06.22.05.13.57
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2015 05:13:57 -0700 (PDT)
Date: Mon, 22 Jun 2015 14:13:56 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: libselinux equivalent of restorecon -F
Message-ID: <20150622121355.GA10451@localhost.localdomain>
References: <9833421.4OAA7AQtgN@sifl> <6033.1434651905@warthog.procyon.org.uk>
 <9305.1434966107@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <9305.1434966107@warthog.procyon.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please excuse my ignorance, and please bear with me for a moment:

I would consider lsetfilecon() functionality roughly the same to that of "r=
estorecon" (in a sense at least).

Which libselinux interface would be provide roughly the same functionality =
to that of "restorecon -F" (in a sense at least) ?

Is that what selinux_lsetfilecon_default() is for?

Thanks

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVh/v/AAoJENAR6kfG5xmcDRgMAIcviiavwsELgkRoDh4Rj6D/
EbenNvWN+sA+cmQrREeNu02D7GuKNLW9Y0vszaWZqcAk1Ly4Lntdb+b1x4l5xQfV
EdtTHIecOPtyGIYYMT+eu+l999IxcOIAxPZKQDdXNydtPNkNxHB4VRlj58eJzhSj
zWAJkyT6c+9VK4JtjURfZ6NmEz79pXh6lcB/5XyaWZnp6gkxBLKwrXfqow2hmpyh
UKehSAeUvoSmVjRSYtt5M5JZmqjz5Qyru8wdAanqZZRvxAeYBOL/Rz1t6Oz60CeD
eIJ4oH9CnzBllHGJbDgYCo8lT352CoVSVF9oqAtKuoLLR46ZbyROIJZDP5D1A39L
9ngC3LTU+TQUdW9j4+zGMqq2diZoFOrg+HbmsDSXRgVTqmMyYZIc0E+xnTtjXKUC
z/yvL7FjAs09BZXSPpOUeGoX8wsMhGXpONXWmMs5yqdE7UsgETWYYA2v7GyGIZBM
jCbOiAr8k8ThN21VvWRNkkEYm/2sN2AGQpKysJY9Wg==
=twiu
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
