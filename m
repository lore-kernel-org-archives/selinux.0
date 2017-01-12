Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0CGoG80023660
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 11:50:17 -0500
Subject: Re: [PATCH] security,selinux,smack: kill security_task_wait hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
References: <1484069312-26653-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhSbwTsR0QhGA8+JGX1EQ+Z73S-iD1Ys-XjQjh3jbvVtxA@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, yangshukui@huawei.com, oleg@redhat.com,
 linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a8eb15b3-cef1-8b55-e757-102f4ccd04fc@schaufler-ca.com>
Date: Thu, 12 Jan 2017 08:49:59 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSbwTsR0QhGA8+JGX1EQ+Z73S-iD1Ys-XjQjh3jbvVtxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/12/2017 8:03 AM, Paul Moore wrote:
> On Tue, Jan 10, 2017 at 12:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> As reported by yangshukui, a permission denial from security_task_wait()
>> can lead to a soft lockup in zap_pid_ns_processes() since it only expects
>> sys_wait4() to return 0 or -ECHILD. Further, security_task_wait() can
>> in general lead to zombies; in the absence of some way to automatically
>> reparent a child process upon a denial, the hook is not useful.  Remove
>> the security hook and its implementations in SELinux and Smack.  Smack
>> already removed its check from its hook.
>>
>> Reported-by: yangshukui <yangshukui@huawei.com>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

In case you miss my earlier Ack.

>> ---
>>  include/linux/lsm_hooks.h  |  7 -------
>>  include/linux/security.h   |  6 ------
>>  kernel/exit.c              | 19 ++-----------------
>>  security/security.c        |  6 ------
>>  security/selinux/hooks.c   |  7 -------
>>  security/smack/smack_lsm.c | 20 --------------------
>>  6 files changed, 2 insertions(+), 63 deletions(-)
> Looks good to me and I'm not seeing any objections so I'll go ahead
> and merge this into the selinux/next branch today unless Casey already
> merged this into the Smack tree - Casey?

Please go ahead and merge into the SELinux tree.
It makes sense to do this atomically.
Thank you.

>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 0dde959..6fe7a5c 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -666,11 +666,6 @@
>>   *     @sig contains the signal value.
>>   *     @secid contains the sid of the process where the signal originated
>>   *     Return 0 if permission is granted.
>> - * @task_wait:
>> - *     Check permission before allowing a process to reap a child process @p
>> - *     and collect its status information.
>> - *     @p contains the task_struct for process.
>> - *     Return 0 if permission is granted.
>>   * @task_prctl:
>>   *     Check permission before performing a process control operation on the
>>   *     current process.
>> @@ -1507,7 +1502,6 @@ union security_list_options {
>>         int (*task_movememory)(struct task_struct *p);
>>         int (*task_kill)(struct task_struct *p, struct siginfo *info,
>>                                 int sig, u32 secid);
>> -       int (*task_wait)(struct task_struct *p);
>>         int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
>>                                 unsigned long arg4, unsigned long arg5);
>>         void (*task_to_inode)(struct task_struct *p, struct inode *inode);
>> @@ -1767,7 +1761,6 @@ struct security_hook_heads {
>>         struct list_head task_getscheduler;
>>         struct list_head task_movememory;
>>         struct list_head task_kill;
>> -       struct list_head task_wait;
>>         struct list_head task_prctl;
>>         struct list_head task_to_inode;
>>         struct list_head ipc_permission;
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index f4ebac1..d3868f2 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -332,7 +332,6 @@ int security_task_getscheduler(struct task_struct *p);
>>  int security_task_movememory(struct task_struct *p);
>>  int security_task_kill(struct task_struct *p, struct siginfo *info,
>>                         int sig, u32 secid);
>> -int security_task_wait(struct task_struct *p);
>>  int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>                         unsigned long arg4, unsigned long arg5);
>>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>> @@ -980,11 +979,6 @@ static inline int security_task_kill(struct task_struct *p,
>>         return 0;
>>  }
>>
>> -static inline int security_task_wait(struct task_struct *p)
>> -{
>> -       return 0;
>> -}
>> -
>>  static inline int security_task_prctl(int option, unsigned long arg2,
>>                                       unsigned long arg3,
>>                                       unsigned long arg4,
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 8f14b86..60f2451 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/tty.h>
>>  #include <linux/iocontext.h>
>>  #include <linux/key.h>
>> -#include <linux/security.h>
>>  #include <linux/cpu.h>
>>  #include <linux/acct.h>
>>  #include <linux/tsacct_kern.h>
>> @@ -1360,7 +1359,7 @@ static int wait_task_continued(struct wait_opts *wo, struct task_struct *p)
>>   * Returns nonzero for a final return, when we have unlocked tasklist_lock.
>>   * Returns zero if the search for a child should continue;
>>   * then ->notask_error is 0 if @p is an eligible child,
>> - * or another error from security_task_wait(), or still -ECHILD.
>> + * or still -ECHILD.
>>   */
>>  static int wait_consider_task(struct wait_opts *wo, int ptrace,
>>                                 struct task_struct *p)
>> @@ -1380,20 +1379,6 @@ static int wait_consider_task(struct wait_opts *wo, int ptrace,
>>         if (!ret)
>>                 return ret;
>>
>> -       ret = security_task_wait(p);
>> -       if (unlikely(ret < 0)) {
>> -               /*
>> -                * If we have not yet seen any eligible child,
>> -                * then let this error code replace -ECHILD.
>> -                * A permission error will give the user a clue
>> -                * to look for security policy problems, rather
>> -                * than for mysterious wait bugs.
>> -                */
>> -               if (wo->notask_error)
>> -                       wo->notask_error = ret;
>> -               return 0;
>> -       }
>> -
>>         if (unlikely(exit_state == EXIT_TRACE)) {
>>                 /*
>>                  * ptrace == 0 means we are the natural parent. In this case
>> @@ -1486,7 +1471,7 @@ static int wait_consider_task(struct wait_opts *wo, int ptrace,
>>   * Returns nonzero for a final return, when we have unlocked tasklist_lock.
>>   * Returns zero if the search for a child should continue; then
>>   * ->notask_error is 0 if there were any eligible children,
>> - * or another error from security_task_wait(), or still -ECHILD.
>> + * or still -ECHILD.
>>   */
>>  static int do_wait_thread(struct wait_opts *wo, struct task_struct *tsk)
>>  {
>> diff --git a/security/security.c b/security/security.c
>> index 32052f5..8c9fee5 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1025,11 +1025,6 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
>>         return call_int_hook(task_kill, 0, p, info, sig, secid);
>>  }
>>
>> -int security_task_wait(struct task_struct *p)
>> -{
>> -       return call_int_hook(task_wait, 0, p);
>> -}
>> -
>>  int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>                          unsigned long arg4, unsigned long arg5)
>>  {
>> @@ -1769,7 +1764,6 @@ struct security_hook_heads security_hook_heads = {
>>         .task_movememory =
>>                 LIST_HEAD_INIT(security_hook_heads.task_movememory),
>>         .task_kill =    LIST_HEAD_INIT(security_hook_heads.task_kill),
>> -       .task_wait =    LIST_HEAD_INIT(security_hook_heads.task_wait),
>>         .task_prctl =   LIST_HEAD_INIT(security_hook_heads.task_prctl),
>>         .task_to_inode =
>>                 LIST_HEAD_INIT(security_hook_heads.task_to_inode),
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index bada3cd..720dbd0 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3969,12 +3969,6 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
>>         return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
>>  }
>>
>> -static int selinux_task_wait(struct task_struct *p)
>> -{
>> -       return avc_has_perm(task_sid(p), current_sid(), SECCLASS_PROCESS,
>> -                           PROCESS__SIGCHLD, NULL);
>> -}
>> -
>>  static void selinux_task_to_inode(struct task_struct *p,
>>                                   struct inode *inode)
>>  {
>> @@ -6217,7 +6211,6 @@ static struct security_hook_list selinux_hooks[] = {
>>         LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
>>         LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
>>         LSM_HOOK_INIT(task_kill, selinux_task_kill),
>> -       LSM_HOOK_INIT(task_wait, selinux_task_wait),
>>         LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
>>
>>         LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 8da4a6b..2166373 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -2272,25 +2272,6 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
>>  }
>>
>>  /**
>> - * smack_task_wait - Smack access check for waiting
>> - * @p: task to wait for
>> - *
>> - * Returns 0
>> - */
>> -static int smack_task_wait(struct task_struct *p)
>> -{
>> -       /*
>> -        * Allow the operation to succeed.
>> -        * Zombies are bad.
>> -        * In userless environments (e.g. phones) programs
>> -        * get marked with SMACK64EXEC and even if the parent
>> -        * and child shouldn't be talking the parent still
>> -        * may expect to know when the child exits.
>> -        */
>> -       return 0;
>> -}
>> -
>> -/**
>>   * smack_task_to_inode - copy task smack into the inode blob
>>   * @p: task to copy from
>>   * @inode: inode to copy to
>> @@ -4658,7 +4639,6 @@ static struct security_hook_list smack_hooks[] = {
>>         LSM_HOOK_INIT(task_getscheduler, smack_task_getscheduler),
>>         LSM_HOOK_INIT(task_movememory, smack_task_movememory),
>>         LSM_HOOK_INIT(task_kill, smack_task_kill),
>> -       LSM_HOOK_INIT(task_wait, smack_task_wait),
>>         LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
>>
>>         LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
>> --
>> 2.7.4
>>
>
>
