Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEN14kd002969
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 18:01:04 -0500
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 00930564986
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 00:00:58 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id g23so128843106wme.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:00:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrFwOHGGSwzCK1UZAJZF8-h2dw9aLmLBQtR8EQ=6fcsqA@mail.gmail.com>
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
 <CAFftDdrFwOHGGSwzCK1UZAJZF8-h2dw9aLmLBQtR8EQ=6fcsqA@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 15 Nov 2016 00:00:57 +0100
Message-ID: <CAJfZ7=nE0i60LuYs7+zU=-54LA8jLb=N8GUK5hNQVEX_65yqXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux,
 libsemanage: fall back to gcc in exception.sh
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f403045ea68e20fc8405414ad04a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045ea68e20fc8405414ad04a
Content-Type: text/plain; charset=UTF-8

The SWIG wrapper already includes the header files using #include (look at
the beginning of libselinux/src/selinuxswig_python.i [1] for example). The
script exception.h reads the header files (through gcc -aux-info) to
generate some SWIG code for almost every interface returning an integer
(this code converts a negative return value to the raising of a
Python OSError exception).

In SWIG documentation [2] I have not found a way to automatically apply a
%exception block to all functions matched by the pattern "it returns an
integer". As you seem to believe I missed something, could you please
explain how you would proceed here?

Nicolas

[1]
https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/selinuxswig_python.i#L11
[2] http://www.swig.org/Doc3.0/SWIGDocumentation.html

On Mon, Nov 14, 2016 at 11:15 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> For a more long term solution, why not just give swig a header file
> (you can ifdef on SWIG for anything to omit), or write the interface
> file by hand. I ended up using a hybrid approach for one my projects
> (the build system is a mess):
>
> https://bitbucket.org/miniat/0x1-miniat/src/f84cb76ab0fbe645ee9c48d30221b2
> 9283745778/vm/src/miniat_python.i?at=master&fileviewer=file-view-default
>
>
> On Mon, Nov 14, 2016 at 1:57 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
> wrote:
> > clang does not support -aux-info option. When exception.sh is run with
> > CC=clang, use gcc to build selinuxswig_python_exception.i and
> > semanageswig_python_exception.i.
> >
> > This does not solve the issue of building libselinux and libsemanage
> > Python wrappers on a system without gcc. However parsing the result of
> > "gcc -aux-info" is easier than parsing the header files so stay with
> > this command at least for now.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libselinux/src/exception.sh  | 6 +++++-
> >  libsemanage/src/exception.sh | 6 +++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> > index a58bf3f45778..a3ff83235ced 100755
> > --- a/libselinux/src/exception.sh
> > +++ b/libselinux/src/exception.sh
> > @@ -15,6 +15,10 @@ echo "
> >  ;;
> >  esac
> >  }
> > -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
> ../include/selinux/selinux.h
> > +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
> ../include/selinux/selinux.h
> > +then
> > +    # clang does not support -aux-info so fall back to gcc
> > +    gcc -x c -c -I../include - -aux-info temp.aux <
> ../include/selinux/selinux.h
> > +fi
> >  for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except
> $i ; done
> >  rm -f -- temp.aux -.o
> > diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
> > index d18959cbe85d..a4095f4f8ba6 100644
> > --- a/libsemanage/src/exception.sh
> > +++ b/libsemanage/src/exception.sh
> > @@ -9,6 +9,10 @@ echo "
> >  }
> >  "
> >  }
> > -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
> ../include/semanage/semanage.h
> > +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
> ../include/semanage/semanage.h
> > +then
> > +    # clang does not support -aux-info so fall back to gcc
> > +    gcc -x c -c -I../include - -aux-info temp.aux <
> ../include/semanage/semanage.h
> > +fi
> >  for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
> >  rm -f -- temp.aux -.o
> > --
> > 2.10.2
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--f403045ea68e20fc8405414ad04a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The SWIG wrapper already includes the header files using #=
include (look at the beginning of=C2=A0libselinux/src/selinuxswig_python.i =
[1] for example). The script exception.h reads the header files (through gc=
c -aux-info) to generate some SWIG code for almost every interface returnin=
g an integer (this code converts a negative return value to the raising of =
a Python=C2=A0OSError exception).<div><br></div><div>In SWIG documentation =
[2] I have not found a way to automatically apply a %exception block to all=
 functions matched by the pattern &quot;it returns an integer&quot;. As you=
 seem to believe I missed something, could you please explain how you would=
 proceed here?</div><div><br></div><div>Nicolas<br><div><br></div><div>[1]=
=C2=A0<a href=3D"https://github.com/SELinuxProject/selinux/blob/master/libs=
elinux/src/selinuxswig_python.i#L11">https://github.com/SELinuxProject/seli=
nux/blob/master/libselinux/src/selinuxswig_python.i#L11</a></div><div>[2]=
=C2=A0<a href=3D"http://www.swig.org/Doc3.0/SWIGDocumentation.html">http://=
www.swig.org/Doc3.0/SWIGDocumentation.html</a><br><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Mon, Nov 14, 2016 at 11:15 PM, William =
Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" t=
arget=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">For a more long term solution, wh=
y not just give swig a header file<br>
(you can ifdef on SWIG for anything to omit), or write the interface<br>
file by hand. I ended up using a hybrid approach for one my projects<br>
(the build system is a mess):<br>
<br>
<a href=3D"https://bitbucket.org/miniat/0x1-miniat/src/f84cb76ab0fbe645ee9c=
48d30221b29283745778/vm/src/miniat_python.i?at=3Dmaster&amp;fileviewer=3Dfi=
le-view-default" rel=3D"noreferrer" target=3D"_blank">https://bitbucket.org=
/miniat/<wbr>0x1-miniat/src/<wbr>f84cb76ab0fbe645ee9c48d30221b2<wbr>9283745=
778/vm/src/miniat_<wbr>python.i?at=3Dmaster&amp;fileviewer=3D<wbr>file-view=
-default</a><br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
On Mon, Nov 14, 2016 at 1:57 PM, Nicolas Iooss &lt;<a href=3D"mailto:nicola=
s.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; wrote:<br>
&gt; clang does not support -aux-info option. When exception.sh is run with=
<br>
&gt; CC=3Dclang, use gcc to build selinuxswig_python_exception.i and<br>
&gt; semanageswig_python_exception.<wbr>i.<br>
&gt;<br>
&gt; This does not solve the issue of building libselinux and libsemanage<b=
r>
&gt; Python wrappers on a system without gcc. However parsing the result of=
<br>
&gt; &quot;gcc -aux-info&quot; is easier than parsing the header files so s=
tay with<br>
&gt; this command at least for now.<br>
&gt;<br>
&gt; Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.o=
rg">nicolas.iooss@m4x.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 libselinux/src/exception.sh=C2=A0 | 6 +++++-<br>
&gt;=C2=A0 libsemanage/src/exception.sh | 6 +++++-<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh=
<br>
&gt; index a58bf3f45778..a3ff83235ced 100755<br>
&gt; --- a/libselinux/src/exception.sh<br>
&gt; +++ b/libselinux/src/exception.sh<br>
&gt; @@ -15,6 +15,10 @@ echo &quot;<br>
&gt;=C2=A0 ;;<br>
&gt;=C2=A0 esac<br>
&gt;=C2=A0 }<br>
&gt; -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux &lt; ../include/=
selinux/selinux.h<br>
&gt; +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux &lt; ../inc=
lude/selinux/selinux.h<br>
&gt; +then<br>
&gt; +=C2=A0 =C2=A0 # clang does not support -aux-info so fall back to gcc<=
br>
&gt; +=C2=A0 =C2=A0 gcc -x c -c -I../include - -aux-info temp.aux &lt; ../i=
nclude/selinux/selinux.h<br>
&gt; +fi<br>
&gt;=C2=A0 for i in `awk &#39;/&lt;stdin&gt;.*extern int/ { print $6 }&#39;=
 temp.aux`; do except $i ; done<br>
&gt;=C2=A0 rm -f -- temp.aux -.o<br>
&gt; diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.=
sh<br>
&gt; index d18959cbe85d..a4095f4f8ba6 100644<br>
&gt; --- a/libsemanage/src/exception.sh<br>
&gt; +++ b/libsemanage/src/exception.sh<br>
&gt; @@ -9,6 +9,10 @@ echo &quot;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 &quot;<br>
&gt;=C2=A0 }<br>
&gt; -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux &lt; ../include/=
semanage/semanage.h<br>
&gt; +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux &lt; ../inc=
lude/semanage/semanage.h<br>
&gt; +then<br>
&gt; +=C2=A0 =C2=A0 # clang does not support -aux-info so fall back to gcc<=
br>
&gt; +=C2=A0 =C2=A0 gcc -x c -c -I../include - -aux-info temp.aux &lt; ../i=
nclude/semanage/semanage.h<br>
&gt; +fi<br>
&gt;=C2=A0 for i in `awk &#39;/extern int/ { print $6 }&#39; temp.aux`; do =
except $i ; done<br>
&gt;=C2=A0 rm -f -- temp.aux -.o<br>
&gt; --<br>
&gt; 2.10.2<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<br>
<br>
<br>
</div></div><span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</font></span></blockquote></div><br></div></div></div></div>

--f403045ea68e20fc8405414ad04a--
