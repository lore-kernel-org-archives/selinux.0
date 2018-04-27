Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3RENN3q021665
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 10:23:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID07.oob.disa.mil (Postfix) with SMTP id 40Xbkw2rm7z17xpj
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 14:23:20 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID07.oob.disa.mil (Postfix) with ESMTP id 40Xbkv1gGhz17xpq
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 14:23:19 +0000 (UTC)
Received: by mail-qt0-f171.google.com with SMTP id m16-v6so2440696qtg.13
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 07:23:18 -0700 (PDT)
MIME-Version: 1.0
From: Troels Arvin <troels.arvin@gmail.com>
Date: Fri, 27 Apr 2018 16:23:17 +0200
Message-ID: <CAJ9kUZ=afxguhDWvttDf6ws-wH=dNcvTT_5s1XU8b-xD7b9-kw@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="000000000000c71fa8056ad53ef7"
Subject: Loopback TCP connection
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000c71fa8056ad53ef7
Content-Type: text/plain; charset="UTF-8"

Hello,

RHEL/CentOS 7.4 was rather disastrous for Tomcat users, because lots of
things which used to work suddenly broke, due to a new SELinux policy for
Tomcat. RHEL 7.5 has fixed most of it, because a number of commits allowed
Tomcat to connect to database systems and other things:

https://github.com/fedora-selinux/selinux-policy-contrib/commit/cf1ac899006bed35c10c08a76adbbf8ce6e68443
https://github.com/fedora-selinux/selinux-policy-contrib/commit/e67f46aec82a897218c879e5c92e6921407b9074
...

But I still have a Tomcat app which has run into SELinux-denials. The app
needs to send mails, so it tries to connect to port 25. I see a number of
ways this could be handled, but I would prefer the following combination:

 - adjust the policy, so that by default, Tomcat can allow to
   port 25/tcp on the loopback interface

 - and add a boolean which allows Tomcat to connect to any port 25/tcp,
   maybe something along the lines of
   corenet_tcp_loopback_connect_smtp(tomcat_domain)

Before I create a Bugzilla case about this for Fedora/Red Hat, I have some
questions:
 - Is it possible to selectively allow an application to connect to
something on the loopback-interface?
 - Is the above proposal a good one, or am I overlooking something?

-- 
Regards,
Troels Arvin

--000000000000c71fa8056ad53ef7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br><br>RHEL/CentOS 7.4 was rather disastrous f=
or Tomcat users, because lots of things which used to work suddenly broke, =
due to a new SELinux policy for Tomcat. RHEL 7.5 has fixed most of it, beca=
use a number of commits allowed Tomcat to connect to database systems and o=
ther things:<br><br><a href=3D"https://github.com/fedora-selinux/selinux-po=
licy-contrib/commit/cf1ac899006bed35c10c08a76adbbf8ce6e68443">https://githu=
b.com/fedora-selinux/selinux-policy-contrib/commit/cf1ac899006bed35c10c08a7=
6adbbf8ce6e68443</a><br><a href=3D"https://github.com/fedora-selinux/selinu=
x-policy-contrib/commit/e67f46aec82a897218c879e5c92e6921407b9074">https://g=
ithub.com/fedora-selinux/selinux-policy-contrib/commit/e67f46aec82a897218c8=
79e5c92e6921407b9074</a><br>...<br><br>But I still have a Tomcat app which =
has run into SELinux-denials. The app needs to send mails, so it tries to c=
onnect to port 25. I see a number of ways this could be handled, but I woul=
d prefer the following combination:<br><br>=C2=A0- adjust the policy, so th=
at by default, Tomcat can allow to<br>=C2=A0=C2=A0 port 25/tcp on the loopb=
ack interface<br><br>=C2=A0- and add a boolean which allows Tomcat to conne=
ct to any port 25/tcp,<br>=C2=A0=C2=A0 maybe something along the lines of<b=
r>=C2=A0=C2=A0 corenet_tcp_loopback_connect_smtp(tomcat_domain)<br><br>Befo=
re I create a Bugzilla case about this for Fedora/Red Hat, I have some ques=
tions:<br>=C2=A0- Is it possible to selectively allow an application to con=
nect to something on the loopback-interface?<br>=C2=A0- Is the above propos=
al a good one, or am I overlooking something?<br></div><div><br>-- <br>Rega=
rds,<br>Troels Arvin<br></div></div>

--000000000000c71fa8056ad53ef7--
