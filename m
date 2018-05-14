Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4ELi56l012276
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 17:44:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 40lDjb60LLz4KRK4
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 21:44:03 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 40lDjb4Bdcz4KRKb
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 21:44:03 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id r2-v6so20242341lff.4
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 14:44:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <baa29a694e352bd4fe8acd0f46f7baca1ad2c147.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
 <baa29a694e352bd4fe8acd0f46f7baca1ad2c147.1526173613.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 17:44:01 -0400
Message-ID: <CAHC9VhQXr76FXPCe8vUWNwa2VshcPg1mZmMY7M30H1F6w30rFA@mail.gmail.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
 Netfilter Devel List <netfilter-devel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Integrity Measurement Architecture <linux-integrity@vger.kernel.org>,
 SElinux list <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH ghak81 RFC V2 3/5] audit: use inline function to
 get audit context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to retrieve the audit context pointer for the task
> rather than reaching directly into the task struct to get it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h                | 14 ++++++--
>  include/net/xfrm.h                   |  2 +-
>  kernel/audit.c                       |  6 ++--
>  kernel/audit_watch.c                 |  2 +-
>  kernel/auditsc.c                     | 64 +++++++++++++++++-------------------
>  net/bridge/netfilter/ebtables.c      |  2 +-
>  net/core/dev.c                       |  2 +-
>  net/netfilter/x_tables.c             |  2 +-
>  net/netlabel/netlabel_user.c         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/integrity_audit.c |  2 +-
>  security/lsm_audit.c                 |  2 +-
>  security/selinux/hooks.c             |  4 +--
>  security/selinux/selinuxfs.c         |  6 ++--
>  security/selinux/ss/services.c       | 12 +++----
>  15 files changed, 64 insertions(+), 60 deletions(-)

Merged, but there was some fuzz due to the missing 1/5 patch and a
handfull of checkpatch.pl fixes.  Please take a look at the commit in
the audit/next branch and if anything looks awry please send a patch
to fix it.

-- 
paul moore
www.paul-moore.com
