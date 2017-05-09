MIME-Version: 1.0
In-Reply-To: <20170509145438.22346-1-sds@tycho.nsa.gov>
References: <20170509145438.22346-1-sds@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 9 May 2017 09:19:38 -0700
Message-ID: <CAFftDdowwv7CLZLsukPkL6vf+RG=dP+kxH=MaR_cqauKe7oc1w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix CFLAGS definition
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1134e6e4ea5b02054f19b8c7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1134e6e4ea5b02054f19b8c7
Content-Type: text/plain; charset=UTF-8

On Tue, May 9, 2017 at 7:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> commit 16c123f4b1f3c8d20b3f597df161d7e635620923 ("libselinux:
> support ANDROID_HOST=1 on Mac") split up warning flags in
> CFLAGS based on compiler support in a manner that could lead to
> including a subset that is invalid, e.g. upon
> make DESTDIR=/path/to/dest install.  Fix it.
>
>
Ack + Review


> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/src/Makefile   | 21 +++++++++++----------
>  libselinux/utils/Makefile | 17 +++++++++--------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index f1b8bd9..4306dd0 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -55,6 +55,15 @@ SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort
> $(wildcard *.c)))
>
>  MAX_STACK_SIZE=32768
>
> +ifeq ($(COMPILER), gcc)
> +EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat
> -Wsync-nand \
> +       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> -Wsuggest-attribute=const \
> +       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> -Wtrampolines -Wjump-misses-init \
> +       -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> -Wp,-D_FORTIFY_SOURCE=2
> +else
> +EXTRA_CFLAGS = -Wunused-command-line-argument
> +endif
> +
>  OBJS= $(patsubst %.c,%.o,$(SRCS))
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
>  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
> -Wmissing-include-dirs \
> @@ -72,19 +81,11 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> -Wformat-security -Winit-self -Wmissi
>            -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) \
>            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option
> -funit-at-a-time \
> -          -Werror -Wno-aggregate-return -Wno-redundant-decls
> +          -Werror -Wno-aggregate-return -Wno-redundant-decls \
> +          $(EXTRA_CFLAGS)
>
>  LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
>
> -ifeq ($(COMPILER), gcc)
> -CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat
> -Wsync-nand \
> -       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> -Wsuggest-attribute=const \
> -       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> -Wtrampolines -Wjump-misses-init \
> -       -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> -Wp,-D_FORTIFY_SOURCE=2
> -else
> -CFLAGS += -Wunused-command-line-argument
> -endif
> -
>  ifeq ($(OS), Darwin)
>  override CFLAGS += -I/opt/local/include
>  override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 5d61031..14f94bd 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -12,6 +12,13 @@ else
>  COMPILER ?= clang
>  endif
>
> +ifeq ($(COMPILER), gcc)
> +EXTRA_CFLAGS = -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand
> -Wcoverage-mismatch \
> +       -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> -Wsuggest-attribute=const \
> +       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> -Wtrampolines -Wjump-misses-init \
> +       -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> +endif
> +
>  MAX_STACK_SIZE=8192
>  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
> -Wmissing-include-dirs \
>            -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow
> -Wpointer-arith \
> @@ -28,17 +35,11 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> -Wformat-security -Winit-self -Wmissi
>            -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE)
> -Wp,-D_FORTIFY_SOURCE=2 \
>            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option
> -funit-at-a-time \
> -          -Werror -Wno-aggregate-return -Wno-redundant-decls
> +          -Werror -Wno-aggregate-return -Wno-redundant-decls \
> +          $(EXTRA_CFLAGS)
>
>  LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
>
> -ifeq ($(COMPILER), gcc)
> -CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand
> -Wcoverage-mismatch \
> -       -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> -Wsuggest-attribute=const \
> -       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> -Wtrampolines -Wjump-misses-init \
> -       -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> -endif
> -
>  ifeq ($(OS), Darwin)
>  override CFLAGS += -I/opt/local/include -I../../libsepol/include
>  override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
> --
> 2.9.3
>
>


-- 
Respectfully,

William C Roberts

--001a1134e6e4ea5b02054f19b8c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 9, 2017 at 7:54 AM, Stephen Smalley <span dir=3D"ltr">&lt;<=
a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">commit 16c123f4b1f3c8d=
20b3f597df161d7<wbr>e635620923 (&quot;libselinux:<br>
support ANDROID_HOST=3D1 on Mac&quot;) split up warning flags in<br>
CFLAGS based on compiler support in a manner that could lead to<br>
including a subset that is invalid, e.g. upon<br>
make DESTDIR=3D/path/to/dest install.=C2=A0 Fix it.<br>
<br></blockquote><div><br></div><div>Ack + Review</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds=
@tycho.nsa.gov</a>&gt;<br>
---<br>
=C2=A0libselinux/src/Makefile=C2=A0 =C2=A0| 21 +++++++++++----------<br>
=C2=A0libselinux/utils/Makefile | 17 +++++++++--------<br>
=C2=A02 files changed, 20 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile<br>
index f1b8bd9..4306dd0 100644<br>
--- a/libselinux/src/Makefile<br>
+++ b/libselinux/src/Makefile<br>
@@ -55,6 +55,15 @@ SRCS=3D $(filter-out $(GENERATED) audit2why.c, $(sort $(=
wildcard *.c)))<br>
<br>
=C2=A0MAX_STACK_SIZE=3D32768<br>
<br>
+ifeq ($(COMPILER), gcc)<br>
+EXTRA_CFLAGS =3D -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -W=
sync-nand \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wcoverage-mismatch -Wcpp -Wformat-contains-nul=
 -Wnormalized=3Dnfc -Wsuggest-attribute=3Dconst \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-attrib=
ute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-attr=
ibute=3Dconst -Wp,-D_FORTIFY_SOURCE=3D2<br>
+else<br>
+EXTRA_CFLAGS =3D -Wunused-command-line-argument<br>
+endif<br>
+<br>
=C2=A0OBJS=3D $(patsubst %.c,%.o,$(SRCS))<br>
=C2=A0LOBJS=3D $(patsubst %.c,%.lo,$(SRCS))<br>
=C2=A0CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit=
-self -Wmissing-include-dirs \<br>
@@ -72,19 +81,11 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-format-nonliteral -Wframe-lar=
ger-than=3D$(MAX_<wbr>STACK_SIZE) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fstack-protector-all --param=3Dss=
p-buffer-size=3D4 -fexceptions \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fasynchronous-unwind-tables -fdia=
gnostics-show-option -funit-at-a-time \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-return -Wno-redu=
ndant-decls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-return -Wno-redu=
ndant-decls \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(EXTRA_CFLAGS)<br>
<br>
=C2=A0LD_SONAME_FLAGS=3D-soname,$(<wbr>LIBSO),-z,defs,-z,relro<br>
<br>
-ifeq ($(COMPILER), gcc)<br>
-CFLAGS +=3D -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-=
nand \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wcoverage-mismatch -Wcpp -Wformat-contains-nul=
 -Wnormalized=3Dnfc -Wsuggest-attribute=3Dconst \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-attrib=
ute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-attr=
ibute=3Dconst -Wp,-D_FORTIFY_SOURCE=3D2<br>
-else<br>
-CFLAGS +=3D -Wunused-command-line-argument<br>
-endif<br>
-<br>
=C2=A0ifeq ($(OS), Darwin)<br>
=C2=A0override CFLAGS +=3D -I/opt/local/include<br>
=C2=A0override LDFLAGS +=3D -L/opt/local/lib -undefined dynamic_lookup<br>
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile<br>
index 5d61031..14f94bd 100644<br>
--- a/libselinux/utils/Makefile<br>
+++ b/libselinux/utils/Makefile<br>
@@ -12,6 +12,13 @@ else<br>
=C2=A0COMPILER ?=3D clang<br>
=C2=A0endif<br>
<br>
+ifeq ($(COMPILER), gcc)<br>
+EXTRA_CFLAGS =3D -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -Wc=
overage-mismatch \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wcpp -Wformat-contains-nul -Wnormalized=3Dnfc =
-Wsuggest-attribute=3Dconst \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-attrib=
ute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-attr=
ibute=3Dconst<br>
+endif<br>
+<br>
=C2=A0MAX_STACK_SIZE=3D8192<br>
=C2=A0CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit=
-self -Wmissing-include-dirs \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wunused -Wunknown-pragmas -Wstric=
t-aliasing -Wshadow -Wpointer-arith \<br>
@@ -28,17 +35,11 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-format-nonliteral -Wframe-lar=
ger-than=3D$(MAX_<wbr>STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=3D2 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fstack-protector-all --param=3Dss=
p-buffer-size=3D4 -fexceptions \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fasynchronous-unwind-tables -fdia=
gnostics-show-option -funit-at-a-time \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-return -Wno-redu=
ndant-decls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-return -Wno-redu=
ndant-decls \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(EXTRA_CFLAGS)<br>
<br>
=C2=A0LD_SONAME_FLAGS=3D-soname,$(<wbr>LIBSO),-z,defs,-z,relro<br>
<br>
-ifeq ($(COMPILER), gcc)<br>
-CFLAGS +=3D -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -Wcovera=
ge-mismatch \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wcpp -Wformat-contains-nul -Wnormalized=3Dnfc =
-Wsuggest-attribute=3Dconst \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-attrib=
ute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-attr=
ibute=3Dconst<br>
-endif<br>
-<br>
=C2=A0ifeq ($(OS), Darwin)<br>
=C2=A0override CFLAGS +=3D -I/opt/local/include -I../../libsepol/include<br=
>
=C2=A0override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lookup<=
br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.9.3<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Respect=
fully,<br><br>William C Roberts<br><br></div>
</div></div>

--001a1134e6e4ea5b02054f19b8c7--
