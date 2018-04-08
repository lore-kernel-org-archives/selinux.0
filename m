Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w38Cjsiw027128
 for <selinux@tycho.nsa.gov>; Sun, 8 Apr 2018 08:45:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 40JtTB14p7z1x08Z
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 12:45:50 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 40JtTB09bHz1wybx
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 12:45:50 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id w6so6341238qkb.4
 for <selinux@tycho.nsa.gov>; Sun, 08 Apr 2018 05:45:48 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Xin Long <lucien.xin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
CC: <selinux@tycho.nsa.gov>, LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 08 Apr 2018 08:45:45 -0400
Message-ID: <162a54a7ca8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
 <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On April 8, 2018 2:13:51 AM Xin Long <lucien.xin@gmail.com> wrote:
On Sat, Apr 7, 2018 at 7:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:

Everything passes the selinux-testsuite, but there are a few known
merge conflicts.  The first is with the netdev tree and is in
net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
Rothwell has already done the heavy lifting in resolving the merge for
you, and the SCTP folks have given his merge patch a thumbs-up.

I ended up re-doing the merge, and it looks like some more sctp
changes happened after Stephen's merge anyway, so mine didn't end up
quite like his.
You're right, a sctp fix went into net-next after Stephen's that merge.
https://patchwork.ozlabs.org/patch/884469/ (v1)
https://patchwork.ozlabs.org/patch/884971/ (v2)

Which caused the resolution to have changed again.

I've checked the new resolution on your tree, the SCTP part is all good.

Thanks for double checking that Xin.

--
paul moore
www.paul-moore.com
