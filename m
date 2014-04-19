Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3JJrpas016422
 for <selinux@tycho.nsa.gov>; Sat, 19 Apr 2014 15:53:51 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so1498733wgg.21
 for <selinux@tycho.nsa.gov>; Sat, 19 Apr 2014 12:53:52 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 19 Apr 2014 21:53:51 +0200
Message-ID: <CAOFt0CQHwubzwGSTsw5ig-1tTG9QJe16X5HFoxgjwvV6_StoaA@mail.gmail.com>
Subject: Allowing access other then permissive mode.
From: Kernel freak <kernelfreak@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bb03ddc2135c604f76aa0dd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bb03ddc2135c604f76aa0dd
Content-Type: text/plain; charset=UTF-8

Hello friends,
                    I am starting a new thread to achieve the objective. I
want to attach my own piece of code wherever SELinux takes access decision
or Policy decision point. So for example, whenever it queries the database
to check the rule, I want to return "allowed" everytime through code and
not by using Permissive mode. It is very important I don't use permissive
mode.

My point of confusion is which part of code I should look to see where
there is a policy decision point where database is queried. As far as I
understand, a return of '0' means access is allowed. I tried hardcoding
rc=0 in many situations, but there are a lot of denials I am getting.

Kindly let me know. Thank you for your time.

--047d7bb03ddc2135c604f76aa0dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello friends,<br></div>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 I am starting a new thread to achieve the objective. =
I want to attach my own piece of code wherever SELinux takes access decisio=
n or Policy decision point. So for example, whenever it queries the databas=
e to check the rule, I want to return &quot;allowed&quot; everytime through=
 code and not by using Permissive mode. It is very important I don&#39;t us=
e permissive mode. <br>
<br></div>My point of confusion is which part of code I should look to see =
where there is a policy decision point where database is queried. As far as=
 I understand, a return of &#39;0&#39; means access is allowed. I tried har=
dcoding rc=3D0 in many situations, but there are a lot of denials I am gett=
ing. <br>
<br></div>Kindly let me know. Thank you for your time.<br></div>

--047d7bb03ddc2135c604f76aa0dd--
