Date: Fri, 12 Jan 2018 10:42:12 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 SELinux <selinux@tycho.nsa.gov>
Message-ID: <20180112094212.GC6488@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <2f76cc8e-b5a5-024e-2c60-baff93fa0bb9@redhat.com>
 <1515510708.24762.10.camel@tycho.nsa.gov>
 <1515517010.5234.4.camel@btinternet.com>
 <1515518652.24762.17.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
In-Reply-To: <1515518652.24762.17.camel@tycho.nsa.gov>
Subject: Re: Re: selabel_lookup() with MEDIA backend issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 12:24:12PM -0500, Stephen Smalley wrote:
> On Tue, 2018-01-09 at 16:56 +0000, Richard Haines wrote:
> > On Tue, 2018-01-09 at 10:11 -0500, Stephen Smalley wrote:
> > > On Mon, 2018-01-08 at 16:10 +0100, Vit Mojzis wrote:
> > > > Hi all,
> > > > there seems to be a discrepancy between man page and actual
> > > > behavior
> > > > of=A0
> > > > selabel_lookup() with MEDIA backend.
> > > > selabel_media man page says:
> > > > =A0=A0=A0=A0=A0"Should there not be a valid entry in the media file=
, then
> > > > the=A0
> > > > default removable_context file will be read (see
> > > > removable_context(5))."
> > > >=20
> > > > but the removable_context file is never used (for more details
> > > > and
> > > > a=A0
> > > > reproducer see https://bugzilla.redhat.com/show_bug.cgi?id=3D139562
> > > > 1)
> > > > .
> > > >=20
> > > > I can see two possible solutions:
> > > > =A0=A0=A01) Remove the removable_context file and adjust man pages
> > > > accordingly.
> > > >=20
> > > > =A0=A0=A02) (Probably better) Add mechanism for using the
> > > > removable_context
> > > >=20
> > > > Which one would you prefer?
> > > >=20
> > > > In case of the latter, would adding the content of
> > > > removable_context=A0
> > > > file to saved_data->spec_arr[nspec + 1] (label_media.c) and
> > > > returning
> > > > it=A0
> > > > in case lookup fails be a reasonable solution?
> > > >=20
> > > > Thank you.
> > >=20
> > > It appears that selinux_removable_context_path() and the
> > > removable_context configuration were added by Dan Walsh in 2004 for
> > > use
> > > by an external caller.=A0=A0The selabel_media backend wasn't introduc=
ed
> > > until 2007, and has never called selinux_removable_context_path()
> > > AFAICT.=A0=A0The man page reference to removable_context in
> > > selabel_media.5
> > > was added by Richard Haines in 2011.=A0=A0I think the man page is just
> > > wrong.=A0=A0I don't know if there are any users of
> > > selinux_removable_context_path() still but we can't remove it
> > > without
> > > breaking ABI.
> > >=20
> >=20
> > As I screwed up the man page I'll fix, however would you prefer
> > option
> > 2 where it will check the removable_context file as I'm happy to do
> > that instead.
>=20
> I don't think we should change the behavior of the label media backend,
> since this is not a regression in the code and altering it could have
> side effects on existing callers. I would appreciate it if someone
> could check whether selinux_removable_context_path() is in fact used by
> anything still, and if so, how (e.g. are they using it as a fallback in
> the event of selabel_lookup failure?). I couldn't seem to find any
> callers in the debian codesearch tool, but not sure if Fedora has
> anything equivalent?
>=20

There's no such equivalent for Fedora. But I checked sources in Red Hat Ent=
erprise
Linux and I didn't find anything what would use
selinux_removable_context_path().

Petr

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpYgugACgkQY6itS5gs
Q3NEjxAAooCAQy2fvaWdJYWsrW1LHatLRxI4GH1xKBcmdMtIkKfsDZ5GCOTQseyd
yh5BPfJaTgWTDYNyI5BJtR6fFIApY6oRYNpcZF0mOH0muwEHlg8zvr5WEFzgqZ0r
rfZ39a3i/AHEBuekJRP4hn67CiXc4x9zUkSOS6KN9espmFlY1ol7kAGjDD+/CvTM
TH3GHYzvfFzig+nyC9bL50RWl33o5B+tq8VIqJBu8K8ILSqNhFH+WdNBqciSZhmp
PPcJN4PL8fyi7oFrH9e9WMlOhro53MCEjgdtLiDBmlgr0C39nsRjsVxkqmHZIhSq
sSHbzO6RGbNbdXwiy/Du+oLFXLP+8pNAnS6U8ZFTk0qXi/fzi/p31sFq7DAONePf
ElLLOgn86LEnLfO6TnNkcV16wkdNrNNP2wLD6ftGKKeYilMdtUmXImzYUnoMDU42
IF28Rl02u66FNlLZVQHbM6aa5BMUo7S9VdUvspfXKj1qrksc9g8J22LK+IJmw6/l
LoudBgFby30nYaZyx+FI1IGH2oxm9pu/SCGWyZcAGCFcNejisoTckdafcHnhAVm7
oqDGmFnVvfwtU3C4healnZjDEldPC6pWe5I7tV9qKxOXNgftECLlN6H86wJl4cLL
+0ACrktyzm6Ez8DEr1yZZhCpggk91P8ROZYtCIi5uQVeadboWvk=
=+71g
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
