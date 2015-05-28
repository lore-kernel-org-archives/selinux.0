Date: Thu, 28 May 2015 15:41:28 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Ted Toth <txtoth@gmail.com>
Subject: Re: postgresql policy
Message-ID: <20150528194128.GI26667@tamriel.snowman.net>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
 <55676C62.2010309@tycho.nsa.gov>
 <CAFPpqQHx4ONAyia4LoFji7AM07xUqVhXNfzvrhJbm4kZmnanOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OVneMNgyq8ifvwDO"
In-Reply-To: <CAFPpqQHx4ONAyia4LoFji7AM07xUqVhXNfzvrhJbm4kZmnanOg@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--OVneMNgyq8ifvwDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ted,

Any chance that module will be released under the PostgreSQL license
(BSD-like)?  We'd certainly like to see what those are doing and I do
wonder if we could use the hooks instead, if the SELinux community feels
that's a worthwhile approach.

Thanks!

* Ted Toth (txtoth@gmail.com) wrote:
> Sorry these are in a module I've developed.
>=20
> Ted
>=20
> On Thu, May 28, 2015 at 2:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
> > On 05/28/2015 03:10 PM, Ted Toth wrote:
> >> Unfortunately it is the latter. Here's an example of what you can do:
> >>
> >> CREATE TABLE reports (
> >>     id integer NOT NULL,
> >>     report json,
> >>     message_id integer NOT NULL,
> >>     location geometry(Point),
> >>         security_label text DEFAULT sepostgres_getpeercon()
> >> );
> >>
> >> CREATE POLICY
> >>   check_report_insert_selinux ON reports FOR INSERT
> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> >> sepostgres_getpeercon(), 'insert'));
> >>
> >> CREATE POLICY
> >>   check_report_delete_selinux ON reports FOR DELETE
> >>   USING (sepostgres_check_row_perm(reports.security_label,
> >> sepostgres_getpeercon(), 'delete'));
> >>
> >> CREATE POLICY
> >>   check_report_update_selinux ON reports FOR UPDATE
> >>   USING (sepostgres_check_row_perm(reports.security_label,
> >> sepostgres_getpeercon(), 'update'))
> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> >> sepostgres_getpeercon(), 'update'));
> >>
> >> CREATE POLICY
> >>   check_report_select_selinux ON reports FOR SELECT
> >>   USING (sepostgres_check_row_perm(sepostgres_getpeercon(),
> >> reports.security_label, 'select'));
> >>
> >> I'm hoping that between DAC, postgresql DAC, selinux policy and RLS
> >> policy we can get something that's secure enough for our purposes.
> >
> > Pardon my ignorance, but are the sepostgres_*() functions something you
> > have implemented or something in the existing sepgsl or postgres code?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--OVneMNgyq8ifvwDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ29oAAoJEO1sijiDR2RVOUgP/08X92pNePZnJ3WV4cpgpdeI
Zt7k5yL/YzCW4hpN1V4rfwa7Sd09fTkUAUuoU5Ro56mvDpswc7ezlQX/QLxvQ4BD
4bBkDg4tc5CJ3omKxPCJv4Gl0g6wqi8lBazMmhhLj2TC/Wr8nvyjXMyZgLjpXfHH
VR983DN4ItpP7Eo4SxwyuHbGm0ufkJFmv7bPCIZizogZEyK1ijDEfmyWIy2g4dv+
MFvHO7U4VY4SfU35TX1heC2KJRgiR2WY+GfAIQk9SdB6l9i1BS1oJgtj2yEo9peN
zzanZO+FwScwjHN6NMJdPR+5+FZk3oH1w7x2iJySthrrMUFYMuHr5ZKFUlV9qhwS
Rg0qnkq0OOGo7Pdk486vuc1s/3l5xw7z9V2Xhv+BDGNFNu0gNeQQQVWiu6mwmmjb
bKuMkZc22SiOiEgezXGonQ2nYc8fBfmgQLEZ79cpJjcRkyy0d+kPzKoaqvNjG3xW
R9GDfl5Rg8T+vlLSjiHysebNWNBeylqCi82zk4Zd7hez4OESdB23p1XVw0uFv1e3
ZpUYgiJhJ1UKwEfzEmK8UdtNlrOb4cMrJYNEGBizyJuKoDJxgKvU7aC9AUfs10or
a2Rd75HpBnFBiWZrvmhDnUq1T9tapMmUHTivCvWl88h0qPYA2Fvk37IMHDo117Lm
gGTzNuq1Nxg7XHHgg0mF
=mFmd
-----END PGP SIGNATURE-----

--OVneMNgyq8ifvwDO--
