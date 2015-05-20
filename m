Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KG4Taq023990
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 12:04:29 -0400
Received: by wizk4 with SMTP id k4so160727635wiz.1
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 09:04:26 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id js3sm27531230wjc.5.2015.05.20.09.04.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2015 09:04:25 -0700 (PDT)
Date: Wed, 20 May 2015 18:04:23 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
Message-ID: <20150520160422.GB30612@x131e>
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
In-Reply-To: <555CAF66.7070004@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
> On 05/20/2015 11:51 AM, Dominick Grift wrote:
> > On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
> >> Add support for per-file labeling of debugfs files so that
> >> we can distinguish them in policy.  This is particularly
> >> important in Android where certain debugfs files have to be writable
> >> by apps and therefore the debugfs directory tree can be read and
> >> searched by all.
> >>
> >> Since debugfs is entirely kernel-generated, the directory tree is
> >> immutable by userspace, and the inodes are pinned in memory, we can
> >> simply use the same approach as with proc and label the inodes from
> >> policy based on pathname from the root of the debugfs filesystem.
> >> Generalize the existing labeling support used for proc and reuse it
> >> for debugfs too.
> >=20
> > Was there a compelling reason not to implement something similar for /s=
ys?
>=20
> The original motivating use case for per-file labeling for sysfs was
> libvirt labeling of specific sysfs nodes to make them accessible to
> specific virtual machines (qemu instances).  In that scenario, we needed
> userspace to be able to drive the labeling based on more than just the
> pathname and so genfs_contexts wasn't suitable.
>=20
> That said, Android is labeling all of /sys at boot based on
> file_contexts entries, so it might be argued that it would benefit from
> similar support for sysfs.  Although genfs_contexts isn't as flexible as
> file_contexts (simple path prefix matching vs pathname regex matching).
>=20

I alway's considered labeling files in /sys based on file_contexts to be a =
rather fragile solution

Fedora for example uses systemd-tmpfiles to label specified files in /sys o=
n boot

Currently in my personal policy i decided to leave everything with the defa=
ult sysfs fs type whilst waiting for a "genfscon" solution to arrive.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXLCCAAoJENAR6kfG5xmcx3kMALv2/cKibyzSIcuylmU2FCD0
gQUGRUUsyc5UUZxEQmxfmEIs12y9qHI2UljPILZ5QASZlI7eZsIrkM6V2xr5SnO8
a84ggMn1TPa/l6KEgWyJ1M8cSc8r6k38caQ1UOdxNHKdlVZR3F/dpDGuGYCvYSKG
rPQn956F2X7Tr5h3FoumicOlcz0R44nnOImiB2uLl9B24ezDZa89LV2DFiryXIzt
RKmInD19tIIy9gSPf3kbDbaPOGsvXHMI30WarddYmp9Ha+2+CCVdshwWve9iegJG
aef2rb6e69dOYs8mrriV6dUtESUHSVCmIFfmxUkJQWnBjFyK2nVPAOUmRVLUas1z
31cqnRmTGoTsewRwK6hq/8IHncGOSl/HQ/Ru631WPXYFYGVfbITtqZZpF7VGLJed
o3uOoUpN20tHwiQFQiZTSXr3GJO88kkkiRp3OZNYzEAyOvfLLRHYY7DwXnT/SnCx
oXj4hFKCddIoC4ZXDKIhGIJny0YGdt2a1YbqvvTuug==
=VWum
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
