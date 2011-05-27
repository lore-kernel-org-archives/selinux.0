Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4RCoICU016877
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 08:50:18 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4RCoHTE017647
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 12:50:17 GMT
Received: by bwg12 with SMTP id 12so1501133bwg.12
        for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 05:50:17 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 May 2011 18:20:16 +0530
Message-ID: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
Subject: Regarding SELinux User mapping
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0003255585b22ad7bd04a4416153
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0003255585b22ad7bd04a4416153
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I am trying to map Linux user to different SELinux user (user_u, guest_u,
xguest_u), but when I login it shows only as
system_u:system_r:local_login_t for all users.   I used semanage to map.

# semange login -l

Login Name     SELinux User

__default__     user_u
root                root
system_u       system_u


I am using selinux enabled kernel in Meego 1.2 , built user space packages
from http://userspace.selinuxproject.org and using refpolicy-2.20101213.


Regards,
Madhu

--0003255585b22ad7bd04a4416153
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>I am trying to map Linux user to different SELinux user (use=
r_u, guest_u, xguest_u), but when I login it shows only as<br>system_u:syst=
em_r:local_login_t for all users.=A0=A0 I used semanage to map. <br><br># s=
emange login -l<br>
<br>Login Name=A0=A0=A0=A0 SELinux User<br><br>__default__=A0=A0=A0=A0 user=
_u<br>root=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 root<br>system_u=A0=
=A0=A0=A0=A0=A0 system_u <br><br><br>I am using selinux enabled kernel in M=
eego 1.2 , built user space packages <br>
from <a href=3D"http://userspace.selinuxproject.org">http://userspace.selin=
uxproject.org</a> and using refpolicy-2.20101213.<br><br><br>Regards,<br>Ma=
dhu<br><br><br><br>

--0003255585b22ad7bd04a4416153--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
