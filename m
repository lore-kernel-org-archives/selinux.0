Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KGKUj2025708
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 12:20:30 -0400
Received: by wizk4 with SMTP id k4so161228233wiz.1
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 09:20:27 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id nb9sm4238552wic.10.2015.05.20.09.20.26
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2015 09:20:26 -0700 (PDT)
Date: Wed, 20 May 2015 18:20:25 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
Message-ID: <20150520162023.GC30612@x131e>
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
 <20150520160422.GB30612@x131e> <555CB29E.30904@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
In-Reply-To: <555CB29E.30904@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 12:13:18PM -0400, Stephen Smalley wrote:
> On 05/20/2015 12:04 PM, Dominick Grift wrote:
> > On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
> >> On 05/20/2015 11:51 AM, Dominick Grift wrote:
> >>> On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:

> >> The original motivating use case for per-file labeling for sysfs was
> >> libvirt labeling of specific sysfs nodes to make them accessible to
> >> specific virtual machines (qemu instances).  In that scenario, we need=
ed
> >> userspace to be able to drive the labeling based on more than just the
> >> pathname and so genfs_contexts wasn't suitable.

I do not think that is applicable anymore (although i may be wrong)


>=20
> The Android init program does a restorecon_recursive("/sys") on boot,
> and specific optimizations have been introduced to prune the tree walk
> when there are no relevant file_contexts entries.
>=20
> We could certainly add full genfs_context support for sysfs, even if we
> do not switch to using it in Android.  Some of the current /sys
> file_contexts entries for Android however can't be represented in
> genfs_contexts, e.g.:
> /sys/devices/virtual/smdpkt/smdcntl([0-9])+/open_timeout
> u:object_r:sysfs_smdcntl_open_timeout:s0
>=20
> Also, genfs_contexts is always a prefix match, so e.g.
> /sys/foo system_u:object_r:foo_t:s0
> will match /sys/foo, /sys/foobar, and /sys/foo/bar.
>=20
> In contrast, file_contexts is an anchored match, so e.g.
> /sys/foo system_u:object_r:foo_t:s0
> will only match /sys/foo,
> /sys/foo(/.*)? system_u:object_r:foo_t:s0
> will match /sys/foo and anything under it if it is a directory, and
> /sys/foo.* will match anything beginning with /sys/foo.
>=20
> So they aren't quite the same.
>=20

That sounds troublesome. Then again, just because one implements genfscon s=
upport that does not mean that labeling based on file_contexts can't be use=
d for stuff that cannot be tackled with genfscon. Right?

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXLRDAAoJENAR6kfG5xmcwWIMAJ/F1IsKxQsZsTKiUzIyzSvf
Q7rDi2IFfnL7E3E6qPA0H9C1ZoeMrDDmOmVhvrs7MOzOSThxvJsqvAWTgmXkc2t1
xA81DUCOrEVN6rkeESho+F20oJoyz0qTEzhSgJpjwrHIsubU0sOxrwbqQs9BTMOP
abvr5i3/9a+NeuE/gWZVIbgabb4OUy3g+bZidQ4TL8tGjRtj8/RWjDAl7U7RvJDe
bejlOqFVAz0L+oXyS5bTT0GLj3p54C9bF/jh3abmFKxjAqPKssopstggvJGsSaGO
X1mNZIb+8voFArhRyz1F0AO5qW9qyKEmeqUMU6QmNPmbRSzpQN9PonNj16PKEiW1
KhSOZb5xZVfz7IQkMBwqX/j9vd4y/dJ2VQ7z7gwcj/XWTA30qKtUZF7BoLCpdsgk
iC/uanzjS1+VZbOkcF/Zq3x+0HUuf4k82qTh6FX0KJarIn2726lh7K5zt3KKA3AO
d8w9u5uX1GLuAbDQkmYID2dbSQdNtQELpZO/YFkYmg==
=WE4d
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
