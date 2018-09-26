Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QMPEmc013980
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 18:25:14 -0400
From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: Jann Horn <jannh@google.com>
CC: Kernel Hardening <kernel-hardening@lists.openwall.com>, kernel list
 <linux-kernel@vger.kernel.org>, linux-security-module
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "Hansen, Dave" <dave.hansen@intel.com>, "Dock,
 Deneen T" <deneen.t.dock@intel.com>, "kristen@linux.intel.com"
 <kristen@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>
Date: Wed, 26 Sep 2018 22:24:34 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732146256E@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-5-casey.schaufler@intel.com>
 <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
In-Reply-To: <CAG48ez1NqoW8bByrYe30MdyCn2th3X+tth=VhMHA2MA-PoaQVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RE: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: Jann Horn [mailto:jannh@google.com]
> Sent: Wednesday, September 26, 2018 2:26 PM
> To: Schaufler, Casey <casey.schaufler@intel.com>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> Subject: Re: [PATCH v5 4/5] Capability: Complete PTRACE_MODE_SCHED
> 
> On Wed, Sep 26, 2018 at 10:35 PM Casey Schaufler
> <casey.schaufler@intel.com> wrote:
> > Allow a complete ptrace access check with mode PTRACE_MODE_SCHED.
> > Disable the inappropriate privilege check in the capability code
> > that does incompatible locking.
> 
> What's that locking you're talking about?

ns_capable() eventually gets you to an audit call. The audit code
is going to do the locking. Fortunately, the preceding cap_issubset()
is the check that we really need here.

> 
> > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > ---
> >  kernel/ptrace.c      | 2 --
> >  security/commoncap.c | 2 ++
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 99cfddde6a55..0b6a9df51c3b 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -331,8 +331,6 @@ static int __ptrace_may_access(struct task_struct
> *task, unsigned int mode)
> >              !ptrace_has_cap(mm->user_ns, mode)))
> >             return -EPERM;
> >
> > -       if (mode & PTRACE_MODE_SCHED)
> > -               return 0;
> >         return security_ptrace_access_check(task, mode);
> >  }
> >
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 2e489d6a3ac8..e77457110d05 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -152,6 +152,8 @@ int cap_ptrace_access_check(struct task_struct
> *child, unsigned int mode)
> >         if (cred->user_ns == child_cred->user_ns &&
> >             cap_issubset(child_cred->cap_permitted, *caller_caps))
> >                 goto out;
> > +       if (mode & PTRACE_MODE_SCHED)
> > +               goto out;
> 
> So for PTRACE_MODE_SCHED, this function always returns 0, right? 

That can't be right, can it? Determining that we have PTRACE_MODE_SCHED
at this point should result in -EPERM. I mucked up on the logic flow. The
next revision will fix this.

> If that's intentional, perhaps you should instead just put "if (mode &
> PTRACE_MODE_SCHED) return 0;" at the start of the function, to avoid
> taking the RCU read lock in this case.
> 
> >         if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
> >                 goto out;
> >         ret = -EPERM;
