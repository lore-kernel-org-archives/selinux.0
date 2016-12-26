Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQKUiYW005593
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 15:30:47 -0500
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 68E3956474C
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 21:30:39 +0100 (CET)
Received: by mail-it0-f51.google.com with SMTP id 75so157632339ite.1
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 12:30:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482506386.10020.10.camel@trentalancia.net>
References: <1482506214.10020.8.camel@trentalancia.net>
 <1482506386.10020.10.camel@trentalancia.net>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 26 Dec 2016 21:30:37 +0100
Message-ID: <CAJfZ7=ksisa9PoaUEZGVuzEiCqhnX3W051VUAmMD5gSU4LzEcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsemanage: fix optimized compile errors
To: Guido Trentalancia <guido@trentalancia.net>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1144bb34cf1ae90544959b6a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144bb34cf1ae90544959b6a
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 23, 2016 at 4:19 PM, Guido Trentalancia <guido@trentalancia.net>
wrote:

> Fix compile errors when using the "-O -Werror" flags on gcc6.
>
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  src/direct_api.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -pru libsemanage-2.6-orig/src/direct_api.c
> libsemanage-2.6/src/direct_api.c
> --- libsemanage-2.6-orig/src/direct_api.c       2016-10-14
> 17:31:26.000000000 +0200
> +++ libsemanage-2.6/src/direct_api.c    2016-12-23 15:22:50.101297993
> +0100
> @@ -955,8 +955,8 @@ static int semanage_compile_module(seman
>         ssize_t bzip_status;
>         int status = 0;
>         int compressed;
> -       size_t cil_data_len;
> -       size_t err_data_len;
> +       size_t cil_data_len = 0;
> +       size_t err_data_len = 0;
>
>         if (!strcasecmp(modinfo->lang_ext, "cil")) {
>                 goto cleanup;
>

Hello,
>From a package maintainer perspective (ie. someone who reads the git log in
order to find patchs which need to be backported), it would be nice if the
patch description would state whether this fixes a real error which went
undetected in the previous releases, or whether this silents a
false-positive warning from the compiler.
In this case, gcc is having hard time to find out whether
semanage_pipe_data() initializes *out_data_len and *err_data_len parameters
when this function is called by semanage_compile_module(). So it seems to
be a false-positive. If you confirm this analysis and send a second
revision, could you please add this information to the description?

Cheers,
Nicolas

--001a1144bb34cf1ae90544959b6a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Dec 23, 2016 at 4:19 PM, Guido Trentalancia <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:guido@trentalancia.net" target=3D"_blank">guido@trentalancia.n=
et</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Fix compile errors when using the &quot;-O -Werror&quot; flags on gcc6.<=
br>
<br>
Signed-off-by: Guido Trentalancia &lt;<a href=3D"mailto:guido@trentalancia.=
net">guido@trentalancia.net</a>&gt;<br>
---<br>
=C2=A0src/direct_api.c |=C2=A0 =C2=A0 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff -pru libsemanage-2.6-orig/src/<wbr>direct_api.c libsemanage-2.6/src/di=
rect_<wbr>api.c<br>
--- libsemanage-2.6-orig/src/<wbr>direct_api.c=C2=A0 =C2=A0 =C2=A0 =C2=A020=
16-10-14 17:31:26.000000000 +0200<br>
+++ libsemanage-2.6/src/direct_<wbr>api.c=C2=A0 =C2=A0 2016-12-23 15:22:50.=
101297993 +0100<br>
@@ -955,8 +955,8 @@ static int semanage_compile_module(seman<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t bzip_status;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int status =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int compressed;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t cil_data_len;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t err_data_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t cil_data_len =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t err_data_len =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcasecmp(modinfo-&gt;lang_<wbr>ext, &quo=
t;cil&quot;)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br></=
blockquote><div><br></div><div>Hello,</div><div>From a package maintainer p=
erspective (ie. someone who reads the git log in order to find patchs which=
 need to be backported), it would be nice if the patch description would st=
ate whether this fixes a real error which went undetected in the previous r=
eleases, or whether this silents a false-positive warning from the compiler=
.</div><div>In this case, gcc is having hard time to find out whether seman=
age_pipe_data() initializes *out_data_len and *err_data_len parameters when=
 this function is called by=C2=A0semanage_compile_module(). So it seems to =
be a false-positive. If you confirm this analysis and send a second revisio=
n, could you please add this information to the description?</div><div><br>=
</div><div>Cheers,</div><div>Nicolas</div></div><br></div></div>

--001a1144bb34cf1ae90544959b6a--
