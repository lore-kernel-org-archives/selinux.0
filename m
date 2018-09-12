Date: Wed, 12 Sep 2018 16:36:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <20180912143644.GA10229@julius.enp8s0.d30>
References: <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
 <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
 <258b172b-01a2-3af5-35e0-6c8f9aade82b@tycho.nsa.gov>
 <CAFPpqQE1x7oS0R21Fm_tU=1XHRy46FEz=ii-QHS9YDE=KAE7Sg@mail.gmail.com>
 <5a423dc6-6667-772a-4715-64fd23fb8378@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <5a423dc6-6667-772a-4715-64fd23fb8378@tycho.nsa.gov>
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 09:57:20AM -0400, Stephen Smalley wrote:
> On 09/12/2018 09:26 AM, Ted Toth wrote:
> >=20
> >=20
> > On Wed, Sep 12, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >=20
> >     On 09/11/2018 04:59 PM, Ted Toth wrote:
> >      > That's awesome and now it's got me thinking about other
> >      > classes/permissions that we could implement. Can cil macros can =
be
> >      > referenced in .te/.if files?
> >=20
> >     Not sure I understand your question.=A0 You can't directly embed cil
> >     statements in .te/.if files.=A0 However, if you define a class/perm=
ission
> >     in a .cil module, you can certainly specify a require on it and use=
 it
> >     from a conventional .te/.if module, ala:
> >     $ cat > usemcstrans.te <<EOF
> >     policy_module(usemcstrans, 1.0)
> >=20
> >     require {
> >      =A0 =A0 =A0 =A0 class mcstrans { color_use };
> >      =A0 =A0 =A0 =A0 attribute domain;
> >     }
> >=20
> >     allow domain self:mcstrans color_use;
> >     EOF
> >=20
> >     $ make -f /usr/share/selinux/devel/Makefile usemcstrans.pp
> >     $ sudo semodule -i usemcstrans.pp
> >=20
> >=20
> > If the cil contained:
> >=20
> > (macro use_color (type caller) (allow caller self mcstrans (color_use)))
> >=20
> > then in x.te can I use the macro:
> >=20
> > type x_t;
> > use_color(x_t)
>=20
> Sorry, no.  The macros used in .te/.if files are just m4 definitions hand=
led
> at the preprocessing stage, not a feature of the module language.  The CIL
> macros are directly supported by the CIL compiler, but they won't be visi=
ble
> to the module compiler.  Also, you are missing several parentheses above
> (I'm not fond of the lisp-like syntax myself).  In a CIL module, I think =
the
> correct syntax would be:
>=20
> (macro use_color ((type caller)) (allow caller self (mcstrans (color_use)=
)))
>=20
> (call use_color(x_t))
>=20
> Or you could define a m4 macro in an .if file and use that in a .te file.
> Or both.
>=20

Ideally you would have all of your policy written in CIL or in a high-level=
 language that was designed to leverage CIL.

My DSSP2 policy is a CIL-only policy. In there I also leverage unordered cl=
asses, Meaning that for example if you remove or disable the mcstrans modul=
e then you automatically also remove or disable  the access vectors that mc=
strans manages.

minimal:

https://github.com/DefenSec/dssp2-minimal

standard (my personal policy based on top of minimal):

https://github.com/DefenSec/dssp2-standard/commits/master

DSSP2 does not support enforcement of confidentiality though

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

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAluZJHgACgkQJXSOVTf5
R2nWbAv+Ny3BYjjbuMY7ksaXMmlEFE4sAR/P8F5li4Kse0iAndLSkWIbrMuncj7W
Df7UjsVsyyGgW95w7MWLwQy9uvLhk5hKjy8uZhRIKWwUoGazY5cSrcV9iwsLPCn0
nbef5naN/s3AycPqawKHmTAjCtldNoqPTpKnzAWwo/7Vj4syqvCYbnsNKQo3zyO1
4mQGfaKkGtsEPZlIKt9fM7pVAbzIa3ynxtl9GEnafp0rPPjaPjEhR2vq8335lSqW
6vXmFJQNWHHe2MOHn4RKHsFbAZLnNp+JODPO6ajH1UFVJyXLDQDctFvyRt398AqW
ka2gYyAm7TOhmONYj7HVv0eJCOW/n2zyLvsWUgMT06J2Flw5CkNuzruyFZmNX39R
pHcQntaU0/HpzzMF9doiKVu8JgIE2AiSumDL7Pav3qNVCrRRyv4QEqHZYm2qN+yG
iIoY/A3+NhvPQRVrK0OSueoG6V4794t/bHI4/foCekjw80B6Ih6C+7q8Xsp52HAJ
jyiAik10
=Bwnp
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
