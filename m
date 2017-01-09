Message-ID: <1483987383.20858.84.camel@tycho.nsa.gov>
Subject: Re: SELinux lead to soft lockup when pid 1 proceess reap child
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Oleg Nesterov <oleg@redhat.com>, yangshukui <yangshukui@huawei.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
 "'Qiang Huang'" <h.huangqiang@huawei.com>, Lizefan
 <lizefan@huawei.com>, "miaoxie (A)" <miaoxie@huawei.com>, Zhangdianfang
 <zhangdianfang@huawei.com>, paul@paul-moore.com,
 eparis@parisplace.org, james.l.morris@oracle.com,
 ebiederm@xmission.com, serge.hallyn@ubuntu.com
Date: Mon, 09 Jan 2017 13:43:03 -0500
In-Reply-To: <20170109182915.GC8972@redhat.com>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
 <58736B2E.90201@huawei.com> <20170109181225.GB8972@redhat.com>
 <20170109182915.GC8972@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-01-09 at 19:29 +0100, Oleg Nesterov wrote:
> Seriously, could someone explain why do we need the
> security_task_wait()
> hook at all?

I would be ok with killing it.
IIRC, the original motivation was to block an unauthorized data flow
from child to parent when the child context differs, but part of that
original design was also to reparent the child automatically, and that
was never implemented.  I don't think there is a real use case for it
in practice and it just breaks things, so let's get rid of it unless
someone objects.

> 
> 
> On 01/09, Oleg Nesterov wrote:
> > 
> > 
> > On 01/09, yangshukui wrote:
> > > 
> > > 
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3596,6 +3596,9 @@ static int selinux_task_kill(struct
> > > task_struct *p,
> > > struct siginfo *info,
> > > 
> > >  static int selinux_task_wait(struct task_struct *p)
> > >  {
> > > +       if (pid_vnr(task_tgid(current)) == 1){
> > > +                return 0;
> > 
> > this check is not really correct, it can be a sub-thread... Doesn't
> > matter,
> > please see below.
> > 
> > > 
> > > +       }
> > >         return task_has_perm(p, current, PROCESS__SIGCHLD);
> > >  }
> > > It work but it permit pid 1 process to reap child without selinux
> > > check. Can
> > > we have a better way to handle this problem?
> > 
> > I never understood why security_task_wait() should deny to reap a
> > child. But
> > since it can we probably want some explicit "the whole namespace
> > goes away" check.
> > We could use, say, PIDNS_HASH_ADDING but I'd suggest something like
> > a trivial change
> > below for now.
> > 
> > Eric, what do you think?
> > 
> > Oleg.
> > 
> > diff --git a/security/security.c b/security/security.c
> > index f825304..1330b4e 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1027,6 +1027,9 @@ int security_task_kill(struct task_struct *p,
> > struct siginfo *info,
> >  
> >  int security_task_wait(struct task_struct *p)
> >  {
> > +	/* must be the exiting child reaper */
> > +	if (unlikely(current->flags & PF_EXITING))
> > +		return 0;
> >  	return call_int_hook(task_wait, 0, p);
> >  }
> >  
