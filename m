Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BBtxXc024799
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 07:56:00 -0400
Received: by vkgd64 with SMTP id d64so25027727vkg.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 04:55:58 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 11 Sep 2015 17:25:39 +0530
Message-ID: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
Subject: Can I change default policy from targeted to minimum
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1142eda41ea118051f776620
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142eda41ea118051f776620
Content-Type: text/plain; charset=UTF-8

Hi,

I have mls and targeted policy installed on my system. I want to have a
minimum policy with all user unconfined and nothing restricted.

I took a minimum policy from selinux-policy-minium noarch rpm and kept in
/etc/selinux folder and edit SELINUXTYPE=minimum. Is this enough to load a
new policy .

load_policy
SELinux:  Could not open policy file <=
/etc/selinux/minimum/policy/policy.28:  No such file or directory
load_policy:  Can't load policy:  No such file or directory

Getting this error while the policy.28 exists in the path.

Please guide me to have a minimum unrestricted policy.

--001a1142eda41ea118051f776620
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>I have mls and target=
ed policy=20
installed on my system. I want to have a minimum policy with all user=20
unconfined and nothing restricted.<br><br></div>I took a minimum policy=20
from selinux-policy-minium noarch rpm and kept in /etc/selinux folder=20
and edit SELINUXTYPE=3Dminimum. Is this enough to load a new policy .<br><b=
r>load_policy <br>SELinux:=C2=A0 Could not open policy file &lt;=3D /etc/se=
linux/minimum/policy/policy.28:=C2=A0 No such file or directory<br>load_pol=
icy:=C2=A0 Can&#39;t load policy:=C2=A0 No such file or directory<br><br></=
div>Getting this error while the policy.28 exists in the path.<br><br></div=
>Please guide me to have a minimum unrestricted policy.</div>

--001a1142eda41ea118051f776620--
