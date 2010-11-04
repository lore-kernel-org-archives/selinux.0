Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA42hbH5004893
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2010 22:43:37 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oA42hZh3026451
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2010 02:43:36 GMT
Received: by bwz7 with SMTP id 7so1417156bwz.12
        for <selinux@tycho.nsa.gov>; Wed, 03 Nov 2010 19:43:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTim=361K5ddpsdRJP-q16ATMN8s_4r84QBhYbZXz@mail.gmail.com>
References: <C8F7383C.BB23F%csellers@tresys.com>
	<AANLkTim=361K5ddpsdRJP-q16ATMN8s_4r84QBhYbZXz@mail.gmail.com>
Date: Thu, 4 Nov 2010 10:43:35 +0800
Message-ID: <AANLkTikMUqjVqzdkNov2_w+qbWopQRLTYQE5zeL3zgUm@mail.gmail.com>
Subject: Re: CIL: the SELinux Common Intermediate Language
From: sure <mengshuo@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636c5b9e8d4fcc40494311fa5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5b9e8d4fcc40494311fa5
Content-Type: text/plain; charset=ISO-8859-1

sorry, the question has nothing to do with CIL.

On Thu, Nov 4, 2010 at 10:35 AM, sure <mengshuo@gmail.com> wrote:

> Hi :
>       I am trying to create my own policy module, but i met with a problem:
> after i finished the myapp.te, myapp.if and myapp.fc in my directory named
> mypolicy, I copied the uncompress refpolicy-20070928.tar.bz2 dir
> ../refpolicy/doc/Makefile.example to ../mypolicy and renamed Makefile, then
> i tried to "make" , it gave such wrong info:
>
> Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file or
> directory
> make: *** No rule to make target
> `/usr/share/selinux/devel/mls/include/Makefile'.  Stop.
>
> then i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp
> files in, but  no directory named include, should i install some other
> package or find it in somewhere else.
>
> here is info of my selinux
> [root@rfsos pol]# sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 21
> Policy from config file:        mls
>
>
> br.
> mengshuo
>

--001636c5b9e8d4fcc40494311fa5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sorry, the question has nothing to do with CIL.<br><br><div class=3D"gmail_=
quote">On Thu, Nov 4, 2010 at 10:35 AM, sure <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mengshuo@gmail.com">mengshuo@gmail.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi :=A0=A0=A0 <br>=A0=A0=A0=A0=A0 I am trying to create my own policy modul=
e, but i met with a problem: after i finished the myapp.te, myapp.if and my=
app.fc in my directory named mypolicy, I copied the uncompress refpolicy-20=
070928.tar.bz2 dir ../refpolicy/doc/Makefile.example to ../mypolicy and ren=
amed Makefile, then i tried to &quot;make&quot; , it gave such wrong info:<=
br>

<br>Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file=
 or directory<br>make: *** No rule to make target `/usr/share/selinux/devel=
/mls/include/Makefile&#39;.=A0 Stop.<br><br>then i check the dir /usr/share=
/selinux/devel/mls/ , there are many *.pp files in, but=A0 no directory nam=
ed include, should i install some other package or find it in somewhere els=
e.<br>

<br>here is info of my selinux<br>[root@rfsos pol]# sestatus <br>SELinux st=
atus:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled<br>SELinuxfs =
mount:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /selinux<br>Current mod=
e:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 permissive<br>Mode=
 from config file:=A0=A0=A0=A0=A0=A0=A0=A0=A0 permissive<br>

Policy version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 21<br>Polic=
y from config file:=A0=A0=A0=A0=A0=A0=A0 mls<br><br><br>br.<br>mengshuo<br>
</blockquote></div><br>

--001636c5b9e8d4fcc40494311fa5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
