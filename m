Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w49GWdgL009589
 for <selinux@tycho.nsa.gov>; Wed, 9 May 2018 12:32:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 40h1nj1Vpzz4564Z
 for <selinux@tycho.nsa.gov>; Wed,  9 May 2018 16:21:29 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 40h1nh3ck6z4565p
 for <selinux@tycho.nsa.gov>; Wed,  9 May 2018 16:21:28 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id t129-v6so12509649lff.3
 for <selinux@tycho.nsa.gov>; Wed, 09 May 2018 09:21:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 May 2018 11:53:57 -0400
Message-ID: <CAHC9VhRY-hhBb+Kg19Cfy87MSHseUO40j9PC8wsdmHQmcV0zDQ@mail.gmail.com>
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
Subject: Re: [PATCH ghak81 RFC V1 0/5] audit: group task params
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 4, 2018 at 4:54 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Group the audit parameters for each task into one structure.
> In particular, remove the loginuid and sessionid values and the audit
> context pointer from the task structure, replacing them with an audit
> task information structure to contain them.  Use access functions to
> access audit values.
>
> Note:  Use static allocation of the audit task information structure
> initially.  Dynamic allocation was considered and attempted, but isn't
> ready yet.  Static allocation has the limitation that future audit task
> information structure changes would cause a visible change to the rest
> of the kernel, whereas dynamic allocation would mostly hide any future
> changes.
>
> The first four access normalization patches could stand alone.

I agree that the first four patches have some standalone value, and
since we are currently at -rc4, did you want to post another patchset
of just those four patches with feedback incorporated?  I imagine that
should be quick work, and that way they aren't help up with any
problems/discussion regarding the take_struct changes.

> Passes audit-testsuite.
>
> Richard Guy Briggs (5):
>   audit: normalize loginuid read access
>   audit: convert sessionid unset to a macro
>   audit: use inline function to get audit context
>   audit: use inline function to set audit context
>   audit: collect audit task parameters
>
>  MAINTAINERS                          |  2 +-
>  include/linux/audit.h                | 30 ++++++++++---
>  include/linux/audit_task.h           | 31 ++++++++++++++
>  include/linux/sched.h                |  6 +--
>  include/net/xfrm.h                   |  4 +-
>  include/uapi/linux/audit.h           |  1 +
>  init/init_task.c                     |  8 +++-
>  kernel/audit.c                       |  4 +-
>  kernel/audit_watch.c                 |  2 +-
>  kernel/auditsc.c                     | 82 ++++++++++++++++++------------------
>  kernel/fork.c                        |  2 +-
>  net/bridge/netfilter/ebtables.c      |  2 +-
>  net/core/dev.c                       |  2 +-
>  net/netfilter/x_tables.c             |  2 +-
>  net/netlabel/netlabel_user.c         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/integrity_audit.c |  2 +-
>  security/lsm_audit.c                 |  2 +-
>  security/selinux/hooks.c             |  4 +-
>  security/selinux/selinuxfs.c         |  6 +--
>  security/selinux/ss/services.c       | 12 +++---
>  21 files changed, 129 insertions(+), 79 deletions(-)
>  create mode 100644 include/linux/audit_task.h
>
> --
> 1.8.3.1
>



-- 
paul moore
www.paul-moore.com
