Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v12NTpMx030226
 for <selinux@tycho.nsa.gov>; Thu, 2 Feb 2017 18:29:51 -0500
Received: by mail-vk0-f65.google.com with SMTP id t8so263035vke.0
 for <selinux@tycho.nsa.gov>; Thu, 02 Feb 2017 15:29:38 -0800 (PST)
MIME-Version: 1.0
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Fri, 3 Feb 2017 04:29:37 +0500
Message-ID: <CAFC8oaf=cT+cVMx0R3sp6ux3EXO8ozuHE9moGLtukmm-7akwsw@mail.gmail.com>
Subject: openshift label issue
To: SELinux <selinux@tycho.nsa.gov>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>,
 nayab@wanclouds.net, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=001a114267dce5f0a20547948936
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114267dce5f0a20547948936
Content-Type: text/plain; charset=UTF-8

Hi,
  i'm facing issue while running openshift, openshift have
unconfined_service_t
  my use has context
      "staff_u:staff_r:staff_t "

i have check the domains accessibility of staff_r so it gives me
 "openshift_var_lib_t"

so it means there is not domain transition for staff_r for openshift_t but
as i have check system_r has the accessibility of  openshift_t so its mean
do i run my user in system_u context if yes then it would have
"system_u:unconfined_r:unconfined_t" so it also don't change into openshift
because unconfined_u also don't have domain transition for openshift_t if i
use newrole command to change my context it won't allow me so right now i'm
stuck
kindly help in this
thanks
Regards
Kashif Ali

--001a114267dce5f0a20547948936
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<br>=C2=A0 i&#39;m facing issue while running ope=
nshift, openshift have unconfined_service_t<br>=C2=A0 my use has context=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0 &quot;staff_u:staff_r:staff_t &quot;<div><br><d=
iv>i have check the domains accessibility of staff_r so it gives me <br>=C2=
=A0&quot;openshift_var_lib_t&quot;</div><div><br></div><div>so it means the=
re is not domain transition for staff_r for openshift_t but as i have check=
 system_r has the accessibility of =C2=A0openshift_t so its mean do i run m=
y user in system_u context if yes then it would have=C2=A0</div><div>&quot;=
system_u:unconfined_r:unconfined_t&quot; so it also don&#39;t change into o=
penshift because unconfined_u also don&#39;t have domain transition for ope=
nshift_t if i use newrole command to change my context it won&#39;t allow m=
e so right now i&#39;m stuck=C2=A0<br>kindly help in this=C2=A0<br>thanks=
=C2=A0<br>Regards=C2=A0<br>Kashif Ali=C2=A0</div></div></div>

--001a114267dce5f0a20547948936--
