Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8OIx7pa025439
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 14:59:07 -0400
Received: by mail-ot1-f49.google.com with SMTP id o13-v6so21079549otl.4
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 11:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180924181052.130507-1-nnk@google.com>
 <20180924181052.130507-2-nnk@google.com>
In-Reply-To: <20180924181052.130507-2-nnk@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 24 Sep 2018 11:58:51 -0700
Message-ID: <CAFftDdo560WbPNt_hMjFqovoh-aG55HnPghpZnzYyHHk1hZirQ@mail.gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000002a6bc70576a295a0"
Subject: Re: [PATCH 2/2] secilc: better error handling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000002a6bc70576a295a0
Content-Type: text/plain; charset="UTF-8"

ack

On Mon, Sep 24, 2018 at 11:12 AM Nick Kralevich via Selinux <
selinux@tycho.nsa.gov> wrote:

> Fix a situation where the secilc command line tool could return success
> even though the compilation failed.
>
>   $ secilc /dev/null -o /dev/null -f /dev/null
>   Failure reading file: /dev/null
>   $ echo $?
>   0
>
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  secilc/secilc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index e1347205..ad6862ba 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -257,6 +257,7 @@ int main(int argc, char *argv[])
>                 rc = stat(argv[i], &filedata);
>                 if (rc == -1) {
>                         fprintf(stderr, "Could not stat file: %s\n",
> argv[i]);
> +                       rc = SEPOL_ERR;
>                         goto exit;
>                 }
>                 file_size = filedata.st_size;
> @@ -265,6 +266,7 @@ int main(int argc, char *argv[])
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
>
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

--0000000000002a6bc70576a295a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ack</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Mon, Sep 24, 2018 at 11:12 AM Nick Kralevich via Selinux &lt;<a href=3D"m=
ailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Fix a situation where the secilc command lin=
e tool could return success<br>
even though the compilation failed.<br>
<br>
=C2=A0 $ secilc /dev/null -o /dev/null -f /dev/null<br>
=C2=A0 Failure reading file: /dev/null<br>
=C2=A0 $ echo $?<br>
=C2=A0 0<br>
<br>
Signed-off-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com" target=
=3D"_blank">nnk@google.com</a>&gt;<br>
---<br>
=C2=A0secilc/secilc.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/secilc/secilc.c b/secilc/secilc.c<br>
index e1347205..ad6862ba 100644<br>
--- a/secilc/secilc.c<br>
+++ b/secilc/secilc.c<br>
@@ -257,6 +257,7 @@ int main(int argc, char *argv[])<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file_size =3D filed=
ata.st_size;<br>
@@ -265,6 +266,7 @@ int main(int argc, char *argv[])<br>
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
<br>
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
</blockquote></div>

--0000000000002a6bc70576a295a0--
