Date: Tue, 19 Jun 2018 18:32:24 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180619163224.GC16326@workstation>
References: <20180618192443.GA8162@workstation>
 <b0a52b4d-ff8c-8970-d738-8901ff37b12a@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
In-Reply-To: <b0a52b4d-ff8c-8970-d738-8901ff37b12a@tycho.nsa.gov>
Subject: Re: is_selinux_enabled() after chroot()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:06:11PM -0400, Stephen Smalley wrote:
> On 06/18/2018 03:24 PM, Petr Lautrbach wrote:
> > Hello,
> >=20
> > libselinux sets selinut_mnt and has_selinux_config only in its construc=
tor and
> > is_selinux_enabled() and others just use selinux_mnt to check if SELinu=
x is
> > enabled. But it doesn't work correctly when you use chroot() to a direc=
tory without /proc
> > and /sys/fs/selinux mounted as it was discovered in
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1321375=20
> >=20
> > In this case, is_selinux_enabled() after chroot() returns true while in=
 a new
> > program run from chrooted process it returns false. It can be demonstra=
ted by
> > the steps below.
> >=20
> > The solution could be to check if selinux_mnt still exists whenever a f=
unction
> > depending on this is called. Would this be acceptable?
>=20
> You want to call stat() or access(F_OK) on selinux_mnt and/or SELINUXCONF=
IG in is_selinux_enabled()?

Yes. I was thinking about something like this:

@@ -16,7 +16,7 @@ int is_selinux_enabled(void)
 #ifdef ANDROID
 	return (selinux_mnt ? 1 : 0);
 #else
-	return (selinux_mnt && has_selinux_config);
+	return (selinux_mnt && (access(selinux_mnt, F_OK) =3D=3D 0) && has_selinu=
x_config);
 #endif
 }

But the problem seems to be more complex and it would probably be better to=
 fix
it on a callers side - mount /sys/fs/selinux and /proc into chroots or do a=
ll
SELinux checks before chroot().

> Could potentially trigger a permission check that wasn't previously requi=
red, thereby breaking existing policies.
> Caller might just be checking to see if SELinux is enabled before using i=
nterfaces other than selinuxfs (e.g. setexeccon, setfilecon, etc) and there=
fore didn't previously need permissions to selinuxfs or /etc/selinux/config.
> So, possible but you'd need to make sure you don't break anything.  Defin=
itely don't want that changed in Android.
> >=20
> >=20
> >=20
> >=20
> > $ sudo dnf --nogpg --installroot=3D/var/lib/machines/example  install s=
ystemd
> >=20
> > $ cat > test_libselinux.c <<EOF
> > #include <selinux/selinux.h>
> > #include <stdio.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <unistd.h>
> >=20
> > int main(int argc, char *argv[]) {
> >   pid_t pid;
> >   int wstatus;
> >=20
> >   if (argc > 1) {
> >     printf("SELinux in chrooted process: %d\n", is_selinux_enabled());
> >     return 0;
> >   }
> >   if (chroot("/var/lib/machines/example") !=3D 0)
> >     return -1;
> >=20
> >   printf("SELinux in process after chroot(): %d\n", is_selinux_enabled(=
));
> >   printf("/sys/fs/selinux exists: %d\n", access("/sys/fs/selinux", F_OK=
));
> >   printf("/etc/selinux/config exists: %d\n\n", access("/etc/selinux/con=
fig", F_OK));
> >=20
> >   if ((pid =3D fork()) =3D=3D 0 ) {
> >     execv("./test_is_selinux_enabled", (char *[]){ "./test_is_selinux_e=
nabled", "chrooted", NULL});
> >   }
> >=20
> >   wait(&wstatus);
> >   return 0;
> > }
> > EOF
> >=20
> > $ gcc -o test_is_selinux_enabled test_libselinux.c -lselinux
> >=20
> > $ sudo ./test_is_selinux_enabled                           =20
> > SELinux in process after chroot(): 1
> > /sys/fs/selinux exists: -1
> > /etc/selinux/config exists: -1
> >=20
> > SELinux in chrooted process: 0
> >=20
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
> >=20
>=20

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlspMBIACgkQviIJHj72
InUJUQ//VVl+WG3exJSCxZa6T0Q+LijHhmG+AGsQUP9GBtqTeRDECuyyQ+1mVXLs
sWbqdSZzli9MRltzU4hdAPt2MkdxRem6Z1/4H3bZPehdnaToqsJGC0WgcMGlt34R
RNsgzGt9C3J6qF8UKySOjVJRn0/DspgWukeAOXESbNOMXpHSRaWlPC5FBqpjNB0o
idOZfGrJ6oFx61SNCabgSEmqXb4jKDU0tZ9VmyWSgHKYfF/7AsMMrLSalxEH5mNT
renLkGgsw96YLmBJJ4kbmJ/c5gjroWvvaJSZDEFrwGkzdmM/qiEWnglF+C79guhk
7Zk+Rk+J3birF2fGj6f10LOC43cfoYJ57QlXPCPARb8ujK6xlJLD2Lrcq+iOvYwa
xF9NQKXTriScZn5I9Rz3TYUReByi/mqfmuSMAhmNjKeDffpQKh59KuFOlajJjFN5
Oj22gT4LC3KdXZWsSNUhHiG9xU+R2foI/Ex5uOKqx8Ji+23vg+dL5PQxpzsRJAHF
+lxoUat5CfHLnxAF/d3nScreokP36QdIRASZdehOTGyW9P9ufFOurwn6fEUnluas
JQgTWv/KWGf1k1PBzNTqBGe+b3IlcOUxNfkczo3YXNuhhjEeXHLBQVcZob9BKx9d
FAitie9+tn+RsZvJiHukrwjcAYuNeGtHdZh9vU3JkH1qJ+0TLwo=
=Tvcq
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
