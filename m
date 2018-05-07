Date: Mon, 7 May 2018 22:00:41 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180507200041.GC23749@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20180504115146.19532-1-plautrba@redhat.com>
 <d705f8cf-43c7-2882-ca42-e2d5dc90c010@tycho.nsa.gov>
 <20180504201234.GB3111@workstation>
 <501c4bac-710c-fcc9-7e3a-6fba61b9fcef@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
In-Reply-To: <501c4bac-710c-fcc9-7e3a-6fba61b9fcef@tycho.nsa.gov>
Subject: Re: [PATCH] python/semanage/seobject.py: Fix undefined
 store check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 09:58:28AM -0400, Stephen Smalley wrote:
> On 05/04/2018 04:12 PM, Petr Lautrbach wrote:
> > On Fri, May 04, 2018 at 01:58:08PM -0400, Stephen Smalley wrote:
> >> On 05/04/2018 07:51 AM, Petr Lautrbach wrote:
> >>> From: Vit Mojzis <vmojzis@redhat.com>
> >>>
> >>> self.store is always a string (actual store name or "") because of
> >>> semanageRecords.__init__. Fix check for not defined store.
> >>>
> >>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1559174#c3
> >>>
> >>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >>> ---
> >>>  python/semanage/seobject.py | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> >>> index ac310ea6..c76dce85 100644
> >>> --- a/python/semanage/seobject.py
> >>> +++ b/python/semanage/seobject.py
> >>> @@ -2651,7 +2651,7 @@ class booleanRecords(semanageRecords):
> >>>              self.current_booleans =3D []
> >>>              ptype =3D None
> >>> =20
> >>> -        if self.store is None or self.store =3D=3D ptype:
> >>> +        if self.store =3D=3D "" or self.store =3D=3D ptype:
> >>>              self.modify_local =3D True
> >>>          else:
> >>>              self.modify_local =3D False
> >>>
> >>
> >> Is there a reason you didn't use if not self.store here?
> >>
> >=20
> > There's a similar check on line 258 and this just follows the same patt=
ern.
>=20
> Ok, I don't have a strong opinion on it either way, but noticed that it w=
as recommended
> to use not self.store in that bugzilla entry, comment #9, and was claimed=
 to have been changed
> in comment #10.  Up to you.
>=20

I think that the important part of the message is not use
`self.store is ""` as it has unpredictable behavior.

The check `not self.store` is already in __init__ on line 252:

 252        if not self.store:                                             =
                              =20
 253            self.store =3D getattr(args, "store", "")

If there's no objection, I'd leave as it is now.


FYI: I'll be offline most time of the week so I won't be able to
respond to emails during this time.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlrwsGAACgkQviIJHj72
InUdNw//aceY9FxbkJLhbaJgT21FIde60bKzpvERBFGc5aBUBkzFSuaScfaP1Y59
lzCaPpKa236joMvwlbDa3iqk0H9HyU7ciY49py5FTvwN5MRhI0xnDc1AbyoZP5Ty
EZzy2HMiO+qp11Clv3ddNOWoSfaHZBtVyY+AzQcerdK1dMHRawsGKBBOIAsL6x+L
o0gsai6MhmrHc5etcCiP0i/gpY6J18iPIWEARGNBDdowdDdWfbt4Qjk4W5uTxHkS
VthZ3C3OPIREXgrEpNS937deIbfp37lKYDCKkxXzHvzJASUnNHf9t3Z4daYJrdJ/
lNlhV2mSE74QOP7BYcyP49Ag9GLvqvQEC8bflF3+v33lTLK3IDOl4fFeqIPuyKJz
j/wJizG09Xd6tCWrh+rd7b9y4Jf9I5cKann9A/1fYb2f0aZ0HLron+byF8fKcZG3
l5WnNy+DYaH8IrxywXGZZdu0/wQptRQQxWWqDMEgwnWDPomNHLBOC7MqVyNqDGDC
VYTtHLWrJaQnSdWuLdb+7p8VTaZR25a3Fy13xDCTv+3xhWIdaGh1fBBckU/LoZkF
P/Grh5rPnoujZjGmZ8/ZQ+CgDkmgxuva8nuIhJKJK/djXdOBloElkLFSxs1bU8QZ
NVD0FjdaNy5w1R8oRtkA0hrhHOzuokZ5ikYQlGxDkPack6chWeA=
=QVMj
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
