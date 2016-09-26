Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QHG813012757
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 13:16:10 -0400
Received: by mail-qk0-f177.google.com with SMTP id t7so170729002qkh.2
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 10:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <1474899756-93610-1-git-send-email-jdanis@android.com>
 <CAFftDdpznum0F7D2qEySpf5J6B2RwUdnqo7sDYN9ab5i1W4C-A@mail.gmail.com>
In-Reply-To: <CAFftDdpznum0F7D2qEySpf5J6B2RwUdnqo7sDYN9ab5i1W4C-A@mail.gmail.com>
From: Janis Danisevskis <jdanis@google.com>
Date: Mon, 26 Sep 2016 17:15:54 +0000
Message-ID: <CAAdwW5P-bSAqBYhUb1CJ35wZUey+Af-TW89wtwLjFYKnC-4MnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: Add architecture string to
 file_context.bin
To: William Roberts <bill.c.roberts@gmail.com>,
 Janis Danisevskis <jdanis@android.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1130cb3c705bfc053d6c4864
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1130cb3c705bfc053d6c4864
Content-Type: text/plain; charset=UTF-8

My line of thought was that all pre version 5 .bin files should load the
regexes from the file. However, given that the PCRE back end ignores the
flag and that only .bin files of version < 5 that where build with
sefcompile_context that was linked against PCRE2 would be affected, I would
agree that reg_arch_matches = 0 would be the saner default setting. I'll
modify the patch accordingly.

Thanks

On Mon, 26 Sep 2016, 17:29 William Roberts, <bill.c.roberts@gmail.com>
wrote:

> On Mon, Sep 26, 2016 at 7:22 AM, Janis Danisevskis <jdanis@android.com>
> wrote:
> > Serialized precompiled regular expressins are architecture
> > dependent when using PCRE2. This patch
> > - bumps the SELINUX_COMPILED_FCONTEXT version to 5 and
> > - adds a field to the output indicating the architecture
> >   compatibility.
> >
> > libselinux can cope with an architecture mismatch by
> > ignoring the precompiled data in the input file and recompiling
> > the regular expressions at runtime. It can also load older
> > versions of file_contexts.bin if they where built with
> > sefcontext_compile using the exact same version of the
> > pcre1/2 as selinux.
> >
> > Signed-off-by: Janis Danisevskis <jdanis@android.com>
> > ---
> >  libselinux/src/label_file.c           | 44
> +++++++++++++++++++++++++++++-
> >  libselinux/src/label_file.h           |  4 ++-
> >  libselinux/src/regex.c                | 50
> ++++++++++++++++++++++++++++++++---
> >  libselinux/src/regex.h                | 15 ++++++++++-
> >  libselinux/utils/sefcontext_compile.c | 13 +++++++++
> >  5 files changed, 120 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 7156825..9abc1d6 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -126,6 +126,8 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
> >         uint32_t i, magic, version;
> >         uint32_t entry_len, stem_map_len, regex_array_len;
> >         const char *reg_version;
> > +       const char *reg_arch;
> > +       char reg_arch_matches = 1;
>
> It appears all the patchs would reset this to 0 properly, but is their
> any reason you
> chose the default to be that it matches? I would assume it would be
> safer to mark
> this as its not a match.
>
> >
> >         mmap_area = malloc(sizeof(*mmap_area));
> >         if (!mmap_area) {
> > @@ -159,6 +161,10 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
> >         if (!reg_version)
> >                 return -1;
> >
> > +       reg_arch = regex_arch_string();
> > +       if (!reg_arch)
> > +               return -1;
> > +
> >         if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
> >
> >                 len = strlen(reg_version);
> > @@ -188,7 +194,43 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
> >                         return -1;
> >                 }
> >                 free(str_buf);
> > +
> > +               if (version >= SELINUX_COMPILED_FCONTEXT_REGEX_ARCH) {
> > +                       len = strlen(reg_arch);
> > +
> > +                       rc = next_entry(&entry_len, mmap_area,
> > +                                       sizeof(uint32_t));
> > +                       if (rc < 0)
> > +                               return -1;
> > +
> > +                       /* Check arch string lengths */
> > +                       if (len != entry_len) {
> > +                               /*
> > +                                * Skip the entry and conclude that we
> have
> > +                                * a mismatch, which is not fatal.
> > +                                */
> > +                               next_entry(NULL, mmap_area, entry_len);
> > +                               reg_arch_matches = 0;
> > +                               goto end_arch_check;
> > +                       }
> > +
> > +                       /* Check if arch string mismatch */
> > +                       str_buf = malloc(entry_len + 1);
> > +                       if (!str_buf)
> > +                               return -1;
> > +
> > +                       rc = next_entry(str_buf, mmap_area, entry_len);
> > +                       if (rc < 0) {
> > +                               free(str_buf);
> > +                               return -1;
> > +                       }
> > +
> > +                       str_buf[entry_len] = '\0';
> > +                       reg_arch_matches = strcmp(str_buf, reg_arch) ==
> 0;
> > +                       free(str_buf);
> > +               }
> >         }
> > +end_arch_check:
> >
> >         /* allocate the stems_data array */
> >         rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
> > @@ -349,7 +391,7 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
> >                         spec->prefix_len = prefix_len;
> >                 }
> >
> > -               rc = regex_load_mmap(mmap_area, &spec->regex);
> > +               rc = regex_load_mmap(mmap_area, &spec->regex,
> reg_arch_matches);
> >                 if (rc < 0)
> >                         goto out;
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 88f4294..00c0a5c 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -24,8 +24,10 @@
> >  #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS    2
> >  #define SELINUX_COMPILED_FCONTEXT_MODE         3
> >  #define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN   4
> > +#define SELINUX_COMPILED_FCONTEXT_REGEX_ARCH   5
> >
> > -#define SELINUX_COMPILED_FCONTEXT_MAX_VERS
>  SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
> > +#define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
> > +       SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
> >
> >  /* A file security context specification. */
> >  struct spec {
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 750088e..a3b427b 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -7,6 +7,44 @@
> >  #include "label_file.h"
> >
> >  #ifdef USE_PCRE2
> > +#define REGEX_ARCH_SIZE_T PCRE2_SIZE
> > +#else
> > +#define REGEX_ARCH_SIZE_T size_t
> > +#endif
> > +
> > +#ifndef __BYTE_ORDER__
> > +#error __BYTE_ORDER__ not defined. Unable to determine endianness.
> > +#endif
> > +
> > +#ifdef USE_PCRE2
> > +char const *regex_arch_string(void)
> > +{
> > +       static char arch_string_buffer[32];
> > +       static char const *arch_string = "";
> > +       char const *endianness = NULL;
> > +       int rc;
> > +
> > +       if (arch_string[0] == '\0') {
> > +               if (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> > +                       endianness = "el";
> > +               else if (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
> > +                       endianness = "eb";
> > +
> > +               if (!endianness)
> > +                       return NULL;
> > +
> > +               rc = snprintf(arch_string_buffer,
> sizeof(arch_string_buffer),
> > +                               "%zu-%zu-%s", sizeof(void *),
> > +                               sizeof(REGEX_ARCH_SIZE_T),
> > +                               endianness);
> > +               if (rc < 0)
> > +                       abort();
> > +
> > +               arch_string = &arch_string_buffer[0];
> > +       }
> > +       return arch_string;
> > +}
> > +
> >  struct regex_data {
> >         pcre2_code *regex; /* compiled regular expression */
> >         /*
> > @@ -56,7 +94,8 @@ char const *regex_version(void)
> >         return version_buf;
> >  }
> >
> > -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex)
> > +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex,
> > +                   int do_load_precompregex)
> >  {
> >         int rc;
> >         uint32_t entry_len;
> > @@ -65,7 +104,7 @@ int regex_load_mmap(struct mmap_area *mmap_area,
> struct regex_data **regex)
> >         if (rc < 0)
> >                 return -1;
> >
> > -       if (entry_len) {
> > +       if (entry_len && do_load_precompregex) {
> >                 /*
> >                  * this should yield exactly one because we store one
> pattern at
> >                  * a time
> > @@ -195,6 +234,10 @@ int regex_cmp(struct regex_data *regex1, struct
> regex_data *regex2)
> >  }
> >
> >  #else // !USE_PCRE2
> > +char const *regex_arch_string(void)
> > +{
> > +       return "N/A";
> > +}
> >
> >  /* Prior to version 8.20, libpcre did not have pcre_free_study() */
> >  #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
> > @@ -247,7 +290,8 @@ char const *regex_version(void)
> >         return pcre_version();
> >  }
> >
> > -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex)
> > +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex,
> > +                   int unused __attribute__((unused)))
> >  {
> >         int rc;
> >         uint32_t entry_len;
> > diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
> > index 810b3c5..186c5ec 100644
> > --- a/libselinux/src/regex.h
> > +++ b/libselinux/src/regex.h
> > @@ -34,6 +34,16 @@ struct regex_error_data {
> >  struct mmap_area;
> >
> >  /**
> > + * regex_arch_string return a string that represents the pointer width,
> the
> > + * width of what the backend considers a size type, and the endianness
> of the
> > + * system that this library was build for. (e.g. for x86_64: "8-8-el").
> > + * This is required when loading stored regular espressions. PCRE2
> regular
> > + * expressions are not portable across architectures that do not have a
> > + * matching arch-string.
> > + */
> > +char const *regex_arch_string(void) hidden;
> > +
> > +/**
> >   * regex_verison returns the version string of the underlying regular
> >   * regular expressions library. In the case of PCRE it just returns the
> >   * result of pcre_version(). In the case of PCRE2, the very first time
> this
> > @@ -86,12 +96,15 @@ int regex_prepare_data(struct regex_data **regex,
> char const *pattern_string,
> >   *               representation of the precompiled pattern.
> >   * @arg regex If successful, the structure returned through *regex was
> allocated
> >   *            with regex_data_create and must be freed with
> regex_data_free.
> > + * @arg do_load_precompregex If non-zero precompiled patterns get
> loaded from
> > + *                          the mmap region (ignored by PCRE1 back-end).
> >   *
> >   * @retval 0 on success
> >   * @retval -1 on error
> >   */
> >  int regex_load_mmap(struct mmap_area *map_area,
> > -                   struct regex_data **regex) hidden;
> > +                   struct regex_data **regex,
> > +                   int do_load_precompregex) hidden;
> >  /**
> >   * This function stores a precompiled regular expression to a file.
> >   * In the case of PCRE, it just dumps the binary representation of the
> > diff --git a/libselinux/utils/sefcontext_compile.c
> b/libselinux/utils/sefcontext_compile.c
> > index 70853e7..d91db9a 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -103,6 +103,7 @@ static int write_binary_file(struct saved_data
> *data, int fd,
> >         uint32_t i;
> >         int rc;
> >         const char *reg_version;
> > +       const char *reg_arch;
> >
> >         bin_file = fdopen(fd, "w");
> >         if (!bin_file) {
> > @@ -133,6 +134,18 @@ static int write_binary_file(struct saved_data
> *data, int fd,
> >         if (len != section_len)
> >                 goto err;
> >
> > +       /* write regex arch string */
> > +       reg_arch = regex_arch_string();
> > +       if (!reg_arch)
> > +               goto err;
> > +       section_len = strlen(reg_arch);
> > +       len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
> > +       if (len != 1)
> > +               goto err;
> > +       len = fwrite(reg_arch, sizeof(char), section_len, bin_file);
> > +       if (len != section_len)
> > +               goto err;
> > +
> >         /* write the number of stems coming */
> >         section_len = data->num_stems;
> >         len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
> > --
> > 2.8.0.rc3.226.g39d4020
> >
> > _______________________________________________
> > Seandroid-list mailing list
> > Seandroid-list@tycho.nsa.gov
> > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--001a1130cb3c705bfc053d6c4864
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">My line of thought was that all pre version 5 .bin files sho=
uld load the regexes from the file. However, given that the PCRE back end i=
gnores the=C2=A0 flag and that only .bin files of version &lt; 5 that where=
 build with sefcompile_context that was linked against PCRE2 would be affec=
ted, I would agree that reg_arch_matches =3D 0 would be the saner default s=
etting. I&#39;ll modify the patch accordingly.</p>
<p dir=3D"ltr">Thanks</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, 26 Sep 2016, 17:29 =
William Roberts, &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.rob=
erts@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mo=
n, Sep 26, 2016 at 7:22 AM, Janis Danisevskis &lt;<a href=3D"mailto:jdanis@=
android.com" class=3D"gmail_msg" target=3D"_blank">jdanis@android.com</a>&g=
t; wrote:<br class=3D"gmail_msg">
&gt; Serialized precompiled regular expressins are architecture<br class=3D=
"gmail_msg">
&gt; dependent when using PCRE2. This patch<br class=3D"gmail_msg">
&gt; - bumps the SELINUX_COMPILED_FCONTEXT version to 5 and<br class=3D"gma=
il_msg">
&gt; - adds a field to the output indicating the architecture<br class=3D"g=
mail_msg">
&gt;=C2=A0 =C2=A0compatibility.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; libselinux can cope with an architecture mismatch by<br class=3D"gmail=
_msg">
&gt; ignoring the precompiled data in the input file and recompiling<br cla=
ss=3D"gmail_msg">
&gt; the regular expressions at runtime. It can also load older<br class=3D=
"gmail_msg">
&gt; versions of file_contexts.bin if they where built with<br class=3D"gma=
il_msg">
&gt; sefcontext_compile using the exact same version of the<br class=3D"gma=
il_msg">
&gt; pcre1/2 as selinux.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Janis Danisevskis &lt;<a href=3D"mailto:jdanis@android.=
com" class=3D"gmail_msg" target=3D"_blank">jdanis@android.com</a>&gt;<br cl=
ass=3D"gmail_msg">
&gt; ---<br class=3D"gmail_msg">
&gt;=C2=A0 libselinux/src/label_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 44 +++++++++++++++++++++++++++++-<br class=3D"gmail_msg">
&gt;=C2=A0 libselinux/src/label_file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 ++-<br class=3D"gmail_msg">
&gt;=C2=A0 libselinux/src/regex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 50 ++++++++++++++++++++++++++++++++---<br class=3D"gmail_ms=
g">
&gt;=C2=A0 libselinux/src/regex.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 15 ++++++++++-<br class=3D"gmail_msg">
&gt;=C2=A0 libselinux/utils/sefcontext_compile.c | 13 +++++++++<br class=3D=
"gmail_msg">
&gt;=C2=A0 5 files changed, 120 insertions(+), 6 deletions(-)<br class=3D"g=
mail_msg">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c=
<br class=3D"gmail_msg">
&gt; index 7156825..9abc1d6 100644<br class=3D"gmail_msg">
&gt; --- a/libselinux/src/label_file.c<br class=3D"gmail_msg">
&gt; +++ b/libselinux/src/label_file.c<br class=3D"gmail_msg">
&gt; @@ -126,6 +126,8 @@ static int load_mmap(FILE *fp, size_t len, struct =
selabel_handle *rec,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i, magic, version;<br class=
=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len, stem_map_len, reg=
ex_array_len;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_version;<br class=3D"=
gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_arch;<br class=3D"gmail_ms=
g">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char reg_arch_matches =3D 1;<br class=3D"g=
mail_msg">
<br class=3D"gmail_msg">
It appears all the patchs would reset this to 0 properly, but is their<br c=
lass=3D"gmail_msg">
any reason you<br class=3D"gmail_msg">
chose the default to be that it matches? I would assume it would be<br clas=
s=3D"gmail_msg">
safer to mark<br class=3D"gmail_msg">
this as its not a match.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_area =3D malloc(sizeof(*mmap_are=
a));<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mmap_area) {<br class=3D"gmail_m=
sg">
&gt; @@ -159,6 +161,10 @@ static int load_mmap(FILE *fp, size_t len, struct=
 selabel_handle *rec,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reg_version)<br class=3D"gmail_m=
sg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1=
;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_arch =3D regex_arch_string();<br class=
=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reg_arch)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br =
class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (version &gt;=3D SELINUX_COMPILED_=
FCONTEXT_PCRE_VERS) {<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D s=
trlen(reg_version);<br class=3D"gmail_msg">
&gt; @@ -188,7 +194,43 @@ static int load_mmap(FILE *fp, size_t len, struct=
 selabel_handle *rec,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -1;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br clas=
s=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(str_=
buf);<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (version &g=
t;=3D SELINUX_COMPILED_FCONTEXT_REGEX_ARCH) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0len =3D strlen(reg_arch);<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0rc =3D next_entry(&amp;entry_len, mmap_area,<br class=3D"gmai=
l_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeo=
f(uint32_t));<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (rc &lt; 0)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br class=3D"gmail_msg"=
>
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Check arch string lengths */<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (len !=3D entry_len) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Skip the entry and conclude th=
at we have<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a mismatch, which is not fatal=
.<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next_entry(NULL, mmap_area, entry=
_len);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg_arch_matches =3D 0;<br class=
=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end_arch_check;<br class=3D"=
gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* Check if arch string mismatch */<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0str_buf =3D malloc(entry_len + 1);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!str_buf)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br class=3D"gmail_msg"=
>
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0rc =3D next_entry(str_buf, mmap_area, entry_len);<br class=3D=
"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (rc &lt; 0) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(str_buf);<br class=3D"gmail_=
msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br class=3D"gmail_msg"=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0str_buf[entry_len] =3D &#39;\0&#39;;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0reg_arch_matches =3D strcmp(str_buf, reg_arch) =3D=3D 0;<br c=
lass=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0free(str_buf);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"=
gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +end_arch_check:<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* allocate the stems_data array */<b=
r class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D next_entry(&amp;stem_map_len, =
mmap_area, sizeof(uint32_t));<br class=3D"gmail_msg">
&gt; @@ -349,7 +391,7 @@ static int load_mmap(FILE *fp, size_t len, struct =
selabel_handle *rec,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0spec-&gt;prefix_len =3D prefix_len;<br class=3D"gmail_m=
sg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br clas=
s=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D regex_l=
oad_mmap(mmap_area, &amp;spec-&gt;regex);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D regex_l=
oad_mmap(mmap_area, &amp;spec-&gt;regex, reg_arch_matches);<br class=3D"gma=
il_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &l=
t; 0)<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto out;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h=
<br class=3D"gmail_msg">
&gt; index 88f4294..00c0a5c 100644<br class=3D"gmail_msg">
&gt; --- a/libselinux/src/label_file.h<br class=3D"gmail_msg">
&gt; +++ b/libselinux/src/label_file.h<br class=3D"gmail_msg">
&gt; @@ -24,8 +24,10 @@<br class=3D"gmail_msg">
&gt;=C2=A0 #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS=C2=A0 =C2=A0 2<br cl=
ass=3D"gmail_msg">
&gt;=C2=A0 #define SELINUX_COMPILED_FCONTEXT_MODE=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03<br class=3D"gmail_msg">
&gt;=C2=A0 #define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN=C2=A0 =C2=A04<br cl=
ass=3D"gmail_msg">
&gt; +#define SELINUX_COMPILED_FCONTEXT_REGEX_ARCH=C2=A0 =C2=A05<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -#define SELINUX_COMPILED_FCONTEXT_MAX_VERS=C2=A0 =C2=A0 =C2=A0SELINUX=
_COMPILED_FCONTEXT_PREFIX_LEN<br class=3D"gmail_msg">
&gt; +#define SELINUX_COMPILED_FCONTEXT_MAX_VERS \<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0SELINUX_COMPILED_FCONTEXT_REGEX_ARCH<br cl=
ass=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 /* A file security context specification. */<br class=3D"gmail_m=
sg">
&gt;=C2=A0 struct spec {<br class=3D"gmail_msg">
&gt; diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c<br class=
=3D"gmail_msg">
&gt; index 750088e..a3b427b 100644<br class=3D"gmail_msg">
&gt; --- a/libselinux/src/regex.c<br class=3D"gmail_msg">
&gt; +++ b/libselinux/src/regex.c<br class=3D"gmail_msg">
&gt; @@ -7,6 +7,44 @@<br class=3D"gmail_msg">
&gt;=C2=A0 #include &quot;label_file.h&quot;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 #ifdef USE_PCRE2<br class=3D"gmail_msg">
&gt; +#define REGEX_ARCH_SIZE_T PCRE2_SIZE<br class=3D"gmail_msg">
&gt; +#else<br class=3D"gmail_msg">
&gt; +#define REGEX_ARCH_SIZE_T size_t<br class=3D"gmail_msg">
&gt; +#endif<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +#ifndef __BYTE_ORDER__<br class=3D"gmail_msg">
&gt; +#error __BYTE_ORDER__ not defined. Unable to determine endianness.<br=
 class=3D"gmail_msg">
&gt; +#endif<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +#ifdef USE_PCRE2<br class=3D"gmail_msg">
&gt; +char const *regex_arch_string(void)<br class=3D"gmail_msg">
&gt; +{<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0static char arch_string_buffer[32];<br cla=
ss=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0static char const *arch_string =3D &quot;&=
quot;;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char const *endianness =3D NULL;<br class=
=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (arch_string[0] =3D=3D &#39;\0&#39;) {<=
br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (__BYTE_ORD=
ER__ =3D=3D __ORDER_LITTLE_ENDIAN__)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0endianness =3D &quot;el&quot;;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (__BYT=
E_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0endianness =3D &quot;eb&quot;;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!endiannes=
s)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return NULL;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snprint=
f(arch_string_buffer, sizeof(arch_string_buffer),<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%zu-%zu-%s&quot;, sizeof(vo=
id *),<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(REGEX_ARCH_SIZE_T),<br cla=
ss=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endianness);<br class=3D"gmail_ms=
g">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)=
<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0abort();<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch_string =
=3D &amp;arch_string_buffer[0];<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return arch_string;<br class=3D"gmail_msg"=
>
&gt; +}<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt;=C2=A0 struct regex_data {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcre2_code *regex; /* compiled regula=
r expression */<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br class=3D"gmail_msg">
&gt; @@ -56,7 +94,8 @@ char const *regex_version(void)<br class=3D"gmail_ms=
g">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return version_buf;<br class=3D"gmail=
_msg">
&gt;=C2=A0 }<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **=
regex)<br class=3D"gmail_msg">
&gt; +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **=
regex,<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
int do_load_precompregex)<br class=3D"gmail_msg">
&gt;=C2=A0 {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len;<br class=3D"gmail=
_msg">
&gt; @@ -65,7 +104,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, st=
ruct regex_data **regex)<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<br class=3D"gmail_msg"=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1=
;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry_len) {<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry_len &amp;&amp; do_load_precompre=
gex) {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br cla=
ss=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this s=
hould yield exactly one because we store one pattern at<br class=3D"gmail_m=
sg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a time=
<br class=3D"gmail_msg">
&gt; @@ -195,6 +234,10 @@ int regex_cmp(struct regex_data *regex1, struct r=
egex_data *regex2)<br class=3D"gmail_msg">
&gt;=C2=A0 }<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 #else // !USE_PCRE2<br class=3D"gmail_msg">
&gt; +char const *regex_arch_string(void)<br class=3D"gmail_msg">
&gt; +{<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;N/A&quot;;<br class=3D"gmail_=
msg">
&gt; +}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 /* Prior to version 8.20, libpcre did not have pcre_free_study()=
 */<br class=3D"gmail_msg">
&gt;=C2=A0 #if (PCRE_MAJOR &lt; 8 || (PCRE_MAJOR =3D=3D 8 &amp;&amp; PCRE_M=
INOR &lt; 20))<br class=3D"gmail_msg">
&gt; @@ -247,7 +290,8 @@ char const *regex_version(void)<br class=3D"gmail_=
msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pcre_version();<br class=3D"gm=
ail_msg">
&gt;=C2=A0 }<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **=
regex)<br class=3D"gmail_msg">
&gt; +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **=
regex,<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
int unused __attribute__((unused)))<br class=3D"gmail_msg">
&gt;=C2=A0 {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t entry_len;<br class=3D"gmail=
_msg">
&gt; diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h<br class=
=3D"gmail_msg">
&gt; index 810b3c5..186c5ec 100644<br class=3D"gmail_msg">
&gt; --- a/libselinux/src/regex.h<br class=3D"gmail_msg">
&gt; +++ b/libselinux/src/regex.h<br class=3D"gmail_msg">
&gt; @@ -34,6 +34,16 @@ struct regex_error_data {<br class=3D"gmail_msg">
&gt;=C2=A0 struct mmap_area;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 /**<br class=3D"gmail_msg">
&gt; + * regex_arch_string return a string that represents the pointer widt=
h, the<br class=3D"gmail_msg">
&gt; + * width of what the backend considers a size type, and the endiannes=
s of the<br class=3D"gmail_msg">
&gt; + * system that this library was build for. (e.g. for x86_64: &quot;8-=
8-el&quot;).<br class=3D"gmail_msg">
&gt; + * This is required when loading stored regular espressions. PCRE2 re=
gular<br class=3D"gmail_msg">
&gt; + * expressions are not portable across architectures that do not have=
 a<br class=3D"gmail_msg">
&gt; + * matching arch-string.<br class=3D"gmail_msg">
&gt; + */<br class=3D"gmail_msg">
&gt; +char const *regex_arch_string(void) hidden;<br class=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt; +/**<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* regex_verison returns the version string of the underlyi=
ng regular<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* regular expressions library. In the case of PCRE it just=
 returns the<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* result of pcre_version(). In the case of PCRE2, the very=
 first time this<br class=3D"gmail_msg">
&gt; @@ -86,12 +96,15 @@ int regex_prepare_data(struct regex_data **regex, =
char const *pattern_string,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
presentation of the precompiled pattern.<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* @arg regex If successful, the structure returned through=
 *regex was allocated<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with regex_data=
_create and must be freed with regex_data_free.<br class=3D"gmail_msg">
&gt; + * @arg do_load_precompregex If non-zero precompiled patterns get loa=
ded from<br class=3D"gmail_msg">
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 the mmap region (ignored by PCRE1 back-end).<br cl=
ass=3D"gmail_msg">
&gt;=C2=A0 =C2=A0*<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* @retval 0 on success<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* @retval -1 on error<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0*/<br class=3D"gmail_msg">
&gt;=C2=A0 int regex_load_mmap(struct mmap_area *map_area,<br class=3D"gmai=
l_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct regex_data **regex) hidden;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
struct regex_data **regex,<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
int do_load_precompregex) hidden;<br class=3D"gmail_msg">
&gt;=C2=A0 /**<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* This function stores a precompiled regular expression to=
 a file.<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0* In the case of PCRE, it just dumps the binary representa=
tion of the<br class=3D"gmail_msg">
&gt; diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/=
sefcontext_compile.c<br class=3D"gmail_msg">
&gt; index 70853e7..d91db9a 100644<br class=3D"gmail_msg">
&gt; --- a/libselinux/utils/sefcontext_compile.c<br class=3D"gmail_msg">
&gt; +++ b/libselinux/utils/sefcontext_compile.c<br class=3D"gmail_msg">
&gt; @@ -103,6 +103,7 @@ static int write_binary_file(struct saved_data *da=
ta, int fd,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_version;<br class=3D"=
gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_arch;<br class=3D"gmail_ms=
g">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bin_file =3D fdopen(fd, &quot;w&quot;=
);<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bin_file) {<br class=3D"gmail_ms=
g">
&gt; @@ -133,6 +134,18 @@ static int write_binary_file(struct saved_data *d=
ata, int fd,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D section_len)<br class=3D=
"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;=
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* write regex arch string */<br class=3D"=
gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_arch =3D regex_arch_string();<br class=
=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reg_arch)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br c=
lass=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0section_len =3D strlen(reg_arch);<br class=
=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(&amp;section_len, sizeof(ui=
nt32_t), 1, bin_file);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 1)<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br c=
lass=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(reg_arch, sizeof(char), sec=
tion_len, bin_file);<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D section_len)<br class=3D"gmai=
l_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br c=
lass=3D"gmail_msg">
&gt; +<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* write the number of stems coming *=
/<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section_len =3D data-&gt;num_stems;<b=
r class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(&amp;section_len, size=
of(uint32_t), 1, bin_file);<br class=3D"gmail_msg">
&gt; --<br class=3D"gmail_msg">
&gt; 2.8.0.rc3.226.g39d4020<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; _______________________________________________<br class=3D"gmail_msg"=
>
&gt; Seandroid-list mailing list<br class=3D"gmail_msg">
&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov" class=3D"gmail_msg" ta=
rget=3D"_blank">Seandroid-list@tycho.nsa.gov</a><br class=3D"gmail_msg">
&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@t=
ycho.nsa.gov" class=3D"gmail_msg" target=3D"_blank">Seandroid-list-leave@ty=
cho.nsa.gov</a>.<br class=3D"gmail_msg">
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Seandroid-list-request@tycho.nsa.gov" class=3D"gmail_msg" target=3D"_=
blank">Seandroid-list-request@tycho.nsa.gov</a>.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
Respectfully,<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
William C Roberts<br class=3D"gmail_msg">
</blockquote></div>

--001a1130cb3c705bfc053d6c4864--
