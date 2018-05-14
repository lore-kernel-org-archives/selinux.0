Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4EJsvxP003465
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 15:54:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40lBHd25SJz2Vp8x
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:54:53 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40lBHc56yCz2Vp9C
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:54:52 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id r25-v6so19833002lfd.1
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 12:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33f131a40a50bd7532ed74ff51e3da920e9e8df5.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
 <33f131a40a50bd7532ed74ff51e3da920e9e8df5.1526173613.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 15:52:03 -0400
Message-ID: <CAHC9VhSPY-49LppFRw9Vmupdw8b2ooMVzWmputdB0bKm3X0+FA@mail.gmail.com>
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
Subject: Re: [PATCH ghak81 RFC V2 1/5] audit: normalize loginuid read access
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the loginuid is an internal audit value, use an access
> function to retrieve the audit loginuid value for the task rather than
> reaching directly into the task struct to get it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 479c031..0d4e269 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -374,7 +374,7 @@ static int audit_field_compare(struct task_struct *tsk,
>         case AUDIT_COMPARE_EGID_TO_OBJ_GID:
>                 return audit_compare_gid(cred->egid, name, f, ctx);
>         case AUDIT_COMPARE_AUID_TO_OBJ_UID:
> -               return audit_compare_uid(tsk->loginuid, name, f, ctx);
> +               return audit_compare_uid(audit_get_loginuid(tsk), name, f, ctx);
>         case AUDIT_COMPARE_SUID_TO_OBJ_UID:
>                 return audit_compare_uid(cred->suid, name, f, ctx);
>         case AUDIT_COMPARE_SGID_TO_OBJ_GID:
> @@ -385,7 +385,7 @@ static int audit_field_compare(struct task_struct *tsk,
>                 return audit_compare_gid(cred->fsgid, name, f, ctx);
>         /* uid comparisons */
>         case AUDIT_COMPARE_UID_TO_AUID:
> -               return audit_uid_comparator(cred->uid, f->op, tsk->loginuid);
> +               return audit_uid_comparator(cred->uid, f->op, audit_get_loginuid(tsk));
>         case AUDIT_COMPARE_UID_TO_EUID:
>                 return audit_uid_comparator(cred->uid, f->op, cred->euid);
>         case AUDIT_COMPARE_UID_TO_SUID:
> @@ -394,11 +394,11 @@ static int audit_field_compare(struct task_struct *tsk,
>                 return audit_uid_comparator(cred->uid, f->op, cred->fsuid);
>         /* auid comparisons */
>         case AUDIT_COMPARE_AUID_TO_EUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->euid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->euid);
>         case AUDIT_COMPARE_AUID_TO_SUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->suid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->suid);
>         case AUDIT_COMPARE_AUID_TO_FSUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->fsuid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->fsuid);
>         /* euid comparisons */
>         case AUDIT_COMPARE_EUID_TO_SUID:
>                 return audit_uid_comparator(cred->euid, f->op, cred->suid);
> @@ -611,7 +611,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>                                 result = match_tree_refs(ctx, rule->tree);
>                         break;
>                 case AUDIT_LOGINUID:
> -                       result = audit_uid_comparator(tsk->loginuid, f->op, f->uid);
> +                       result = audit_uid_comparator(audit_get_loginuid(tsk), f->op, f->uid);
>                         break;
>                 case AUDIT_LOGINUID_SET:
>                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
> @@ -2281,14 +2281,14 @@ int audit_signal_info(int sig, struct task_struct *t)
>         struct audit_aux_data_pids *axp;
>         struct task_struct *tsk = current;
>         struct audit_context *ctx = tsk->audit_context;
> -       kuid_t uid = current_uid(), t_uid = task_uid(t);
> +       kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
>
>         if (auditd_test_task(t) &&
>             (sig == SIGTERM || sig == SIGHUP ||
>              sig == SIGUSR1 || sig == SIGUSR2)) {
>                 audit_sig_pid = task_tgid_nr(tsk);
> -               if (uid_valid(tsk->loginuid))
> -                       audit_sig_uid = tsk->loginuid;
> +               if (uid_valid(auid = audit_get_loginuid(tsk)))
> +                       audit_sig_uid = auid;
>                 else
>                         audit_sig_uid = uid;
>                 security_task_getsecid(tsk, &audit_sig_sid);

A gentle reminder that you should try to make you patches as
"checkpatch clean" as possible (see scripts/checkpatch.pl).  There are
several 80-char warnings, which aren't fatal, but the big no-no is
below:

  ERROR: do not use assignment in if condition
  #72: FILE: kernel/auditsc.c:2290:
  +               if (uid_valid(auid = audit_get_loginuid(tsk)))

... while I don't completely agree with everything checkpatch has to
say, I definitely agree with checkpatch when it comes to assignments
in if conditions.

-- 
paul moore
www.paul-moore.com
