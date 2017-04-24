Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OLUmIW009570
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 17:30:48 -0400
Received: by mail-vk0-f49.google.com with SMTP id j127so45882602vkh.0
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:30:46 -0700 (PDT)
MIME-Version: 1.0
From: Umair Sarfraz <aquadestructor@gmail.com>
Date: Tue, 25 Apr 2017 02:30:45 +0500
Message-ID: <CAGJp4bCsPw_yVs=krjDO3nq0YQNuBbkVhL-TANMdWu3_DihK1w@mail.gmail.com>
Subject: Docker daemon in enforcing state
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1142a312eb4415054df0512c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142a312eb4415054df0512c
Content-Type: text/plain; charset=UTF-8

Hi,

So, I have been trying to play around with MLS (which I have successfully
configured) on CentOS 7. I'm aiming to apply some security policies
(categorization of docker containers) via MLS, but I can't seem to access
and get correct labels of docker daemon if I am in `enforcing` mode.
However, changing it to permissive mode allow me to access the service and
have correct label. In enforcing mode, I get unlablled_t on the docker
dirs.


I am fairly new to SELinux so please excuse me if this is a silly question
but I am pretty sure I am missing something here. Any sort of help would be
appreciated. Thanks.

-- 

Umair Sarfraz

--001a1142a312eb4415054df0512c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>So, I have been trying to pla=
y around with MLS (which I have successfully configured) on CentOS 7. I&#39=
;m aiming to apply some security policies (categorization of docker contain=
ers) via MLS, but I can&#39;t seem to access and get correct labels of dock=
er daemon if I am in `enforcing` mode. However, changing it to permissive m=
ode allow me to access the service and have correct label. In enforcing mod=
e, I get unlablled_t on the docker dirs.=C2=A0</div><div><br></div><div><br=
></div><div>I am fairly new to SELinux so please excuse me if this is a sil=
ly question but I am pretty sure I am missing something here. Any sort of h=
elp would be appreciated. Thanks.<br clear=3D"all"><div><br></div>-- <br><d=
iv class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div><br></div><div><span style=3D"font-size:12=
.8px">Umair Sarfraz</span><br></div></div><div dir=3D"ltr"><br><div><br></d=
iv></div></div></div></div>
</div></div>

--001a1142a312eb4415054df0512c--
