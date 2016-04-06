Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u360WSYK022619
 for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2016 20:32:29 -0400
Received: by mail-yw0-f179.google.com with SMTP id g3so37490041ywa.3
 for <selinux@tycho.nsa.gov>; Tue, 05 Apr 2016 17:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459902074-127953-1-git-send-email-nnk@google.com>
References: <1459902074-127953-1-git-send-email-nnk@google.com>
Date: Tue, 5 Apr 2016 17:32:27 -0700
Message-ID: <CAFJ0LnFTRaW9ir86H1Ls_Aznu-R1Zpj7CtRb4YRqOojBJBnUBg@mail.gmail.com>
Subject: Re: [PATCH] cil_mem.c: #define _GNU_SOURCE
From: Nick Kralevich <nnk@google.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c0a7ce2b03ba3052fc618ab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0a7ce2b03ba3052fc618ab
Content-Type: text/plain; charset=UTF-8

please disregard this patch.

-- Nick

On Tue, Apr 5, 2016 at 5:21 PM, Nick Kralevich <nnk@google.com> wrote:

> Fix the following compiler error:
>
>   external/selinux/libsepol/cil/src/cil_mem.c:109:7: warning: implicit
>   declaration of function 'vasprintf' is invalid in C99
>   [-Wimplicit-function-declaration]
> ---
>  libsepol/cil/src/cil_mem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> index 12c59be..023e6bd 100644
> --- a/libsepol/cil/src/cil_mem.c
> +++ b/libsepol/cil/src/cil_mem.c
> @@ -27,6 +27,7 @@
>   * either expressed or implied, of Tresys Technology, LLC.
>   */
>
> +#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <stdarg.h>
> --
> 2.8.0.rc3.226.g39d4020
>
>


-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--94eb2c0a7ce2b03ba3052fc618ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">please disregard this patch.<div><br></div><div>-- Nick</d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, =
Apr 5, 2016 at 5:21 PM, Nick Kralevich <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:nnk@google.com" target=3D"_blank">nnk@google.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Fix the following compiler error:<br>
<br>
=C2=A0 external/selinux/libsepol/cil/src/cil_mem.c:109:7: warning: implicit=
<br>
=C2=A0 declaration of function &#39;vasprintf&#39; is invalid in C99<br>
=C2=A0 [-Wimplicit-function-declaration]<br>
---<br>
=C2=A0libsepol/cil/src/cil_mem.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c<br>
index 12c59be..023e6bd 100644<br>
--- a/libsepol/cil/src/cil_mem.c<br>
+++ b/libsepol/cil/src/cil_mem.c<br>
@@ -27,6 +27,7 @@<br>
=C2=A0 * either expressed or implied, of Tresys Technology, LLC.<br>
=C2=A0 */<br>
<br>
+#define _GNU_SOURCE<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.0.rc3.226.g39d4020<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div>Nick Kralevich | Android Security | <=
a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a> | 650=
.214.4037</div></div>
</div>

--94eb2c0a7ce2b03ba3052fc618ab--
