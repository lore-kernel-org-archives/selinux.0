Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3TGqBsl019959
 for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2015 12:52:12 -0400
Received: by wgso17 with SMTP id o17so35078349wgs.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2015 09:52:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Apr 2015 18:52:08 +0200
Message-ID: <CAEcA1_ur1JCYfQfH4T9CPjVSRC+emjr5Prp7vO-geVj+U+bsJg@mail.gmail.com>
Subject: SELinux policy for Xen with CloudStack
From: Andrew Holway <andrew.holway@otternetworks.de>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04428c12be681c0514dfcc13
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d04428c12be681c0514dfcc13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have a customer that is asking me to make investigations about setting up
CloudStack with SELinux. I asked Daniel Walsh and it seems that KVM is
covered with sVirt in Libvirt however XenServer is a big question mark.
Should I assume that no work has been done to cover Xen with SELinux?

Thanks,

Andrew Holway

--=20
Otter Networks UG
http://otternetworks.de
fon: +49 30 54 88 5197
Gotenstra=C3=9Fe 17
10829 Berlin

--f46d04428c12be681c0514dfcc13
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have a customer that is asking me=
 to make investigations about setting up CloudStack with SELinux. I asked D=
aniel Walsh and it seems that KVM is covered with sVirt in Libvirt however =
XenServer is a big question mark. Should I assume that no work has been don=
e to cover Xen with SELinux?</div><div><br></div><div>Thanks,</div><div><br=
></div><div>Andrew Holway</div><div><div><br></div>-- <br><div><div dir=3D"=
ltr">Otter Networks UG<br><a href=3D"http://otternetworks.de" target=3D"_bl=
ank">http://otternetworks.de</a><br>fon: <a href=3D"tel:%2B49%2030%2054%208=
8%205197" value=3D"+493054885197" target=3D"_blank">+49 30 54 88 5197</a><b=
r>Gotenstra=C3=9Fe 17<br>10829 Berlin</div></div>
</div></div>

--f46d04428c12be681c0514dfcc13--
