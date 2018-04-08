Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w38CosvK027460
 for <selinux@tycho.nsa.gov>; Sun, 8 Apr 2018 08:50:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 40JtZy6xp9z1pKYf
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 12:50:50 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 40JtZy4wkSz1pKYb
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 12:50:50 +0000 (UTC)
Received: by mail-qk0-f172.google.com with SMTP id v2so6353142qkh.10
 for <selinux@tycho.nsa.gov>; Sun, 08 Apr 2018 05:50:49 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Richard Haines <richard_c_haines@btinternet.com>
CC: Xin Long <lucien.xin@gmail.com>, <selinux@tycho.nsa.gov>,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 08 Apr 2018 08:50:46 -0400
Message-ID: <162a54f1470.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
 <1523120055.31267.13.camel@btinternet.com>
 <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On April 7, 2018 1:03:57 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
On Sat, Apr 7, 2018 at 9:54 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:

So please check my resolution, but also somebody should tell me
"Linus, you're a cretin, sctp_connect() doesn't want that
security_sctp_bind_connect() at all because it was already done by
XYZ"

sctp_connect() or __sctp_connect() do not need to call
security_sctp_bind_connect(). This is because the connect(2) call will
handle the checks required via security_socket_connect():

Ok, thanks, that's exactly what I wanted to get.

Anyway, somebody should still verify that it all looks good in my
tree, but I don't actually expect the merge to have had any issues
even if the refactoring made it a bit more complex than most merges
are.

Thanks for the quick response Richard.

Xin Long looked it over and gave it the thumbs up, I'll take a look too, but to be honest I trust his SCTP understanding much more than mine.  I also do weekly tests of each rcX release at a minimum so if something odd pops up I'll make sure you get a fix.

Thanks again everyone.

--
paul moore
www.paul-moore.com
