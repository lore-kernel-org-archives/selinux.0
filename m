Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1FI9sUv030179
 for <selinux@tycho.nsa.gov>; Sat, 15 Feb 2014 13:09:54 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id 809AB260031
 for <selinux@tycho.nsa.gov>; Sat, 15 Feb 2014 19:09:50 +0100 (CET)
Date: Sat, 15 Feb 2014 19:09:41 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Using genfscon's partial_path for other filesystems than proc
Message-ID: <20140215190941.1bac965b@gentp.lnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/KlemWgO23u/LBwrgfb7CqEb"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/KlemWgO23u/LBwrgfb7CqEb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,


The genfscon policy statement has an argument "partial_path" which can
be used to use specialized contexts for subpaths inside a file system.
However, the documentation mentions that this can only be used for the
proc filesystem. Is this really the case, and if yes, why? I'd like to
use it for the sysfs.

The motivation for this is that both the Fedora and the Gentoo policy
have cpu_online_t for /sys/devices/system/cpu/online, as this file is
accessed by all applications linked to a recent glibc and therefore
needs wider access permissions than the normal sysfs_t. Currently, the
context is changed at startup via an init script, which is a bit of a
hack. It would be neat if a genfscon statement could be used for that.

Is this currently possible or would it require changes to the kernel
and/or the selinux libraries?


Regards,
Luis Ressel

--Sig_/KlemWgO23u/LBwrgfb7CqEb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS/61mXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpPKgQAKE88OenIQoElVQmn+Y/IAiu
POYvudERpROh2DjTgYOuhv4GUNx5OvSiACZGO5OrXln8s+ZUZxCK7JxCsiTQHIYs
d1UWldFxcNMBova9J7Gq7xHV79w9Bw/s+SC0/1KLW+vzOl6g8As9mRfGqQ229e6V
HD3Yv6M+NVWutKsjJxKf2JWNrLrMVm+FfFngDd7xWnekEfnBdfQR/rxLeZw++pI0
8txGg3GXtoDmXd8RkhfDoqVxmlJllPgLfDPgCvXyrKvMzYm7VsplcY1YQTj2o8GE
PLCq9VpCJ7qI5PyPNIn815Nu9TfWicyWagdeH2VSSpXwU7TE+CJMrk1Da/IsQVn5
SgpOvPhKp1Yt7SJaqbS0gFd/G5EJHKgj/guUWGD5iEi8FJPY3BZFCxPYEuJjJvec
VBPyfzHGKRY9OKCqQUs+a8WQbRY8mrd2Z/75d6fnKNqs+Drk22MjzEUXyxyHKvn8
MBUTWeivsmdW4XR4Vmb8egpNOa5pxqJnHU7GNjV72kQHGewLerEXnw8UxcCoUiaf
WZF1gTVHkiAralXK1/q4oUgUx/MBKblDp+Y9mk1M2Gntp3P7r6hBb2jUgIK2Mf7q
TDqdod+T3NVIbGhwhArr/WBVBY0SGfV0stEfyGeSiDoRclQk4/ViJ1WQcDQozNc+
HwTpOoySRyMnhN78js9a
=CAkI
-----END PGP SIGNATURE-----

--Sig_/KlemWgO23u/LBwrgfb7CqEb--
