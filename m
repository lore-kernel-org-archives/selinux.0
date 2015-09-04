Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84B5R3j002479
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 07:05:27 -0400
Received: by vkhf67 with SMTP id f67so9404279vkh.1
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 04:05:02 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 4 Sep 2015 16:34:42 +0530
Message-ID: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
Subject: Enable user_xattr - Selinux failing
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf303635e90f1de4051ee9df44
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--20cf303635e90f1de4051ee9df44
Content-Type: text/plain; charset=UTF-8

Hi,

I am getting this error while building the selinux enabled image.


* SELinux requires the root '/' filesystem support extended
  filesystem attributes (XATTRs).  It does not appear that this
  filesystem has extended attribute support or it is not enabled.

  - To continue using SELinux you will need to enable extended
    attribute support on the root device.

  - To disable SELinux, please add "selinux=0" in the kernel
    command line.

* Halting the system now.

My fstab is below :

rootfs                  /               ext3
defaults,acl,user_xattr 0 1

Any idea where is the problem?

Thanks,

--20cf303635e90f1de4051ee9df44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div><div>I am getting this error while b=
uilding the selinux enabled image.<br><br><br>* SELinux requires the root &=
#39;/&#39; filesystem support extended<br>=C2=A0 filesystem attributes (XAT=
TRs).=C2=A0 It does not appear that this<br>=C2=A0 filesystem has extended =
attribute support or it is not enabled.<br><br>=C2=A0 - To continue using S=
ELinux you will need to enable extended<br>=C2=A0=C2=A0=C2=A0 attribute sup=
port on the root device.<br><br>=C2=A0 - To disable SELinux, please add &qu=
ot;selinux=3D0&quot; in the kernel<br>=C2=A0=C2=A0=C2=A0 command line.<br><=
br>* Halting the system now.<br><br></div><div>My fstab is below :<br></div=
><div><br>rootfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext3=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults,acl,user_xa=
ttr 0 1 <br><br></div><div>Any idea where is the problem?<br><br></div><div=
>Thanks,<br><br></div></div>

--20cf303635e90f1de4051ee9df44--
