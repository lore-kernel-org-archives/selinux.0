Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8U3JjfT025896
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 23:19:45 -0400
Received: by mail-vk0-f50.google.com with SMTP id y190so61471504vkd.3
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 20:19:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1475205475-146225-1-git-send-email-bowgotsai@google.com>
References: <1475205475-146225-1-git-send-email-bowgotsai@google.com>
From: Bowgo Tsai <bowgotsai@google.com>
Date: Fri, 30 Sep 2016 11:19:26 +0800
Message-ID: <CAMFYTWd2Hz7sEJZ_f4qCbGZUHYCVxv9yHLfC1mkWEaV10c2TaQ@mail.gmail.com>
Subject: Re: [PATCH] secilc: correct include path of cil.h for Android
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>, Daniel Cashman <dcashman@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=001a11439d68c93981053db10f52
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11439d68c93981053db10f52
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 30, 2016 at 11:17 AM, Bowgo Tsai <bowgotsai@google.com> wrote:

> From: bowgotsai <bowgotsai@google.com>
>
> The original CL in AOSP tree:
>   https://android-review.googlesource.com/#/c/274894
>
> BUG=31366888
> ---
>  secilc/secilc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index e98abe2..dad1e90 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -35,7 +35,7 @@
>  #include <sys/stat.h>
>
>  #ifdef ANDROID
> -#include <sepol/cil.h>
> +#include <cil/cil.h>
>  #else
>  #include <sepol/cil/cil.h>
>  #endif
> --
> 2.8.0.rc3.226.g39d4020
>
>


-- 

Bowgo Tsai |  Engineer |  bowgotsai@google.com |  +886 (2) 8729-6364
<%2B886287296364>

--001a11439d68c93981053db10f52
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Fri, Sep 30, 2016 at 11:17 AM, Bowgo Tsai <span dir=3D"ltr">&l=
t;<a href=3D"mailto:bowgotsai@google.com" target=3D"_blank">bowgotsai@googl=
e.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: bowgots=
ai &lt;<a href=3D"mailto:bowgotsai@google.com">bowgotsai@google.com</a>&gt;=
<br>
<br>
The original CL in AOSP tree:<br>
=C2=A0 <a href=3D"https://android-review.googlesource.com/#/c/274894" rel=
=3D"noreferrer" target=3D"_blank">https://android-review.<wbr>googlesource.=
com/#/c/274894</a><br>
<br>
BUG=3D31366888<br>
---<br>
=C2=A0secilc/secilc.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/secilc/secilc.c b/secilc/secilc.c<br>
index e98abe2..dad1e90 100644<br>
--- a/secilc/secilc.c<br>
+++ b/secilc/secilc.c<br>
@@ -35,7 +35,7 @@<br>
=C2=A0#include &lt;sys/stat.h&gt;<br>
<br>
=C2=A0#ifdef ANDROID<br>
-#include &lt;sepol/cil.h&gt;<br>
+#include &lt;cil/cil.h&gt;<br>
=C2=A0#else<br>
=C2=A0#include &lt;sepol/cil/cil.h&gt;<br>
=C2=A0#endif<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.0.rc3.226.g39d4020<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"=
><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=
=3D"font-family:Times"><tbody><tr style=3D"color:rgb(85,85,85);font-family:=
sans-serif;font-size:small"><td nowrap style=3D"font-family:arial;border-to=
p-style:solid;border-top-color:rgb(213,15,37);border-top-width:2px">Bowgo T=
sai |</td><td nowrap style=3D"font-family:arial;border-top-style:solid;bord=
er-top-color:rgb(51,105,232);border-top-width:2px">=C2=A0Engineer |</td><td=
 nowrap style=3D"font-family:arial;border-top-style:solid;border-top-color:=
rgb(0,153,57);border-top-width:2px">=C2=A0<a href=3D"mailto:bowgotsai@googl=
e.com" target=3D"_blank">bowgotsai@google.com</a>=C2=A0|</td><td nowrap sty=
le=3D"font-family:arial;border-top-style:solid;border-top-color:rgb(238,178=
,17);border-top-width:2px">=C2=A0<a href=3D"tel:%2B886287296364" value=3D"+=
886287296364" style=3D"color:rgb(17,85,204);font-family:arial,sans-serif;fo=
nt-size:12.8000001907349px;white-space:normal" target=3D"_blank">+886 (2) 8=
729-6364</a></td></tr></tbody></table><br><div><font face=3D"Times" size=3D=
"3" style=3D"color:rgb(136,136,136);background-color:rgb(255,255,255)"></fo=
nt></div></div></div></div></div></div></div></div></div></div></div></div>=
</div></div></div></div>
</div>

--001a11439d68c93981053db10f52--
