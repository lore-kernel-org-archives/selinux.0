Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SAVxp0030622
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 06:32:01 -0400
Received: by mail-qt0-f173.google.com with SMTP id r60so4788890qtd.3
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 03:31:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1475058512-76102-1-git-send-email-jdanis@android.com>
References: <1475058512-76102-1-git-send-email-jdanis@android.com>
From: Janis Danisevskis <jdanis@android.com>
Date: Wed, 28 Sep 2016 11:31:48 +0100
Message-ID: <CA+xTVEuXqQjUKjJ5k1NReQXds3846kS+FcD730rO6QxnNTqLgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: Add architecture string to
 file_context.bin
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 Janis Danisevskis <jdanis@google.com>
Cc: Janis Danisevskis <jdanis@android.com>
Content-Type: multipart/alternative; boundary=001a11404dfc63bdf9053d8edeba
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11404dfc63bdf9053d8edeba
Content-Type: text/plain; charset=UTF-8

The only change with respect to the first set of patches is the new default
"reg_arch_matches = 0".


On Wed, Sep 28, 2016 at 11:28 AM, Janis Danisevskis <jdanis@android.com>
wrote:

> Serialized precompiled regular expressins are architecture
> dependent when using PCRE2. This patch
> - bumps the SELINUX_COMPILED_FCONTEXT version to 5 and
> - adds a field to the output indicating the architecture
>   compatibility.
>
> libselinux can cope with an architecture mismatch by
> ignoring the precompiled data in the input file and recompiling
> the regular expressions at runtime. It can also load older
> versions of file_contexts.bin if they where built with
> sefcontext_compile using the exact same version of the
> pcre1/2 as selinux.
>
> Signed-off-by: Janis Danisevskis <jdanis@android.com>
> ---
>  libselinux/src/label_file.c           | 43 +++++++++++++++++++++++++++++-
>  libselinux/src/label_file.h           |  4 ++-
>  libselinux/src/regex.c                | 50 ++++++++++++++++++++++++++++++
> ++---
>  libselinux/src/regex.h                | 15 ++++++++++-
>  libselinux/utils/sefcontext_compile.c | 13 +++++++++
>  5 files changed, 119 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 7156825..13e05c1 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -126,6 +126,8 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
>         uint32_t i, magic, version;
>         uint32_t entry_len, stem_map_len, regex_array_len;
>         const char *reg_version;
> +       const char *reg_arch;
> +       char reg_arch_matches = 0;
>
>         mmap_area = malloc(sizeof(*mmap_area));
>         if (!mmap_area) {
> @@ -159,6 +161,10 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
>         if (!reg_version)
>                 return -1;
>
> +       reg_arch = regex_arch_string();
> +       if (!reg_arch)
> +               return -1;
> +
>         if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
>
>                 len = strlen(reg_version);
> @@ -188,7 +194,42 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
>                         return -1;
>                 }
>                 free(str_buf);
> +
> +               if (version >= SELINUX_COMPILED_FCONTEXT_REGEX_ARCH) {
> +                       len = strlen(reg_arch);
> +
> +                       rc = next_entry(&entry_len, mmap_area,
> +                                       sizeof(uint32_t));
> +                       if (rc < 0)
> +                               return -1;
> +
> +                       /* Check arch string lengths */
> +                       if (len != entry_len) {
> +                               /*
> +                                * Skip the entry and conclude that we have
> +                                * a mismatch, which is not fatal.
> +                                */
> +                               next_entry(NULL, mmap_area, entry_len);
> +                               goto end_arch_check;
> +                       }
> +
> +                       /* Check if arch string mismatch */
> +                       str_buf = malloc(entry_len + 1);
> +                       if (!str_buf)
> +                               return -1;
> +
> +                       rc = next_entry(str_buf, mmap_area, entry_len);
> +                       if (rc < 0) {
> +                               free(str_buf);
> +                               return -1;
> +                       }
> +
> +                       str_buf[entry_len] = '\0';
> +                       reg_arch_matches = strcmp(str_buf, reg_arch) == 0;
> +                       free(str_buf);
> +               }
>         }
> +end_arch_check:
>
>         /* allocate the stems_data array */
>         rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
> @@ -349,7 +390,7 @@ static int load_mmap(FILE *fp, size_t len, struct
> selabel_handle *rec,
>                         spec->prefix_len = prefix_len;
>                 }
>
> -               rc = regex_load_mmap(mmap_area, &spec->regex);
> +               rc = regex_load_mmap(mmap_area, &spec->regex,
> reg_arch_matches);
>                 if (rc < 0)
>                         goto out;
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 88f4294..00c0a5c 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -24,8 +24,10 @@
>  #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS    2
>  #define SELINUX_COMPILED_FCONTEXT_MODE         3
>  #define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN   4
> +#define SELINUX_COMPILED_FCONTEXT_REGEX_ARCH   5
>
> -#define SELINUX_COMPILED_FCONTEXT_MAX_VERS     SELINUX_COMPILED_FCONTEXT_
> PREFIX_LEN
> +#define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
> +       SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
>
>  /* A file security context specification. */
>  struct spec {
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 750088e..a3b427b 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -7,6 +7,44 @@
>  #include "label_file.h"
>
>  #ifdef USE_PCRE2
> +#define REGEX_ARCH_SIZE_T PCRE2_SIZE
> +#else
> +#define REGEX_ARCH_SIZE_T size_t
> +#endif
> +
> +#ifndef __BYTE_ORDER__
> +#error __BYTE_ORDER__ not defined. Unable to determine endianness.
> +#endif
> +
> +#ifdef USE_PCRE2
> +char const *regex_arch_string(void)
> +{
> +       static char arch_string_buffer[32];
> +       static char const *arch_string = "";
> +       char const *endianness = NULL;
> +       int rc;
> +
> +       if (arch_string[0] == '\0') {
> +               if (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> +                       endianness = "el";
> +               else if (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
> +                       endianness = "eb";
> +
> +               if (!endianness)
> +                       return NULL;
> +
> +               rc = snprintf(arch_string_buffer,
> sizeof(arch_string_buffer),
> +                               "%zu-%zu-%s", sizeof(void *),
> +                               sizeof(REGEX_ARCH_SIZE_T),
> +                               endianness);
> +               if (rc < 0)
> +                       abort();
> +
> +               arch_string = &arch_string_buffer[0];
> +       }
> +       return arch_string;
> +}
> +
>  struct regex_data {
>         pcre2_code *regex; /* compiled regular expression */
>         /*
> @@ -56,7 +94,8 @@ char const *regex_version(void)
>         return version_buf;
>  }
>
> -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex)
> +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex,
> +                   int do_load_precompregex)
>  {
>         int rc;
>         uint32_t entry_len;
> @@ -65,7 +104,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct
> regex_data **regex)
>         if (rc < 0)
>                 return -1;
>
> -       if (entry_len) {
> +       if (entry_len && do_load_precompregex) {
>                 /*
>                  * this should yield exactly one because we store one
> pattern at
>                  * a time
> @@ -195,6 +234,10 @@ int regex_cmp(struct regex_data *regex1, struct
> regex_data *regex2)
>  }
>
>  #else // !USE_PCRE2
> +char const *regex_arch_string(void)
> +{
> +       return "N/A";
> +}
>
>  /* Prior to version 8.20, libpcre did not have pcre_free_study() */
>  #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
> @@ -247,7 +290,8 @@ char const *regex_version(void)
>         return pcre_version();
>  }
>
> -int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex)
> +int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data
> **regex,
> +                   int unused __attribute__((unused)))
>  {
>         int rc;
>         uint32_t entry_len;
> diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
> index 810b3c5..186c5ec 100644
> --- a/libselinux/src/regex.h
> +++ b/libselinux/src/regex.h
> @@ -34,6 +34,16 @@ struct regex_error_data {
>  struct mmap_area;
>
>  /**
> + * regex_arch_string return a string that represents the pointer width,
> the
> + * width of what the backend considers a size type, and the endianness of
> the
> + * system that this library was build for. (e.g. for x86_64: "8-8-el").
> + * This is required when loading stored regular espressions. PCRE2 regular
> + * expressions are not portable across architectures that do not have a
> + * matching arch-string.
> + */
> +char const *regex_arch_string(void) hidden;
> +
> +/**
>   * regex_verison returns the version string of the underlying regular
>   * regular expressions library. In the case of PCRE it just returns the
>   * result of pcre_version(). In the case of PCRE2, the very first time
> this
> @@ -86,12 +96,15 @@ int regex_prepare_data(struct regex_data **regex, char
> const *pattern_string,
>   *               representation of the precompiled pattern.
>   * @arg regex If successful, the structure returned through *regex was
> allocated
>   *            with regex_data_create and must be freed with
> regex_data_free.
> + * @arg do_load_precompregex If non-zero precompiled patterns get loaded
> from
> + *                          the mmap region (ignored by PCRE1 back-end).
>   *
>   * @retval 0 on success
>   * @retval -1 on error
>   */
>  int regex_load_mmap(struct mmap_area *map_area,
> -                   struct regex_data **regex) hidden;
> +                   struct regex_data **regex,
> +                   int do_load_precompregex) hidden;
>  /**
>   * This function stores a precompiled regular expression to a file.
>   * In the case of PCRE, it just dumps the binary representation of the
> diff --git a/libselinux/utils/sefcontext_compile.c
> b/libselinux/utils/sefcontext_compile.c
> index 70853e7..d91db9a 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -103,6 +103,7 @@ static int write_binary_file(struct saved_data *data,
> int fd,
>         uint32_t i;
>         int rc;
>         const char *reg_version;
> +       const char *reg_arch;
>
>         bin_file = fdopen(fd, "w");
>         if (!bin_file) {
> @@ -133,6 +134,18 @@ static int write_binary_file(struct saved_data *data,
> int fd,
>         if (len != section_len)
>                 goto err;
>
> +       /* write regex arch string */
> +       reg_arch = regex_arch_string();
> +       if (!reg_arch)
> +               goto err;
> +       section_len = strlen(reg_arch);
> +       len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
> +       if (len != 1)
> +               goto err;
> +       len = fwrite(reg_arch, sizeof(char), section_len, bin_file);
> +       if (len != section_len)
> +               goto err;
> +
>         /* write the number of stems coming */
>         section_len = data->num_stems;
>         len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
> --
> 2.8.0.rc3.226.g39d4020
>
>

--001a11404dfc63bdf9053d8edeba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The only change with respect to the first set of patches i=
s the new default &quot;reg_arch_matches =3D 0&quot;.<div><br></div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Sep 28, 20=
16 at 11:28 AM, Janis Danisevskis <span dir=3D"ltr">&lt;<a href=3D"mailto:j=
danis@android.com" target=3D"_blank">jdanis@android.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Serialized precompiled regular express=
ins are architecture<br>
dependent when using PCRE2. This patch<br>
- bumps the SELINUX_COMPILED_FCONTEXT version to 5 and<br>
- adds a field to the output indicating the architecture<br>
=C2=A0 compatibility.<br>
<br>
libselinux can cope with an architecture mismatch by<br>
ignoring the precompiled data in the input file and recompiling<br>
the regular expressions at runtime. It can also load older<br>
versions of file_contexts.bin if they where built with<br>
sefcontext_compile using the exact same version of the<br>
pcre1/2 as selinux.<br>
<br>
Signed-off-by: Janis Danisevskis &lt;<a href=3D"mailto:jdanis@android.com">=
jdanis@android.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/label_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 43 +++++++++++++++++++++++++++++-<br>
=C2=A0libselinux/src/label_file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++-<br>
=C2=A0libselinux/src/regex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 50 ++++++++++++++++++++++++++++++<wbr>++---<br>
=C2=A0libselinux/src/regex.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 15 ++++++++++-<br>
=C2=A0libselinux/utils/sefcontext_<wbr>compile.c | 13 +++++++++<br>
=C2=A05 files changed, 119 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c<br>
index 7156825..13e05c1 100644<br>
--- a/libselinux/src/label_file.c<br>
+++ b/libselinux/src/label_file.c<br>
@@ -126,6 +126,8 @@ static int load_mmap(FILE *fp, size_t len, struct selab=
el_handle *rec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t i, magic, version;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t entry_len, stem_map_len, regex_array_l=
en;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *reg_version;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_arch;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char reg_arch_matches =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_area =3D malloc(sizeof(*mmap_area));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mmap_area) {<br>
@@ -159,6 +161,10 @@ static int load_mmap(FILE *fp, size_t len, struct sela=
bel_handle *rec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!reg_version)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_arch =3D regex_arch_string();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reg_arch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (version &gt;=3D SELINUX_COMPILED_FCONTEXT_<=
wbr>PCRE_VERS) {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(reg_=
version);<br>
@@ -188,7 +194,42 @@ static int load_mmap(FILE *fp, size_t len, struct sela=
bel_handle *rec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(str_buf);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (version &gt;=3D=
 SELINUX_COMPILED_FCONTEXT_<wbr>REGEX_ARCH) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0len =3D strlen(reg_arch);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D next_entry(&amp;entry_len, mmap_area,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(ui=
nt32_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Check arch string lengths */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (len !=3D entry_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Skip the entry and conclude that w=
e have<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a mismatch, which is not fatal.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0next_entry(NULL, mmap_area, entry_len=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end_arch_check;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Check if arch string mismatch */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0str_buf =3D malloc(entry_len + 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!str_buf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D next_entry(str_buf, mmap_area, entry_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(str_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0str_buf[entry_len] =3D &#39;\0&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0reg_arch_matches =3D strcmp(str_buf, reg_arch) =3D=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free(str_buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+end_arch_check:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allocate the stems_data array */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D next_entry(&amp;stem_map_len, mmap_area,=
 sizeof(uint32_t));<br>
@@ -349,7 +390,7 @@ static int load_mmap(FILE *fp, size_t len, struct selab=
el_handle *rec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 spec-&gt;prefix_len =3D prefix_len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D regex_load_m=
map(mmap_area, &amp;spec-&gt;regex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D regex_load_m=
map(mmap_area, &amp;spec-&gt;regex, reg_arch_matches);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out;<br>
<br>
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h<br>
index 88f4294..00c0a5c 100644<br>
--- a/libselinux/src/label_file.h<br>
+++ b/libselinux/src/label_file.h<br>
@@ -24,8 +24,10 @@<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_<wbr>PCRE_VERS=C2=A0 =C2=A0 2<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A03<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_<wbr>PREFIX_LEN=C2=A0 =C2=A04<br>
+#define SELINUX_COMPILED_FCONTEXT_<wbr>REGEX_ARCH=C2=A0 =C2=A05<br>
<br>
-#define SELINUX_COMPILED_FCONTEXT_MAX_<wbr>VERS=C2=A0 =C2=A0 =C2=A0SELINUX=
_COMPILED_FCONTEXT_<wbr>PREFIX_LEN<br>
+#define SELINUX_COMPILED_FCONTEXT_MAX_<wbr>VERS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SELINUX_COMPILED_FCONTEXT_<wbr>REGEX_ARCH<br>
<br>
=C2=A0/* A file security context specification. */<br>
=C2=A0struct spec {<br>
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c<br>
index 750088e..a3b427b 100644<br>
--- a/libselinux/src/regex.c<br>
+++ b/libselinux/src/regex.c<br>
@@ -7,6 +7,44 @@<br>
=C2=A0#include &quot;label_file.h&quot;<br>
<br>
=C2=A0#ifdef USE_PCRE2<br>
+#define REGEX_ARCH_SIZE_T PCRE2_SIZE<br>
+#else<br>
+#define REGEX_ARCH_SIZE_T size_t<br>
+#endif<br>
+<br>
+#ifndef __BYTE_ORDER__<br>
+#error __BYTE_ORDER__ not defined. Unable to determine endianness.<br>
+#endif<br>
+<br>
+#ifdef USE_PCRE2<br>
+char const *regex_arch_string(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static char arch_string_buffer[32];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static char const *arch_string =3D &quot;&quot;=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char const *endianness =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (arch_string[0] =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (__BYTE_ORDER__ =
=3D=3D __ORDER_LITTLE_ENDIAN__)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0endianness =3D &quot;el&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (__BYTE_ORD=
ER__ =3D=3D __ORDER_BIG_ENDIAN__)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0endianness =3D &quot;eb&quot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!endianness)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snprintf(arc=
h_string_buffer, sizeof(arch_string_buffer),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%zu-%zu-%s&quot;, sizeof(void *=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(REGEX_ARCH_SIZE_T),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endianness);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abort();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch_string =3D &am=
p;arch_string_buffer[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return arch_string;<br>
+}<br>
+<br>
=C2=A0struct regex_data {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcre2_code *regex; /* compiled regular expressi=
on */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
@@ -56,7 +94,8 @@ char const *regex_version(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return version_buf;<br>
=C2=A0}<br>
<br>
-int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex=
)<br>
+int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int d=
o_load_precompregex)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t entry_len;<br>
@@ -65,7 +104,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct =
regex_data **regex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (entry_len &amp;&amp; do_load_precompregex) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this should=
 yield exactly one because we store one pattern at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a time<br>
@@ -195,6 +234,10 @@ int regex_cmp(struct regex_data *regex1, struct regex_=
data *regex2)<br>
=C2=A0}<br>
<br>
=C2=A0#else // !USE_PCRE2<br>
+char const *regex_arch_string(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;N/A&quot;;<br>
+}<br>
<br>
=C2=A0/* Prior to version 8.20, libpcre did not have pcre_free_study() */<b=
r>
=C2=A0#if (PCRE_MAJOR &lt; 8 || (PCRE_MAJOR =3D=3D 8 &amp;&amp; PCRE_MINOR =
&lt; 20))<br>
@@ -247,7 +290,8 @@ char const *regex_version(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pcre_version();<br>
=C2=A0}<br>
<br>
-int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex=
)<br>
+int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int u=
nused __attribute__((unused)))<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t entry_len;<br>
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h<br>
index 810b3c5..186c5ec 100644<br>
--- a/libselinux/src/regex.h<br>
+++ b/libselinux/src/regex.h<br>
@@ -34,6 +34,16 @@ struct regex_error_data {<br>
=C2=A0struct mmap_area;<br>
<br>
=C2=A0/**<br>
+ * regex_arch_string return a string that represents the pointer width, th=
e<br>
+ * width of what the backend considers a size type, and the endianness of =
the<br>
+ * system that this library was build for. (e.g. for x86_64: &quot;8-8-el&=
quot;).<br>
+ * This is required when loading stored regular espressions. PCRE2 regular=
<br>
+ * expressions are not portable across architectures that do not have a<br=
>
+ * matching arch-string.<br>
+ */<br>
+char const *regex_arch_string(void) hidden;<br>
+<br>
+/**<br>
=C2=A0 * regex_verison returns the version string of the underlying regular=
<br>
=C2=A0 * regular expressions library. In the case of PCRE it just returns t=
he<br>
=C2=A0 * result of pcre_version(). In the case of PCRE2, the very first tim=
e this<br>
@@ -86,12 +96,15 @@ int regex_prepare_data(struct regex_data **regex, char =
const *pattern_string,<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0representati=
on of the precompiled pattern.<br>
=C2=A0 * @arg regex If successful, the structure returned through *regex wa=
s allocated<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with regex_data_create an=
d must be freed with regex_data_free.<br>
+ * @arg do_load_precompregex If non-zero precompiled patterns get loaded f=
rom<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 the mmap region (ignored by PCRE1 back-end).<br>
=C2=A0 *<br>
=C2=A0 * @retval 0 on success<br>
=C2=A0 * @retval -1 on error<br>
=C2=A0 */<br>
=C2=A0int regex_load_mmap(struct mmap_area *map_area,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t regex_data **regex) hidden;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t regex_data **regex,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int d=
o_load_precompregex) hidden;<br>
=C2=A0/**<br>
=C2=A0 * This function stores a precompiled regular expression to a file.<b=
r>
=C2=A0 * In the case of PCRE, it just dumps the binary representation of th=
e<br>
diff --git a/libselinux/utils/sefcontext_<wbr>compile.c b/libselinux/utils/=
sefcontext_<wbr>compile.c<br>
index 70853e7..d91db9a 100644<br>
--- a/libselinux/utils/sefcontext_<wbr>compile.c<br>
+++ b/libselinux/utils/sefcontext_<wbr>compile.c<br>
@@ -103,6 +103,7 @@ static int write_binary_file(struct saved_data *data, i=
nt fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *reg_version;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reg_arch;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bin_file =3D fdopen(fd, &quot;w&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bin_file) {<br>
@@ -133,6 +134,18 @@ static int write_binary_file(struct saved_data *data, =
int fd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len !=3D section_len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* write regex arch string */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_arch =3D regex_arch_string();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reg_arch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0section_len =3D strlen(reg_arch);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(&amp;section_len, sizeof(uint32_=
t), 1, bin_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(reg_arch, sizeof(char), section_=
len, bin_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D section_len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write the number of stems coming */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 section_len =3D data-&gt;num_stems;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D fwrite(&amp;section_len, sizeof(uint32_=
t), 1, bin_file);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.0.rc3.226.g39d4020<br>
<br>
</font></span></blockquote></div><br></div>

--001a11404dfc63bdf9053d8edeba--
