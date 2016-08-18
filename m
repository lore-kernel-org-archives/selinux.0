Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7I5ubmU008387
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 01:56:37 -0400
Date: Thu, 18 Aug 2016 01:56:27 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, sgrubb@redhat.com,
 linux-audit@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] security: lsm_audit: print pid and tid
Message-ID: <20160818055627.GH1304@madcap2.tricolour.ca>
References: <1469544870-11574-1-git-send-email-jeffv@google.com>
 <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2016-08-17 16:58, Paul Moore wrote:
> On Tue, Jul 26, 2016 at 10:54 AM, Jeff Vander Stoep <jeffv@google.com> wrote:
> > dump_common_audit_data() currently contains a field for pid, but the
> > value printed is actually the thread ID, tid. Update this value to
> > return the task group ID. Add a new field for tid. With this change
> > the values printed by audit now match the values returned by the
> > getpid() and gettid() syscalls.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
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

There is some naming confusion between userspace and kernel space with
pid vs. tid vs. tgid...

> However, as far as I can see, the biggest problem with this patch is
> that it adds a field in the middle of a record which will likely cause
> the audit userspace tools to explode (or so I've been warned in the
> past).  Steve, what say you about the userspace?

Adding fields in the middle isn't necessarily a problem if it doesn't
confuse the existing scanner, which can skip over fields about which it
does not care.  I've carefully added fields in the middle in the past,
trying my best to group it logically with the rest of the information as
has been requested, I think: subject, action, object, result.

> [1] https://github.com/linux-audit/audit-testsuite
> [2] https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/field-dictionary.csv
> 
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index cccbf30..57f26c1 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -220,7 +220,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >          */
> >         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
> >
> > -       audit_log_format(ab, " pid=%d comm=", task_pid_nr(current));
> > +       audit_log_format(ab, " pid=%d tid=%d comm=", task_tgid_vnr(tsk),
> > +                       task_pid_vnr(tsk));
> >         audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
> >
> >         switch (a->type) {
> > @@ -294,10 +295,12 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> >         case LSM_AUDIT_DATA_TASK: {
> >                 struct task_struct *tsk = a->u.tsk;
> >                 if (tsk) {
> > -                       pid_t pid = task_pid_nr(tsk);
> > +                       pid_t pid = task_tgid_vnr(tsk);
> >                         if (pid) {
> >                                 char comm[sizeof(tsk->comm)];
> >                                 audit_log_format(ab, " opid=%d ocomm=", pid);
> > +                               audit_log_format(ab, " opid=%d otid=%d ocomm=",
> > +                                               pid, task_pid_vnr(tsk));
> >                                 audit_log_untrustedstring(ab,
> >                                     memcpy(comm, tsk->comm, sizeof(comm)));
> >                         }
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Kernel Security Engineering, Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635
