Date: Thu, 28 May 2015 15:49:42 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Ted Toth <txtoth@gmail.com>
Subject: Re: postgresql policy
Message-ID: <20150528194941.GL26667@tamriel.snowman.net>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <CAFPpqQGW=-pmSOfyppL1Q8uZLP=0ikpniQHRMUF-41dFXSdJiQ@mail.gmail.com>
 <55676C62.2010309@tycho.nsa.gov>
 <CAFPpqQHx4ONAyia4LoFji7AM07xUqVhXNfzvrhJbm4kZmnanOg@mail.gmail.com>
 <20150528194128.GI26667@tamriel.snowman.net>
 <CAFPpqQHiJrOMC=jgs-rTB1QQy4qc8Ni65vTRE2OjDn4Ux63jYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KfkUYJP3oDyf1HAg"
In-Reply-To: <CAFPpqQHiJrOMC=jgs-rTB1QQy4qc8Ni65vTRE2OjDn4Ux63jYw@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--KfkUYJP3oDyf1HAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ted,

Fantastic, and certainly, makes sense.

Please let me know if there's anything I can do to help.

Thanks!

* Ted Toth (txtoth@gmail.com) wrote:
> Absolutely I'll share it when I'm happy with it.
>=20
> Ted
>=20
> On Thu, May 28, 2015 at 2:41 PM, Stephen Frost <sfrost@snowman.net> wrote:
> > Ted,
> >
> > Any chance that module will be released under the PostgreSQL license
> > (BSD-like)?  We'd certainly like to see what those are doing and I do
> > wonder if we could use the hooks instead, if the SELinux community feels
> > that's a worthwhile approach.
> >
> > Thanks!
> >
> > * Ted Toth (txtoth@gmail.com) wrote:
> >> Sorry these are in a module I've developed.
> >>
> >> Ted
> >>
> >> On Thu, May 28, 2015 at 2:28 PM, Stephen Smalley <sds@tycho.nsa.gov> w=
rote:
> >> > On 05/28/2015 03:10 PM, Ted Toth wrote:
> >> >> Unfortunately it is the latter. Here's an example of what you can d=
o:
> >> >>
> >> >> CREATE TABLE reports (
> >> >>     id integer NOT NULL,
> >> >>     report json,
> >> >>     message_id integer NOT NULL,
> >> >>     location geometry(Point),
> >> >>         security_label text DEFAULT sepostgres_getpeercon()
> >> >> );
> >> >>
> >> >> CREATE POLICY
> >> >>   check_report_insert_selinux ON reports FOR INSERT
> >> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> >> >> sepostgres_getpeercon(), 'insert'));
> >> >>
> >> >> CREATE POLICY
> >> >>   check_report_delete_selinux ON reports FOR DELETE
> >> >>   USING (sepostgres_check_row_perm(reports.security_label,
> >> >> sepostgres_getpeercon(), 'delete'));
> >> >>
> >> >> CREATE POLICY
> >> >>   check_report_update_selinux ON reports FOR UPDATE
> >> >>   USING (sepostgres_check_row_perm(reports.security_label,
> >> >> sepostgres_getpeercon(), 'update'))
> >> >>   WITH CHECK (sepostgres_check_row_perm(reports.security_label,
> >> >> sepostgres_getpeercon(), 'update'));
> >> >>
> >> >> CREATE POLICY
> >> >>   check_report_select_selinux ON reports FOR SELECT
> >> >>   USING (sepostgres_check_row_perm(sepostgres_getpeercon(),
> >> >> reports.security_label, 'select'));
> >> >>
> >> >> I'm hoping that between DAC, postgresql DAC, selinux policy and RLS
> >> >> policy we can get something that's secure enough for our purposes.
> >> >
> >> > Pardon my ignorance, but are the sepostgres_*() functions something =
you
> >> > have implemented or something in the existing sepgsl or postgres cod=
e?
> >> _______________________________________________
> >> Selinux mailing list
> >> Selinux@tycho.nsa.gov
> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.

--KfkUYJP3oDyf1HAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ3FVAAoJEO1sijiDR2RVjxEP/RcGTnsotBjM6yX5cMSMB6Ec
r72MhLPauo6tkbxJkwwuHCZHr+RgXXFDXDHqyQrmVHaIs4EgHG332w+dRQG71JhA
d3UDnVYQTM83pIkm7YoWVuXV6ZCR4taFg6B3bEH8wLPOzhNfRAChBMyLb0HDJ7C9
htJn+VSKZTVlJc6cASksWQ0jbIMPJ0PqMFMnWowECEfISBXdBN3WvyvU9ZnSrtVE
gBTE761vMVLzNJ6MK3ScwYbVIdKFl+BAvpQxZfoY0c/kXjLHvIKbgy/kVzKBKXt/
pUR9gpvosgW2Y5/4bOQNgdNOL9Zdp1zv/S+/FDnFPQWNpk2JPp9BZFLL5xu8gEm+
bfoLdl1kpgove6Uwi00zEM7D7kejCOZYAd4/jFn6p3ES34mxJyJALOaluNecHlOH
5Q13lFGWvQH2L99coCy44TxHUHfusKg/Kg11v2TAmn4NGkcZ3cWX6Lv9Id7+NKFF
HtGbTAV319DftjcY2mRr1Rubj0k2rSsFFaxx6mvF+Sc5fkJsPW0ORd035winWHko
qq2P7ZhNR14teBHi10VoslqIiMo6azWzGhzHjC0OP6HIyAugU1FwipbcvV7Mkwyl
edwnsXL7uJZIBqfEJjjYyviyPwNx7MZciZeU+vfPD21KGbuD0cy76orDydc6N2lX
TztFEtwVjalgDhlIZbOv
=Y8mN
-----END PGP SIGNATURE-----

--KfkUYJP3oDyf1HAg--
