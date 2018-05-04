Date: Fri, 4 May 2018 22:12:35 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180504201234.GB3111@workstation>
References: <20180504115146.19532-1-plautrba@redhat.com>
 <d705f8cf-43c7-2882-ca42-e2d5dc90c010@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
In-Reply-To: <d705f8cf-43c7-2882-ca42-e2d5dc90c010@tycho.nsa.gov>
Subject: Re: [PATCH] python/semanage/seobject.py: Fix undefined
 store check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 01:58:08PM -0400, Stephen Smalley wrote:
> On 05/04/2018 07:51 AM, Petr Lautrbach wrote:
> > From: Vit Mojzis <vmojzis@redhat.com>
> >=20
> > self.store is always a string (actual store name or "") because of
> > semanageRecords.__init__. Fix check for not defined store.
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1559174#c3
> >=20
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  python/semanage/seobject.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index ac310ea6..c76dce85 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -2651,7 +2651,7 @@ class booleanRecords(semanageRecords):
> >              self.current_booleans =3D []
> >              ptype =3D None
> > =20
> > -        if self.store is None or self.store =3D=3D ptype:
> > +        if self.store =3D=3D "" or self.store =3D=3D ptype:
> >              self.modify_local =3D True
> >          else:
> >              self.modify_local =3D False
> >=20
>=20
> Is there a reason you didn't use if not self.store here?
>=20

There's a similar check on line 258 and this just follows the same pattern.



--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlrsvqsACgkQviIJHj72
InVhbBAApRzNRjjN2T33HIoMO2FR2ke3XjemFeShEaxWmJOEm72VzovZIqPncTsF
VsS3O5Kflg7tj3retWUdPrq1Ne5ekIjZ2FYpCinD8alKK8Z6C9YkwznmG1deL/D8
ZWBmhw5AbHAngAAVdQP6g0a+E6yy8VzrENdyeyqhe/QMgUjeKqcMBKZa4IXLQX41
aR7iHcVzsgn6qOEwFkpz6nAGdFMbETGQDTSx4rxwUFghu1Re8lV+Tb6IlY2xH6kE
cywxGiDTQZk68MaETO4fP0DES7owW8KGMZfkvZdgt+bqJC3RD5fq+ReoZj8s1hE4
+Gd4wS8nUXYDTlHS6iAsZ07+NR2jWc9z6/J8f5pflcIMx5BFov7otJsScEajrEeG
etfan2JBbt0WwNOxuIQZcXTGIY7Q6dZfYLfa1EQn2vdmeahDNM4GSQ0yxMzOlb3S
DVF/MN0MbhDNDVHFx4twRi5i5pCxGeshs2NdSqP+qZThmpLJ8EbIKW4cxXlmpWBb
TJaJ8FSozK7/9AIhNKR0kPsv49uEBT/5AjBskE/ptNlefcxjG2LUmZhRcA7L22Ol
SrSw3nKdiG1F0PGHKkOLNnlUd6kns2602XpXSbihgda6YZPpPerLClLOWSszjEn7
7xhMcefCi5fUkg5ng8MfVg03C1/fWxtH50aFraMI6GZ2y9TdJhs=
=vhEP
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
