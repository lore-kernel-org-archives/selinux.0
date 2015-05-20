Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KHiqdP032320
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 13:44:52 -0400
Received: by wgbgq6 with SMTP id gq6so60721341wgb.3
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 10:44:49 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id n3sm4671802wix.1.2015.05.20.10.44.48
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2015 10:44:48 -0700 (PDT)
Date: Wed, 20 May 2015 19:44:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
Message-ID: <20150520174444.GE30612@x131e>
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
 <20150520155135.GA30612@x131e> <555CAF66.7070004@tycho.nsa.gov>
 <20150520160422.GB30612@x131e> <555CB29E.30904@tycho.nsa.gov>
 <20150520162023.GC30612@x131e> <555CB552.5040305@tycho.nsa.gov>
 <20150520162817.GD30612@x131e> <555CC3A6.1030404@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
In-Reply-To: <555CC3A6.1030404@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 01:25:58PM -0400, Stephen Smalley wrote:
> On 05/20/2015 12:28 PM, Dominick Grift wrote:
> > On Wed, May 20, 2015 at 12:24:50PM -0400, Stephen Smalley wrote:
> >> On 05/20/2015 12:20 PM, Dominick Grift wrote:
> >>> On Wed, May 20, 2015 at 12:13:18PM -0400, Stephen Smalley wrote:
> >>>> On 05/20/2015 12:04 PM, Dominick Grift wrote:
> >>>>> On Wed, May 20, 2015 at 11:59:34AM -0400, Stephen Smalley wrote:
> >>>>>> On 05/20/2015 11:51 AM, Dominick Grift wrote:
> >>>>>>> On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
> >>>
> >>>>>> The original motivating use case for per-file labeling for sysfs w=
as
> >>>>>> libvirt labeling of specific sysfs nodes to make them accessible to
> >>>>>> specific virtual machines (qemu instances).  In that scenario, we =
needed
> >>>>>> userspace to be able to drive the labeling based on more than just=
 the
> >>>>>> pathname and so genfs_contexts wasn't suitable.
> >>>
> >>> I do not think that is applicable anymore (although i may be wrong)
> >>
> >> Not sure what you mean, but to clarify, I mean that libvirt has to set
> >> the context (at least the categories for MCS and possibly the type as
> >> well) on any sysfs node that needs to be accessible by the qemu
> >> instance.  At least that used to be the case.
> >>
> >=20
> > That is what i mean. I am not aware of any such scenario's today. Again=
, I might be overlooking it.
>=20
> Would only show up if you are doing PCI passthrough, I believe.
>=20
> Also possible that they never leveraged the support in libvirt even
> after we got the kernel support merged.  But not to say that it wouldn't
> improve their security nonetheless today...
>=20
>=20

Thanks, I haven't noticed that. Your patch would not break that functionali=
ty.

Thanks for your patch, i will allow me to start labeling some files in /sys=
 as well

I just really did not feel comfortable by relying on systemd-tmpfiles for t=
hat.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXMgIAAoJENAR6kfG5xmc2iYMAKBj+kEDAxpK3SMhzuHgZxgp
Pz4aBfJ6Msk4UG230heam7SpGfHJDXaxy8nghuxDayttj3TqE7fBdd4njdVLzDHe
mVP++4afvaVc1MMmTSW7MeL/QF27v6th6XF+t6l/SHKhenzk44yRA8+O9RKPeufr
Kos4z3iXtE4d3LfJRiwOBOqvhH3C2jjco2O4rVOFAgq89yDqAhNlwVwRr6EAgNc6
kjSKRD3tr50CHQABJxrWTPztGeJIBsjdTAAJOp/vWepuYZtUTVsqVvjzwgOhaF26
oMJ+ZDntavLOZFQL+CYVtMPhsZFO/Q8NlCqaHZD9XG7tkIsue+ixBaDyCbSqwZJd
2QbG5r3RazY4LxXwCMignEeOygmmp7TfKRQxhsha45sENvWEhyGw/4gj5YNJ2noD
LwTIR3ERC4G8coUvyYZP713buCuTC7IuG92ZrqRhxapg4ePYtF4BAXCSVRWmn+++
J8xfqFaB/BeM+mNoLmTy3iNQ9KkaEVPUUn78tbDldQ==
=gmhN
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
