To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
 <20180119120713.GA16873@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
Date: Mon, 22 Jan 2018 21:50:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180119120713.GA16873@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7I3IdSvKCW3wiaLJ1sTr1fCduUm4JGDY0"
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7I3IdSvKCW3wiaLJ1sTr1fCduUm4JGDY0
Content-Type: multipart/mixed; boundary="T0SXpWlHEYw3dQTEMr3hhLwYX2fz1w4F8";
 protected-headers="v1"
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c286ed2a-a228-5a2d-9457-b9033fe05fef@polytechnique.org>
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard semantics for
 DESTDIR and PREFIX
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
 <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
 <20180119120713.GA16873@gmail.com>
In-Reply-To: <20180119120713.GA16873@gmail.com>

--T0SXpWlHEYw3dQTEMr3hhLwYX2fz1w4F8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19/01/18 13:07, Marcus Folkesson wrote:
> Hi Nicolas!
>=20
> On Wed, Jan 17, 2018 at 11:12:56PM +0100, Nicolas Iooss wrote:
>> On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
>> <marcus.folkesson@gmail.com> wrote:
>>> This patch solves the following issues:
>>> - The pkg-config files generates odd paths when using DESTDIR without=
 PREFIX
>>> - DESTDIR is needed during compile time to compute library and header=
 paths which it should not.
>>> - Installing with both DESTDIR and PREFIX set gives us odd paths
>>> - Make usage of DESTDIR and PREFIX more standard
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
>>>  libselinux/include/Makefile     |  4 ++--
>>>  libselinux/man/Makefile         |  7 ++++---
>>>  libselinux/src/Makefile         | 12 +++++-------
>>>  libselinux/src/libselinux.pc.in |  2 +-
>>>  libselinux/utils/Makefile       |  6 ++----
>>>  5 files changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/libselinux/include/Makefile b/libselinux/include/Makefil=
e
>>> index 757a6c9c..3b51f5ce 100644
>>> --- a/libselinux/include/Makefile
>>> +++ b/libselinux/include/Makefile
>>> @@ -1,6 +1,6 @@
>>>  # Installation directories.
>>> -PREFIX ?=3D $(DESTDIR)/usr
>>> -INCDIR ?=3D $(PREFIX)/include/selinux
>>> +PREFIX ?=3D /usr
>>> +INCDIR =3D $(DESTDIR)$(PREFIX)/include/selinux
>>>
>>>  all:
>>>
>>> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
>>> index 0643e6af..233bfaa9 100644
>>> --- a/libselinux/man/Makefile
>>> +++ b/libselinux/man/Makefile
>>> @@ -1,7 +1,8 @@
>>>  # Installation directories.
>>> -MAN8DIR ?=3D $(DESTDIR)/usr/share/man/man8
>>> -MAN5DIR ?=3D $(DESTDIR)/usr/share/man/man5
>>> -MAN3DIR ?=3D $(DESTDIR)/usr/share/man/man3
>>> +PREFIX ?=3D /usr
>>> +MAN8DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man8
>>> +MAN5DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man5
>>> +MAN3DIR ?=3D $(DESTDIR)$(PREFIX)/share/man/man3
>>>
>>>  all:
>>>
>>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>>> index 18df75c8..18a58164 100644
>>> --- a/libselinux/src/Makefile
>>> +++ b/libselinux/src/Makefile
>>> @@ -8,8 +8,8 @@ RUBYPREFIX ?=3D $(notdir $(RUBY))
>>>  PKG_CONFIG ?=3D pkg-config
>>>
>>>  # Installation directories.
>>> -PREFIX ?=3D $(DESTDIR)/usr
>>> -LIBDIR ?=3D $(PREFIX)/lib
>>> +PREFIX ?=3D /usr
>>> +LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
>>>  SHLIBDIR ?=3D $(DESTDIR)/lib
>>>  INCLUDEDIR ?=3D $(PREFIX)/include
>>>  PYINC ?=3D $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>>> @@ -19,8 +19,6 @@ PYCEXT ?=3D $(shell $(PYTHON) -c 'import imp;print(=
[s for s,m,t in imp.get_suffixe
>>>  RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubya=
rchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>>>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libd=
ir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["L=
IBRUBYARG_SHARED"]')
>>>  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG=
["vendorarchdir"]')
>>> -LIBBASE ?=3D $(shell basename $(LIBDIR))
>>> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
>>>
>>>  VERSION =3D $(shell cat ../VERSION)
>>>  LIBVERSION =3D 1
>>> @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
>>>         ln -sf $@ $(TARGET)
>>>
>>>  $(LIBPC): $(LIBPC).in ../VERSION
>>> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@li=
bdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_=
MODULE):' < $< > $@
>>> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@li=
bdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_M=
ODULE):' < $< > $@
>>>
>>>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>>>         bash -e exception.sh > $@ || (rm -f $@ ; false)
>>> @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/selinu=
x/selinux.h
>>>  $(AUDIT2WHYLOBJ): audit2why.c
>>>         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARE=
D -c -o $@ $<
>>>
>>> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
>>> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(P=
YLIBS)
>>> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
>>> +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(P=
YLIBS) -l:libsepol.a
>>
>> Hello,
>> This change makes audit2why.so no longer being rebuilt when libsepol's=

>> code change. This is an issue when debugging issues in libsepol, which=

>> is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO) in
>> commit dcd135cc06ab ("Re-link programs after libsepol.a is updated"
>> [1]).
>> By the way, I like the change from using a "hardcoded" path to
>> libsepol.a to telling the compiler to look into directories specified
>> with option -L in LDFLAGS. This would ease the packaging a little bit,=

>> as it makes defining LIBSEPOLA no longer necessary (if I understood
>> the changes correctly, I have not tested this point). Is there a way
>> to ask the compiler for the resolved location of a static library, in
>> a way which can be used to compute the value of LIBSEPOLA? ("gcc
>> -Wl,--trace ..." displays it but it is not easily usable).
>=20
> First of all, thank you for your review.
>=20
> Actually, I do not have any "good" way to address this issue.
> Is $(LIBSEPOLA) mostly used during debug/development?
>=20
> What do you think about this change:
>=20
> -----------------8<--------------------------------------------
>=20
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 18df75c8..b722a584 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -20,7 +20,11 @@ RUBYINC ?=3D $(shell $(RUBY) -e 'puts "-I" + RbConfi=
g::CONFIG["rubyarchhdrdir"] +
>  RUBYLIBS ?=3D $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir=
"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIB=
RUBYARG_SHARED"]')
>  RUBYINSTALL ?=3D $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["=
vendorarchdir"]')
>  LIBBASE ?=3D $(shell basename $(LIBDIR))
> -LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> +
> +# If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> +ifeq ($(LIBSEPOLA),)
> +       LDFLAGS +=3D -l:libsepol.a
> +endif
>=20
>  VERSION =3D $(shell cat ../VERSION)
>  LIBVERSION =3D 1
>=20
> -----------------8<--------------------------------------------
>=20
> This will search for libsepol.a in paths specified in LDFLAGS, but keep=

> the possibility to "track" a specific libsepol.a to make dependent subp=
rojects
> recompile if libsepol.a is changed.

Adding "-l:libsepol.a" to LDFLAGS breaks compiling with "make
'LDFLAGS=3D-Wl,--as-needed,--no-undefined'" (which helps detecting shared=

libraries linking issues), because of two issues:

* "LDFLAGS +=3D ..." does nothing when LDFLAGS is defined on the command
line. This is why "override LDFLAGS +=3D ..." is used in other places in
the Makefile.
* After adding "override", -l:libsepol.a appears before $(AUDIT2WHYLOBJ)
in the linker invocation, so its objects get ignored because of
--as-needed (which is why LDLIBS exists independently of LDFLAGS).

This issue can be easily reproduced by running in libselinux/src the
following command:

make clean && make 'LDFLAGS=3D-Wl,--as-needed,--no-undefined' pywrap

In order to address this issue, I suggest defining a new variable,
LDLIBS_LIBSEPOLA, defined by something like:

# If no specific libsepol.a is specified, fall back on LDFLAGS search pat=
h
# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
is no need to define a value for LDLIBS_LIBSEPOLA
ifeq ($(LIBSEPOLA),)
	LDLIBS_LIBSEPOLA :=3D -l:libsepol.a
endif

#....

$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
$(LDLIBS_LIBSEPOLA) $(PYLIBS)

What do you think of this?

Best regards,
Nicolas



--T0SXpWlHEYw3dQTEMr3hhLwYX2fz1w4F8--

--7I3IdSvKCW3wiaLJ1sTr1fCduUm4JGDY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJUBAEBCAA+FiEERLrjEL1V/i0DKU9qwZFBXzQNqqAFAlpmTqMgHG5pY29sYXMu
aW9vc3NAcG9seXRlY2huaXF1ZS5vcmcACgkQwZFBXzQNqqCVvBAAhrjOezMOWH2q
WVHzh8PXsjijg781vRY1najLnxKvt0EC2kEz166efWaHNbpC5n0jI/ckDb9UD4mP
hYjtiAMHo4D+99ZhElQZuHtZTUndy6RCwyIRekoKiZUKJRBkvI2QGUfDbRbXAMRe
AqIWLMBat+JbqUx9drAteYVrWGv3vFRO4Xgli/PHFIaChzuU0IA7P8AGMxneyEMg
gEnGXdJ6twLQ87dhUpGLWuD30jxP+YZ4+aXhQ4OWm99aWYlIO6/49obmox4Nk2Ap
x02E5+s8KgvOVyJmf/crKCL4X94lUyAesFEdWUPe2DiEuh/bs+QMfOKYJ8ZIu3OL
56elKNBfrrLIqdfHVZZKeTOG9S2PDJnBYMMDps6/UbwaRb241Bw7tmNDCBKW0IoS
zSe51An669CL+mJdszEkb8zpDOUJ64z9G4e4WLli8JB3IucCoMGw+8qjYcDo4bYa
yzIdXdKkq9rgok/uyGEwttJ2Da3Vybnk5aCewimhODMiQ0yxNkpoj+R4EhxN6Vrx
wcFRj6MfuF24/tY0kd+enwOaC73w+Aul4/QGNaZhEO9OKc+36J0jFf83nVTv1mIP
D91z9vKdwKbvjs1YhzBhV1KnuR9OIY9rtKYlrJJPk8yr7RPoUPuUFfkAbXHequwb
f4xAttxX5RSCe7FOhj3OnScEU69W+nQ=
=q9df
-----END PGP SIGNATURE-----

--7I3IdSvKCW3wiaLJ1sTr1fCduUm4JGDY0--
