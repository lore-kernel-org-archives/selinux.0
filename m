Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4P88W8f013495
 for <selinux@tycho.nsa.gov>; Fri, 25 May 2018 04:08:32 -0400
Received: by mail-ua0-f172.google.com with SMTP id g9-v6so2908756uak.7
 for <selinux@tycho.nsa.gov>; Fri, 25 May 2018 01:08:28 -0700 (PDT)
MIME-Version: 1.0
From: bhawna goel <bhawnagoel13@gmail.com>
Date: Fri, 25 May 2018 13:38:27 +0530
Message-ID: <CABCvxxqSZa8kqtjvPy0601REvawdbH60VpwUEAwGQp9dky8meQ@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="000000000000dba631056d03455e"
Subject: Selinux load_policy command on chrooted partition is
 loading policy on active partition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000dba631056d03455e
Content-Type: text/plain; charset="UTF-8"

Hi Team,

We are facing an issue with load_policy command on Centos 7.4.. Need to
understand what it exactly does.

We have Centos 7.4 machine which have two partitions .
Ist partition (partA) have all the policies with unconfined and when we are
installing second partition (partB) we are adding all the policies for
sysadm.
During installation of partB below command is getting executed from partA
chroot partB load_policy -qi.

Just after executing this command partA stops working with unconfined
policies . partA giving denials which was working before executing this
command.

Just to recover my system i executed load_policy -q in partA and it gets
back to normal.

I wanted to understand what exactly load_policy do . Why my partA stopped
working when load_policy is executed in partB .Is this expected behavior or
there is some issue.

Thanks in advance.

Regards,
Bhawna

--000000000000dba631056d03455e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Team,<div><br></div><div>We are facing an issue with lo=
ad_policy command on Centos 7.4.. Need to understand what it exactly does.<=
/div><div><br></div><div>We have Centos 7.4 machine which have two partitio=
ns .</div><div>Ist partition (partA) have all the policies with unconfined =
and when we are installing second partition (partB) we are adding all the p=
olicies for sysadm.=C2=A0</div><div>During installation of partB below comm=
and is getting executed from partA</div><div>chroot partB load_policy -qi.<=
/div><div><br></div><div>Just after executing this command partA stops work=
ing with unconfined policies . partA giving denials which was working befor=
e executing this command.</div><div><br></div><div>Just to recover my syste=
m i executed load_policy -q in partA and it gets back to normal.</div><div>=
<br></div><div>I wanted to understand what exactly load_policy do . Why my =
partA stopped working when load_policy is executed in partB .Is this expect=
ed behavior or there is some issue.</div><div><br></div><div>Thanks in adva=
nce.</div><div><br></div><div>Regards,</div><div>Bhawna</div></div>

--000000000000dba631056d03455e--
