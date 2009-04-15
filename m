Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3F6wAbJ023867
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 02:58:10 -0400
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3F6w987019347
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 06:58:09 GMT
Received: by qw-out-1920.google.com with SMTP id 5so2889111qwf.30
        for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 23:58:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 Apr 2009 11:51:34 +0500
Message-ID: <7b740b700904142351i6eb6078bq862a181b168694b5@mail.gmail.com>
Subject: Policy building and loading problems
From: Shaz <shazalive@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: Security Engineering Archive <groupsecurityengineering@gmail.com>
Content-Type: multipart/alternative; boundary=0016364eef70d306ac046792601b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364eef70d306ac046792601b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi everyone,

I have some problem with loading policy. The device is in enabled and
permissive mode.

----------------

root@some-device:/etc/selinux/targeted# make load
make: Warning: File `/usr/bin/checkpolicy' has modification time 1.6e+07 s
in the future
Compiling policy ...
/usr/bin/checkpolicy  -o /etc/selinux/targeted/policy/policy.23 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 23) to
/etc/selinux/targeted/policy/policy.23
/usr/bin/checkpolicy  -c 19 -o /etc/selinux/targeted/policy/policy.19
policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 19) to
/etc/selinux/targeted/policy/policy.19
Loading Policy ...
/usr/bin/load_policy /etc/selinux/targeted/policy/policy.19
BusyBox v1.10.1 (2009-04-07 15:36:44 PKT) multi-call binary

Usage: load_policy



make: *** [tmp/load] Error 1

---------------------------------

I also had a clock skew warning at every build step of policy building. Does
it matter? How to solve it easily? Where did policy 23 come from?

Thanx.
-- 
Shaz

--0016364eef70d306ac046792601b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everyone,<br><br>I have some problem with loading policy. The device is =
in enabled and permissive mode.<br><br>----------------<br><br><span dir=3D=
"ltr" id=3D":25f">root@some-device:/etc/selinux/targeted# make load<br>make=
: Warning: File `/usr/bin/checkpolicy&#39; has modification time 1.6e+07 s =
in the future<br>
Compiling policy ...<br>/usr/bin/checkpolicy =A0-o /etc/selinux/targeted/po=
licy/policy.23 policy.conf<br>/usr/bin/checkpolicy: =A0loading policy confi=
guration from policy.conf<br>/usr/bin/checkpolicy: =A0policy configuration =
loaded<br>
/usr/bin/checkpolicy: =A0writing binary representation (version 23) to /etc=
/selinux/targeted/policy/policy.23<br>/usr/bin/checkpolicy =A0-c 19 -o /etc=
/selinux/targeted/policy/policy.19 policy.conf<br>/usr/bin/checkpolicy: =A0=
loading policy configuration from policy.conf<br>
/usr/bin/checkpolicy: =A0policy configuration loaded<br>/usr/bin/checkpolic=
y: =A0writing binary representation (version 19) to /etc/selinux/targeted/p=
olicy/policy.19<br>Loading Policy ...<br>/usr/bin/load_policy /etc/selinux/=
targeted/policy/policy.19<br>
BusyBox v1.10.1 (2009-04-07 15:36:44 PKT) multi-call binary<br><br>Usage: l=
oad_policy <br><br><br><br>make: <b>*</b> [tmp/load] Error 1</span><br><br>=
---------------------------------<br><span dir=3D"ltr" id=3D":2cl"></span><=
br>
I also had a clock skew warning at every build step of policy building. Doe=
s it matter? How to solve it easily? Where did policy 23 come from?<br><br =
clear=3D"all">Thanx.<br>-- <br>Shaz<br><br>

--0016364eef70d306ac046792601b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
