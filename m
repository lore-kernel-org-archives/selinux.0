Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4O5mp06012673
 for <selinux@tycho.nsa.gov>; Thu, 24 May 2018 01:48:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40rz2L0jlYzrKYS
 for <selinux@tycho.nsa.gov>; Thu, 24 May 2018 05:48:26 +0000 (UTC)
Received: from UPBD19PA03.eemsg.mil (unknown [192.168.18.4])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40rz2K5Z1XzrKYR
 for <selinux@tycho.nsa.gov>; Thu, 24 May 2018 05:48:25 +0000 (UTC)
Received: by mail-ot0-f169.google.com with SMTP id i5-v6so521235otf.1
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 22:48:24 -0700 (PDT)
MIME-Version: 1.0
From: shagun maheshwari <shagunmaheshwariitmec@gmail.com>
Date: Thu, 24 May 2018 11:18:23 +0530
Message-ID: <CAMYJFZ9V2stVKHZVuS0OqRTqk-iUXAZRzrys1oULDdV_mGi5wg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="000000000000153027056ced3321"
Subject: Selinux load_policy command on inactive partition is
 loading policy on active partition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000153027056ced3321
Content-Type: text/plain; charset="UTF-8"

Hi,

We have done changes in our Centos7.4 to disable the unconfined user from
our code. We have created an iso in which we have replaced unconfined with
sysadm and we are performing an upgrade using the new iso.
After upgrade current partition stop working. It started expecting policies
for unconfined when we perform reboot things started working fine again.
We are suspecting some issues with this command "load_policy -qi" when this
command is being executed on partB in permissive mode and after we move the
system to enforcing mode. It starts giving denials for unconfined.

Can you explain what exactly load_policy do?
Does it load the policies for all the partitions of the system?


Regards,
Shagun

--000000000000153027056ced3321
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>We have done changes in our Centos7=
.4 to disable the unconfined user from our code.=C2=A0We have created an is=
o in which we have replaced unconfined with sysadm and=C2=A0we are performi=
ng an upgrade using the new iso.=C2=A0</div><div>After upgrade current part=
ition stop working. It started expecting policies for unconfined when we pe=
rform reboot things started working fine again.=C2=A0</div><div>We are susp=
ecting some issues with this command &quot;load_policy -qi&quot; when this =
command is being executed on partB in permissive mode and after we move the=
 system to enforcing mode. It starts giving denials for unconfined.=C2=A0</=
div><div><br></div><div>Can you explain what exactly load_policy do?=C2=A0<=
/div><div>Does=C2=A0it load the policies for all the partitions of the syst=
em?</div><div><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif"><br></p>





Regards,</div><div>Shagun</div></div>

--000000000000153027056ced3321--
