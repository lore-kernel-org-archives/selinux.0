Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41NXqdl000673
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 19:33:52 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey16so26871wid.0
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 16:33:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51819de6.9042320a.547a.3e91@mx.google.com>
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
	<CADjGSjjHJk=M97=qTH+hybhZ8v9dCkt8eYO+LWtrDrS0k6ofsw@mail.gmail.com>
	<51819de6.9042320a.547a.3e91@mx.google.com>
Date: Wed, 1 May 2013 16:33:49 -0700
Message-ID: <CAFftDdr6CmEzzbnbuBkpGVZfa9xbb9vU7LqhTA9KqP1F-SB4pw@mail.gmail.com>
Subject: Re: Current Makefile system is inconvenient/limited
From: William Roberts <bill.c.roberts@gmail.com>
To: Michael Seyfert <michael@codesand.org>
Cc: Joshua Brindle <brindle@quarksecurity.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c222bac8b2bb04dbb08cc0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001a11c222bac8b2bb04dbb08cc0
Content-Type: text/plain; charset=ISO-8859-1

Ive used scons, for my own my projects, but had to roll all the packaging
stuff on my own. Its really limited in that respect, but made the build
dirt simple.


On Wed, May 1, 2013 at 3:57 PM, Michael Seyfert <michael@codesand.org>wrote:

> SCons or CMake maybe. I might try a few changes to make packaging
> for distributions easier. Thing is setools depends on parts of selinux
> and selinux depends on parts of setools, as you were saying.
>
> On Wed, May 01, 2013 at 08:43:30AM -0400, Joshua Brindle wrote:
> > No, we all think it. It's become unwieldy with optional dependencies
> > too. There are also mutual dependencies between parts of the SELinux
> > userspace.
> >
> > Do you have any suggestions on improving it? IMHO autoconf is hell on
> > earth, and it was attempted a couple time. Something like Scons
> > *might* help, but I'm not convinced.
> >
> > On Wed, May 1, 2013 at 8:14 AM, Michael Seyfert <michael@codesand.org>
> wrote:
> > > The current system for building selinux requires a lot of workarounds
> like C_INCLUDE_PATH and is also interdependent on setools. I was looking at
> the debian packages and they require two build throughs of selinux just to
> get things to compile properly. Am I the only one that thinks this is a
> problem?
> > > --
> > > Michael Seyfert
> > >
> > > --
> > > This message was distributed to subscribers of the selinux mailing
> list.
> > > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
Respectfully,

William C Roberts

--001a11c222bac8b2bb04dbb08cc0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ive used scons, for my own my projects, but had to roll al=
l the packaging stuff on my own. Its really limited in that respect, but ma=
de the build dirt simple.</div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">
On Wed, May 1, 2013 at 3:57 PM, Michael Seyfert <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:michael@codesand.org" target=3D"_blank">michael@codesand.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
SCons or CMake maybe. I might try a few changes to make packaging<br>
for distributions easier. Thing is setools depends on parts of selinux<br>
and selinux depends on parts of setools, as you were saying.<br>
<br>
On Wed, May 01, 2013 at 08:43:30AM -0400, Joshua Brindle wrote:<br>
&gt; No, we all think it. It&#39;s become unwieldy with optional dependenci=
es<br>
&gt; too. There are also mutual dependencies between parts of the SELinux<b=
r>
&gt; userspace.<br>
&gt;<br>
&gt; Do you have any suggestions on improving it? IMHO autoconf is hell on<=
br>
&gt; earth, and it was attempted a couple time. Something like Scons<br>
&gt; *might* help, but I&#39;m not convinced.<br>
&gt;<br>
&gt; On Wed, May 1, 2013 at 8:14 AM, Michael Seyfert &lt;<a href=3D"mailto:=
michael@codesand.org">michael@codesand.org</a>&gt; wrote:<br>
&gt; &gt; The current system for building selinux requires a lot of workaro=
unds like C_INCLUDE_PATH and is also interdependent on setools. I was looki=
ng at the debian packages and they require two build throughs of selinux ju=
st to get things to compile properly. Am I the only one that thinks this is=
 a problem?<br>

&gt; &gt; --<br>
&gt; &gt; Michael Seyfert<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; This message was distributed to subscribers of the selinux mailin=
g list.<br>
&gt; &gt; If you no longer wish to subscribe, send mail to <a href=3D"mailt=
o:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
&gt; &gt; the words &quot;unsubscribe selinux&quot; without quotes as the m=
essage.<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfully=
,<br><br>William C Roberts<br><br>
</div>

--001a11c222bac8b2bb04dbb08cc0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
