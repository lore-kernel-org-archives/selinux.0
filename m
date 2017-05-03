Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43Drvhg000989
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 09:53:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id r189so15106562qkf.1
 for <selinux@tycho.nsa.gov>; Wed, 03 May 2017 06:53:56 -0700 (PDT)
MIME-Version: 1.0
From: Naina Emmanuel <nemmanuel1992@gmail.com>
Date: Wed, 3 May 2017 18:53:55 +0500
Message-ID: <CAN=9EoTPRbc33=ACdKXc4yBtNMG+GOqsRwjqEzNAL30tcEGjiA@mail.gmail.com>
Subject: MLS on centos 7
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
 Vit Mojzis <vmojzis@redhat.com>
Cc: masoom alam <masoom.alam@gmail.com>,
 Umair Sarfraz <aquadestructor@gmail.com>
Content-Type: multipart/alternative; boundary=94eb2c071d04c0d93c054e9efc8e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c071d04c0d93c054e9efc8e
Content-Type: text/plain; charset=UTF-8

Good evening sir,

   - I am working on CENTOS7 and has enabled mls on it, I want to make it
   in enforcing mood but I am getting 'SELinux is preventing ' logs in
   /var/log/directory at initial they were 262 and when I try to solve them
   denial logs are getting much as system is in running form.
   - If I go to enforcing mood without resolving these logs (as they are
   much) then my machine gets stuck and could not reboot it crashes.

Please help in this regard, how to resolve these issues moving towards mls
in enforcing mood.
Thanks in advance.


*[root@localhost ~]# sestabash: sesta: command not found...[root@localhost
~]# sestatus SELinux status:                 enabledSELinuxfs mount:
         /sys/fs/selinuxSELinux root directory:         /etc/selinuxLoaded
policy name:             mlsCurrent mode:                   permissiveMode
from config file:          permissivePolicy MLS status:
 enabledPolicy deny_unknown status:     deniedMax kernel policy version:
   28*
*[root@localhost ~]# cat /var/log/messages | grep 'SELinux is preventing' |
wc -l*
*1285*




*Engr. Naina Emmanuel*
*Cryptography Certified*
*Linux Essential Certified (LEPDC)*
*Cisco Certified Network Associate (CCNA)*

*Computer Engineering Department, UET Taxila*


*Information Security, CS Department, CIIT Islamabad*

--94eb2c071d04c0d93c054e9efc8e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"=
ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Good evening s=
ir,</div><div><ul><li>I am working on CENTOS7 and has enabled mls=C2=A0on i=
t, I want to make it in enforcing mood but I am getting &#39;SELinux is pre=
venting &#39; logs in /var/log/directory at initial they were 262 and when =
I try to solve them denial logs are getting much as system is in running fo=
rm.<br></li><li>If I go to enforcing mood without resolving these logs (as =
they are much) then my machine gets stuck and could not reboot it crashes.<=
/li></ul>Please help in this regard, how to resolve these issues moving tow=
ards mls in enforcing mood.</div><div>Thanks in advance.</div><div><br></di=
v><div><font><div><b><div>[root@localhost ~]# sesta</div><div>bash: sesta: =
command not found...</div><div>[root@localhost ~]# sestatus=C2=A0</div><div=
>SELinux status: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 en=
abled</div><div>SELinuxfs mount: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/sys/fs/selinux</div><div>SELinux root directory: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /etc/selinux</div><div>Loaded policy name: =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mls</div><div>Current mode: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 permissive</div><div>Mode fro=
m config file: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0permissive</div><div>Polic=
y MLS status: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enabled</div>=
<div>Policy deny_unknown status: =C2=A0 =C2=A0 denied</div><div>Max kernel =
policy version: =C2=A0 =C2=A0 =C2=A028</div><div><br></div></b></div><div><=
b>[root@localhost ~]# cat /var/log/messages | grep &#39;SELinux is preventi=
ng&#39; | wc -l</b></div><div><b>1285</b></div><div style=3D"font-weight:bo=
ld;font-size:large"><br></div></font></div><div style=3D"font-size:large;fo=
nt-weight:bold"><font size=3D"4"><b><br></b></font></div><div style=3D"font=
-size:large;font-weight:bold"><font size=3D"4"><b><br></b></font></div><div=
 style=3D"font-size:large;font-weight:bold"><font size=3D"4"><b><br></b></f=
ont></div><font color=3D"#666666" style=3D"font-size:large;font-weight:bold=
"><i>Engr. Naina Emmanuel</i></font></div><div dir=3D"ltr"><div><b style=3D=
"color:rgb(102,102,102);font-size:small">Cryptography Certified</b></div><d=
iv><b style=3D"color:rgb(102,102,102);font-size:small">Linux Essential Cert=
ified (LEPDC)</b><font color=3D"#666666" size=3D"2"><b><br></b></font></div=
><div><font color=3D"#666666" size=3D"2"><b>Cisco Certified Network Associa=
te (CCNA)</b></font></div><div><b style=3D"color:rgb(102,102,102);font-size=
:small">Computer Engineering Department, UET Taxila<br></b></div><div><b st=
yle=3D"color:rgb(102,102,102);font-size:small">Information Security, CS Dep=
artment, CIIT Islamabad<br><br></b></div></div></div></div></div></div></di=
v></div></div></div></div></div>
</div>

--94eb2c071d04c0d93c054e9efc8e--
