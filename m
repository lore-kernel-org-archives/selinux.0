Date: Thu, 28 May 2015 15:43:06 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Ted Toth <txtoth@gmail.com>
Subject: Re: postgresql policy
Message-ID: <20150528194306.GJ26667@tamriel.snowman.net>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <20150528190926.GG26667@tamriel.snowman.net>
 <55676C25.5040609@tycho.nsa.gov>
 <CAFPpqQEFQ+RQsbztDUM=2rfb=oy5=J9aAt0mfBFsrte_TfH9iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VDc1TgllIlsABkyJ"
In-Reply-To: <CAFPpqQEFQ+RQsbztDUM=2rfb=oy5=J9aAt0mfBFsrte_TfH9iw@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--VDc1TgllIlsABkyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ted,

That certainly sounds like it makes a lot of sense.

Is that function available under RHEL 6.5, or just later versions?  I
know there has been a fair bit of work in this area.

Thanks!

* Ted Toth (txtoth@gmail.com) wrote:
> In fact I'm using a variant of selinux_check_access in my
> sepostgres_check_row_perm function that I called
> selinux_check_access_noaudit since the select policy may naturally
> fail perm checks on rows that are above the callers level and I don't
> want generate audit storms.
>=20
> On Thu, May 28, 2015 at 2:27 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
> > On 05/28/2015 03:09 PM, Stephen Frost wrote:
> >> Stephen,
> >>
> >> * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> >>> On 05/28/2015 12:52 PM, Ted Toth wrote:
> >>>> The ref policy contains a number of sepgsql_ types that are specific
> >>>> to the sepgsql postgresql module. The sepgsql module was written to
> >>>> support a postgresql security patch that was never accepted by the
> >>>> upstream. Now postgresql has gone in a different direction security
> >>>> wise adding row level security (RLS). I've been working on developing
> >>>> RLS policy to label rows on insert and update and to check access
> >>>> perms on select. I've tried using the sepgsql module in the RLS poli=
cy
> >>>> but have come to the conclusion that because it was not designed for
> >>>> this purpose it is not usable. So I'd like to suggest that these typ=
es
> >>>> be moved out of the postgresql policy possibly into their own module
> >>>> although I personally think they have little if any use.
> >>>
> >>> Should probably post a rfc patch to refpolicy list.
> >>>
> >>> On a different note, does this RLS implementation have any SELinux
> >>> integration or is it just the typical "let's implement our own custom
> >>> policy engine in the database manager and not link it in any way to t=
he
> >>> OS security model" approach?  Pity if it is the latter.
> >>
> >> As the one who committed RLS to PostgreSQL, I'm hopeful that what we
> >> have is actually able to provide both.  There is a system inside of
> >> PostgreSQL for creating policies, which was a requirement of the PG
> >> community as we fully expect it to be used in non-SELinux environments,
> >> but there are also hooks available where a module (such as the sepgsql
> >> contrib module that's included with PG) could add its own restrictive
> >> and/or permissive policies.
> >
> > Thanks, glad to hear that there are at least hooks available.
> >
> >> I'm certainly interested in the type changes being discussed here and
> >> would love to work with someone from the SELinux community on improving
> >> the sepgsql contrib module (or, perhaps, adding a different and simpler
> >> module which is closer to a shim around SELinux than the existing
> >> sepgsql module).
> >
> > Yes, the latter might be the best path.  It could use the newer
> > selinux_check_access() interface in libselinux for checking whether a
> > given permission is granted and avoid having to replicate or directly
> > use the lower level interfaces.
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.

--VDc1TgllIlsABkyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ2/KAAoJEO1sijiDR2RVO+MQALUAH3wL+QUrjOrG6bJjTel4
wz84kDq9c7Y+frss2ql7U14JIubJkKAGnGhRoIDZizLlMvUCs+oxVdZCP44slpQD
gg2KTQQrvRoPlJFpDTtRpsvCUF2rpYjT9IO5NzLtwZWsPa6eevIyI+qAUOoW2VqL
VHtGNfnpe9BdG/g6QdHD0zYDgoYzkyb+BPth7ZieF2mmH0Hz0d0reyPIKaMAXC0j
kuQ6oghtAkGG0oAAD44pwBGUIosBS5L4UM9vdkU0eaNFHWdd2niDHPSdqheDBtHq
GGRoH43oyFmY0xqabTACB3cvYhnfqYUSP1nkZnHIwJwo4xdR8SR/mF2gFtEg0EhK
Krb+A3NdYAQ7k4Gw7UmkfLUNmeZ/0EWXa2J9FWVeEjGes2ERkyqaoID/kO8OjxSl
MTKDboQGDIT9Txqq1dyJBvGxwu96+G3Qd82RBly14QVah1OKfIbAtvmWq/07Q6sr
efGnZTdg75OhOHBNIF8C3/BxjUS7hjYyFVdCnKoQs3v2dYdlJew8L5BQ1JxB1kQI
6meLRfOYqY+FZrPSJ8MY29x1sAPrCLO7oc40nObxw8NXwL99LU2EJ1P9FPz/0pLS
MNwvWvMFiRCXK/lP0g/ZrjrG2b2Lbc1yXvtsJHYvHKjzaVKX/le2c95yTN9GGLvm
q2hvsBSf96fbL6WVk0IV
=5Kj3
-----END PGP SIGNATURE-----

--VDc1TgllIlsABkyJ--
