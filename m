Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7KLphWu027800
 for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2018 17:51:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so28521339oib.10
 for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2018 14:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180819184901.6395-3-nicolas.iooss@m4x.org>
References: <20180819184901.6395-1-nicolas.iooss@m4x.org>
 <20180819184901.6395-3-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 20 Aug 2018 14:51:37 -0700
Message-ID: <CAFftDdqrOxwdTVYeZkHckgkrTpLrA=jmjU+DvGneOLb+M+Euzg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000ebb2ae0573e4e9fb"
Subject: Re: [PATCH 3/3] python: remove semicolon from end of lines
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000ebb2ae0573e4e9fb
Content-Type: text/plain; charset="UTF-8"

Ack on these as well

On Sun, Aug 19, 2018 at 11:49 AM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> Python does not need to end a statement with a semicolon. Doing this
> gets reported by linters such as flake8 ("E703 statement ends with a
> semicolon").
>
> Remove such semicolons in the code and enable this warning in
> scripts/run-flake8.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/sepolgen/src/sepolgen/audit.py | 2 +-
>  python/sepolgen/src/sepolgen/yacc.py  | 8 ++++----
>  python/sepolicy/sepolicy/manpage.py   | 2 +-
>  scripts/run-flake8                    | 1 -
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/
> sepolgen/audit.py
> index daed58ce9643..4adb851f3e93 100644
> --- a/python/sepolgen/src/sepolgen/audit.py
> +++ b/python/sepolgen/src/sepolgen/audit.py
> @@ -258,7 +258,7 @@ class AVCMessage(AuditMessage):
>          if (scontext, tcontext, self.tclass, access_tuple) in
> avcdict.keys():
>              self.type, self.data = avcdict[(scontext, tcontext,
> self.tclass, access_tuple)]
>          else:
> -            self.type, self.data = audit2why.analyze(scontext, tcontext,
> self.tclass, self.accesses);
> +            self.type, self.data = audit2why.analyze(scontext, tcontext,
> self.tclass, self.accesses)
>              if self.type == audit2why.NOPOLICY:
>                  self.type = audit2why.TERULE
>              if self.type == audit2why.BADTCON:
> diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src/
> sepolgen/yacc.py
> index f00635469af1..afef174849f2 100644
> --- a/python/sepolgen/src/sepolgen/yacc.py
> +++ b/python/sepolgen/src/sepolgen/yacc.py
> @@ -1864,10 +1864,10 @@ del _lr_action_items
>  """)
>
>          else:
> -            f.write("\n_lr_action = { ");
> +            f.write("\n_lr_action = { ")
>              for k,v in _lr_action.items():
>                  f.write("(%r,%r):%r," % (k[0],k[1],v))
> -            f.write("}\n");
> +            f.write("}\n")
>
>          if smaller:
>              # Factor out names to try and make smaller
> @@ -1901,10 +1901,10 @@ for _k, _v in _lr_goto_items.items():
>  del _lr_goto_items
>  """)
>          else:
> -            f.write("\n_lr_goto = { ");
> +            f.write("\n_lr_goto = { ")
>              for k,v in _lr_goto.items():
>                  f.write("(%r,%r):%r," % (k[0],k[1],v))
> -            f.write("}\n");
> +            f.write("}\n")
>
>          # Write production table
>          f.write("_lr_productions = [\n")
> diff --git a/python/sepolicy/sepolicy/manpage.py
> b/python/sepolicy/sepolicy/manpage.py
> index cb211ba083ca..cfcb7c3932d7 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -539,7 +539,7 @@ class ManPage:
>                      self.fd = fd
>                      self.man_page_path = man_page_path
>              except KeyError:
> -                continue;
> +                continue
>              self.attributes[domain_type] = next(sepolicy.info(sepolicy.TYPE,
> ("%s") % domain_type))["attributes"]
>
>          self._header()
> diff --git a/scripts/run-flake8 b/scripts/run-flake8
> index 8a1f490b8a62..207edd20dd89 100755
> --- a/scripts/run-flake8
> +++ b/scripts/run-flake8
> @@ -14,7 +14,6 @@ IGNORE_LIST=''
>  IGNORE_LIST="$IGNORE_LIST,W191" # indentation contains tabs
>
>  IGNORE_LIST="$IGNORE_LIST,E101" # indentation contains mixed spaces and
> tabs
> -IGNORE_LIST="$IGNORE_LIST,E703" # statement ends with a semicolon
>  IGNORE_LIST="$IGNORE_LIST,E711" # comparison to None should be 'if cond
> is not None:'
>  IGNORE_LIST="$IGNORE_LIST,E712" # comparison to False should be 'if cond
> is False:' or 'if not cond:'
>  IGNORE_LIST="$IGNORE_LIST,E722" # do not use bare 'except'
> --
> 2.18.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--000000000000ebb2ae0573e4e9fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ack on these as well</div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Sun, Aug 19, 2018 at 11:49 AM, Nicolas Iooss <=
span dir=3D"ltr">&lt;<a href=3D"mailto:nicolas.iooss@m4x.org" target=3D"_bl=
ank">nicolas.iooss@m4x.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Python does not need to end a statement with a semicolon. Doing thi=
s<br>
gets reported by linters such as flake8 (&quot;E703 statement ends with a<b=
r>
semicolon&quot;).<br>
<br>
Remove such semicolons in the code and enable this warning in<br>
scripts/run-flake8.<br>
<br>
Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org">n=
icolas.iooss@m4x.org</a>&gt;<br>
---<br>
=C2=A0python/sepolgen/src/sepolgen/<wbr>audit.py | 2 +-<br>
=C2=A0python/sepolgen/src/sepolgen/<wbr>yacc.py=C2=A0 | 8 ++++----<br>
=C2=A0python/sepolicy/sepolicy/<wbr>manpage.py=C2=A0 =C2=A0| 2 +-<br>
=C2=A0scripts/run-flake8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A04 files changed, 6 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/python/sepolgen/src/<wbr>sepolgen/audit.py b/python/sepolgen/s=
rc/<wbr>sepolgen/audit.py<br>
index daed58ce9643..4adb851f3e93 100644<br>
--- a/python/sepolgen/src/<wbr>sepolgen/audit.py<br>
+++ b/python/sepolgen/src/<wbr>sepolgen/audit.py<br>
@@ -258,7 +258,7 @@ class AVCMessage(AuditMessage):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (scontext, tcontext, self.tclass, acce=
ss_tuple) in avcdict.keys():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.type, self.data =3D av=
cdict[(scontext, tcontext, self.tclass, access_tuple)]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.type, self.data =3D audit2w=
hy.analyze(scontext, tcontext, self.tclass, self.accesses);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.type, self.data =3D audit2w=
hy.analyze(scontext, tcontext, self.tclass, self.accesses)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.type =3D=3D audit2w=
hy.NOPOLICY:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.type =3D=
 audit2why.TERULE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.type =3D=3D audit2w=
hy.BADTCON:<br>
diff --git a/python/sepolgen/src/<wbr>sepolgen/yacc.py b/python/sepolgen/sr=
c/<wbr>sepolgen/yacc.py<br>
index f00635469af1..afef174849f2 100644<br>
--- a/python/sepolgen/src/<wbr>sepolgen/yacc.py<br>
+++ b/python/sepolgen/src/<wbr>sepolgen/yacc.py<br>
@@ -1864,10 +1864,10 @@ del _lr_action_items<br>
=C2=A0&quot;&quot;&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;\n_lr_action =3D {=
 &quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;\n_lr_action =3D {=
 &quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k,v in _lr_action.items=
():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(&quot=
;(%r,%r):%r,&quot; % (k[0],k[1],v))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;}\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;}\n&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if smaller:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Factor out names to try a=
nd make smaller<br>
@@ -1901,10 +1901,10 @@ for _k, _v in _lr_goto_items.items():<br>
=C2=A0del _lr_goto_items<br>
=C2=A0&quot;&quot;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;\n_lr_goto =3D { &=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;\n_lr_goto =3D { &=
quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k,v in _lr_goto.items()=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(&quot=
;(%r,%r):%r,&quot; % (k[0],k[1],v))=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;}\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;}\n&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Write production table<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(&quot;_lr_productions =3D [\n&quo=
t;)<br>
diff --git a/python/sepolicy/sepolicy/<wbr>manpage.py b/python/sepolicy/sep=
olicy/<wbr>manpage.py<br>
index cb211ba083ca..cfcb7c3932d7 100755<br>
--- a/python/sepolicy/sepolicy/<wbr>manpage.py<br>
+++ b/python/sepolicy/sepolicy/<wbr>manpage.py<br>
@@ -539,7 +539,7 @@ class ManPage:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.fd =3D fd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.man_page_path =3D man_page_path<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except KeyError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.attributes[domain_type=
] =3D next(<a href=3D"http://sepolicy.info" rel=3D"noreferrer" target=3D"_b=
lank">sepolicy.info</a>(sepolicy.<wbr>TYPE, (&quot;%s&quot;) % domain_type)=
)[&quot;attributes&quot;]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._header()<br>
diff --git a/scripts/run-flake8 b/scripts/run-flake8<br>
index 8a1f490b8a62..207edd20dd89 100755<br>
--- a/scripts/run-flake8<br>
+++ b/scripts/run-flake8<br>
@@ -14,7 +14,6 @@ IGNORE_LIST=3D&#39;&#39;<br>
=C2=A0IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>W191&quot; # indentation contai=
ns tabs<br>
<br>
=C2=A0IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>E101&quot; # indentation contai=
ns mixed spaces and tabs<br>
-IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>E703&quot; # statement ends with a s=
emicolon<br>
=C2=A0IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>E711&quot; # comparison to None=
 should be &#39;if cond is not None:&#39;<br>
=C2=A0IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>E712&quot; # comparison to Fals=
e should be &#39;if cond is False:&#39; or &#39;if not cond:&#39;<br>
=C2=A0IGNORE_LIST=3D&quot;$IGNORE_LIST,<wbr>E722&quot; # do not use bare &#=
39;except&#39;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.18.0<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br></div>

--000000000000ebb2ae0573e4e9fb--
