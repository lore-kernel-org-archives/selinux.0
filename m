Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w91LmGr6027625
 for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2018 17:48:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id m129-v6so6202768ywc.1
 for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2018 14:48:13 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id e82-v6sm12295375ywa.60.2018.10.01.14.48.12
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 14:48:12 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id c4-v6so6296985ybl.6
 for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2018 14:48:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 1 Oct 2018 14:48:10 -0700
Message-ID: <CAGXu5j+XTMcqdPQK=E6KV3-oMCFA+UkiGsfHN2T6CCfAA7X9Qw@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 21/19] LSM: Cleanup and fixes from Tetsuo Handa
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> lsm_early_cred()/lsm_early_task() are called from only __init functions.
>
> lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .
>
> lsm_early_inode() should be avoided because it is not appropriate to
> call panic() when lsm_early_inode() is called after __init phase.
>
> Since all free hooks are called when one of init hooks failed, each
> free hook needs to check whether init hook was called.
>
> The original changes are from Tetsuo Handa. I have made minor
> changes in some places, but this is mostly his code.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  6 ++----
>  security/security.c               | 27 ++++-----------------------
>  security/selinux/hooks.c          |  5 ++++-
>  security/selinux/include/objsec.h |  2 ++
>  security/smack/smack_lsm.c        |  8 +++++++-
>  5 files changed, 19 insertions(+), 29 deletions(-)

I've split this across the various commits they touch:

Infrastructure management of the cred security blob
LSM: Infrastructure management of the file security
LSM: Infrastructure management of the inode security
LSM: Infrastructure management of the task security
LSM: Blob sharing support for S.A.R.A and LandLock

Based on these changes, I've uploaded the "v4.1", or "Casey is on
vacation", tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/blob-sharing-v4.1

I'm going to work on a merged series for the "arbitrary ordering" and
"blob-sharing" trees next...

-Kees

-- 
Kees Cook
Pixel Security
