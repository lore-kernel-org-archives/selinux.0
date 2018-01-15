Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0FGBOuP006011
 for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2018 11:11:24 -0500
Date: Mon, 15 Jan 2018 17:11:00 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Message-ID: <20180115161059.GL11058@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20180114153436.21916-1-richard_c_haines@btinternet.com>
 <CAFftDdrCMd9Zw-gUf=er5rsAd5EfnpTwASXYikEeZDbr-iowrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
In-Reply-To: <CAFftDdrCMd9Zw-gUf=er5rsAd5EfnpTwASXYikEeZDbr-iowrQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Allow tmp files to be kept if a compile fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 07:46:27AM -0800, William Roberts wrote:
> On Sun, Jan 14, 2018 at 7:34 AM, Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Add new option to semanage.conf that allows the tmp build files
> > to be kept for debugging when building policy.
>=20
> How do people know where the tmp files are, does something print it out o=
r is it
> documented in a manpage somewhere?

I usually see them when I try to load a module with some problem, e.g.

# semodule -i myconfined10.cil  =20
neverallow check failed at /var/lib/selinux/targeted/tmp/modules/100/base/c=
il:13249
=2E..


=20
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  libsemanage/man/man5/semanage.conf.5 |  8 ++++++++
> >  libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
> >  libsemanage/src/conf-scan.l          |  1 +
> >  libsemanage/src/direct_api.c         | 21 ++++++++++++---------
> >  libsemanage/src/semanage_conf.h      |  1 +
> >  5 files changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man=
5/semanage.conf.5
> > index 8f8de55a..10cab65a 100644
> > --- a/libsemanage/man/man5/semanage.conf.5
> > +++ b/libsemanage/man/man5/semanage.conf.5
> > @@ -121,6 +121,14 @@ and by default it is set to "false".
> >  Please note that since this option deletes all HLL files, an updated H=
LL compiler will not be able to recompile the original HLL file into CIL.
> >  In order to compile the original HLL file into CIL, the same HLL file =
will need to be reinstalled.
> >
> > +.TP
> > +.B retain-tmp
> > +When set to "true", tmp directories (the sandbox at \fBstore-root/\fR[=
\fIpolicy-store\fR]\fB/tmp \fRand/or the final policy at \fBstore-root/fina=
l/\fR[\fIpolicy-store\fR]) will be retained after compilation to allow debu=
gging of any build errors. Note that on a successful build the sandbox beco=
mes \fBstore-root/\fR[\fIpolicy-store\fR]\fB/active\fR.
> > +.br
> > +The
> > +.B retain-tmp
> > +option can be set to either "true" or "false" and by default it is set=
 to "false".
> > +
> >  .SH "SEE ALSO"
> >  .TP
> >  semanage(8)
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> > index b527e893..f098e55d 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -61,7 +61,7 @@ static int parse_errors;
> >
> >  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_=
LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
> >  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISAB=
LE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> > -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> > +%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL RETAIN_TMP
> >  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_=
END
> >  %token PROG_PATH PROG_ARGS
> >  %token <s> ARG
> > @@ -95,6 +95,7 @@ single_opt:     module_store
> >         |       bzip_blocksize
> >         |       bzip_small
> >         |       remove_hll
> > +       |       retain_tmp
> >          ;
> >
> >  module_store:   MODULE_STORE '=3D' ARG {
> > @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
> >         free($3);
> >  }
> >
> > +retain_tmp:  RETAIN_TMP'=3D' ARG {
> > +       if (strcasecmp($3, "false") =3D=3D 0) {
> > +               current_conf->retain_tmp =3D 0;
> > +       } else if (strcasecmp($3, "true") =3D=3D 0) {
> > +               current_conf->retain_tmp =3D 1;
> > +       } else {
> > +               yyerror("retain-tmp can only be 'true' or 'false'");
> > +       }
> > +       free($3);
> > +}
> > +
> >  command_block:
> >                  command_start external_opts BLOCK_END  {
> >                          if (new_external->path =3D=3D NULL) {
> > @@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * con=
f)
> >         conf->bzip_small =3D 0;
> >         conf->ignore_module_cache =3D 0;
> >         conf->remove_hll =3D 0;
> > +       conf->retain_tmp =3D 0;
> >
> >         conf->save_previous =3D 0;
> >         conf->save_linked =3D 0;
> > diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> > index 607bbf0b..e26c3494 100644
> > --- a/libsemanage/src/conf-scan.l
> > +++ b/libsemanage/src/conf-scan.l
> > @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
> >  bzip-blocksize return BZIP_BLOCKSIZE;
> >  bzip-small     return BZIP_SMALL;
> >  remove-hll     return REMOVE_HLL;
> > +retain-tmp     return RETAIN_TMP;
> >  "[load_policy]"   return LOAD_POLICY_START;
> >  "[setfiles]"      return SETFILES_START;
> >  "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index a455612f..5d2a443c 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -326,7 +326,10 @@ static void semanage_direct_destroy(semanage_handl=
e_t * sh
> >  static int semanage_direct_disconnect(semanage_handle_t * sh)
> >  {
> >         /* destroy transaction */
> > -       if (sh->is_in_transaction) {
> > +       if (sh->is_in_transaction)
> > +               semanage_release_trans_lock(sh);
> > +
> > +       if (!sh->conf->retain_tmp && sh->is_in_transaction) {
> >                 /* destroy sandbox */
> >                 if (semanage_remove_directory
> >                     (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < =
0) {
> > @@ -342,7 +345,6 @@ static int semanage_direct_disconnect(semanage_hand=
le_t * sh)
> >                                                 SEMANAGE_FINAL_TOPLEVEL=
));
> >                         return -1;
> >                 }
> > -               semanage_release_trans_lock(sh);
> >         }
> >
> >         /* Release object databases: local modifications */
> > @@ -1639,13 +1641,14 @@ cleanup:
> >
> >         free(fc_buffer);
> >
> > -       /* regardless if the commit was successful or not, remove the
> > -          sandbox if it is still there */
> > -       semanage_remove_directory(semanage_path
> > -                                 (SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
> > -       semanage_remove_directory(semanage_final_path
> > -                                 (SEMANAGE_FINAL_TMP,
> > -                                  SEMANAGE_FINAL_TOPLEVEL));
> > +       /* Delete sandbox unless requested by semanage.conf */
> > +       if (!sh->conf->retain_tmp) {
> > +               semanage_remove_directory(semanage_path
> > +                                         (SEMANAGE_TMP, SEMANAGE_TOPLE=
VEL));
> > +               semanage_remove_directory(semanage_final_path
> > +                                         (SEMANAGE_FINAL_TMP,
> > +                                          SEMANAGE_FINAL_TOPLEVEL));
> > +       }
> >         umask(mask);
> >
> >         return retval;
> > diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage=
_conf.h
> > index c99ac8c7..f7bba754 100644
> > --- a/libsemanage/src/semanage_conf.h
> > +++ b/libsemanage/src/semanage_conf.h
> > @@ -46,6 +46,7 @@ typedef struct semanage_conf {
> >         int bzip_blocksize;
> >         int bzip_small;
> >         int remove_hll;
> > +       int retain_tmp;
> >         int ignore_module_cache;
> >         char *ignoredirs;       /* ";" separated of list for genhomedir=
con to ignore */
> >         struct external_prog *load_policy;
> > --
> > 2.14.3
> >
> >
>=20
>=20
>=20
> --=20
> Respectfully,
>=20
> William C Roberts
>=20
>=20

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlpc0o0ACgkQY6itS5gs
Q3O9cBAAgqV88a/OUw3iJW4FJELoP0APLokkIemD7UmPIteMR1kRxpf3XknSD5oL
X5f0b5EnWdqgg0sFI7LtfQ3dPJI6MeTA6hVl6Jm2QsO+258u3bTqROFd2atSFqsF
7Y0sSc46CadWZn40CsRJjrL7BkGVv7oOEU/uReTNwIXW4c7gZeei5ehuskjgAEWN
gSd71l0TllFNDNzD5I0qgCNQgizSG42kRPaBkIuBwrSyKiyHfVHHyVi/ZALwgkLz
mtDofoVgtnAjBya2JLapinGJW74zc6JTpRhaUQOwr4Z4rC02IKjVmug/X6emLOku
3at48JRtvX83kiWx9XYlle8tmZOyTjEoZ1g9/GpkkBozuG/aCEqcniI3nLYhMNB/
E2SvR8pIttMHwL8NeUJpw3vzbJlp97jeAVyynuzb9ZVn2cr8ia8ytifStbD2WvJ8
CiEtPYsex4ffic9JzziXLpu9A+VY30hxagaDE/aqGMQIWbxPA4VS5Fao73DF7Ge3
39IvbZn74mflzZpvYUHEP/uPXHYqo1UpF3rxegWOmgVuyFwvzhl3lZA8FqgKelZX
6n41SW7jKownNM8OryKpbjNnf45RuZFKtGSjxTOe9xb2VbLr6VjDc5d7U1hxzSBm
mIzD6GBZZiO/wDACsFwY9FOD1NXRBWHtkXcfCVokd+tfvqYQNvg=
=L5ts
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--
