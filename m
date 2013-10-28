Message-ID: <526EBE56.6010901@redhat.com>
Date: Mon, 28 Oct 2013 15:43:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 01/17] Do not return error if system is in permissive mode.
Content-Type: multipart/mixed;
 boundary="------------070105000100060208030306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070105000100060208030306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is an updated patch with Steven's suggestions on making sure we audit bad
data.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuvlYACgkQrlYvE4MpobMm8QCgqk5v5fp8VWkf1US0iWGCVa81
F+wAoKpueblWU0BMkNPGsU+EFhAbmUjR
=nR1C
-----END PGP SIGNATURE-----

--------------070105000100060208030306
Content-Type: text/x-patch;
 name="0001-Do-not-return-error-if-system-is-in-permissive-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Do-not-return-error-if-system-is-in-permissive-mode.pat";
 filename*1="ch"


--------------070105000100060208030306--
