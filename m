Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w37H42mn008054
 for <selinux@tycho.nsa.gov>; Sat, 7 Apr 2018 13:04:03 -0400
Received: by mail-io0-f176.google.com with SMTP id q84so5121330iod.10
 for <selinux@tycho.nsa.gov>; Sat, 07 Apr 2018 10:03:57 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1523120055.31267.13.camel@btinternet.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
 <1523120055.31267.13.camel@btinternet.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 10:03:56 -0700
Message-ID: <CA+55aFxo4Z3S7qG66esSL_qxg5jwzcFgZpYR0gRpto4Z_yghTQ@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Paul Moore <paul@paul-moore.com>, Xin Long <lucien.xin@gmail.com>,
 selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Apr 7, 2018 at 9:54 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
>>
>> So please check my resolution, but also somebody should tell me
>> "Linus, you're a cretin, sctp_connect() doesn't want that
>> security_sctp_bind_connect() at all because it was already done by
>> XYZ"
>
> sctp_connect() or __sctp_connect() do not need to call
> security_sctp_bind_connect(). This is because the connect(2) call will
> handle the checks required via security_socket_connect():

Ok, thanks, that's exactly what I wanted to get.

Anyway, somebody should still verify that it all looks good in my
tree, but I don't actually expect the merge to have had any issues
even if the refactoring made it a bit more complex than most merges
are.

                      Linus
