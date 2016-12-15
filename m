Message-ID: <1481839327.20082.14.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: clean up cred usage and simplify
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov
Date: Thu, 15 Dec 2016 17:02:07 -0500
In-Reply-To: <CAHC9VhQ_VpmLPuJOoE9OY0aawHW_=Ka_=+M3Yghao9HmjDnxMA@mail.gmail.com>
References: <1481318475-7288-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQ_VpmLPuJOoE9OY0aawHW_=Ka_=+M3Yghao9HmjDnxMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2016-12-15 at 16:10 -0500, Paul Moore wrote:
> On Fri, Dec 9, 2016 at 4:21 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > 
> > SELinux was sometimes using the task "objective" credentials when
> > it could/should use the "subjective" credentials.  This was
> > sometimes
> > hidden by the fact that we were unnecessarily passing around
> > pointers
> > to the current task, making it appear as if the task could be
> > something
> > other than current, so eliminate all such passing.  Given that
> > tasks may only alter their own credentials, we likely should move
> > the check from selinux_setprocattr() to security_setprocattr() or
> > even
> > to proc_pid_attr_write() and drop the task argument to the security
> > hook
> > altogether; it can only serve to confuse things.
> > 
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/hooks.c | 154 +++++++++++++++++++++++----------
> > --------------
> >  1 file changed, 76 insertions(+), 78 deletions(-)
> 
> No substantial objections, just some style nit picks below.
> 
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8a90a0b..3f99480 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1696,23 +1696,27 @@ static int cred_has_perm(const struct cred
> > *actor,
> >  }
> > 
> >  /*
> > - * Check permission between a pair of tasks, e.g. signal checks,
> > - * fork check, ptrace check, etc.
> > - * tsk1 is the actor and tsk2 is the target
> > - * - this uses the default subjective creds of tsk1
> > + * Check permission between a task and the current task.
> >   */
> > -static int task_has_perm(const struct task_struct *tsk1,
> > -                        const struct task_struct *tsk2,
> > -                        u32 perms)
> > +static int task_has_perm_to_current(const struct task_struct *tsk,
> > +                                   u32 perms)
> >  {
> > -       const struct task_security_struct *__tsec1, *__tsec2;
> > -       u32 sid1, sid2;
> > +       u32 ssid, tsid;
> > 
> > -       rcu_read_lock();
> > -       __tsec1 = __task_cred(tsk1)->security;  sid1 = __tsec1-
> > >sid;
> > -       __tsec2 = __task_cred(tsk2)->security;  sid2 = __tsec2-
> > >sid;
> > -       rcu_read_unlock();
> > -       return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms,
> > NULL);
> > +       ssid = task_sid(tsk);
> > +       tsid = current_sid();
> > +       return avc_has_perm(ssid, tsid, SECCLASS_PROCESS, perms,
> > NULL);
> > +}
> 
> Why not just get rid of both ssid and tsid and turn this into a one
> line function?
> 
>   avc_has_perm(task_sid(tsk), current_sid(), ...);
> 
> > 
> > +/*
> > + * Check permission between current and itself.
> > + */
> > +static int self_has_perm(u32 perms)
> > +{
> > +       u32 sid;
> > +
> > +       sid = current_sid();
> 
> Nit picky, but if you're respining the patch for the above, why not
> change this too ...
> 
>   u32 sid = current_sid();
> 
> > 
> > +       return avc_has_perm(sid, sid, SECCLASS_PROCESS, perms,
> > NULL);
> >  }
> > 
> >  /*
> > @@ -1772,13 +1776,10 @@ static int cred_has_capability(const struct
> > cred *cred,
> >         return rc;
> >  }
> > 
> > -/* Check whether a task is allowed to use a system operation. */
> > -static int task_has_system(struct task_struct *tsk,
> > -                          u32 perms)
> > +/* Check whether the current task is allowed to use a system
> > operation. */
> > +static int current_has_system(u32 perms)
> 
> We should have a little more naming consistentcy between
> current_has_system() and self_has_perm().  Something like
> current_has_process/current_has_system,
> self_has_process/self_has_system, or something else along the lines
> ... I think you get the idea.

Not sure how to improve upon it in a manner that is concise and clear.
At present, the patch splits the old task_has_perm() into
task_has_perm_to_current() vs self_has_perm() and renames
task_has_system() to current_has_system().  If I rename self_has_perm()
to current_has_process(), then it seems confusingly similar and
inconsistent with the existing current_has_perm(), which is unchanged
by this patch. If I instead rename current_has_system() to
self_has_system(), then that also seems confusing/inconsistent;
self_has_perm() indicates it is a current-self check, whereas
current_has_system() is a current-kernel:system check.  I could do that
but not sure it is an improvement.

The other option would be to inline them all since they are all quite
trivial now.
