Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8OIwCax023078
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 14:58:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id c12-v6so21066821otl.6
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 11:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180924181052.130507-1-nnk@google.com>
In-Reply-To: <20180924181052.130507-1-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 24 Sep 2018 11:55:43 -0700
Message-ID: <CAFftDdqBCkh=RFaO0EBqJNgbxx3pg_TCybCTb1u=o34mOXrVyw@mail.gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="00000000000000d7560576a28a0c"
Subject: Re: [PATCH 1/2] whitespace and spelling cleanup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--00000000000000d7560576a28a0c
Content-Type: text/plain; charset="UTF-8"

ack

On Mon, Sep 24, 2018 at 11:12 AM Nick Kralevich via Selinux <
selinux@tycho.nsa.gov> wrote:

> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  libsepol/include/sepol/errcodes.h |  2 +-
>  secilc/secilc.c                   | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/include/sepol/errcodes.h
> b/libsepol/include/sepol/errcodes.h
> index 0136564a..6e9ff316 100644
> --- a/libsepol/include/sepol/errcodes.h
> +++ b/libsepol/include/sepol/errcodes.h
> @@ -12,7 +12,7 @@ extern "C" {
>  #define SEPOL_OK             0
>
>  /* These first error codes are defined for compatibility with
> - * previous version of libsepol. In the future, custome error
> + * previous version of libsepol. In the future, custom error
>   * codes that don't map to system error codes should be defined
>   * outside of the range of system error codes.
>   */
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index 0be6975b..e1347205 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -1,16 +1,16 @@
>  /*
>   * Copyright 2011 Tresys Technology, LLC. All rights reserved.
> - *
> + *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions are
> met:
> - *
> + *
>   *    1. Redistributions of source code must retain the above copyright
> notice,
>   *       this list of conditions and the following disclaimer.
> - *
> + *
>   *    2. Redistributions in binary form must reproduce the above
> copyright notice,
>   *       this list of conditions and the following disclaimer in the
> documentation
>   *       and/or other materials provided with the distribution.
> - *
> + *
>   * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY
> EXPRESS
>   * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> WARRANTIES OF
>   * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> IN NO
> @@ -21,7 +21,7 @@
>   * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
> NEGLIGENCE
>   * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
> IF
>   * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> + *
>   * The views and conclusions contained in the software and documentation
> are those
>   * of the authors and should not be interpreted as representing official
> policies,
>   * either expressed or implied, of Tresys Technology, LLC.
> @@ -259,7 +259,7 @@ int main(int argc, char *argv[])
>                         fprintf(stderr, "Could not stat file: %s\n",
> argv[i]);
>                         goto exit;
>                 }
> -               file_size = filedata.st_size;
> +               file_size = filedata.st_size;
>
>                 buffer = malloc(file_size);
>                 rc = fread(buffer, file_size, 1, file);
> @@ -347,7 +347,7 @@ int main(int argc, char *argv[])
>                 fprintf(stderr, "Failed to open file_contexts file\n");
>                 goto exit;
>         }
> -
> +
>         if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) !=
> fc_size) {
>                 fprintf(stderr, "Failed to write file_contexts file\n");
>                 goto exit;
> --
> 2.19.0.444.g18242da7ef-goog
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--00000000000000d7560576a28a0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ack</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Mon, Sep 24, 2018 at 11:12 AM Nick Kralevich via Selinux &lt;<a href=3D"m=
ailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Signed-off-by: Nick Kralevich &lt;<a href=3D=
"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>&gt;<br>
---<br>
=C2=A0libsepol/include/sepol/errcodes.h |=C2=A0 2 +-<br>
=C2=A0secilc/secilc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 14 +++++++-------<br>
=C2=A02 files changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/libsepol/include/sepol/errcodes.h b/libsepol/include/sepol/err=
codes.h<br>
index 0136564a..6e9ff316 100644<br>
--- a/libsepol/include/sepol/errcodes.h<br>
+++ b/libsepol/include/sepol/errcodes.h<br>
@@ -12,7 +12,7 @@ extern &quot;C&quot; {<br>
=C2=A0#define SEPOL_OK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
<br>
=C2=A0/* These first error codes are defined for compatibility with<br>
- * previous version of libsepol. In the future, custome error<br>
+ * previous version of libsepol. In the future, custom error<br>
=C2=A0 * codes that don&#39;t map to system error codes should be defined<b=
r>
=C2=A0 * outside of the range of system error codes.<br>
=C2=A0 */<br>
diff --git a/secilc/secilc.c b/secilc/secilc.c<br>
index 0be6975b..e1347205 100644<br>
--- a/secilc/secilc.c<br>
+++ b/secilc/secilc.c<br>
@@ -1,16 +1,16 @@<br>
=C2=A0/*<br>
=C2=A0 * Copyright 2011 Tresys Technology, LLC. All rights reserved.<br>
- * <br>
+ *<br>
=C2=A0 * Redistribution and use in source and binary forms, with or without=
<br>
=C2=A0 * modification, are permitted provided that the following conditions=
 are met:<br>
- * <br>
+ *<br>
=C2=A0 *=C2=A0 =C2=A0 1. Redistributions of source code must retain the abo=
ve copyright notice,<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0this list of conditions and the followin=
g disclaimer.<br>
- * <br>
+ *<br>
=C2=A0 *=C2=A0 =C2=A0 2. Redistributions in binary form must reproduce the =
above copyright notice,<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0this list of conditions and the followin=
g disclaimer in the documentation<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0and/or other materials provided with the=
 distribution.<br>
- * <br>
+ *<br>
=C2=A0 * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS&#39;&#=
39; AND ANY EXPRESS<br>
=C2=A0 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED =
WARRANTIES OF<br>
=C2=A0 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIME=
D. IN NO<br>
@@ -21,7 +21,7 @@<br>
=C2=A0 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDI=
NG NEGLIGENCE<br>
=C2=A0 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, =
EVEN IF<br>
=C2=A0 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.<br>
- * <br>
+ *<br>
=C2=A0 * The views and conclusions contained in the software and documentat=
ion are those<br>
=C2=A0 * of the authors and should not be interpreted as representing offic=
ial policies,<br>
=C2=A0 * either expressed or implied, of Tresys Technology, LLC.<br>
@@ -259,7 +259,7 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(stderr, &quot;Could not stat file: %s\n&quot;, argv[i]);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_size =3D filed=
ata.st_size;=C2=A0 =C2=A0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_size =3D filed=
ata.st_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer =3D malloc(f=
ile_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D fread(buffer=
, file_size, 1, file);<br>
@@ -347,7 +347,7 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;Failed to open file_contexts file\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fwrite(fc_buf, sizeof(char), fc_size, file_=
contexts) !=3D fc_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;Failed to write file_contexts file\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
-- <br>
2.19.0.444.g18242da7ef-goog<br>
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

--00000000000000d7560576a28a0c--
