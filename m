Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1S45abE025468
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 23:05:36 -0500
Received: by mail-oi0-f67.google.com with SMTP id f192so48736oic.3
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 20:05:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdry4gzU33U3UuZBk=mk_A-K9+TQieUc7cTWkR10ZAWO=g@mail.gmail.com>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
 <20170227203935.23674-3-nicolas.iooss@m4x.org>
 <CAFftDdry4gzU33U3UuZBk=mk_A-K9+TQieUc7cTWkR10ZAWO=g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 27 Feb 2017 20:05:33 -0800
Message-ID: <CAFftDdpDSZaz3G_nty1pcd_4JWfhV9L4ju4pkW701q8-2Nqvdw@mail.gmail.com>
Subject: Re: [PATCH 3/6] libsemanage: never call memcpy with a NULL value
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113cdb68c0b0c105498f4ed9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113cdb68c0b0c105498f4ed9
Content-Type: text/plain; charset=UTF-8

On Feb 27, 2017 2:16 PM, "William Roberts" <bill.c.roberts@gmail.com> wrote:



On Feb 27, 2017 12:42, "Nicolas Iooss" <nicolas.iooss@m4x.org> wrote:

clang's static analyzer reports "Argument with 'nonnull' attribute
passed null" in append_str(), because argument t may be NULL but is used
in a call to memcpy().

Make append_str() do nothing when called with t=NULL.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/semanage_store.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_sto
re.c
index f468faba4b64..47ec93185e06 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1194,8 +1194,14 @@ static char *append(char *s, char c)
 static char *append_str(char *s, const char *t)
 {
        size_t s_len = (s == NULL ? 0 : strlen(s));
-       size_t t_len = (t == NULL ? 0 : strlen(t));
-       char *new_s = realloc(s, s_len + t_len + 1);
+       size_t t_len;
+       char *new_s;
+
+       if (t == NULL) {
+               return s;
+       }
+       t_len = strlen(t);
+       new_s = realloc(s, s_len + t_len + 1);


Overflow possibility here?


I guess since s and t lengths come from strlen() and the architectures we
worry about running code on, overflowing would be pretty impossible here.


        if (new_s == NULL) {
                return NULL;
        }
--
2.11.1

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113cdb68c0b0c105498f4ed9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Feb 27, 2017 2:16 PM, &quot;William Roberts&quot; &lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div c=
lass=3D"elided-text"><div><br><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Feb 27, 2017 12:42, &quot;Nicolas Iooss&quot; &lt;<a href=
=3D"mailto:nicolas.iooss@m4x.org" target=3D"_blank">nicolas.iooss@m4x.org</=
a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"m_-2967454301020=
82773quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">clang&#39;s static analyzer reports &quot;Argument with &#39;nonnu=
ll&#39; attribute<br>
passed null&quot; in append_str(), because argument t may be NULL but is us=
ed<br>
in a call to memcpy().<br>
<br>
Make append_str() do nothing when called with t=3DNULL.<br>
<br>
Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org" t=
arget=3D"_blank">nicolas.iooss@m4x.org</a>&gt;<br>
---<br>
=C2=A0libsemanage/src/semanage_stor<wbr>e.c | 10 ++++++++--<br>
=C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/libsemanage/src/semanage_sto<wbr>re.c b/libsemanage/src/semana=
ge_sto<wbr>re.c<br>
index f468faba4b64..47ec93185e06 100644<br>
--- a/libsemanage/src/semanage_sto<wbr>re.c<br>
+++ b/libsemanage/src/semanage_sto<wbr>re.c<br>
@@ -1194,8 +1194,14 @@ static char *append(char *s, char c)<br>
=C2=A0static char *append_str(char *s, const char *t)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t s_len =3D (s =3D=3D NULL ? 0 : strlen(s)=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t t_len =3D (t =3D=3D NULL ? 0 : strlen(t)=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char *new_s =3D realloc(s, s_len + t_len + 1);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t t_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *new_s;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (t =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0t_len =3D strlen(t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0new_s =3D realloc(s, s_len + t_len + 1);<br></b=
lockquote></div></div></div><div dir=3D"auto"><br></div></div><div dir=3D"a=
uto">Overflow possibility here?</div></div></blockquote></div></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">I guess since s and t lengths =
come from strlen() and the architectures we worry about running code on, ov=
erflowing would be pretty impossible here.</div><div dir=3D"auto"><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"auto"><div class=3D"quoted-text"><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquot=
e class=3D"m_-296745430102082773quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (new_s =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<font color=3D"#888888">--<br>
2.11.1<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</font></blockquote></div><br></div></div></div></div>
</blockquote></div><br></div></div></div>

--001a113cdb68c0b0c105498f4ed9--
