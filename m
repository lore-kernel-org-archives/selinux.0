Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8GKVWqk029044
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 16:31:32 -0400
Received: by wicgb1 with SMTP id gb1so90577743wic.1
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 13:31:28 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Thu, 17 Sep 2015 02:01:08 +0530
Message-ID: <CA+=dQ-95Sob03WHZzjvJiiYS3RnaqB+1O2iGg7YHW5CpGd0_WA@mail.gmail.com>
Subject: http process running as initrc_t
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bd91acce23ff1051fe32e4f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bd91acce23ff1051fe32e4f
Content-Type: text/plain; charset=UTF-8

Hi,

run_init /usr/sbin/httpd -k start

leads to
system_u:system_r:initrc_t:s0   root      3977     1  0 19:57 ?
00:00:00 /usr/sbin/httpd -k start

It should be httpd_t

sesearch -ACT -t httpd_exec_t has the transition
type_transition initrc_t httpd_exec_t : process httpd_t;

--047d7bd91acce23ff1051fe32e4f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>run_init /usr/sbin/httpd -k start <br><br>=
leads to <br>system_u:system_r:initrc_t:s0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 3977=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0 0 19:57 ?=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:00:00 /usr/sbin/httpd -k start<br><br></d=
iv>It should be httpd_t <br><br>sesearch -ACT -t httpd_exec_t has the trans=
ition<br>type_transition initrc_t httpd_exec_t : process httpd_t;<br><br><b=
r></div>

--047d7bd91acce23ff1051fe32e4f--
