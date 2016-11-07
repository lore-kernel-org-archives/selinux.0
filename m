MIME-Version: 1.0
In-Reply-To: <61dd695f-31bd-069b-9865-bf45ea377de9@tycho.nsa.gov>
References: <20161105212403.30462-1-nicolas.iooss@m4x.org>
 <61dd695f-31bd-069b-9865-bf45ea377de9@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 7 Nov 2016 13:19:57 -0800
Message-ID: <CAFftDdrN_vC0EgqT+co82486atTNBLzFOMGBPnZqBEmQ8bDNiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: remove *swig_python_exception.i if its creation failed
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: multipart/alternative; boundary=94eb2c07d4f2ff5e1f0540bc95fb
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c07d4f2ff5e1f0540bc95fb
Content-Type: text/plain; charset=UTF-8

On Nov 7, 2016 13:03, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 11/05/2016 05:24 PM, Nicolas Iooss wrote:
> > When compiling libselinux with CC=clang, "make pywrap" reports the
> > following message:
> >
> >     bash exception.sh > selinuxswig_python_exception.i
> >     clang-3.9: error: no such file or directory: 'temp.aux'
> >     awk: fatal: cannot open file `temp.aux' for reading (No such file or
> >     directory)
> >
> > This does not make the build fail as exception.sh returns an "OK"
> > status. Use "bash -e" with this script to make it return an error value.
> >
> > In order not to keep an empty selinuxswig_python_exception.i file after
> > a build fails (which would make a second run of "make pywrap"
incorrectly
> > succeed), remove the file when exception.sh fails.
> >
> > As libsemanage uses the same code to build
> > semanageswig_python_exception.i, modify its Makefile too.
> >
> > By the way, on Linux clang does not seem to currently support -aux-info
> > so it cannot be used to craft selinuxswig_python_exception.i.
>
> Thanks, applied all three.  Maybe we need to just always set CC to gcc
> in exception.sh?
>

What if you don't have GCC? We should support CC consistently and not set
it under the hood IMHO.

> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libselinux/src/Makefile  | 2 +-
> >  libsemanage/src/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index b92fe1c8f5f9..24946cee8a01 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -140,7 +140,7 @@ $(LIBPC): $(LIBPC).in ../VERSION
> >       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):;
s:@includedir@:$(INCLUDEDIR):' < $< > $@
> >
> >  selinuxswig_python_exception.i: ../include/selinux/selinux.h
> > -     bash exception.sh > $@
> > +     bash -e exception.sh > $@ || (rm -f $@ ; false)
> >
> >  $(AUDIT2WHYLOBJ): audit2why.c
> >       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c
-o $@ $<
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 55e3f469b0ba..cd29a8abf5ab 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -98,7 +98,7 @@ $(LIBPC): $(LIBPC).in ../VERSION
> >       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):;
s:@includedir@:$(INCLUDEDIR):' < $< > $@
> >
> >  semanageswig_python_exception.i: ../include/semanage/semanage.h
> > -     bash exception.sh > $@
> > +     bash -e exception.sh > $@ || (rm -f $@ ; false)
> >
> >  conf-scan.c: conf-scan.l conf-parse.h
> >       $(LEX) $(LFLAGS) -t $< > $@
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--94eb2c07d4f2ff5e1f0540bc95fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 7, 2016 13:03, &quot;Stephen Smalley&quot; &lt;<a hre=
f=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 11/05/2016 05:24 PM, Nicolas Iooss wrote:<br>
&gt; &gt; When compiling libselinux with CC=3Dclang, &quot;make pywrap&quot=
; reports the<br>
&gt; &gt; following message:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0bash exception.sh &gt; selinuxswig_python_exce=
ption.i<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0clang-3.9: error: no such file or directory: &=
#39;temp.aux&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0awk: fatal: cannot open file `temp.aux&#39; fo=
r reading (No such file or<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0directory)<br>
&gt; &gt;<br>
&gt; &gt; This does not make the build fail as exception.sh returns an &quo=
t;OK&quot;<br>
&gt; &gt; status. Use &quot;bash -e&quot; with this script to make it retur=
n an error value.<br>
&gt; &gt;<br>
&gt; &gt; In order not to keep an empty selinuxswig_python_exception.i file=
 after<br>
&gt; &gt; a build fails (which would make a second run of &quot;make pywrap=
&quot; incorrectly<br>
&gt; &gt; succeed), remove the file when exception.sh fails.<br>
&gt; &gt;<br>
&gt; &gt; As libsemanage uses the same code to build<br>
&gt; &gt; semanageswig_python_exception.i, modify its Makefile too.<br>
&gt; &gt;<br>
&gt; &gt; By the way, on Linux clang does not seem to currently support -au=
x-info<br>
&gt; &gt; so it cannot be used to craft selinuxswig_python_exception.i.<br>
&gt;<br>
&gt; Thanks, applied all three.=C2=A0 Maybe we need to just always set CC t=
o gcc<br>
&gt; in exception.sh?<br>
&gt;</p>
<p dir=3D"ltr">What if you don&#39;t have GCC? We should support CC consist=
ently and not set it under the hood IMHO.</p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt; Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@=
m4x.org">nicolas.iooss@m4x.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 libselinux/src/Makefile=C2=A0 | 2 +-<br>
&gt; &gt;=C2=A0 libsemanage/src/Makefile | 2 +-<br>
&gt; &gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile<br=
>
&gt; &gt; index b92fe1c8f5f9..24946cee8a01 100644<br>
&gt; &gt; --- a/libselinux/src/Makefile<br>
&gt; &gt; +++ b/libselinux/src/Makefile<br>
&gt; &gt; @@ -140,7 +140,7 @@ $(LIBPC): $(LIBPC).in ../VERSION<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e &#39;s/@VERSION@/$(VERSION)/; s:=
@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):&=
#39; &lt; $&lt; &gt; $@<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 selinuxswig_python_exception.i: ../include/selinux/selinux.=
h<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0bash exception.sh &gt; $@<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0bash -e exception.sh &gt; $@ || (rm -f $@ ; =
false)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 $(AUDIT2WHYLOBJ): audit2why.c<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(filter-out -Werror, $(CFLAGS)) =
$(PYINC) -fPIC -DSHARED -c -o $@ $&lt;<br>
&gt; &gt; diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile<=
br>
&gt; &gt; index 55e3f469b0ba..cd29a8abf5ab 100644<br>
&gt; &gt; --- a/libsemanage/src/Makefile<br>
&gt; &gt; +++ b/libsemanage/src/Makefile<br>
&gt; &gt; @@ -98,7 +98,7 @@ $(LIBPC): $(LIBPC).in ../VERSION<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e &#39;s/@VERSION@/$(VERSION)/; s:=
@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):&=
#39; &lt; $&lt; &gt; $@<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 semanageswig_python_exception.i: ../include/semanage/semana=
ge.h<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0bash exception.sh &gt; $@<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0bash -e exception.sh &gt; $@ || (rm -f $@ ; =
false)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 conf-scan.c: conf-scan.l conf-parse.h<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LEX) $(LFLAGS) -t $&lt; &gt; $@<br>
&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--94eb2c07d4f2ff5e1f0540bc95fb--
