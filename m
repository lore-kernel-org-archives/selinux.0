Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UF4N6k006161
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 11:04:23 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 linux-audit@redhat.com
Subject: Re: [PATCH] security: lsm_audit: print pid and tid
Date: Tue, 30 Aug 2016 11:03:53 -0400
Message-ID: <1761452.xxMEsoZRlS@x2>
In-Reply-To: <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
References: <1469544870-11574-1-git-send-email-jeffv@google.com>
 <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, August 17, 2016 4:58:02 PM EDT Paul Moore wrote:
> On Tue, Jul 26, 2016 at 10:54 AM, Jeff Vander Stoep <jeffv@google.com> wrote:
> > dump_common_audit_data() currently contains a field for pid, but the
> > value printed is actually the thread ID, tid. Update this value to
> > return the task group ID. Add a new field for tid. With this change
> > the values printed by audit now match the values returned by the
> > getpid() and gettid() syscalls.
> > 
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> > 
> >  security/lsm_audit.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Hi Jeff,
> 
> Have you tested this against the audit-testsuite[1]?  We don't have an
> explicit PID test yet, but at least two of the tests do test it as a
> side effect.
> 
> Steve, I don't see the thread ID listed in the field dictionary, are
> you okay with using "tid" for this?

Yes. Can someone add both?

> However, as far as I can see, the biggest problem with this patch is
> that it adds a field in the middle of a record which will likely cause
> the audit userspace tools to explode (or so I've been warned in the
> past).  Steve, what say you about the userspace?

This is OK. After picking out pid, search utiliies scan for comm. They will 
just skip over the new field. If fields that we normally search change order, 
then we have a problem.

So, ACK on my end.

-Steve

> [1] https://github.com/linux-audit/audit-testsuite
> [2]
> https://github.com/linux-audit/audit-documentation/blob/master/specs/fields
> /field-dictionary.csv
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index cccbf30..57f26c1 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -220,7 +220,8 @@ static void dump_common_audit_data(struct audit_buffer
> > *ab,> 
> >          */
> >         
> >         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
> > 
> > -       audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
> > +       audit_log_format(ab, " pid=%d tid=%d comm=", task_tgid_vnr(tsk),
> > +                       task_pid_vnr(tsk));
> > 
> >         audit_log_untrustedstring(ab, memcpy(comm, current->comm,
> >         sizeof(comm)));
> >         
> >         switch (a->type) {
> > 
> > @@ -294,10 +295,12 @@ static void dump_common_audit_data(struct
> > audit_buffer *ab,> 
> >         case LSM_AUDIT_DATA_TASK: {
> >         
> >                 struct task_struct *tsk = a->u.tsk;
> >                 if (tsk) {
> > 
> > -                       pid_t pid = task_pid_nr(tsk);
> > +                       pid_t pid = task_tgid_vnr(tsk);
> > 
> >                         if (pid) {
> >                         
> >                                 char comm[sizeof(tsk->comm)];
> >                                 audit_log_format(ab, " opid=%d ocomm=",
> >                                 pid);
> > 
> > +                               audit_log_format(ab, " opid=%d otid=%d
> > ocomm=", +                                               pid,
> > task_pid_vnr(tsk));> 
> >                                 audit_log_untrustedstring(ab,
> >                                 
> >                                     memcpy(comm, tsk->comm,
> >                                     sizeof(comm)));
> >                         
> >                         }
