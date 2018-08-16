Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7GEMpgr029541
 for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2018 10:22:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so8314190oib.4
 for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2018 07:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180815235355.14908-1-casey.schaufler@intel.com>
 <20180815235355.14908-6-casey.schaufler@intel.com>
In-Reply-To: <20180815235355.14908-6-casey.schaufler@intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Aug 2018 16:22:08 +0200
Message-ID: <CAG48ez0OAFqzak1=OEF5V8cZR_-dYUiXnUVp=mgnikexjQkELA@mail.gmail.com>
To: casey.schaufler@intel.com
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 selinux@tycho.nsa.gov, SMACK-discuss@lists.01.org,
 Dave Hansen <dave.hansen@intel.com>, deneen.t.dock@intel.com,
 kristen@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH RFC 5/5] SELinux: Support SELinux determination
 of side-channel vulnerability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 16, 2018 at 11:52 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  security/selinux/hooks.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a8bf324130f5..7fbd7d7ac1cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>         spin_unlock(&isec->lock);
>  }
>
> +static int selinux_task_safe_sidechannel(struct task_struct *p)
> +{
> +       struct av_decision avd;
> +
> +       return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
> +                                   SECCLASS_PROCESS, PROCESS__SHARE, 0, &avd);
> +}

current_sid() -> current_security() -> current_cred_xxx() ->
current_cred() accesses current->cred, the subjective credentials
associated with the current syscall context, affected by
override_creds(). You probably want to look at objective credentials
here, since what you're interested in is not the security context of
the current syscall, but the security context of the userspace code
running in the current address space.

task_sid() does the right thing and looks at the objective creds.
