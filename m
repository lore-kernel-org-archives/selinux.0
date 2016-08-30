Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UKuYJv014950
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 16:56:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id s207so2868540oie.0
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 13:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469544870-11574-1-git-send-email-jeffv@google.com>
References: <1469544870-11574-1-git-send-email-jeffv@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Aug 2016 16:56:31 -0400
Message-ID: <CAHC9VhSDrLzTMG5wSVVAY5RKcWaKBnei1+twneOG1ss8av+cYw@mail.gmail.com>
Subject: Re: [PATCH] security: lsm_audit: print pid and tid
To: Jeff Vander Stoep <jeffv@google.com>
Cc: selinux@tycho.nsa.gov, linux-audit@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 26, 2016 at 10:54 AM, Jeff Vander Stoep <jeffv@google.com> wrote:
> dump_common_audit_data() currently contains a field for pid, but the
> value printed is actually the thread ID, tid. Update this value to
> return the task group ID. Add a new field for tid. With this change
> the values printed by audit now match the values returned by the
> getpid() and gettid() syscalls.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  security/lsm_audit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Unfortunately while reviewing this code I realized that the problem
extends far beyond just lsm_audit.c, kernel/audit*.c is affected as
well.  It's actually much worse in kernel/audit*.c as it is very
inconsistent.

I was going to ask you to fix the other code too while you were at it,
but I realized what it was easy enough to fix it while I was going
through the code anyway ... expect a patch shortly.

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index cccbf30..57f26c1 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -220,7 +220,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>          */
>         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
>
> -       audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
> +       audit_log_format(ab, " pid=%d tid=%d comm=", task_tgid_vnr(tsk),
> +                       task_pid_vnr(tsk));
>         audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
>
>         switch (a->type) {
> @@ -294,10 +295,12 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_TASK: {
>                 struct task_struct *tsk = a->u.tsk;
>                 if (tsk) {
> -                       pid_t pid = task_pid_nr(tsk);
> +                       pid_t pid = task_tgid_vnr(tsk);
>                         if (pid) {
>                                 char comm[sizeof(tsk->comm)];
>                                 audit_log_format(ab, " opid=%d ocomm=", pid);
> +                               audit_log_format(ab, " opid=%d otid=%d ocomm=",
> +                                               pid, task_pid_vnr(tsk));
>                                 audit_log_untrustedstring(ab,
>                                     memcpy(comm, tsk->comm, sizeof(comm)));
>                         }
> --
> 2.8.0.rc3.226.g39d4020

-- 
paul moore
www.paul-moore.com
