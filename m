Date: Fri, 20 Apr 2018 15:31:41 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>, Yuli Khodorkovskiy <ykhodo@gmail.com>
Message-ID: <20180420133104.GB2126@workstation>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <20180420123135.GA2126@workstation>
 <1ec7a74e-c05e-48ef-c2d1-b97d5c8ef58f@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <1ec7a74e-c05e-48ef-c2d1-b97d5c8ef58f@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace 2.8-rc1 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 08:49:41AM -0400, Stephen Smalley wrote:
> On 04/20/2018 08:31 AM, Petr Lautrbach wrote:
> > On Thu, Apr 19, 2018 at 11:07:39AM -0400, Stephen Smalley wrote:
> >> A 2.8-rc1 release candidate for the SELinux userspace is now available=
 at:
> >> https://github.com/SELinuxProject/selinux/wiki/Releases
> >>
> >> Please give it a test and let us know if there are any issues.
> >=20
> >=20
> > I've built in my Fedora COPR repo [1] and I'm running Fedora CI [2] tes=
ts on it.=20
> >=20
> > So far there's one problem found by libselinux/selabel-function [3] tes=
t. It
> > looks like commit 814631d3aebaa changed the behavior of selabel_open() =
when
> > SELABEL_OPT_VALIDATE is null - a context should not be validated, but i=
t is.
>=20
> So, is this a bug in the test or a bug in libselinux?  As noted in that c=
ommit description,
> failing to verify contexts at all before use can lead to applying an inva=
lid label (if the system is permissive).

selabel_open(3) states that "an invalid context may not be treated as  an
error unless it is actually encountered during a lookup operation ". So at
least, it's some disproportion between the code and the documentation.=20

I read the commit message as that a context should be validated before it's
applied. But now it's validated during lookup.



> Are there real users of libselinux that rely on the current behavior or i=
s there some use case where
> it is desirable?

I don't know. I was thinking about setfiles but it always validate. There m=
ight be 3rd party users who
lookups for labels in chroot.


> >=20
> > The reproducer code:
> >=20
> > #include <errno.h>
> > #include <stdio.h>
> >=20
> > #include <selinux/selinux.h>
> > #include <selinux/label.h>
> >=20
> > int main() {
> >   struct selabel_handle *hnd =3D NULL;
> >   security_context_t selabel_context;
> >=20
> >   struct selinux_opt selabel_option [] =3D {
> >     { SELABEL_OPT_PATH, "my_contexts" },
> >     { SELABEL_OPT_SUBSET, NULL },
> >     { SELABEL_OPT_VALIDATE, (char *) 0 },
> >     { SELABEL_OPT_BASEONLY, (char *) 0 }
> >   };
> >   int result =3D 0;
> >=20
> >   if ((hnd =3D selabel_open(SELABEL_CTX_FILE, selabel_option, 4)) =3D=
=3D NULL) {
> >     return 1;
> >   }
> >=20
> >   if ((result =3D selabel_lookup_raw(hnd, &selabel_context, "/tmp/mypat=
h", 0)) =3D=3D -1) {
> >     perror("selabel_lookup_raw - ERROR");
> >     return 1;
> >   }
> >=20
> >   printf("%s\n", selabel_context);
> >=20
> >   return 0;
> > }
> >=20
> > ---
> >=20
> > $ gcc -o selabel_reproducer selabel_reproducer.c -lselinux
> > $ echo '/tmp/mypath  my_user_u:my_role_r:my_type_t:s' > my_contexts
> >=20
> > Before:
> >=20
> > $ ./selabel_reproducer
> > my_user_u:my_role_r:my_type_t:s
> >=20
> > After:
> >=20
> > $ ./selabel_reproducer
> > my_contexts: line 1 has invalid context my_user_u:my_role_r:my_type_t:s
> > selabel_lookup_raw - ERROR: Invalid argument
> >=20
> >=20
> >=20
> >=20
> > [1] https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/pac=
kages/
> > [2] https://src.fedoraproject.org/tests/selinux/tree/master
> > [3] https://src.fedoraproject.org/tests/selinux/blob/master/f/libselinu=
x/selabel-functions
> >=20
> >> If there are specific changes that you think should be called out in
> >> release notes for packagers and users in the final release announcemen=
t, let us know.
> >>
> >> Thanks to all the contributors to this release candidate!
> >>
> >> A shortlog of changes since the 2.7 release is below.
> >>
> >> Dan Cashman (1):
> >>       libsepol: cil: Add ability to redeclare types[attributes]
> >>
> >> Dominick Grift (1):
> >>       Describe multiple-decls in secilc.8.xml
> >>
> >> Gr=E9goire Colbert (1):
> >>       Fixed bad reference in roleattribute
> >>
> >> James Carter (4):
> >>       libsepol/cil: Keep attributes used by generated attributes in ne=
verallow rules
> >>       libsepol/cil: Create new keep field for type attribute sets
> >>       libsepol: Prevent freeing unitialized value in ibendport handling
> >>       libsepol/cil: Improve processing of context rules
> >>
> >> Jan Zarsky (6):
> >>       libsepol: reset pointer after free
> >>       libsepol: fix memory leak in sepol_bool_query()
> >>       libsepol: free ibendport device names
> >>       libsemanage: free genhomedircon fallback user
> >>       libsemanage: properly check return value of iterate function
> >>       python/sepolgen: fix typo in PolicyGenerator
> >>
> >> Lee Stubbs (1):
> >>       Minor update for bash completion. Bash completion for ports is m=
issing '-' for type. Based on documentation, it should be --type, not -type.
> >>
> >> Lukas Vrabec (1):
> >>       python/sepolicy: Fix sepolicy manpage.
> >>
> >> Marcus Folkesson (15):
> >>       libsepol: build: follow standard semantics for DESTDIR and PREFIX
> >>       libselinux: build: follow standard semantics for DESTDIR and PRE=
FIX
> >>       libsemanage: build: follow standard semantics for DESTDIR and PR=
EFIX
> >>       checkpolicy: build: follow standard semantics for DESTDIR and PR=
EFIX
> >>       gui: build: follow standard semantics for DESTDIR and PREFIX
> >>       mcstrans: build: follow standard semantics for DESTDIR and PREFIX
> >>       policycoreutils: build: follow standard semantics for DESTDIR an=
d PREFIX
> >>       python: build: follow standard semantics for DESTDIR and PREFIX
> >>       python: build: move modules from platform-specific to platform-s=
hared
> >>       restorecond: build: follow standard semantics for DESTDIR and PR=
EFIX
> >>       sandbox: build: follow standard semantics for DESTDIR and PREFIX
> >>       secilc: build: follow standard semantics for DESTDIR and PREFIX
> >>       semodule-utils: build: follow standard semantics for DESTDIR and=
 PREFIX
> >>       dbus: build: follow standard semantics for DESTDIR and PREFIX
> >>       build: setup buildpaths if DESTDIR is specified
> >>
> >> Nicolas Iooss (36):
> >>       Travis-CI: use sugulite environment
> >>       Travis-CI: do not test gold linkers with clang
> >>       sepolicy: fix Python3 syntax in manpage
> >>       sepolicy: do not fail when file_contexts.local does not exist
> >>       sepolicy: fix misspelling of _ra_content_t suffix
> >>       sepolicy: support non-MLS policy in manpage
> >>       sepolicy: support non-MCS policy in manpage
> >>       sepolicy: remove stray space in section "SEE ALSO"
> >>       libsepol: use IN6ADDR_ANY_INIT to initialize IPv6 addresses
> >>       libsepol/cil: __cil_post_db_neverallow_attr_helper() does not us=
e extra_args
> >>       libsepol/cil: fix -Wwrite-strings warning
> >>       libsepol/cil: drop wrong unused attribute
> >>       restorecond: check write() and daemon() results
> >>       Makefile: define a default value for CFLAGS
> >>       sepolicy: do not fail when file_contexts.local or .subs do not e=
xist
> >>       gui: port to Python 3 by migrating to PyGI
> >>       Travis-CI: fix configuration after September's update
> >>       sepolicy: ignore comments and empty lines in file_contexts.subs_=
dist
> >>       sepolicy: support non-MLS policy in gui
> >>       gui: remove the status bar
> >>       gui: fix parsing of "semodule -lfull" in tab Modules
> >>       gui: delete overridden definition of usersPage.delete()
> >>       gui: remove mappingsPage
> >>       Travis-CI: try working around network issues by retrying downloa=
ds
> >>       Travis-CI: do not duplicate $DESTDIR in $PYSITEDIR
> >>       python/sepolicy: Fix translated strings with parameters
> >>       python/sepolicy: Support non-MLS policy
> >>       python/sepolicy: Initialize policy.ports as a dict in generate.py
> >>       libsepol: cil: show an error when cil_expr_to_string() fails
> >>       libsemanage: silence clang static analyzer report
> >>       libselinux,libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
> >>       libsepol: do not dereference NULL if stack_init fails
> >>       libsepol: ensure the level context is not empty
> >>       libselinux: label_file: fix memory management in store_stem()
> >>       libselinux: fix memory leak in getconlist
> >>       libselinux: remove unused variable usercon
> >>
> >> Petr Lautrbach (12):
> >>       libselinux: Add support for pcre2 to pkgconfig definition
> >>       python/semanage: drop *_ini functions
> >>       python/semanage: Don't use global setup variable
> >>       python/semanage: Enforce noreload only if it's requested by -N o=
ption
> >>       libsemanage: Use umask(0077) for fopen() write operations
> >>       python/semanage: make seobject.py backward compatible
> >>       python/semanage: bring semanageRecords.set_reload back
> >>       gui/polgengui.py: Fix sepolicy.generate import in polgengui.py
> >>       gui/polgengui.py: Convert polgen.glade to Builder format polgen.=
ui
> >>       python/sepolicy: Use list instead of map
> >>       python/sepolicy: Do not use types.BooleanType
> >>       gui/polgengui.py: Use stop_emission_by_name instead of emit_stop=
_by_name
> >>
> >> Richard Haines (3):
> >>       libselinux: Correct manpages regarding removable_context
> >>       libsemanage: Return commit number if save-previous false
> >>       libsemanage: Allow tmp files to be kept if a compile fails
> >>
> >> Richard Haines via Selinux (1):
> >>       selinux: Add support for the SCTP portcon keyword
> >>
> >> Stephen Smalley (4):
> >>       checkpolicy,libselinux,libsepol,policycoreutils: Update my email=
 address
> >>       semodule-utils: remove semodule_deps
> >>       libsepol: Export sepol_polcap_getnum/name functions
> >>       Update VERSION files to 2.8-rc1
> >>
> >> Tri Vo (1):
> >>       Resolve conflicts in expandattribute.
> >>
> >> Vit Mojzis (18):
> >>       libsemanage: Keep copy of file_contexts.homedirs in policy store
> >>       libsemanage: Add support for listing fcontext.homedirs file
> >>       python/semanage: Enable listing file_contexts.homedirs
> >>       python/semanage: Fix export of ibendport entries
> >>       python/semanage: Update Infiniband code to work on python3
> >>       python/semanage: Remove redundant and broken moduleRecords.modif=
y()
> >>       semodule-utils/semodule_package: fix semodule_unpackage man page
> >>       libsemanage: Improve warning for installing disabled module
> >>       gui/semanagePage: Close "edit" and "add" dialogues when successf=
ull
> >>       gui/fcontextPage: Set default object class in addDialog
> >>       libsemanage: remove access() check to make setuid programs work
> >>       libsemanage: remove access() check to make setuid programs work
> >>       libsemanage: replace access() checks to make setuid programs work
> >>       libsemanage/direct_api.c: Fix iterating over array
> >>       policycoreutils/semodule: Improve man page and unify it with --h=
elp
> >>       policycoreutils/semodule: Allow enabling/disabling multiple modu=
les at once
> >>       python/sepolgen: Try to translate SELinux contexts to raw
> >>       libsemanage: do not change file mode of seusers and users_extra
> >>
> >> Yuli Khodorkovskiy (3):
> >>       secilc: Fix documentation build for OS X systems
> >>       libselinux: verify file_contexts when using restorecon
> >>       libselinux: echo line number of bad label in selabel_fini()
> >>
> >>
>=20

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlrZ67YACgkQviIJHj72
InXWlQ/+J3UjVql6/6sRNB1Bm9txyVqWCpFFgC+JeN5t7sPbzNrnjUMu9sJrOSm0
H/EQAEhorTN/gwtkZwGv2dmYk1YmchWrM1HRdoaARIhl7SdKrgCkgoHwigu7jYVM
dCHWVQWYIVwRKg6j1tzvaYxUPVlAJHZW5EY37UGAjcx3hc1qbcjrvpyF7ekCikAm
RbaY5RBWXi4TWIS0ro4eOeGi4ljsRK9fo4OgvV7UfwJ4LTFRJ3ij2y8YTdGmvAmM
+j8MoeFJU0kLWFjK5mydVdoI7JyPaB4OqywEwcoIpPLVm3+4QW1/0nRoJlxSe5At
oDP3iAs/OBQXQ6Eoypx+/TKZuIfe8Iz/W+YQ/zL+qxmhe97CexQWme48k9caadK9
YfMrD6gjywymjzfBY/ldcxVzviLvnhWXTTSPbGs3eR6zVPjiN6Rjpls0QGyrb6X2
4DxIuzEb7bsGsv73D4evq60C4Qc2/p06pS7laeOfRkqzfwOFxZuAkYwgOSrPUryr
xXUbgRfaOUgsNanIDfePvryEzKkCgrO+p8O2e8BeSSKaPugRtFC/mC5OAD3c314D
L8wqRpn/80ajQpCQf28HlB222ssVJk+l12krKNjKOH/5yBUfGJygNPFju9Qj088b
ztbih3WIj7cG91mBHVhPhEkBueDPArZYqXaXgwwh04PvErQg9tA=
=8RmM
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
