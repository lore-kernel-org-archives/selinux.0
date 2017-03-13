Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2DNBRbd015413
 for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2017 19:11:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11so51563707wma.0
 for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2017 16:11:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170313220715.4mbrqzwcr3xzrcr2@perpetual.pseudorandom.co.uk>
References: <CAJ2a_DcAMXXj5+LZeHsRqARfEmbCCpwfVt2fBiana5rH4mWEGA@mail.gmail.com>
 <20170313220715.4mbrqzwcr3xzrcr2@perpetual.pseudorandom.co.uk>
From: cgzones <cgzones@googlemail.com>
Date: Tue, 14 Mar 2017 00:11:22 +0100
Message-ID: <CAJ2a_DdCveafhom+5-VHW-Bi7kTNvDx0x2u=-dhKW2x81Q+QFQ@mail.gmail.com>
Subject: Re: Bug#857660: SELinux: cannot sent policyload notice
To: selinux <selinux@tycho.nsa.gov>
Cc: 857660@bugs.debian.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,
I created bug report against dbus 1.10 on Debian [1] due to failing to
send policyload notices.
Are there any objections or comments on the upstream patch[2]?
The patch works for me:

Mar 14 00:01:36 debianSE audit[441]: USER_AVC pid=441 uid=105
auid=4294967295 ses=4294967295
subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg='avc:
received policyload notice (seqno=3)
                                     exe="/usr/bin/dbus-daemon"
sauid=105 hostname=? addr=? terminal=?'
Mar 14 00:01:36 debianSE dbus[441]: [system] Reloaded configuration

Best regards,
       Christian Göttsche


[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=857660
[2] https://cgit.freedesktop.org/dbus/dbus/commit/?id=a3a5935a0a038c3b44c61ce5719f0f7e647b96c6
