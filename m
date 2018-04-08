Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w386DvHV009783
 for <selinux@tycho.nsa.gov>; Sun, 8 Apr 2018 02:13:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 40Jjmw0yRFzQ5Wf
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 06:13:52 +0000 (UTC)
Received: from USFB3CPA02_EEMSG_MP24.eemsg.mil (unknown [192.168.16.19])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 40Jjmv6VSZzQ5Wd
 for <selinux@tycho.nsa.gov>; Sun,  8 Apr 2018 06:13:51 +0000 (UTC)
Received: by mail-io0-f194.google.com with SMTP id p139so6104149iod.0
 for <selinux@tycho.nsa.gov>; Sat, 07 Apr 2018 23:13:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 8 Apr 2018 14:13:49 +0800
Message-ID: <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Apr 7, 2018 at 7:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:
>>
>> Everything passes the selinux-testsuite, but there are a few known
>> merge conflicts.  The first is with the netdev tree and is in
>> net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
>> Rothwell has already done the heavy lifting in resolving the merge for
>> you, and the SCTP folks have given his merge patch a thumbs-up.
>
> I ended up re-doing the merge, and it looks like some more sctp
> changes happened after Stephen's merge anyway, so mine didn't end up
 > quite like his.
>
You're right, a sctp fix went into net-next after Stephen's that merge.
https://patchwork.ozlabs.org/patch/884469/ (v1)
https://patchwork.ozlabs.org/patch/884971/ (v2)

Which caused the resolution to have changed again.

I've checked the new resolution on your tree, the SCTP part is all good.

Thanks.
