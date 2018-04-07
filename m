Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w37GsSHD007431
 for <selinux@tycho.nsa.gov>; Sat, 7 Apr 2018 12:54:28 -0400
Message-ID: <1523120055.31267.13.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore
 <paul@paul-moore.com>, Xin Long <lucien.xin@gmail.com>
Cc: selinux@tycho.nsa.gov, LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 07 Apr 2018 17:54:15 +0100
In-Reply-To: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-04-06 at 16:07 -0700, Linus Torvalds wrote:
> On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com>
> wrote:
> > 
> > Everything passes the selinux-testsuite, but there are a few known
> > merge conflicts.  The first is with the netdev tree and is in
> > net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully
> > Stephen
> > Rothwell has already done the heavy lifting in resolving the merge
> > for
> > you, and the SCTP folks have given his merge patch a thumbs-up.
> 
> I ended up re-doing the merge, and it looks like some more sctp
> changes happened after Stephen's merge anyway, so mine didn't end up
> quite like his.
> 
> Adding Xin Long to see if he can verify it again, but it all *looks*
> sane.
> 
> While looking at it, it struck me that the new security hooks don't
> seem to hook into __sctp_connect(), which also does that
> 
>                         scope = sctp_scope(&to);
>                         asoc = sctp_association_new(ep, sk, scope,
> GFP_KERNEL);
> 
> thing. Is that intentional? The sendmsg case does that
> security_sctp_bind_connect, the actual __sctp_connect() does not.
> 
> This is not because I screwed up the merge - it's that way in the
> SELinux tree too. And I obviously _left_ it that way, but while doing
> the merge and trying to understand what was going on, this struck me.
> 
> I'm probably missing something really obvious why the connect case
> doesn't want to do it thgere.
> 
> NOTE! I do see it being done in __sctp_setsockopt_connectx(). But
> __sctp_connect() has another caller (in sctp_connect()) which doesn't
> have that security_sctp_bind_connect() call.
> 
> So please check my resolution, but also somebody should tell me
> "Linus, you're a cretin, sctp_connect() doesn't want that
> security_sctp_bind_connect() at all because it was already done by
> XYZ"
> 
>                  Linus

Thought I would answer the questions as I wrote the SELinux/SCTP
patches.

sctp_connect() or __sctp_connect() do not need to call
security_sctp_bind_connect(). This is because the connect(2) call will
handle the checks required via security_socket_connect():

       connect(2)
          |
 SYSCALL_DEFINE3(connect, ....)
          |
   security_socket_connect()
          |
     sctp_connect()

SCTP uses security_sctp_bind_connect() as this can handle one or more
addresses for either sctp_connectx(3) or sctp_bindx(3). It is also used
for handling the sendmsg(2) and sctp_sendmsg(3) calls in SCTP for a new
association (that is effectively a "connect").

Hope this helps

Richard

> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
