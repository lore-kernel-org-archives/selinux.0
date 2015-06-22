Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MITOlJ015147
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 14:29:24 -0400
Received: by wgck11 with SMTP id k11so21493613wgc.0
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 11:29:22 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id ei8sm31806731wjd.32.2015.06.22.11.29.21
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2015 11:29:21 -0700 (PDT)
Date: Mon, 22 Jun 2015 20:29:20 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
Message-ID: <20150622182919.GD10451@localhost.localdomain>
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
 <20150314072253.GA26393@linksys-wireless-usb.network2>
 <5506CFD9.2030606@tycho.nsa.gov> <558832B8.8020705@redhat.com>
 <20150622180857.GB10451@localhost.localdomain>
 <5588513C.2050309@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
In-Reply-To: <5588513C.2050309@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2015 at 02:17:32PM -0400, Stephen Smalley wrote:
> On 06/22/2015 02:08 PM, Dominick Grift wrote:
> > On Mon, Jun 22, 2015 at 06:07:20PM +0200, Miroslav Grepl wrote:
> >=20
> >>
> >> In Fedora, we have unconfined_service_t domain for unconfined services
> >> started by init. So there is init_t @bin_t -> unconfined_service_t and
> >> we get op=3Dsecurity_bounded_transition for init_t against
> >> unconfined_service_t. But of course it is not going to work with
> >>
> >> typebounds init_t unconfined_service_t;
> >>
> >> because there is
> >>
> >> # <audit-1401> op=3Dsecurity_compute_av reason=3Dbounds
> >> scontext=3Dsystem_u:system_r:unconfined_service_t:s0
> >> tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile perms=3Dentrypoint
> >>
> >> So this logic breaks our concept with unconfined_service_t.
> >>
> >=20
> > What is running in the unconfined_service_t domain in that event?
>=20
> Nothing at the point of that message.  The message indicates a bounds
> failure, which will then cause the kernel to fall back to the old
> context if it was an automatic transition, or fail the exec with -EPERM
> if it was explicitly requested via setexeccon().
>=20

Sounds reasonable to me (it just seems I can't get easily used to that mess=
age but that is probably just because it does not happen often)

But yes at that point, suppose you know you have something to target.

I still would like to know what triggered this. Only thing i can think of i=
s systemd-importd

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJViFP7AAoJENAR6kfG5xmcBZ4L/Rnl7Chs8mqIyTnP5WUpZG5n
ESqbh43gnbTlxFF2HD4IX696vRls4hj7g9GCWwBpYJ7qnStSO7AxuytLJGK4T8O/
SUdiOCBojnXPF8cNhrgHpWKdI7i8Q1YBbCer5upFPUI8irqYcANupKLrJYG/RJvw
Bkf8ZiXRUc9ZdIrXr2FiO3z4bwBSgLx2tlOIjhQ54KYdZjVfMMb4ZfWmI40/oBF1
P6WauRPjHFSie0F+v+BJw4v9C0p4oYiQi4T+a2T3LoY9MDnIpZczrDK0UpvYC29F
iIR5kzRqcsYQEKN1qtiDORvzoQFV2aSJbKV1i1JZrQKDiINxAEfw9oHPJnszufpF
p2ClFZUHtdV1+1UaIetfT5Yzxl33+ZoyY/4ee+/VxYrLwQ8iU7kOj9b+mKCGLOeV
qff5XNY9xAgEVxcmmvFk2PhkSCj1sCQC191Ktf7ZgfcebBabK+viRZFZ12YGVO7o
Nsi7MtSHF6xT5NKTUILJKwtedQfF38kPEaVsndq6YQ==
=r+/V
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
