Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RJnh5w005788
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 15:49:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id q4-v6so3727400otf.13
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 12:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180824224117.3356-1-casey.schaufler@intel.com>
 <20180927191720.9480-1-casey.schaufler@intel.com>
In-Reply-To: <20180927191720.9480-1-casey.schaufler@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 27 Sep 2018 21:49:10 +0200
Message-ID: <CAG48ez1qZQqffLfB_JV=UB12QjFWmfHm2=PH2eiF+Z_yn9RhpA@mail.gmail.com>
To: Casey Schaufler <casey.schaufler@intel.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
 deneen.t.dock@intel.com, kristen@linux.intel.com,
 Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 6/5] capability: Repair sidechannel test in
 ptrace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 27, 2018 at 9:17 PM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> From: Casey Schaufler <casey@schaufler-ca.com>
>
> The PTRACE_MODE_SCHED check erroniously returns 0 in
> all cases. It should be returning -EPERM. This fixes
> the logic to correct that error.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  security/commoncap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index e77457110d05..70a7e3d19c16 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -152,9 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>         if (cred->user_ns == child_cred->user_ns &&
>             cap_issubset(child_cred->cap_permitted, *caller_caps))
>                 goto out;
> -       if (mode & PTRACE_MODE_SCHED)
> -               goto out;
> -       if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
> +       if (!(mode & PTRACE_MODE_SCHED) &&
> +           ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>                 goto out;
>         ret = -EPERM;
>  out:
> --
> 2.17.1
>
