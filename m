Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAENIuu5004204
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 18:18:56 -0500
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BE1E35646C5
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 00:18:45 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id a197so129487119wmd.0
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:18:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdodmRSq8FmFrYi+YyJWaw8s0KMU-nUTJ40F7ZtaP8Jh8Q@mail.gmail.com>
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
 <CAFftDdrFwOHGGSwzCK1UZAJZF8-h2dw9aLmLBQtR8EQ=6fcsqA@mail.gmail.com>
 <CAJfZ7=nE0i60LuYs7+zU=-54LA8jLb=N8GUK5hNQVEX_65yqXw@mail.gmail.com>
 <CAFftDdodmRSq8FmFrYi+YyJWaw8s0KMU-nUTJ40F7ZtaP8Jh8Q@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 15 Nov 2016 00:18:44 +0100
Message-ID: <CAJfZ7=n11UToHMMpeJ0RaCaGOZVVFT6p5WUcCjEymBoD+jG-9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux,
 libsemanage: fall back to gcc in exception.sh
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113fa572b6ef3605414b0f2c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113fa572b6ef3605414b0f2c
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 15, 2016 at 12:06 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Mon, Nov 14, 2016 at 3:00 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
> wrote:
> > The SWIG wrapper already includes the header files using #include (look
> at
> > the beginning of libselinux/src/selinuxswig_python.i [1] for example).
> The
> > script exception.h reads the header files (through gcc -aux-info) to
> > generate some SWIG code for almost every interface returning an integer
> > (this code converts a negative return value to the raising of a Python
> > OSError exception).
> >
> > In SWIG documentation [2] I have not found a way to automatically apply a
> > %exception block to all functions matched by the pattern "it returns an
> > integer". As you seem to believe I missed something,
>
> I don't think you did.
>
> could you please
> > explain how you would proceed here?
>
> Yeah that script is just generating a bunch of interface code, I would
> just remove that script
> and write it by hand. The only downfall is that you would have to add
> a stub if you add something
> to the header file, but I don't consider that a downside, I prefer to
> be explicit. Especially
> considering they already had to put a function in the script to skip.
> I don't think the script provides
> much value.


This kind of question is about the way maintainers want to manage the
maintenance and development of the code. I understand the need to keep
things simple, but how replacing the script with a "static file"
(selinuxswig_python_exception.i, or its integration into
selinuxswig_python.i) would keep working on the project simple or make it
more complex is something I do not know.
An alternative approach would be something like projects using autotools
do: keep the script in the git tree but package releases with
selinuxswig_python_exception.i (and semanage...exception.i) so that end
users do not have to build it.

Nicolas

--001a113fa572b6ef3605414b0f2c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Nov 15, 2016 at 12:06 AM, William Roberts <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><span class=3D"gmail-">On Mon, Nov 14, 2016 at 3:00 PM, Nicolas Iooss =
&lt;<a href=3D"mailto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; =
wrote:<br>
&gt; The SWIG wrapper already includes the header files using #include (loo=
k at<br>
&gt; the beginning of libselinux/src/selinuxswig_<wbr>python.i [1] for exam=
ple). The<br>
&gt; script exception.h reads the header files (through gcc -aux-info) to<b=
r>
&gt; generate some SWIG code for almost every interface returning an intege=
r<br>
&gt; (this code converts a negative return value to the raising of a Python=
<br>
&gt; OSError exception).<br>
&gt;<br>
&gt; In SWIG documentation [2] I have not found a way to automatically appl=
y a<br>
&gt; %exception block to all functions matched by the pattern &quot;it retu=
rns an<br>
&gt; integer&quot;. As you seem to believe I missed something,<br>
<br>
</span>I don&#39;t think you did.<br>
<span class=3D"gmail-"><br>
could you please<br>
&gt; explain how you would proceed here?<br>
<br>
</span>Yeah that script is just generating a bunch of interface code, I wou=
ld<br>
just remove that script<br>
and write it by hand. The only downfall is that you would have to add<br>
a stub if you add something<br>
to the header file, but I don&#39;t consider that a downside, I prefer to<b=
r>
be explicit. Especially<br>
considering they already had to put a function in the script to skip.<br>
I don&#39;t think the script provides<br>
much value.</blockquote><div><br></div><div>This kind of question is about =
the way maintainers want to manage the maintenance and development of the c=
ode. I understand the need to keep things simple, but how replacing the scr=
ipt with a &quot;static file&quot; (selinuxswig_python_exception.i, or its =
integration into selinuxswig_python.i) would keep working on the project si=
mple or make it more complex is something I do not know.</div><div>An alter=
native approach would be something like projects using autotools do: keep t=
he script in the git tree but package releases with selinuxswig_python_exce=
ption.i (and semanage...exception.i) so that end users do not have to build=
 it.</div><div><br></div><div>Nicolas</div></div><br></div></div>

--001a113fa572b6ef3605414b0f2c--
