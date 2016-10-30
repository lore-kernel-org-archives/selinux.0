Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9ULZK56005080
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 17:35:20 -0400
Received: by mail-qk0-f193.google.com with SMTP id v138so6035107qka.2
 for <selinux@tycho.nsa.gov>; Sun, 30 Oct 2016 14:35:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161030212722.24743-1-nicolas.iooss@m4x.org>
References: <20161030212722.24743-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 30 Oct 2016 14:35:18 -0700
Message-ID: <CAFftDdoCBonFzoNAj=cbrGOp-EhVXAic3aey8bYGq8td+_attw@mail.gmail.com>
Subject: Re: [PATCH 1/1] policycoreutils: semodule_package: do not fail with
 an empty fc file
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c043d7228b6b905401bdeda
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c043d7228b6b905401bdeda
Content-Type: text/plain; charset=UTF-8

Ack on this, I've had similar issues in Android that I patched up in the
Android specific tooling.

On Oct 30, 2016 14:28, "Nicolas Iooss" <nicolas.iooss@m4x.org> wrote:

> When running sepolgen tests on a Linux 4.7 kernel, one test fails with
> the following message:
>
>     /usr/bin/semodule_package:  Failed to mmap
>     tmp/module_compile_test.mod.fc:  Invalid argument
>
> The .fc file is empty, which is why it cannot be used with mmap().
> Anyway the current code supports empty files (with if() conditions in
> main()) so do not try to mmap an empty file in file_to_data().
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>
> While at it, it seems that neither seusersdata nor user_extradata are
> unmapped at the end of main(). As this does not cause a test to fail
> I will not send a patch to fix this.
>
>  policycoreutils/semodule_package/semodule_package.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/policycoreutils/semodule_package/semodule_package.c
> b/policycoreutils/semodule_package/semodule_package.c
> index d2a5fd07bd71..e472054826a3 100644
> --- a/policycoreutils/semodule_package/semodule_package.c
> +++ b/policycoreutils/semodule_package/semodule_package.c
> @@ -72,6 +72,10 @@ static int file_to_data(const char *path, char **data,
> size_t * len)
>                         path, strerror(errno));
>                 goto err;
>         }
> +       if (!sb.st_size) {
> +               *len = 0;
> +               return 0;
> +       }
>
>         *data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
>         if (*data == MAP_FAILED) {
> --
> 2.10.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--94eb2c043d7228b6b905401bdeda
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Ack on this, I&#39;ve had similar issues in Android that I p=
atched up in the Android specific tooling.</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Oct 30, 2016 1=
4:28, &quot;Nicolas Iooss&quot; &lt;<a href=3D"mailto:nicolas.iooss@m4x.org=
">nicolas.iooss@m4x.org</a>&gt; wrote:<br type=3D"attribution"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">When running sepolgen tests on a Linux 4.7 kernel, one t=
est fails with<br>
the following message:<br>
<br>
=C2=A0 =C2=A0 /usr/bin/semodule_package:=C2=A0 Failed to mmap<br>
=C2=A0 =C2=A0 tmp/module_compile_test.mod.<wbr>fc:=C2=A0 Invalid argument<b=
r>
<br>
The .fc file is empty, which is why it cannot be used with mmap().<br>
Anyway the current code supports empty files (with if() conditions in<br>
main()) so do not try to mmap an empty file in file_to_data().<br>
<br>
Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org">n=
icolas.iooss@m4x.org</a>&gt;<br>
---<br>
<br>
While at it, it seems that neither seusersdata nor user_extradata are<br>
unmapped at the end of main(). As this does not cause a test to fail<br>
I will not send a patch to fix this.<br>
<br>
=C2=A0policycoreutils/semodule_<wbr>package/semodule_package.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/policycoreutils/semodule_<wbr>package/semodule_package.c b/pol=
icycoreutils/semodule_<wbr>package/semodule_package.c<br>
index d2a5fd07bd71..e472054826a3 100644<br>
--- a/policycoreutils/semodule_<wbr>package/semodule_package.c<br>
+++ b/policycoreutils/semodule_<wbr>package/semodule_package.c<br>
@@ -72,6 +72,10 @@ static int file_to_data(const char *path, char **data, s=
ize_t * len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 path, strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sb.st_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*len =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *data =3D mmap(NULL, sb.st_size, PROT_READ, MAP=
_PRIVATE, fd, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*data =3D=3D MAP_FAILED) {<br>
--<br>
2.10.1<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div></div>

--94eb2c043d7228b6b905401bdeda--
