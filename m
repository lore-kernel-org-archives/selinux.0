MIME-Version: 1.0
In-Reply-To: <1484689682.20454.26.camel@tycho.nsa.gov>
References: <20170114143825.4592-1-nicolas.iooss@m4x.org>
 <1484689682.20454.26.camel@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 17 Jan 2017 23:01:26 +0100
Message-ID: <CAJfZ7=mNS_hEnR9R4GdD1NHjnqxNqiB-seRA6EeGMmccE1rz=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Re-link programs after libsepol.a is updated
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1140138611d0b5054651711e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140138611d0b5054651711e
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 17, 2017 at 10:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Sat, 2017-01-14 at 15:38 +0100, Nicolas Iooss wrote:
> > After libsepol is modified (for example while developing new features
> > or
> > fixing bugs), running "make install" in the top-level directory does
> > not
> > update the programs which use libsepol.a. Add this static library to
> > the
> > target dependencies in order to force their updates. This makes
> > "make"
> > use libsepol.a in the linking command without using LDLIBS.
> >
> > While at it, copy what commit 14d706434846 ("libselinux: Allow
> > overriding libsepol.a location during build") introduced in
> > libselinux
> > Makefile by using a new LIBSEPOLA variable in all Makefiles.
>

> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index d17792c13350..5640a57d2768 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -155,8 +155,8 @@ selinuxswig_python_exception.i:
> > ../include/selinux/selinux.h
> >  $(AUDIT2WHYLOBJ): audit2why.c
> >       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC
> > -DSHARED -c -o $@ $<
> >
> > -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> > -     $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux
> > $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)
> > +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> > +     $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux
> > $(PYLIBS) -L$(LIBDIR)
>
> Why did you change this?


When libsepol.a is updated, $(AUDIT2WHYSO) (which is a Python extension,
named something like python3audit2why.so and installed as module
"selinux.audit2why") was not rebuilt. Adding $(LIBSEPOLA) to the
dependencies (in order to fix this) makes libsepol.a appear in the command
line through $^ so I removed $(LIBSEPOLA) from the "$(CC)..." line.

Thanks for your review,
Nicolas

--001a1140138611d0b5054651711e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jan 17, 2017 at 10:48 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div clas=
s=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Sat, 2017-01-14 at 15:38 +010=
0, Nicolas Iooss wrote:<br>
&gt; After libsepol is modified (for example while developing new features<=
br>
&gt; or<br>
&gt; fixing bugs), running &quot;make install&quot; in the top-level direct=
ory does<br>
&gt; not<br>
&gt; update the programs which use libsepol.a. Add this static library to<b=
r>
&gt; the<br>
&gt; target dependencies in order to force their updates. This makes<br>
&gt; &quot;make&quot;<br>
&gt; use libsepol.a in the linking command without using LDLIBS.<br>
&gt;<br>
&gt; While at it, copy what commit 14d706434846 (&quot;libselinux: Allow<br=
>
&gt; overriding libsepol.a location during build&quot;) introduced in<br>
&gt; libselinux<br>
&gt; Makefile by using a new LIBSEPOLA variable in all Makefiles.<br></div>=
</div></blockquote><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">
&gt; diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile<br>
&gt; index d17792c13350..5640a57d2768 100644<br>
&gt; --- a/libselinux/src/Makefile<br>
&gt; +++ b/libselinux/src/Makefile<br>
&gt; @@ -155,8 +155,8 @@ selinuxswig_python_exception.<wbr>i:<br>
&gt; ../include/selinux/selinux.h<br>
&gt; =C2=A0$(AUDIT2WHYLOBJ): audit2why.c<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYI=
NC) -fPIC<br>
&gt; -DSHARED -c -o $@ $&lt;<br>
&gt; =C2=A0<br>
&gt; -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -=
lselinux<br>
&gt; $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)<br>
&gt; +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -=
lselinux<br>
&gt; $(PYLIBS) -L$(LIBDIR)<br>
<br>
</div></div>Why did you change this?</blockquote><div><br></div><div>When l=
ibsepol.a is updated, $(AUDIT2WHYSO) (which is a Python extension, named so=
mething like python3audit2why.so and installed as module &quot;selinux.audi=
t2why&quot;) was not rebuilt. Adding=C2=A0$(LIBSEPOLA) to the dependencies =
(in order to fix this) makes libsepol.a appear in the command line through =
$^ so I removed $(LIBSEPOLA) from the &quot;$(CC)...&quot; line.</div><div>=
<br></div><div>Thanks for your review,</div><div>Nicolas</div></div></div><=
/div>

--001a1140138611d0b5054651711e--
