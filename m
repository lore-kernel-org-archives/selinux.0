Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tANItrbi022517
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 13:57:38 -0500
Received: by oies6 with SMTP id s6so139172124oie.1
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:55:14 -0800 (PST)
MIME-Version: 1.0
References: <1448286761-4903-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1448286761-4903-1-git-send-email-richard_c_haines@btinternet.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 23 Nov 2015 18:55:04 +0000
Message-ID: <CABXk95Bp5tTAsSuYvm0n9F3ZnyEHbd1GTt=WViyJMV5VRF3-Uw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Correct line count for property and service
 contexts files
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e0149c664eb5c1f052539c353
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0149c664eb5c1f052539c353
Content-Type: text/plain; charset=UTF-8

Acked-by: Jeff Vander Stoep <jeffv@google.com>

Already merged into AOSP.

On Mon, Nov 23, 2015 at 5:56 AM Richard Haines <
richard_c_haines@btinternet.com> wrote:

> When a line number is displayed for context errors they are
> x2 the correct value, so reset line count for each pass.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/label_android_property.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_android_property.c
> b/libselinux/src/label_android_property.c
> index 712eecb..fea1f8f 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -132,7 +132,7 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>         const char *path = NULL;
>         FILE *fp;
>         char line_buf[BUFSIZ];
> -       unsigned int lineno = 0, maxnspec, pass;
> +       unsigned int lineno, maxnspec, pass;
>         int status = -1;
>         struct stat sb;
>
> @@ -166,6 +166,7 @@ static int init(struct selabel_handle *rec, const
> struct selinux_opt *opts,
>         maxnspec = UINT_MAX / sizeof(spec_t);
>         for (pass = 0; pass < 2; pass++) {
>                 data->nspec = 0;
> +               lineno = 0;
>
>                 while (fgets(line_buf, sizeof(line_buf) - 1, fp)
>                        && data->nspec < maxnspec) {
> --
> 2.5.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--089e0149c664eb5c1f052539c353
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Acked-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jef=
fv@google.com">jeffv@google.com</a>&gt;<br></div><div><br></div><div>Alread=
y merged into AOSP.</div><div><br></div><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Mon, Nov 23, 2015 at 5:56 AM Richard Haines &lt;<a href=3D"mail=
to:richard_c_haines@btinternet.com" target=3D"_blank">richard_c_haines@btin=
ternet.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When a l=
ine number is displayed for context errors they are<br>
x2 the correct value, so reset line count for each pass.<br>
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com" target=3D"_blank">richard_c_haines@btinternet.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/label_android_property.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label=
_android_property.c<br>
index 712eecb..fea1f8f 100644<br>
--- a/libselinux/src/label_android_property.c<br>
+++ b/libselinux/src/label_android_property.c<br>
@@ -132,7 +132,7 @@ static int init(struct selabel_handle *rec, const struc=
t selinux_opt *opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char line_buf[BUFSIZ];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int lineno =3D 0, maxnspec, pass;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int lineno, maxnspec, pass;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int status =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stat sb;<br>
<br>
@@ -166,6 +166,7 @@ static int init(struct selabel_handle *rec, const struc=
t selinux_opt *opts,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 maxnspec =3D UINT_MAX / sizeof(spec_t);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (pass =3D 0; pass &lt; 2; pass++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;nspec =3D =
0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lineno =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (fgets(line_b=
uf, sizeof(line_buf) - 1, fp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; data-&gt;nspec &lt; maxnspec) {<br>
--<br>
2.5.0<br>
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
</blockquote></div></div>

--089e0149c664eb5c1f052539c353--
