Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QLQfQw007566
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 17:26:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id n1-v6so407585oic.4
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 14:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-5-casey.schaufler@intel.com>
In-Reply-To: <20180926203446.2004-5-casey.schaufler@intel.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Sep 2018 23:26:07 +0200
Message-ID: <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
To: Casey Schaufler <casey.schaufler@intel.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
 deneen.t.dock@intel.com, kristen@linux.intel.com,
 Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
<casey.schaufler@intel.com> wrote:
> Allow a complete ptrace access check with mode PTRACE_MODE_SCHED.
> Disable the inappropriate privilege check in the capability code
> that does incompatible locking.

What's that locking you're talking about?

> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  kernel/ptrace.c      | 2 --
>  security/commoncap.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 99cfddde6a55..0b6a9df51c3b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -331,8 +331,6 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>              !ptrace_has_cap(mm->user_ns, mode)))
>             return -EPERM;
>
> -       if (mode & PTRACE_MODE_SCHED)
> -               return 0;
>         return security_ptrace_access_check(task, mode);
>  }
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 2e489d6a3ac8..e77457110d05 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -152,6 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>         if (cred->user_ns == child_cred->user_ns &&
>             cap_issubset(child_cred->cap_permitted, *caller_caps))
>                 goto out;
> +       if (mode & PTRACE_MODE_SCHED)
> +               goto out;

So for PTRACE_MODE_SCHED, this function always returns 0, right? If
that's intentional, perhaps you should instead just put "if (mode &
PTRACE_MODE_SCHED) return 0;" at the start of the function, to avoid
taking the RCU read lock in this case.

>         if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>                 goto out;
>         ret = -EPERM;
