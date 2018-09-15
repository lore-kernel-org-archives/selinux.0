Date: Sat, 15 Sep 2018 08:08:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Ted Toth <txtoth@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <20180915060850.GA1511@julius.enp8s0.d30>
References: <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
 <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
 <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
 <5a423dc6-6667-772a-4715-64fd23fb8378@tycho.nsa.gov>
 <20180912143644.GA10229@julius.enp8s0.d30>
 <CAFPpqQEdXiduYNoRvS-LuF+TmwEow7Y+5te1dRxjjfCybSXQjQ@mail.gmail.com>
 <CAFPpqQGymYh-dNn1XMzFVDHNu-0-MbLo7=8rk+DMuLHEKh963Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <CAFPpqQGymYh-dNn1XMzFVDHNu-0-MbLo7=8rk+DMuLHEKh963Q@mail.gmail.com>
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 04:18:29PM -0500, Ted Toth wrote:
> On Wed, Sep 12, 2018 at 9:57 AM Ted Toth <txtoth@gmail.com> wrote:
>=20
> >
> >
> > On Wed, Sep 12, 2018 at 9:36 AM Dominick Grift <dac.override@gmail.com>
> > wrote:
> >
> >> On Wed, Sep 12, 2018 at 09:57:20AM -0400, Stephen Smalley wrote:
> >> > On 09/12/2018 09:26 AM, Ted Toth wrote:
> >> > >
> >> > >
> >> > > On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov
> >> > > <mailto:sds@tycho.nsa.gov>> wrote:
> >> > >
> >> > >     On 09/11/2018 04:59 PM, Ted Toth wrote:
> >> > >      > That's awesome and now it's got me thinking about other
> >> > >      > classes/permissions that we could implement. Can cil macros
> >> can be
> >> > >      > referenced in .te/.if files?
> >> > >
> >> > >     Not sure I understand your question.  You can't directly embed=
 cil
> >> > >     statements in .te/.if files.  However, if you define a
> >> class/permission
> >> > >     in a .cil module, you can certainly specify a require on it and
> >> use it
> >> > >     from a conventional .te/.if module, ala:
> >> > >     $ cat > usemcstrans.te <<EOF
> >> > >     policy_module(usemcstrans, 1.0)
> >> > >
> >> > >     require {
> >> > >              class mcstrans { color_use };
> >> > >              attribute domain;
> >> > >     }
> >> > >
> >> > >     allow domain self:mcstrans color_use;
> >> > >     EOF
> >> > >
> >> > >     $ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
> >> > >     $ sudo semodule -i usemcstrans.pp
> >> > >
> >> > >
> >> > > If the cil contained:
> >> > >
> >> > > (macro use_color (type caller) (allow caller self mcstrans
> >> (color_use)))
> >> > >
> >> > > then in x.te can I use the macro:
> >> > >
> >> > > type x_t;
> >> > > use_color(x_t)
> >> >
> >> > Sorry, no.  The macros used in .te/.if files are just m4 definitions
> >> handled
> >> > at the preprocessing stage, not a feature of the module language.  T=
he
> >> CIL
> >> > macros are directly supported by the CIL compiler, but they won't be
> >> visible
> >> > to the module compiler.  Also, you are missing several parentheses a=
bove
> >> > (I'm not fond of the lisp-like syntax myself).  In a CIL module, I
> >> think the
> >> > correct syntax would be:
> >> >
> >> > (macro use_color ((type caller)) (allow caller self (mcstrans
> >> (color_use))))
> >> >
> >> > (call use_color(x_t))
> >> >
> >> > Or you could define a m4 macro in an .if file and use that in a .te
> >> file.
> >> > Or both.
> >> >
> >>
> >> Ideally you would have all of your policy written in CIL or in a
> >> high-level language that was designed to leverage CIL.
> >>
> >
> > Unfortunately I/we don't live in an ideal world :( but thanks for the
> > pointers.
> >
> >
> >>
> >> My DSSP2 policy is a CIL-only policy. In there I also leverage unorder=
ed
> >> classes, Meaning that for example if you remove or disable the mcstrans
> >> module then you automatically also remove or disable  the access vecto=
rs
> >> that mcstrans manages.
> >>
> >> minimal:
> >>
> >> https://github.com/DefenSec/dssp2-minimal
> >>
> >> standard (my personal policy based on top of minimal):
> >>
> >> https://github.com/DefenSec/dssp2-standard/commits/master
> >>
> >> DSSP2 does not support enforcement of confidentiality though
> >>
> >> > _______________________________________________
> >> > Selinux mailing list
> >> > Selinux@tycho.nsa.gov
> >> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > To get help, send an email containing "help" to
> >> Selinux-request@tycho.nsa.gov.
> >>
> >> --
> >> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
> >> Dominick Grift
> >>
> >
> I added a security class and permission using the following cil:
> (block mcstrans
>     (typeattributeset cil_gen_require  setrans_t)
>     (typeattributeset cil_gen_require user_t)
>     (class level_color (pick_using_dominance))
>     (classorder (unordered level_color))
>=20
>     (mlsconstrain (level_color (pick_using_dominance)) (dom h1 h2))
>=20
>     (allow setrans_t self (level_color (pick_using_dominance))))
>=20
> and this works for the mcscolor code I changed to use it. However I wrote
> some python code to test the class/permission (using
> security_compute_av_raw) and ran it before adding an allow rule for the
> python code type and no avc was generated as I'd expected. Is there
> anything different about adding a security class this way that would affe=
ct
> avc generation?

Did you look for type=3Duser_avc messages? Is setrans using "selinux_access=
_check()" instead of "avc_has_perm()"?

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlucoe4ACgkQJXSOVTf5
R2kh9AwAljX9nTaR7JPV60rlUkyJ0T62eSPic5nX07y7dsFxAVcF5EwAs0/OlJuc
KxXnhLnlN2E63Sz51br7TOM7FFRThKgVpxCgucxpa2hOnbNwGmw8w40MXN+K7fok
EqbztGl0RuXqeAWupCDHGbiu60go1lDpYaNzBD4YLku7pfMWJfVQJELrQn0giHkL
nP+4FpOkDUDdwB7JFBzqKi4xc49Tti0FfGBEjCDz+u60tMqxgYkWOmR3Bi8NzMD2
G/+fN/VbBQ9IpHveiFy+at+SohvZrb+HSoAynR9CBTB+c33OHTK/a3925/d/2i4r
2meFuEdBh+vahAYpVyWugOkz/hO2VANgoYYXlFW2AAy7N1xPJgYuu9jpmp3wbj4t
ZFvlsmtBeccE3vHSl7xk64Zg8edjzxZkRR8Z0/uxbATHfB7DG7pBHBJgxbzkLwGm
JVLjdBJHnU5pHqJMOVe/xYgxa2/kkQjGJtaDD2MBjh60GQ8iTjXOSoYx6DI3QSvb
w7v59Ath
=Imaa
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
