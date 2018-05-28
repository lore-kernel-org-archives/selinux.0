Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4S4gG6m013966
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 00:42:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id k2-v6so4746159pgc.1
 for <selinux@tycho.nsa.gov>; Sun, 27 May 2018 21:42:11 -0700 (PDT)
Date: Mon, 28 May 2018 12:42:07 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180528044207.GA9472@baraddur.perfinion.com>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH 0/7] Fix some issues spotted by static analyzers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 26, 2018 at 08:42:06PM +0200, Nicolas Iooss wrote:
> Hi,
> As you may have noticed, I have been using clang's static analyzer for
> a few months and submitted fixes for bugs that it found. There are also
> many minor issues in the code (memory leaks, dead assignments, etc.)
> which introduce much noise and make it harder to find real issues. For
> example if a reported "dead variable assignment" is about the return
> value of a function which would need to be checked and the wrong
> variable is used in the check, this would be detected by the analyzer
> but would be in the noise of other minor issues.
> 
> Therefore this patchset (and the ones that I would like to send in the
> following weeks) is about reducing this noise.
> 
> I am starting with libsepol/src/module_to_cil.c and while cleaning up
> the commits I have written in order to use clang's static analyzer, I
> stumbled upon some other local commits I forgot to send, which fix more
> important bugs (like a missing call to va_end(), in the last patch).
> This explains why there are other files which are modified.
> 
> Here is the git shortlog:
> 
> Nicolas Iooss (7):
>   libsepol: cil: silence clang analyzer false positive
>   libsepol: do not leak memory if list_prepend fails
>   libsepol: remove some dead assignments
>   libsepol: do not call malloc with 0 byte
>   libsepol: remove unused variable
>   checkpolicy: destroy the class datum if it fails to initialize
>   libsepol: destroy the copied va_list
> 
>  checkpolicy/module_compiler.c   |  1 +
>  libsepol/cil/src/cil_tree.c     |  2 +-
>  libsepol/src/kernel_to_common.c |  3 +++
>  libsepol/src/module_to_cil.c    | 21 +++++++++++++--------
>  4 files changed, 18 insertions(+), 9 deletions(-)

These all look good to me. I didnt compile test since your CI has
already done that many many times.

For the whole series:
Acked-by: Jason Zaman <jason@perfinion.com>

-- Jason

> 
> Cheers,
> Nicolas
> 
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
