Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3Q6a5Ti028757
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2013 02:36:07 -0400
Received: by mail-qe0-f52.google.com with SMTP id q19so2543258qeb.39
        for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2013 23:36:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADjGSjipXROGK+9_bpJZngjBF7rH-=U3nUpwyUdgA_UERbn=Vg@mail.gmail.com>
References: <CADjGSjhkWnxg6rEzUowJ4pU0icFYbboxeDh2ejZ6gpg83W0QYA@mail.gmail.com>
	<20130425200130.GA17297@siphos.be>
	<CADjGSjipXROGK+9_bpJZngjBF7rH-=U3nUpwyUdgA_UERbn=Vg@mail.gmail.com>
Date: Fri, 26 Apr 2013 08:36:05 +0200
Message-ID: <CAPzO=NyzomgTJoSvf9Ogxae2BDfWk=UFiu6C7qobNcMfDc7kgw@mail.gmail.com>
Subject: Re: [Ann] SELinux userspace release
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Joshua Brindle <brindle@quarksecurity.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf3020761ce2e5cd04db3dbff9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf3020761ce2e5cd04db3dbff9
Content-Type: text/plain; charset=ISO-8859-1

On Apr 26, 2013 1:15 AM, "Joshua Brindle" <brindle@quarksecurity.com> wrote:
>
> On Thu, Apr 25, 2013 at 4:01 PM, Sven Vermeulen
> <sven.vermeulen@siphos.be> wrote:
> > https://bugs.gentoo.org/show_bug.cgi?id=467264
> >
> > - using semanage permissive fails with stacktrace referring to a
Makefile on
> >   a non-existing location (/usr/share/selinux/default/Makefile)
> >
> > I have yet to find the culprit of this (getting late so that'll be for
> > tomorrow evening).
> >
>
> semanage permissive builds a module to make a permissive domain. On
> Fedora there is an out-of-tree policy build environment in
> /usr/share/selinux. Without this environment it can't build a module.
> Does Gentoo have it in a different place or just not at all?

In the previous release it worked so I probably need to find where the
location is coded and have that point to
/usr/share/selinux/$SELINUXTYPE/include/Makefile or so. That is the
Makefile used to build (refpolicy-style) policy modules here.

> >
> > https://bugs.gentoo.org/show_bug.cgi?id=467268
> >
> > - policycoreutils' sepolicy command requires yum python bindings
> >
> > Since yum is not available on Gentoo, is this really necessary?
> >
>
> Unfortunate. I'd exclude it for now and hopefully we can work out
> making it more distro independent.

Certainly. I'll see if I can draft up something when I get more familiar
with the required functionalities.

Wkr,
  Sven Vermeulen

--20cf3020761ce2e5cd04db3dbff9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On Apr 26, 2013 1:15 AM, &quot;Joshua Brindle&quot; &lt;<a h=
ref=3D"mailto:brindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; On Thu, Apr 25, 2013 at 4:01 PM, Sven Vermeulen<br>
&gt; &lt;<a href=3D"mailto:sven.vermeulen@siphos.be">sven.vermeulen@siphos.=
be</a>&gt; wrote:<br>
&gt; &gt; <a href=3D"https://bugs.gentoo.org/show_bug.cgi?id=3D467264">http=
s://bugs.gentoo.org/show_bug.cgi?id=3D467264</a><br>
&gt; &gt;<br>
&gt; &gt; - using semanage permissive fails with stacktrace referring to a =
Makefile on<br>
&gt; &gt; =A0 a non-existing location (/usr/share/selinux/default/Makefile)=
<br>
&gt; &gt;<br>
&gt; &gt; I have yet to find the culprit of this (getting late so that&#39;=
ll be for<br>
&gt; &gt; tomorrow evening).<br>
&gt; &gt;<br>
&gt;<br>
&gt; semanage permissive builds a module to make a permissive domain. On<br=
>
&gt; Fedora there is an out-of-tree policy build environment in<br>
&gt; /usr/share/selinux. Without this environment it can&#39;t build a modu=
le.<br>
&gt; Does Gentoo have it in a different place or just not at all?</p>
<p dir=3D"ltr">In the previous release it worked so I probably need to find=
 where the location is coded and have that point to /usr/share/selinux/$SEL=
INUXTYPE/include/Makefile or so. That is the Makefile used to build (refpol=
icy-style) policy modules here.</p>

<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt; <a href=3D"https://bugs.gentoo.org/show_bug.cgi?id=3D467268">http=
s://bugs.gentoo.org/show_bug.cgi?id=3D467268</a><br>
&gt; &gt;<br>
&gt; &gt; - policycoreutils&#39; sepolicy command requires yum python bindi=
ngs<br>
&gt; &gt;<br>
&gt; &gt; Since yum is not available on Gentoo, is this really necessary?<b=
r>
&gt; &gt;<br>
&gt;<br>
&gt; Unfortunate. I&#39;d exclude it for now and hopefully we can work out<=
br>
&gt; making it more distro independent.</p>
<p dir=3D"ltr">Certainly. I&#39;ll see if I can draft up something when I g=
et more familiar with the required functionalities.</p>
<p dir=3D"ltr">Wkr,<br>
=A0 Sven Vermeulen<br>
</p>

--20cf3020761ce2e5cd04db3dbff9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
