Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2N0SXme005825
 for <selinux@tycho.nsa.gov>; Wed, 22 Mar 2017 20:28:33 -0400
Received: by mail-yw0-f178.google.com with SMTP id d191so9975921ywe.2
 for <selinux@tycho.nsa.gov>; Wed, 22 Mar 2017 17:28:19 -0700 (PDT)
MIME-Version: 1.0
Sender: grundler@google.com
In-Reply-To: <20170316222652.125702-1-mka@chromium.org>
References: <20170316222652.125702-1-mka@chromium.org>
From: Grant Grundler <grundler@chromium.org>
Date: Wed, 22 Mar 2017 17:28:17 -0700
Message-ID: <CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove unnecessary check of array base in
 selinux_set_mapping()
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Prarit Bhargava <prarit@redhat.com>, David Howells <dhowells@redhat.com>,
 Grant Grundler <grundler@chromium.org>,
 Michael Davidson <md@google.com>, Greg Hackmann <ghackmann@google.com>
Content-Type: multipart/alternative; boundary=f403045eb0821ff1df054b5af44c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045eb0821ff1df054b5af44c
Content-Type: text/plain; charset=UTF-8

Ping? Any feedback on this patch?

LGTM.

cheers,
grant

On Thu, Mar 16, 2017 at 3:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:

> 'perms' will never be NULL since it isn't a plain pointer but an array
> of u32 values.
>
> This fixes the following warning when building with clang:
>
> security/selinux/ss/services.c:158:16: error: address of array
> 'p_in->perms' will always evaluate to 'true'
> [-Werror,-Wpointer-bool-conversion]
>                 while (p_in->perms && p_in->perms[k]) {
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/
> services.c
> index 082b20c78363..2f20b5f974f4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>                 }
>
>                 k = 0;
> -               while (p_in->perms && p_in->perms[k]) {
> +               while (p_in->perms[k]) {
>                         /* An empty permission string skips ahead */
>                         if (!*p_in->perms[k]) {
>                                 k++;
> --
> 2.12.0.367.g23dc2f6d3c-goog
>
>

--f403045eb0821ff1df054b5af44c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping? Any feedback on this patch?<div><br></div><div>LGTM.=
</div><div><br></div><div>cheers,</div><div>grant<br><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Mar 16, 2017 at 3:26 PM, Matthi=
as Kaehlcke <span dir=3D"ltr">&lt;<a href=3D"mailto:mka@chromium.org" targe=
t=3D"_blank">mka@chromium.org</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">&#39;perms&#39; will never be NULL since it isn&#39;t a plain po=
inter but an array<br>
of u32 values.<br>
<br>
This fixes the following warning when building with clang:<br>
<br>
security/selinux/ss/services.<wbr>c:158:16: error: address of array<br>
&#39;p_in-&gt;perms&#39; will always evaluate to &#39;true&#39;<br>
[-Werror,-Wpointer-bool-<wbr>conversion]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (p_in-&gt;per=
ms &amp;&amp; p_in-&gt;perms[k]) {<br>
<br>
Signed-off-by: Matthias Kaehlcke &lt;<a href=3D"mailto:mka@chromium.org">mk=
a@chromium.org</a>&gt;<br>
---<br>
=C2=A0security/selinux/ss/services.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/security/selinux/ss/<wbr>services.c b/security/selinux/ss/<wbr=
>services.c<br>
index 082b20c78363..2f20b5f974f4 100644<br>
--- a/security/selinux/ss/<wbr>services.c<br>
+++ b/security/selinux/ss/<wbr>services.c<br>
@@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (p_in-&gt;per=
ms &amp;&amp; p_in-&gt;perms[k]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (p_in-&gt;per=
ms[k]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* An empty permission string skips ahead */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!*p_in-&gt;perms[k]) {<br>
<span class=3D"HOEnZb"><font color=3D"#888888">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 k++;<br>
--<br>
2.12.0.367.g23dc2f6d3c-goog<br>
<br>
</font></span></blockquote></div><br></div></div></div>

--f403045eb0821ff1df054b5af44c--
