Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M0ISkZ009846
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:18:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id i10-v6so14716226oth.0
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 17:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180922000859.121485-1-nnk@google.com>
In-Reply-To: <20180922000859.121485-1-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 21 Sep 2018 17:17:50 -0700
Message-ID: <CAFftDdo8p7M02QZsXm9Kf4BgDh0fhTBrj4rZ+qGFZL2YG0ypPg@mail.gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000516f8d05766ab07f"
Subject: Re: [PATCH] secilc: better error handling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000516f8d05766ab07f
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 21, 2018 at 5:12 PM Nick Kralevich via Selinux <
selinux@tycho.nsa.gov> wrote:

> Fix a situation where the secilc command line tool could return success
> even though the compilation failed.
>
>   $ secilc /dev/null -o /dev/null -f /dev/null
>   Failure reading file: /dev/null
>   $ echo $?
>   0
>
> Fix a few other minor oversights while I'm here.
>

I'd prefer this split into at least 2 patches on the off chance we
need to revert the actual code changes we don't lose the spelling
and whitespace fixes. Otherwise LGTM.


>
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  libsepol/include/sepol/errcodes.h | 2 +-
>  secilc/secilc.c                   | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
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
> index 0be6975b..8578cc26 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -257,14 +257,16 @@ int main(int argc, char *argv[])
>                 rc = stat(argv[i], &filedata);
>                 if (rc == -1) {
>                         fprintf(stderr, "Could not stat file: %s\n",
> argv[i]);
> +                       rc = SEPOL_ERR;
>                         goto exit;
>                 }
> -               file_size = filedata.st_size;
> +               file_size = filedata.st_size;
>
>                 buffer = malloc(file_size);
>                 rc = fread(buffer, file_size, 1, file);
>                 if (rc != 1) {
>                         fprintf(stderr, "Failure reading file: %s\n",
> argv[i]);
> +                       rc = SEPOL_ERR;
>                         goto exit;
>                 }
>                 fclose(file);
> @@ -345,11 +347,13 @@ int main(int argc, char *argv[])
>
>         if (file_contexts == NULL) {
>                 fprintf(stderr, "Failed to open file_contexts file\n");
> +               rc = SEPOL_ERR;
>                 goto exit;
>         }
> -
> +
>         if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) !=
> fc_size) {
>                 fprintf(stderr, "Failed to write file_contexts file\n");
> +               rc = SEPOL_ERR;
>                 goto exit;
>         }
>
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

--000000000000516f8d05766ab07f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri=
, Sep 21, 2018 at 5:12 PM Nick Kralevich via Selinux &lt;<a href=3D"mailto:=
selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Fix a situation where the secilc command line tool=
 could return success<br>
even though the compilation failed.<br>
<br>
=C2=A0 $ secilc /dev/null -o /dev/null -f /dev/null<br>
=C2=A0 Failure reading file: /dev/null<br>
=C2=A0 $ echo $?<br>
=C2=A0 0<br>
<br>
Fix a few other minor oversights while I&#39;m here.<br></blockquote><div><=
br></div><div>I&#39;d prefer this split into at least 2 patches on the off =
chance we</div><div>need to revert the actual code changes we don&#39;t los=
e the spelling</div><div>and whitespace fixes. Otherwise LGTM.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com" target=
=3D"_blank">nnk@google.com</a>&gt;<br>
---<br>
=C2=A0libsepol/include/sepol/errcodes.h | 2 +-<br>
=C2=A0secilc/secilc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 8 ++++++--<br>
=C2=A02 files changed, 7 insertions(+), 3 deletions(-)<br>
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
index 0be6975b..8578cc26 100644<br>
--- a/secilc/secilc.c<br>
+++ b/secilc/secilc.c<br>
@@ -257,14 +257,16 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D stat(argv[i]=
, &amp;filedata);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc =3D=3D -1) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(stderr, &quot;Could not stat file: %s\n&quot;, argv[i]);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D SEPOL_ERR;<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D 1) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(stderr, &quot;Failure reading file: %s\n&quot;, argv[i])=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rc =3D SEPOL_ERR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(file);<br>
@@ -345,11 +347,13 @@ int main(int argc, char *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (file_contexts =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;Failed to open file_contexts file\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_ERR;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fwrite(fc_buf, sizeof(char), fc_size, file_=
contexts) !=3D fc_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;Failed to write file_contexts file\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_ERR;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
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
</blockquote></div></div>

--000000000000516f8d05766ab07f--
