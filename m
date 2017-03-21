Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2LF7Aij028509
 for <selinux@tycho.nsa.gov>; Tue, 21 Mar 2017 11:07:16 -0400
Received: by mail-wr0-f180.google.com with SMTP id l37so113983986wrc.1
 for <selinux@tycho.nsa.gov>; Tue, 21 Mar 2017 08:06:32 -0700 (PDT)
MIME-Version: 1.0
From: cgzones <cgzones@googlemail.com>
Date: Tue, 21 Mar 2017 16:06:30 +0100
Message-ID: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
Subject: net_admin audit for setsockopt SO_SNDBUFFORCE
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,
this thread[1] about setsockopt(...,...,SO_SNDBUFFORCE), which
triggers widely due to systemd, let me think about the recent SELinux
kernel fixes: the reordering of dac_read_search and dac_override and
also the cap_wake_alarm fix.

Would it make sense to test, if the send buffer is really set to a
higher value than wmem_max, before testing for the cap_net_admin
permission[2]?
(might also apply to SO_RCVBUFFORCE)

Best regards,
    Christian Göttsche


[1] http://oss.tresys.com/pipermail/refpolicy/2017-March/009185.html
[2] https://github.com/torvalds/linux/blob/ae50dfd61665086e617cc9e554a1285d52765670/net/core/sock.c#L715


p.s.: friendly ping on https://marc.info/?l=selinux&m=148944677530753&w=2
