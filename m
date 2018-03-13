Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2DJnZS1006486
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 15:49:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 40155T58zqz1x08Z
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 19:49:01 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 40155T43T4z1x08m
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 19:49:01 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id u21-v6so1227473lfc.7
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 12:49:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180305164756.7878-2-sds@tycho.nsa.gov>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
 <20180305164756.7878-2-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Mar 2018 15:48:59 -0400
Message-ID: <CAHC9VhS=brNsC89F9ou4TRPgA0mQN-6prUG3-mz-ksEu1PM=wQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com,
 James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] selinux: wrap AVC state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Wrap the AVC state within the selinux_state structure and
> pass it explicitly to all AVC functions.  The AVC private state
> is encapsulated in a selinux_avc structure that is referenced
> from the selinux_state.
>
> This change should have no effect on SELinux behavior or
> APIs (userspace or LSM).
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c              | 284 ++++++++++++++-----------
>  security/selinux/hooks.c            | 398 ++++++++++++++++++++++++------------
>  security/selinux/include/avc.h      |  32 ++-
>  security/selinux/include/avc_ss.h   |   3 +-
>  security/selinux/include/security.h |   3 +
>  security/selinux/netlabel.c         |   3 +-
>  security/selinux/selinuxfs.c        |  60 ++++--
>  security/selinux/ss/services.c      |   9 +-
>  security/selinux/xfrm.c             |  17 +-
>  9 files changed, 512 insertions(+), 297 deletions(-)

This patch looks fine to me.  Once we sort out my questions/comments
in patch 1/2 I'll apply this.

-- 
paul moore
www.paul-moore.com
