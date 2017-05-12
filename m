Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4C0ICHt003614
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 20:18:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id l18so49188852oig.2
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 17:18:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170511235002.26468-1-tomcherry@google.com>
References: <20170511235002.26468-1-tomcherry@google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 11 May 2017 17:18:04 -0700
Message-ID: <CAFftDdrQMV_HbFLaUTjtDwO4UXgWCcKF8QWe8BytX_iPUUWZtQ@mail.gmail.com>
Subject: Re: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
To: Tom Cherry <tomcherry@google.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "enh@google.com" <enh@google.com>
Content-Type: multipart/alternative; boundary="001a11c15cfaa33ed5054f48a3a8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c15cfaa33ed5054f48a3a8
Content-Type: text/plain; charset="UTF-8"

On Thursday, May 11, 2017, Tom Cherry via Selinux <selinux@tycho.nsa.gov>
wrote:

> This check is not specific to Android devices. If libselinux were used
> with Bionic on a normal Linux system this check would still be needed.
>
> Signed-off-by: Tom Cherry <tomcherry@google.com <javascript:;>>
> ---
>  libselinux/src/procattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index ebc0adec..48dd8aff 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -22,8 +22,8 @@ static pthread_key_t destructor_key;
>  static int destructor_key_initialized = 0;
>  static __thread char destructor_initialized;
>
> -#ifndef __ANDROID__
> -/* Android declares this in unistd.h and has a definition for it */
> +#ifndef __BIONIC__
> +/* Bionic declares this in unistd.h and has a definition for it */
>  static pid_t gettid(void)
>  {
>         return syscall(__NR_gettid);
> --
> 2.13.0.rc2.291.g57267f2277-goog



Ack.. thanks for this. There might be other places I used Android when I
should have used bionic




-- 
Respectfully,

William C Roberts

--001a11c15cfaa33ed5054f48a3a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, May 11, 2017, Tom Cherry via Selinux &lt;<a href=3D"mailto:sel=
inux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">This check is not specific to Android devices. If libselinu=
x were used<br>
with Bionic on a normal Linux system this check would still be needed.<br>
<br>
Signed-off-by: Tom Cherry &lt;<a href=3D"javascript:;" onclick=3D"_e(event,=
 &#39;cvml&#39;, &#39;tomcherry@google.com&#39;)">tomcherry@google.com</a>&=
gt;<br>
---<br>
=C2=A0libselinux/src/procattr.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c<br>
index ebc0adec..48dd8aff 100644<br>
--- a/libselinux/src/procattr.c<br>
+++ b/libselinux/src/procattr.c<br>
@@ -22,8 +22,8 @@ static pthread_key_t destructor_key;<br>
=C2=A0static int destructor_key_initialized =3D 0;<br>
=C2=A0static __thread char destructor_initialized;<br>
<br>
-#ifndef __ANDROID__<br>
-/* Android declares this in unistd.h and has a definition for it */<br>
+#ifndef __BIONIC__<br>
+/* Bionic declares this in unistd.h and has a definition for it */<br>
=C2=A0static pid_t gettid(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return syscall(__NR_gettid);<br>
--<br>
2.13.0.rc2.291.g57267f2277-<wbr>goog</blockquote><div><br></div><div><br></=
div><div>Ack.. thanks for this. There might be other places I used Android =
when I should have used bionic<br></div><div><br></div><div>=C2=A0</div><br=
><br>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>

--001a11c15cfaa33ed5054f48a3a8--
