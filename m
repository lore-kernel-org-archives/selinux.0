MIME-Version: 1.0
In-Reply-To: <CAFJ0LnEh1xctyg_JZRk-kHyU6Ykvqg09fbGKejJ8vcESxKTOOQ@mail.gmail.com>
References: <1462291125-28934-1-git-send-email-sds@tycho.nsa.gov>
 <CAFJ0LnEh1xctyg_JZRk-kHyU6Ykvqg09fbGKejJ8vcESxKTOOQ@mail.gmail.com>
Date: Tue, 3 May 2016 10:06:27 -0700
Message-ID: <CAFftDdqa-Fxu-w3OgGjqGS_d8joQH7sQj1usf87fZ1voGdxW6g@mail.gmail.com>
Subject: Re: [PATCH] libsepol, checkpolicy,
 secilc: Replace #ifdef DARWIN with __APPLE__.
From: William Roberts <bill.c.roberts@gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Elliott Hughes <enh@google.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114099363b0fc50531f321c3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114099363b0fc50531f321c3
Content-Type: text/plain; charset=UTF-8

LGTM, but have no way to test it. I have no apples.

On Tue, May 3, 2016 at 9:13 AM, Nick Kralevich <nnk@google.com> wrote:

> On Tue, May 3, 2016 at 8:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > As per discussion in https://android-review.googlesource.com/#/c/221980,
> > we should be using #ifdef __APPLE__ rather than our own custom-defined
> > DARWIN for building on MacOS X.
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Acked-By: Nick Kralevich <nnk@google.com>
>
> > ---
> >  checkpolicy/Android.mk      | 4 ----
> >  checkpolicy/checkpolicy.c   | 2 +-
> >  checkpolicy/policy_define.c | 2 +-
> >  libsepol/Android.mk         | 4 ----
> >  libsepol/src/genbools.c     | 4 ++--
> >  libsepol/src/genusers.c     | 4 ++--
> >  libsepol/src/node_record.c  | 4 ++--
> >  libsepol/src/private.h      | 4 ++--
> >  secilc/Android.mk           | 4 ----
> >  9 files changed, 10 insertions(+), 22 deletions(-)
> >
> > diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> > index 98f5168..3b7ff8a 100644
> > --- a/checkpolicy/Android.mk
> > +++ b/checkpolicy/Android.mk
> > @@ -12,10 +12,6 @@ common_cflags := \
> >         -Wall -Wshadow -O2 \
> >         -pipe -fno-strict-aliasing \
> >
> > -ifeq ($(HOST_OS),darwin)
> > -common_cflags += -DDARWIN
> > -endif
> > -
> >  common_includes := \
> >         $(LOCAL_PATH)/ \
> >         $(LOCAL_PATH)/../libsepol/include/ \
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index 7947c20..2d68316 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -73,7 +73,7 @@
> >  #include <errno.h>
> >  #include <sys/mman.h>
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >  #include <ctype.h>
> >  #endif
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 2068b71..100e517 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -5140,7 +5140,7 @@ int define_ipv6_node_context(void)
> >
> >         memset(newc, 0, sizeof(ocontext_t));
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
> >         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
> >  #else
> > diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> > index 5d2c96b..6d89f17 100644
> > --- a/libsepol/Android.mk
> > +++ b/libsepol/Android.mk
> > @@ -69,10 +69,6 @@ common_cflags := \
> >         -Wshadow -Wmissing-noreturn \
> >         -Wmissing-format-attribute
> >
> > -ifeq ($(HOST_OS), darwin)
> > -common_cflags += -DDARWIN
> > -endif
> > -
> >  common_includes := \
> >         $(LOCAL_PATH)/include/ \
> >         $(LOCAL_PATH)/src/ \
> > diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
> > index 6a06ec9..c81e848 100644
> > --- a/libsepol/src/genbools.c
> > +++ b/libsepol/src/genbools.c
> > @@ -79,7 +79,7 @@ static int load_booleans(struct policydb *policydb,
> const char *path,
> >         if (boolf == NULL)
> >                 goto localbool;
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >          if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
> >            ERR(NULL, "out of memory");
> >           return -1;
> > @@ -111,7 +111,7 @@ static int load_booleans(struct policydb *policydb,
> const char *path,
> >         boolf = fopen(localbools, "r");
> >         if (boolf != NULL) {
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >
> >           while(fgets(buffer, 255, boolf) != NULL) {
> >  #else
> > diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
> > index 7826b71..0b98a76 100644
> > --- a/libsepol/src/genusers.c
> > +++ b/libsepol/src/genusers.c
> > @@ -7,7 +7,7 @@
> >
> >  #include <sepol/policydb/policydb.h>
> >
> > -#ifndef DARWIN
> > +#ifndef __APPLE__
> >  #include <stdio_ext.h>
> >  #endif
> >
> > @@ -47,7 +47,7 @@ static int load_users(struct policydb *policydb, const
> char *path)
> >         if (fp == NULL)
> >                 return -1;
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >         if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
> >           ERR(NULL, "out of memory");
> >           return -1;
> > diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
> > index bd48ba0..21043b6 100644
> > --- a/libsepol/src/node_record.c
> > +++ b/libsepol/src/node_record.c
> > @@ -70,7 +70,7 @@ static int node_parse_addr(sepol_handle_t * handle,
> >                                 return STATUS_ERR;
> >                         }
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >                         memcpy(addr_bytes, in_addr.s6_addr, 16);
> >  #else
> >                         memcpy(addr_bytes, in_addr.s6_addr32, 16);
> > @@ -162,7 +162,7 @@ static int node_expand_addr(sepol_handle_t * handle,
> >                 {
> >                         struct in6_addr addr;
> >                         memset(&addr, 0, sizeof(struct in6_addr));
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >                         memcpy(&addr.s6_addr[0], addr_bytes, 16);
> >  #else
> >                         memcpy(&addr.s6_addr32[0], addr_bytes, 16);
> > diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> > index 8a6d4bb..9c700c9 100644
> > --- a/libsepol/src/private.h
> > +++ b/libsepol/src/private.h
> > @@ -5,7 +5,7 @@
> >  #include <sepol/policydb/policydb.h>
> >
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >  #include <sys/types.h>
> >  #include <machine/endian.h>
> >  #else
> > @@ -16,7 +16,7 @@
> >  #include <errno.h>
> >  #include <dso.h>
> >
> > -#ifdef DARWIN
> > +#ifdef __APPLE__
> >  #define __BYTE_ORDER  BYTE_ORDER
> >  #define __LITTLE_ENDIAN  LITTLE_ENDIAN
> >  #endif
> > diff --git a/secilc/Android.mk b/secilc/Android.mk
> > index 3dd9023..6c7b9d3 100644
> > --- a/secilc/Android.mk
> > +++ b/secilc/Android.mk
> > @@ -6,10 +6,6 @@ common_cflags := \
> >         -Wall -Wshadow -O2 \
> >         -pipe -fno-strict-aliasing \
> >
> > -ifeq ($(HOST_OS), darwin)
> > -common_cflags += -DDARWIN
> > -endif
> > -
> >  common_includes := \
> >         $(LOCAL_PATH)/../libsepol/cil/include/ \
> >         $(LOCAL_PATH)/../libsepol/include/ \
> > --
> > 2.5.5
> >
>
>
>
> --
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a114099363b0fc50531f321c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LGTM, but have no way to test it. I have no apples.</div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, May 3, 201=
6 at 9:13 AM, Nick Kralevich <span dir=3D"ltr">&lt;<a href=3D"mailto:nnk@go=
ogle.com" target=3D"_blank">nnk@google.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><span class=3D"">On Tue, May 3, 2016 at 8:58 AM, St=
ephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a=
>&gt; wrote:<br>
</span><span class=3D"">&gt; As per discussion in <a href=3D"https://androi=
d-review.googlesource.com/#/c/221980" rel=3D"noreferrer" target=3D"_blank">=
https://android-review.googlesource.com/#/c/221980</a>,<br>
&gt; we should be using #ifdef __APPLE__ rather than our own custom-defined=
<br>
&gt; DARWIN for building on MacOS X.<br>
&gt;<br>
&gt; Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov=
">sds@tycho.nsa.gov</a>&gt;<br>
<br>
</span>Acked-By: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com">nnk@g=
oogle.com</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; ---<br>
&gt;=C2=A0 checkpolicy/Android.mk=C2=A0 =C2=A0 =C2=A0 | 4 ----<br>
&gt;=C2=A0 checkpolicy/checkpolicy.c=C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 checkpolicy/policy_define.c | 2 +-<br>
&gt;=C2=A0 libsepol/Android.mk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ----<br=
>
&gt;=C2=A0 libsepol/src/genbools.c=C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 libsepol/src/genusers.c=C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 libsepol/src/node_record.c=C2=A0 | 4 ++--<br>
&gt;=C2=A0 libsepol/src/private.h=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
&gt;=C2=A0 secilc/Android.mk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 --=
--<br>
&gt;=C2=A0 9 files changed, 10 insertions(+), 22 deletions(-)<br>
&gt;<br>
&gt; diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk<br>
&gt; index 98f5168..3b7ff8a 100644<br>
&gt; --- a/checkpolicy/Android.mk<br>
&gt; +++ b/checkpolicy/Android.mk<br>
&gt; @@ -12,10 +12,6 @@ common_cflags :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wall -Wshadow -O2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-pipe -fno-strict-aliasing \<br>
&gt;<br>
&gt; -ifeq ($(HOST_OS),darwin)<br>
&gt; -common_cflags +=3D -DDARWIN<br>
&gt; -endif<br>
&gt; -<br>
&gt;=C2=A0 common_includes :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/include/ \<=
br>
&gt; diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c<br>
&gt; index 7947c20..2d68316 100644<br>
&gt; --- a/checkpolicy/checkpolicy.c<br>
&gt; +++ b/checkpolicy/checkpolicy.c<br>
&gt; @@ -73,7 +73,7 @@<br>
&gt;=C2=A0 #include &lt;errno.h&gt;<br>
&gt;=C2=A0 #include &lt;sys/mman.h&gt;<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 #include &lt;ctype.h&gt;<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt; diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c=
<br>
&gt; index 2068b71..100e517 100644<br>
&gt; --- a/checkpolicy/policy_define.c<br>
&gt; +++ b/checkpolicy/policy_define.c<br>
&gt; @@ -5140,7 +5140,7 @@ int define_ipv6_node_context(void)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(newc, 0, sizeof(ocontext_t));<=
br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;newc-&gt;u.node6.addr[0],=
 &amp;addr.s6_addr[0], 16);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;newc-&gt;u.node6.mask[0],=
 &amp;mask.s6_addr[0], 16);<br>
&gt;=C2=A0 #else<br>
&gt; diff --git a/libsepol/Android.mk b/libsepol/Android.mk<br>
&gt; index 5d2c96b..6d89f17 100644<br>
&gt; --- a/libsepol/Android.mk<br>
&gt; +++ b/libsepol/Android.mk<br>
&gt; @@ -69,10 +69,6 @@ common_cflags :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wshadow -Wmissing-noreturn \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wmissing-format-attribute<br>
&gt;<br>
&gt; -ifeq ($(HOST_OS), darwin)<br>
&gt; -common_cflags +=3D -DDARWIN<br>
&gt; -endif<br>
&gt; -<br>
&gt;=C2=A0 common_includes :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/include/ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/src/ \<br>
&gt; diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c<br>
&gt; index 6a06ec9..c81e848 100644<br>
&gt; --- a/libsepol/src/genbools.c<br>
&gt; +++ b/libsepol/src/genbools.c<br>
&gt; @@ -79,7 +79,7 @@ static int load_booleans(struct policydb *policydb, =
const char *path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (boolf =3D=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto loca=
lbool;<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((buffer =3D (char *)malloc(255 *=
 sizeof(char))) =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(NULL, &quot;out of memory=
&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; @@ -111,7 +111,7 @@ static int load_booleans(struct policydb *policydb=
, const char *path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boolf =3D fopen(localbools, &quot;r&q=
uot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (boolf !=3D NULL) {<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while(fgets(buffer, 255, boolf=
) !=3D NULL) {<br>
&gt;=C2=A0 #else<br>
&gt; diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c<br>
&gt; index 7826b71..0b98a76 100644<br>
&gt; --- a/libsepol/src/genusers.c<br>
&gt; +++ b/libsepol/src/genusers.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;<br>
&gt;=C2=A0 #include &lt;sepol/policydb/policydb.h&gt;<br>
&gt;<br>
&gt; -#ifndef DARWIN<br>
&gt; +#ifndef __APPLE__<br>
&gt;=C2=A0 #include &lt;stdio_ext.h&gt;<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt; @@ -47,7 +47,7 @@ static int load_users(struct policydb *policydb, con=
st char *path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1=
;<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((buffer =3D (char *)malloc(255 * =
sizeof(char))) =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(NULL, &quot;out of memory&=
quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c<b=
r>
&gt; index bd48ba0..21043b6 100644<br>
&gt; --- a/libsepol/src/node_record.c<br>
&gt; +++ b/libsepol/src/node_record.c<br>
&gt; @@ -70,7 +70,7 @@ static int node_parse_addr(sepol_handle_t * handle,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return STATUS_ERR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(addr_bytes, in_addr.s6_addr, 16);<br>
&gt;=C2=A0 #else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(addr_bytes, in_addr.s6_addr32, 16);<br>
&gt; @@ -162,7 +162,7 @@ static int node_expand_addr(sepol_handle_t * handl=
e,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct in6_addr addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memset(&amp;addr, 0, sizeof(struct in6_addr));<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;addr.s6_addr[0], addr_bytes, 16);<br>
&gt;=C2=A0 #else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;addr.s6_addr32[0], addr_bytes, 16);<br>
&gt; diff --git a/libsepol/src/private.h b/libsepol/src/private.h<br>
&gt; index 8a6d4bb..9c700c9 100644<br>
&gt; --- a/libsepol/src/private.h<br>
&gt; +++ b/libsepol/src/private.h<br>
&gt; @@ -5,7 +5,7 @@<br>
&gt;=C2=A0 #include &lt;sepol/policydb/policydb.h&gt;<br>
&gt;<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 #include &lt;sys/types.h&gt;<br>
&gt;=C2=A0 #include &lt;machine/endian.h&gt;<br>
&gt;=C2=A0 #else<br>
&gt; @@ -16,7 +16,7 @@<br>
&gt;=C2=A0 #include &lt;errno.h&gt;<br>
&gt;=C2=A0 #include &lt;dso.h&gt;<br>
&gt;<br>
&gt; -#ifdef DARWIN<br>
&gt; +#ifdef __APPLE__<br>
&gt;=C2=A0 #define __BYTE_ORDER=C2=A0 BYTE_ORDER<br>
&gt;=C2=A0 #define __LITTLE_ENDIAN=C2=A0 LITTLE_ENDIAN<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/secilc/Android.mk b/secilc/Android.mk<br>
&gt; index 3dd9023..6c7b9d3 100644<br>
&gt; --- a/secilc/Android.mk<br>
&gt; +++ b/secilc/Android.mk<br>
&gt; @@ -6,10 +6,6 @@ common_cflags :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Wall -Wshadow -O2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-pipe -fno-strict-aliasing \<br>
&gt;<br>
&gt; -ifeq ($(HOST_OS), darwin)<br>
&gt; -common_cflags +=3D -DDARWIN<br>
&gt; -endif<br>
&gt; -<br>
&gt;=C2=A0 common_includes :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/cil/include=
/ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/include/ \<=
br>
&gt; --<br>
&gt; 2.5.5<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Nick Kralevich | Android Security | <a href=3D"mailto:nnk@google.com">nnk@g=
oogle.com</a> | <a href=3D"tel:650.214.4037" value=3D"+16502144037">650.214=
.4037</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><b=
r></div>
</div>

--001a114099363b0fc50531f321c3--
