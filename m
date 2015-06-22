Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MIDgbk014174
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 14:13:42 -0400
Received: by wgck11 with SMTP id k11so21173500wgc.0
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 11:13:39 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id ee1sm4708410wic.8.2015.06.22.11.13.39
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2015 11:13:39 -0700 (PDT)
Date: Mon, 22 Jun 2015 20:13:38 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
Message-ID: <20150622181336.GC10451@localhost.localdomain>
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
 <20150314072253.GA26393@linksys-wireless-usb.network2>
 <5506CFD9.2030606@tycho.nsa.gov> <558832B8.8020705@redhat.com>
 <55883793.2040400@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
In-Reply-To: <55883793.2040400@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2015 at 12:28:03PM -0400, Stephen Smalley wrote:
> But the bounds check is only applied if the caller or one of its
> ancestors (systemd?) set NO_NEW_PRIVS or the filesystem is mounted nosuid.
>=20
> And if the type is not bounded, we simply fall back to the original
> context on a default transition, just as we did unconditionally prior to
> the kernel change when NO_NEW_PRIVS was set.  The kernel change did not
> make type bounds a requirement; it just added it as an optional way of
> support type transitions under NO_NEW_PRIVS.  Prior to the kernel
> change, there was no way to perform a type transition upon exec if
> NO_NEW_PRIVS was set.
>=20
> What definition of typebounds would permit the above scenario yet still
> ensure that no privilege escalation can result?  Would we need special
> case handling of :file entrypoint and possibly self: rules (to address
> Dominick's earlier issue)?  Or dropping the target bounds checks
> entirely as was proposed back in
> http://marc.info/?l=3Dselinux&m=3D125770868309928&w=3D2 ?
> _______________________________________________

For the record. I accepted things the way they are now. Sure it is not perf=
ect but I learned to compromize

The only encounter i had with this was with systemd-importd.

Any other app/service that has the same requirements just needs to be targe=
ted and dealt with accordingly

If something that is not targeted then so be it. Not supported until i targ=
et it.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJViFBMAAoJENAR6kfG5xmcbqwMAMyTGQCLHV/plp9CX556MRQx
uKkdj4SU7hQvHiPpf4O8+cF8BKx5dPXAz+inFeLj3niHeGCJCoe7RlqrInEvf3Ah
q2o2/3JSXDJPQtw2HliBXrUsL2WtRY2UY6fE+BeiCiTkszMZrlvM6kxg06MenJ73
Mh9v6hFBIBOjgH/DFAZc5V32Y20d6V2Wiu303PXMbcXTGyM1aHBxdj4nS1ki7TgD
R3XW+AsfGNQPeY8kmn0H3V8zdIyuFqTpQp6MEW4h18DcFJLHGxGbaIM3KYppiuyB
+eshLxOCiuteAUTbK4mbtE4/HOx4rf6gEwv4h5+99Z95zEHrMmdhOJOX7aNZSozm
9y1tMDOnobBprJ9za6b4xt+DdF92KY+wHmDpFhMInVf9vG+80Kc6LuvBQn2QYwg5
BaNP7Pe25JrffjW0GW8fbEYdeTP97OKabnHqXP+a9dkLCw/8p29NqjTBF4wNv8pU
hKvdUqfwjqzzItBNf2aEq1hPHEPOQgXFyvFPtMi55g==
=QW0s
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
