Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA81k5fi025235
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 20:46:05 -0500
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oA81k3bc020016
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2010 01:46:04 GMT
Received: by bwz7 with SMTP id 7so4925659bwz.12
        for <selinux@tycho.nsa.gov>; Sun, 07 Nov 2010 17:46:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CD3F36E.3040309@tresys.com>
References: <AANLkTiknqsWLqo2M+dpr75rDHG4jE-ei+Rm4mDC61PS3@mail.gmail.com>
	<4CD3F36E.3040309@tresys.com>
Date: Mon, 8 Nov 2010 09:46:01 +0800
Message-ID: <AANLkTi=1szsiAZvxDsXyFaVgZ59LX60pup1hervyJ86C@mail.gmail.com>
Subject: Re: About compile an appplication's policy
From: sure <mengshuo@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636d3466c5a075f049480c9ec
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636d3466c5a075f049480c9ec
Content-Type: text/plain; charset=ISO-8859-1

I use RHEL 5.0 here, there is no devel package. i will try to download one.
Another question : Am i using the conventional way to create a policy
module? i used polgen several times, but sometimes after you do the e.g.
"myapp.sh - -update" untill "no new avcs found" you still need to modify the
scripts .

On Fri, Nov 5, 2010 at 8:07 PM, Christopher J. PeBenito <
cpebenito@tresys.com> wrote:

> On 11/04/10 22:19, sure wrote:
> > Hi :
> >       I am trying to create my own policy module, but i met with a
> > problem: after i finished the myapp.te, myapp.if and myapp.fc in my
> > directory named mypolicy, I copied the uncompress
> > refpolicy-20070928.tar.bz2 dir ../refpolicy/doc/Makefile.example to
> > ../mypolicy and renamed Makefile, then i tried to "make" , it gave such
> > wrong info:
> >
> > Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file
> > or directory
> > make: *** No rule to make target
> > `/usr/share/selinux/devel/mls/include/Makefile'.  Stop.
> >
> > then i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp
> > files in, but  no directory named include, should i install some other
> > package or find it in somewhere else.
>
> What version of Red Hat/Fedora are you using?  I believe some of the
> older ones had these files in the selinux-policy-devel package.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
>

--001636d3466c5a075f049480c9ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I use RHEL 5.0 here, there is no devel package.=A0i will try to downlo=
ad one.</div>
<div>Another question : Am i using the conventional way to create a policy =
module? i used polgen several times, but sometimes after you do the e.g. &q=
uot;myapp.sh - -update&quot; untill &quot;no new avcs found&quot;=A0you sti=
ll=A0need to modify the scripts . <br>
<br></div>
<div class=3D"gmail_quote">On Fri, Nov 5, 2010 at 8:07 PM, Christopher J. P=
eBenito <span dir=3D"ltr">&lt;<a href=3D"mailto:cpebenito@tresys.com">cpebe=
nito@tresys.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im">On 11/04/10 22:19, sure wrote:<br>&gt; Hi :<br>&gt; =A0 =
=A0 =A0 I am trying to create my own policy module, but i met with a<br>&gt=
; problem: after i finished the myapp.te, myapp.if and myapp.fc in my<br>&g=
t; directory named mypolicy, I copied the uncompress<br>
&gt; refpolicy-20070928.tar.bz2 dir ../refpolicy/doc/Makefile.example to<br=
>&gt; ../mypolicy and renamed Makefile, then i tried to &quot;make&quot; , =
it gave such<br>&gt; wrong info:<br>&gt;<br>&gt; Makefile:8: /usr/share/sel=
inux/devel/mls/include/Makefile: No such file<br>
&gt; or directory<br>&gt; make: *** No rule to make target<br>&gt; `/usr/sh=
are/selinux/devel/mls/include/Makefile&#39;. =A0Stop.<br>&gt;<br>&gt; then =
i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp<br>&gt;=
 files in, but =A0no directory named include, should i install some other<b=
r>
&gt; package or find it in somewhere else.<br><br></div>What version of Red=
 Hat/Fedora are you using? =A0I believe some of the<br>older ones had these=
 files in the selinux-policy-devel package.<br><font color=3D"#888888"><br>
--<br>Chris PeBenito<br>Tresys Technology, LLC<br><a href=3D"http://www.tre=
sys.com/" target=3D"_blank">www.tresys.com</a> | <a href=3D"http://oss.tres=
ys.com/" target=3D"_blank">oss.tresys.com</a><br></font></blockquote></div>=
<br>

--001636d3466c5a075f049480c9ec--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
