Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FHpmBk000872
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 13:51:48 -0400
Received: by mail-yw0-f171.google.com with SMTP id w127so109207560ywf.3
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 10:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
From: Nick Kralevich <nnk@google.com>
Date: Fri, 15 Jul 2016 10:51:18 -0700
Message-ID: <CAFJ0LnEBDjZyHb1cBr6Wck9c_z1ATcfnmWtOTYBS2F0TEK5_vA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2 v2] proc: Relax /proc/<tid>/timerslack_ns
 capability requirements
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Dmitry Shmidt <dimitrysh@google.com>,
 Elliott Hughes <enh@google.com>,
 Android Kernel Team <kernel-team@android.com>,
 linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, Jul 15, 2016 at 10:24 AM, John Stultz <john.stultz@linaro.org> wrote:
> When an interface to allow a task to change another tasks
> timerslack was first proposed, it was suggested that something
> greater then CAP_SYS_NICE would be needed, as a task could be
> delayed further then what normally could be done with nice
> adjustments.
>
> So CAP_SYS_PTRACE was adopted instead for what became the
> /proc/<tid>/timerslack_ns interface. However, for Android (where
> this feature originates), giving the system_server
> CAP_SYS_PTRACE would allow it to observe and modify all tasks
> memory. This is considered too high a privilege level for only
> needing to change the timerslack.
>
> After some discussion, it was realized that a CAP_SYS_NICE
> process can set a task as SCHED_FIFO, so they could fork some
> spinning processes and set them all SCHED_FIFO 99, in effect
> delaying all other tasks for an infinite amount of time.
>
> So as a CAP_SYS_NICE task can already cause trouble for other
> tasks, using it as a required capability for accessing and
> modifying /proc/<tid>/timerslack_ns seems sufficient.
>
> Thus, this patch loosens the capability requirements to
> CAP_SYS_NICE and removes CAP_SYS_PTRACE, simplifying some
> of the code flow as well.
>
> This is technically an ABI change, but as the feature just
> landed in 4.6, I suspect no one is yet using it.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Oren Laadan <orenl@cellrox.com>
> Cc: Ruchi Kandoi <kandoiruchi@google.com>
> Cc: Rom Lemarchand <romlem@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Nick Kralevich <nnk@google.com>
> Cc: Dmitry Shmidt <dimitrysh@google.com>
> Cc: Elliott Hughes <enh@google.com>
> Cc: Android Kernel Team <kernel-team@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Removed CAP_SYS_PTRACE check and simplified code flow
>
>  fs/proc/base.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index a11eb71..8f4f8d7 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2277,19 +2277,19 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>         if (err < 0)
>                 return err;
>
> +       if (!capable(CAP_SYS_NICE))
> +               return -EPERM;
> +

Since you're going the LSM route (from your second patch of this
series), the capability check above should be moved to the LSM hook in
security/commoncap.c.  Only one security call to
security_task_settimerslack is needed, which will cover the standard
capabilities check as well as the SELinux check.

>         p = get_proc_task(inode);
>         if (!p)
>                 return -ESRCH;
>

Per your patch #2, you'd call security_task_settimerslack here. This
would call into the capability LSM hook you added in
security/commoncap.c

> -       if (ptrace_may_access(p, PTRACE_MODE_ATTACH_FSCREDS)) {
> -               task_lock(p);
> -               if (slack_ns == 0)
> -                       p->timer_slack_ns = p->default_timer_slack_ns;
> -               else
> -                       p->timer_slack_ns = slack_ns;
> -               task_unlock(p);
> -       } else
> -               count = -EPERM;
> +       task_lock(p);
> +       if (slack_ns == 0)
> +               p->timer_slack_ns = p->default_timer_slack_ns;
> +       else
> +               p->timer_slack_ns = slack_ns;
> +       task_unlock(p);
>
>         put_task_struct(p);
>
> @@ -2300,22 +2300,21 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>  {
>         struct inode *inode = m->private;
>         struct task_struct *p;
> -       int err =  0;
> +
> +       if (!capable(CAP_SYS_NICE))
> +               return -EPERM;
>
>         p = get_proc_task(inode);
>         if (!p)
>                 return -ESRCH;
>
> -       if (ptrace_may_access(p, PTRACE_MODE_ATTACH_FSCREDS)) {
> -               task_lock(p);
> -               seq_printf(m, "%llu\n", p->timer_slack_ns);
> -               task_unlock(p);
> -       } else
> -               err = -EPERM;
> +       task_lock(p);
> +       seq_printf(m, "%llu\n", p->timer_slack_ns);
> +       task_unlock(p);
>
>         put_task_struct(p);
>
> -       return err;
> +       return 0;
>  }
>
>  static int timerslack_ns_open(struct inode *inode, struct file *filp)
> --
> 1.9.1
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
