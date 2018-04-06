Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w36N79DV020980
 for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2018 19:07:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID14.oob.disa.mil (Postfix) with SMTP id 40HwLw4fqjz3dvhy
 for <selinux@tycho.nsa.gov>; Fri,  6 Apr 2018 23:07:04 +0000 (UTC)
Received: from USFB3CPA03_EEMSG_MP25.eemsg.mil (unknown [192.168.16.20])
 by USFBF3ID14.oob.disa.mil (Postfix) with ESMTP id 40HwLw3f9Wz3dvhq
 for <selinux@tycho.nsa.gov>; Fri,  6 Apr 2018 23:07:04 +0000 (UTC)
Received: by mail-io0-f194.google.com with SMTP id v13so3474261iob.6
 for <selinux@tycho.nsa.gov>; Fri, 06 Apr 2018 16:07:03 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Apr 2018 16:07:02 -0700
Message-ID: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>, Xin Long <lucien.xin@gmail.com>
Cc: selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:
>
> Everything passes the selinux-testsuite, but there are a few known
> merge conflicts.  The first is with the netdev tree and is in
> net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
> Rothwell has already done the heavy lifting in resolving the merge for
> you, and the SCTP folks have given his merge patch a thumbs-up.

I ended up re-doing the merge, and it looks like some more sctp
changes happened after Stephen's merge anyway, so mine didn't end up
quite like his.

Adding Xin Long to see if he can verify it again, but it all *looks* sane.

While looking at it, it struck me that the new security hooks don't
seem to hook into __sctp_connect(), which also does that

                        scope = sctp_scope(&to);
                        asoc = sctp_association_new(ep, sk, scope, GFP_KERNEL);

thing. Is that intentional? The sendmsg case does that
security_sctp_bind_connect, the actual __sctp_connect() does not.

This is not because I screwed up the merge - it's that way in the
SELinux tree too. And I obviously _left_ it that way, but while doing
the merge and trying to understand what was going on, this struck me.

I'm probably missing something really obvious why the connect case
doesn't want to do it thgere.

NOTE! I do see it being done in __sctp_setsockopt_connectx(). But
__sctp_connect() has another caller (in sctp_connect()) which doesn't
have that security_sctp_bind_connect() call.

So please check my resolution, but also somebody should tell me
"Linus, you're a cretin, sctp_connect() doesn't want that
security_sctp_bind_connect() at all because it was already done by
XYZ"

                 Linus
