Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA52JN2i007421
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2010 22:19:23 -0400
Received: from mail-fx0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oA52JM3b023453
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2010 02:19:23 GMT
Received: by fxm6 with SMTP id 6so2076865fxm.12
        for <selinux@tycho.nsa.gov>; Thu, 04 Nov 2010 19:19:22 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 5 Nov 2010 10:19:22 +0800
Message-ID: <AANLkTiknqsWLqo2M+dpr75rDHG4jE-ei+Rm4mDC61PS3@mail.gmail.com>
Subject: About compile an appplication's policy
From: sure <mengshuo@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636c5b35b10162d049444e793
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5b35b10162d049444e793
Content-Type: text/plain; charset=ISO-8859-1

Hi :
      I am trying to create my own policy module, but i met with a problem:
after i finished the myapp.te, myapp.if and myapp.fc in my directory named
mypolicy, I copied the uncompress refpolicy-20070928.tar.bz2 dir
../refpolicy/doc/Makefile.example to ../mypolicy and renamed Makefile, then
i tried to "make" , it gave such wrong info:

Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file or
directory
make: *** No rule to make target
`/usr/share/selinux/devel/mls/include/Makefile'.  Stop.

then i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp
files in, but  no directory named include, should i install some other
package or find it in somewhere else.

here is info of my selinux
[root@rfsos pol]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 21
Policy from config file:        mls


br.
mengshuo

--001636c5b35b10162d049444e793
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi :=A0=A0=A0=A0<br>=A0=A0=A0=A0=A0 I am trying to create my own policy =
module, but i met with a problem: after i finished the myapp.te, myapp.if a=
nd myapp.fc in my directory named mypolicy, I copied the uncompress refpoli=
cy-20070928.tar.bz2 dir ../refpolicy/doc/Makefile.example to ../mypolicy an=
d renamed Makefile, then i tried to &quot;make&quot; , it gave such wrong i=
nfo:</p>

<p>Makefile:8: /usr/share/selinux/devel/mls/include/Makefile: No such file =
or directory<br>make: *** No rule to make target `/usr/share/selinux/devel/=
mls/include/Makefile&#39;.=A0 Stop.</p>
<p>then i check the dir /usr/share/selinux/devel/mls/ , there are many *.pp=
 files in, but=A0 no directory named include, should i install some other p=
ackage or find it in somewhere else.</p>
<p>here is info of my selinux<br>[root@rfsos pol]# sestatus <br>SELinux sta=
tus:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled<br>SELinuxfs m=
ount:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /selinux<br>Current mode=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 permissive<br>Mode =
from config file:=A0=A0=A0=A0=A0=A0=A0=A0=A0 permissive<br>
Policy version:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 21<br>Polic=
y from config file:=A0=A0=A0=A0=A0=A0=A0 mls</p>
<p><br>br.<br>mengshuo</p>

--001636c5b35b10162d049444e793--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
