Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7MCM22P003685
 for <selinux@tycho.nsa.gov>; Tue, 22 Aug 2017 08:22:02 -0400
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::1d])
 by forward101o.mail.yandex.net (Yandex) with ESMTP id C5C85134497E
 for <selinux@tycho.nsa.gov>; Tue, 22 Aug 2017 15:15:36 +0300 (MSK)
From: Sky Autumn <autumnsky00@yandex.ru>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <31471503404136@web31o.yandex.ru>
Date: Tue, 22 Aug 2017 15:15:36 +0300
Content-Type: text/html; charset=utf-8
Subject: 
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<div><div><div>Hello, everyone.=C2=A0</div><div>There's my problem. When =
I try to set label on directory with russian letters in name with policy =
module, the following error occur:=C2=A0</div><div>=C2=A0/etc/selinux/fin=
al/targeted/contexts/files/file_contexts: =C2=A0line 5206 error due to: N=
on-ASCII characters found</div><div>=C2=A0</div><div>On other machine it =
works fine. libselinux version on first machine 2.5-6, on second 2.2.2-6.=
 Can I somehow install such policy on first machine without renaming dire=
ctory? Thank you.</div></div></div>
