Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t66EosdR022414
 for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2015 10:50:55 -0400
Received: by oiab3 with SMTP id b3so1119673oia.1
 for <selinux@tycho.nsa.gov>; Mon, 06 Jul 2015 07:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <1436007429-3740-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1436007429-3740-1-git-send-email-richard_c_haines@btinternet.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 06 Jul 2015 14:50:37 +0000
Message-ID: <CABXk95BdhBgFtDigvrZxeyc_saF7zH-aVKGEM0egcXRgvAKsng@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix binary file labels for regexes with
 metachars
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c03432e4fe90051a360727
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c03432e4fe90051a360727
Content-Type: text/plain; charset=UTF-8

Just for clarification, this patch is in addition to what I uploaded right?
i.e. you need both patches for binary file_contexts to be labeled properly
with the lookup_best_match() function?

On Sat, Jul 4, 2015 at 4:07 AM Richard Haines <
richard_c_haines@btinternet.com> wrote:

> File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters in the
> binary file_contexts file version.
>
> This change adds a new entry in the binary file with the calculated
> prefix length that is then read when processing the file. This fix
> also bumps SELINUX_COMPILED_FCONTEXT_MAX_VERS.
>
> This patch relies on patch [1] that fixes the same problem
> for text based file_contexts files.
>
> [1] http://marc.info/?l=selinux&m=143576498713964&w=2
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/label_file.c           | 11 ++++++++++-
>  libselinux/src/label_file.h           |  3 ++-
>  libselinux/utils/sefcontext_compile.c |  8 ++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 4faf808..b4ee15d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -261,7 +261,7 @@ static int load_mmap(struct selabel_handle *rec, const
> char *path,
>         for (i = 0; i < regex_array_len; i++) {
>                 struct spec *spec;
>                 int32_t stem_id, meta_chars;
> -               uint32_t mode = 0;
> +               uint32_t mode = 0, prefix_len = 0;
>
>                 rc = grow_specs(data);
>                 if (rc < 0)
> @@ -337,6 +337,15 @@ static int load_mmap(struct selabel_handle *rec,
> const char *path,
>                         goto err;
>
>                 spec->hasMetaChars = meta_chars;
> +               /* and prefix length for use by selabel_lookup_best_match
> */
> +               if (version >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN) {
> +                       rc = next_entry(&prefix_len, mmap_area,
> +                                           sizeof(uint32_t));
> +                       if (rc < 0)
> +                               goto err;
> +
> +                       spec->prefix_len = prefix_len;
> +               }
>
>                 /* Process regex and study_data entries */
>                 rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 73bcbba..1818dd6 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -12,8 +12,9 @@
>  #define SELINUX_COMPILED_FCONTEXT_NOPCRE_VERS  1
>  #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS    2
>  #define SELINUX_COMPILED_FCONTEXT_MODE         3
> +#define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN   4
>
> -#define SELINUX_COMPILED_FCONTEXT_MAX_VERS
>  SELINUX_COMPILED_FCONTEXT_MODE
> +#define SELINUX_COMPILED_FCONTEXT_MAX_VERS
>  SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
>
>  /* Prior to version 8.20, libpcre did not have pcre_free_study() */
>  #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
> diff --git a/libselinux/utils/sefcontext_compile.c
> b/libselinux/utils/sefcontext_compile.c
> index a93105d..4160632 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -68,6 +68,7 @@ out:
>   *            mode_t for <= SELINUX_COMPILED_FCONTEXT_PCRE_VERS
>   *     s32  - stemid associated with the regex
>   *     u32  - spec has meta characters
> + *     u32  - The specs prefix_len if >=
> SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
>   *     u32  - data length of the pcre regex
>   *     char - a bufer holding the raw pcre regex info
>   *     u32  - data length of the pcre regex study daya
> @@ -141,6 +142,7 @@ static int write_binary_file(struct saved_data *data,
> int fd)
>                 char *context = specs[i].lr.ctx_raw;
>                 char *regex_str = specs[i].regex_str;
>                 mode_t mode = specs[i].mode;
> +               size_t prefix_len = specs[i].prefix_len;
>                 int32_t stem_id = specs[i].stem_id;
>                 pcre *re = specs[i].regex;
>                 pcre_extra *sd = get_pcre_extra(&specs[i]);
> @@ -186,6 +188,12 @@ static int write_binary_file(struct saved_data *data,
> int fd)
>                 if (len != 1)
>                         goto err;
>
> +               /* For SELINUX_COMPILED_FCONTEXT_PREFIX_LEN */
> +               to_write = prefix_len;
> +               len = fwrite(&to_write, sizeof(to_write), 1, bin_file);
> +               if (len != 1)
> +                       goto err;
> +
>                 /* determine the size of the pcre data in bytes */
>                 rc = pcre_fullinfo(re, NULL, PCRE_INFO_SIZE, &size);
>                 if (rc < 0)
> --
> 2.1.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c03432e4fe90051a360727
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just for clarification, this patch is in addition to what =
I uploaded right? i.e. you need both patches for binary file_contexts to be=
 labeled properly with the=C2=A0lookup_best_match() function?<br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr">On Sat, Jul 4, 2015 at 4:07 AM =
Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinternet.com">richa=
rd_c_haines@btinternet.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">File labels assigned using the lookup_best_match() function do not<b=
r>
assign the best match if its regex contains metacharacters in the<br>
binary file_contexts file version.<br>
<br>
This change adds a new entry in the binary file with the calculated<br>
prefix length that is then read when processing the file. This fix<br>
also bumps SELINUX_COMPILED_FCONTEXT_MAX_VERS.<br>
<br>
This patch relies on patch [1] that fixes the same problem<br>
for text based file_contexts files.<br>
<br>
[1] <a href=3D"http://marc.info/?l=3Dselinux&amp;m=3D143576498713964&amp;w=
=3D2" rel=3D"noreferrer" target=3D"_blank">http://marc.info/?l=3Dselinux&am=
p;m=3D143576498713964&amp;w=3D2</a><br>
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com" target=3D"_blank">richard_c_haines@btinternet.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/label_file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 11 ++++++++++-<br>
=C2=A0libselinux/src/label_file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 3 ++-<br>
=C2=A0libselinux/utils/sefcontext_compile.c |=C2=A0 8 ++++++++<br>
=C2=A03 files changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c<br>
index 4faf808..b4ee15d 100644<br>
--- a/libselinux/src/label_file.c<br>
+++ b/libselinux/src/label_file.c<br>
@@ -261,7 +261,7 @@ static int load_mmap(struct selabel_handle *rec, const =
char *path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; regex_array_len; i++) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct spec *spec;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t stem_id, me=
ta_chars;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mode =3D 0=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mode =3D 0=
, prefix_len =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D grow_specs(d=
ata);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
@@ -337,6 +337,15 @@ static int load_mmap(struct selabel_handle *rec, const=
 char *path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec-&gt;hasMetaCha=
rs =3D meta_chars;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* and prefix lengt=
h for use by selabel_lookup_best_match */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (version &gt;=3D=
 SELINUX_COMPILED_FCONTEXT_PREFIX_LEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D next_entry(&amp;prefix_len, mmap_area,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sizeof(uint32_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rc &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spec-&gt;prefix_len =3D prefix_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Process regex an=
d study_data entries */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D next_entry(&=
amp;entry_len, mmap_area, sizeof(uint32_t));<br>
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h<br>
index 73bcbba..1818dd6 100644<br>
--- a/libselinux/src/label_file.h<br>
+++ b/libselinux/src/label_file.h<br>
@@ -12,8 +12,9 @@<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_NOPCRE_VERS=C2=A0 1<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_PCRE_VERS=C2=A0 =C2=A0 2<br>
=C2=A0#define SELINUX_COMPILED_FCONTEXT_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A03<br>
+#define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN=C2=A0 =C2=A04<br>
<br>
-#define SELINUX_COMPILED_FCONTEXT_MAX_VERS=C2=A0 =C2=A0 =C2=A0SELINUX_COMP=
ILED_FCONTEXT_MODE<br>
+#define SELINUX_COMPILED_FCONTEXT_MAX_VERS=C2=A0 =C2=A0 =C2=A0SELINUX_COMP=
ILED_FCONTEXT_PREFIX_LEN<br>
<br>
=C2=A0/* Prior to version 8.20, libpcre did not have pcre_free_study() */<b=
r>
=C2=A0#if (PCRE_MAJOR &lt; 8 || (PCRE_MAJOR =3D=3D 8 &amp;&amp; PCRE_MINOR =
&lt; 20))<br>
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefco=
ntext_compile.c<br>
index a93105d..4160632 100644<br>
--- a/libselinux/utils/sefcontext_compile.c<br>
+++ b/libselinux/utils/sefcontext_compile.c<br>
@@ -68,6 +68,7 @@ out:<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_t for &lt;=3D SELINU=
X_COMPILED_FCONTEXT_PCRE_VERS<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0s32=C2=A0 - stemid associated with the regex<br=
>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0u32=C2=A0 - spec has meta characters<br>
+ *=C2=A0 =C2=A0 =C2=A0u32=C2=A0 - The specs prefix_len if &gt;=3D SELINUX_=
COMPILED_FCONTEXT_PREFIX_LEN<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0u32=C2=A0 - data length of the pcre regex<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0char - a bufer holding the raw pcre regex info<=
br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0u32=C2=A0 - data length of the pcre regex study=
 daya<br>
@@ -141,6 +142,7 @@ static int write_binary_file(struct saved_data *data, i=
nt fd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *context =3D s=
pecs[i].lr.ctx_raw;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *regex_str =3D=
 specs[i].regex_str;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_t mode =3D spe=
cs[i].mode;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t prefix_len =
=3D specs[i].prefix_len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t stem_id =3D=
 specs[i].stem_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcre *re =3D specs[=
i].regex;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcre_extra *sd =3D =
get_pcre_extra(&amp;specs[i]);<br>
@@ -186,6 +188,12 @@ static int write_binary_file(struct saved_data *data, =
int fd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto err;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* For SELINUX_COMP=
ILED_FCONTEXT_PREFIX_LEN */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to_write =3D prefix=
_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D fwrite(&amp=
;to_write, sizeof(to_write), 1, bin_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* determine the si=
ze of the pcre data in bytes */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pcre_fullinf=
o(re, NULL, PCRE_INFO_SIZE, &amp;size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
--<br>
2.1.0<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div>

--001a11c03432e4fe90051a360727--
