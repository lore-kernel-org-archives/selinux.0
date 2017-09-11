Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8B63u4R030127
 for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2017 02:04:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id i189so31127755wmf.1
 for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2017 23:03:36 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 11 Sep 2017 08:03:34 +0200
Message-ID: <CAJ2a_DeMsv9kAiTwcDvK9XhW6bVqQQezXze3+ME8tdJxJ=AZhw@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: restorecon: Warning no default label for foo
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,

in the 2.7 release, restorecon changed its behavior regarding warnings
of no default labels.

With a refpolicy file context definition `/run/.* <<none>>` previously
the behavior was:

$ touch /run/test.pid
$ restoreon -v -R -n /run
Warning no default label for /run/test.pid

Now the warning has disappeared. Is there a switch to toggle it back,
cause for policy development it's quite helpful.

Regards,
     Christian Göttsche
