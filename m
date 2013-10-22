Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MEDmAq025705
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 10:13:53 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so4312879eaj.28
        for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 07:13:46 -0700 (PDT)
Date: Tue, 22 Oct 2013 10:13:38 -0400
From: Joe MacDonald <joe@deserted.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] libselinux: avoid shadowing 'stat' in load_mmap
Message-ID: <20131022141336.GA3728@deserted.net>
References: <1382383000-16439-1-git-send-email-joe@deserted.net>
 <1382383000-16439-2-git-send-email-joe@deserted.net>
 <1382383000-16439-3-git-send-email-joe@deserted.net>
 <5265905B.2020703@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <5265905B.2020703@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

[Re: [PATCH 2/2] libselinux: avoid shadowing 'stat' in load_mmap] On 13.10.=
21 (Mon 16:36) Stephen Smalley wrote:

> On 10/21/2013 03:16 PM, Joe MacDonald wrote:
> >    label_file.c: In function =E2=80=98load_mmap=E2=80=99:
> >    label_file.c:238:81: error: declaration of =E2=80=98stat=E2=80=99 sh=
adows a global declaration [-Werror=3Dshadow]
> >    cc1: all warnings being treated as errors
>=20
> I don't particularly mind the change, but I neither see this warning nor
> see the underlying issue in the source code - where is the global stat
> declaration?  Is it in some system header file you have on your system?

I'm honestly not sure:

~/external/selinux cscope -L -1 stat
/usr/include/glob.h stat 82 struct stat;
/usr/include/sys/stat.h stat 211 extern int stat (__const char *__restrict =
__file,
/usr/include/sys/stat.h stat 225 #define stat stat64
/usr/include/sys/stat.h stat 455 __NTH (stat (__const char *__path, struct =
stat *__statbuf))
/usr/include/bits/stat.h stat 46 struct stat

glob.h is probably implicated, but this test case:

------------------------------------------------------------------------
   #include <glob.h>
   #include <sys/stat.h>

   void testfunc(struct stat *stat)
   {
      ;
   }

   int main (int argc, char *argv)
   {
      struct stat sb;
      testfunc(&sb);
   }
------------------------------------------------------------------------

Compiled with 'gcc -Wshadow foo.c -o foo' builds without warning on my
more recent setup (Debian GNU/Linux 7.2 (wheezy)) but produces the
warning on the older one:

------------------------------------------------------------------------
/tmp gcc -Wshadow foo.c -o foo
foo.c: In function =E2=80=98testfunc=E2=80=99:
foo.c:4:28: warning: declaration of =E2=80=98stat=E2=80=99 shadows a global=
 declaration [-Wshadow]
/tmp lsb_release -d
Description:    Ubuntu 12.04.3 LTS
------------------------------------------------------------------------

Removing #include <glob.h> doesn't help, though, which I wouldn't really
expect anyway since label_file.c doesn't include it directly anyway.
Maybe it's a gcc version thing?  The failing machine is "gcc
(Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3" whereas the happy one is "gcc
(Debian 4.7.2-5) 4.7.2".

Anyway, as I said in 0/2, I'm confident I'm missing something, I
shouldn't be the first one to trip over this, but I don't know what the
missing piece is, exactly.

-J.

>=20
> >=20
> > Signed-off-by: Joe MacDonald <joe@deserted.net>
> > ---
> >  libselinux/src/label_file.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 51520cf..af7c227 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -235,7 +235,7 @@ static int process_line(struct selabel_handle *rec,
> >  	return 0;
> >  }
> > =20
> > -static int load_mmap(struct selabel_handle *rec, const char *path, str=
uct stat *stat)
> > +static int load_mmap(struct selabel_handle *rec, const char *path, str=
uct stat *sb)
> >  {
> >  	struct saved_data *data =3D (struct saved_data *)rec->data;
> >  	char mmap_path[PATH_MAX + 1];
> > @@ -266,13 +266,13 @@ static int load_mmap(struct selabel_handle *rec, =
const char *path, struct stat *
> >  	}
> > =20
> >  	/* if mmap is old, ignore it */
> > -	if (mmap_stat.st_mtime < stat->st_mtime) {
> > +	if (mmap_stat.st_mtime < sb->st_mtime) {
> >  		close(mmapfd);
> >  		return -1;
> >  	}
> > =20
> > -	if (mmap_stat.st_mtime =3D=3D stat->st_mtime &&
> > -	    mmap_stat.st_mtim.tv_nsec < stat->st_mtim.tv_nsec) {
> > +	if (mmap_stat.st_mtime =3D=3D sb->st_mtime &&
> > +	    mmap_stat.st_mtim.tv_nsec < sb->st_mtim.tv_nsec) {
> >  		close(mmapfd);
> >  		return -1;
> >  	}
> >=20
>=20

--=20
-Joe MacDonald.
:wq

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJmiAcACgkQwFvcllog0XyglwCeK/X52qtKGc1wa3Alpd6RLnhA
rP8AoIi0VbqcsPKBavbxpRoBEJAidPgc
=2eiF
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
