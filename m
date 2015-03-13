Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DHOjIc028682
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 13:24:45 -0400
Message-ID: <55031D59.2040909@native-instruments.de>
Date: Fri, 13 Mar 2015 18:24:41 +0100
From: Andrew Holway <andrew.holway@native-instruments.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Saltstack and ipa-install on Centos7 failing
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hallo,

Could someone please lend a hand with this issue?

https://www.redhat.com/archives/freeipa-users/2015-March/msg00345.html

When I run ipa-server-install from Saltstack it is breaking. I imagine
this is because the script is being run in an unexpected domain
(init_t rather than unconfined_t).

Thanks,

Andrew
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJVAx1ZAAoJEMFRZbkg22K+A2QP/3qXIw6EKuklLhDPGh81TWjA
DuLF3nvvEq/50XFFPNNceUFCs4vST8EUYTX0S968wy6v7R1oAb398wQOQrWUR2LR
mSxYQEv7Pk1aqxAraBUDk/qxgYn/Mztsz4xh/F+Wsh+EWMN+CN/hueuU9CAAD9VA
ZJax9FO+9GjwHj688ZidHQPJyBh4QTTU0mIB3dGmBhFZ1rdOraIGgbMD5P9j6ltV
uX/3p8hr61irBcvWb9caVLS/kBlcFWHHLSQhMYM4wibNxYPgKB9fWYsLexPTPVRm
DizR098vXahtmVHbCV0Cyaixq9uifSZc5UZfXiphjeooIme9jTEV8R75f2NzSHRv
ulOJBzok2lCovtnE492BP/7SFdEH3Yttgg71mXG0cW7ozJLwcuKnEm1loWJ/4KXx
7u3wf7yeeOjakaE51wVrz/a47vtWdlNDbkHe1WFvb3MSmJby13xRc6km+Cd0Nw10
l1d97/renCRiDjXqNa0xwCiRp76WrxCJ0FLIkm9MD7c0/pKj1YZ0mpRCM9eobutH
FZOXkiprOCvq6N4L24nYccGQC1pdQM91GIU3bM/bpAIP/v6P/bBaNBo8BGS0faTj
l1KPeCdU+novZojpCEnQPkq7WIUivKDt/Ni5ORXiF2G10iNzpOMd51AuavkzvtIi
TMIrEYiVHhMjCeruuGpQ
=2xyi
-----END PGP SIGNATURE-----
