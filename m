Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8G90dUr005420
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 05:00:40 -0400
Received: by wicgb1 with SMTP id gb1so63693058wic.1
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 02:00:21 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Wed, 16 Sep 2015 14:30:01 +0530
Message-ID: <CA+=dQ-_64TQHHx5GWqByLSh=X=pWiLr4FXzEWH6w6C70c4DOxA@mail.gmail.com>
Subject: remove unconfined user
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c1b96a3de9d0051fd987b7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1b96a3de9d0051fd987b7
Content-Type: text/plain; charset=UTF-8

Hi,

I am running a minimum policy  with unconfined policy

id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

This leads to my http process running to unconfined type

ps -efZ | grep http
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 2357 1  0 08:38
? 00:00:00 /usr/sbin/httpd -k start
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2358 2357  0
08:38 ? 00:00:00 /usr/sbin/httpd -k start
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2359 2357  0
08:38 ? 00:00:00 /usr/sbin/httpd -k start
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2360 2357  0
08:38 ? 00:00:00 /usr/sbin/httpd -k start
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2361 2357  0
08:38 ? 00:00:00 /usr/sbin/httpd -k start
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 2458 2138  0
08:43 pts/0 00:00:00 grep http

I want my http process to run in confined user type so that apache.pp can
be functional . I think it should run in httpd_exec_t type ? Am I correct.

I want to add some rules in apache policy.

Thanks,
Divya

--001a11c1b96a3de9d0051fd987b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I am running a minimum policy=
=C2=A0 with unconfined policy <br><br>id -Z<br>unconfined_u:unconfined_r:un=
confined_t:s0-s0:c0.c1023<br><br></div><div>This leads to my http process r=
unning to unconfined type<br><br>ps -efZ | grep http<br>unconfined_u:unconf=
ined_r:unconfined_t:s0-s0:c0.c1023 root 2357 1=C2=A0 0 08:38 ? 00:00:00 /us=
r/sbin/httpd -k start<br>unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023 daemon 2358 2357=C2=A0 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start<br>u=
nconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 daemon 2359 2357=C2=A0=
 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start<br>unconfined_u:unconfined_r:u=
nconfined_t:s0-s0:c0.c1023 daemon 2360 2357=C2=A0 0 08:38 ? 00:00:00 /usr/s=
bin/httpd -k start<br>unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023=
 daemon 2361 2357=C2=A0 0 08:38 ? 00:00:00 /usr/sbin/httpd -k start<br>unco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 root 2458 2138=C2=A0 0 08=
:43 pts/0 00:00:00 grep http<br><br></div><div>I want my http process to ru=
n in confined user type so that apache.pp can be functional . I think it sh=
ould run in httpd_exec_t type ? Am I correct.<br><br></div><div>I want to a=
dd some rules in apache policy.<br><br></div><div>Thanks,<br></div><div>Div=
ya<br></div><div><br><br><br></div></div>

--001a11c1b96a3de9d0051fd987b7--
