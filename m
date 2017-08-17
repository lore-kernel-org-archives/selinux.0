Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7HKH62e004079
 for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2017 16:17:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id f7so158612lfg.0
 for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2017 12:37:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170817173237.5858-2-sds@tycho.nsa.gov>
References: <20170817173237.5858-1-sds@tycho.nsa.gov>
 <20170817173237.5858-2-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Aug 2017 15:36:44 -0400
Message-ID: <CAHC9VhQMtniwyDcCpiqgvA64sUg3mdGu+c6HR3ofE2P2SqGHTQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] lsm_audit: update my email address
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 17, 2017 at 1:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Update my email address since epoch.ncsc.mil no longer exists.
> MAINTAINERS and CREDITS are already correct.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

While not strictly SELinux related, this patch is obviously trivial
and I was already merging patch 1/2 so I went ahead and merged this
into the selinux/next tree too.

-- 
paul moore
www.paul-moore.com
