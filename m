Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3HMFpWN003147
 for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2018 18:15:51 -0400
Date: Tue, 17 Apr 2018 18:09:47 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Message-ID: <20180417220947.vyq4dd3ah2mvwgjf@madcap2.tricolour.ca>
References: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
 <CAHC9VhQzt4-f5zYkh18NWcp0HALXNR3iB+jeGOPkxdZZx8SdLQ@mail.gmail.com>
 <CAHC9VhTJN0bR73ZUrPY8=wSHBYdrszQXaxBNUfxweuMDGevgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhTJN0bR73ZUrPY8=wSHBYdrszQXaxBNUfxweuMDGevgcA@mail.gmail.com>
Subject: Re: [PATCH ghak46 V1] audit: normalize MAC_STATUS record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2018-04-17 17:59, Paul Moore wrote:
> On Wed, Apr 11, 2018 at 5:08 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Apr 9, 2018 at 7:34 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> >> There were two formats of the audit MAC_STATUS record, one of which was more
> >> standard than the other.  One listed enforcing status changes and the
> >> other listed enabled status changes with a non-standard label.  In
> >> addition, the record was missing information about which LSM was
> >> responsible and the operation's completion status.  While this record is
> >> only issued on success, the parser expects the res= field to be present.
> >>
> >> old enforcing/permissive:
> >> type=MAC_STATUS msg=audit(1523312831.378:24514): enforcing=0 old_enforcing=1 auid=0 ses=1
> >> old enable/disable:
> >> type=MAC_STATUS msg=audit(1523312831.378:24514): selinux=0 auid=0 ses=1
> >>
> >> List both sets of status and old values and add the lsm= field and the
> >> res= field.
> >>
> >> Here is the new format:
> >> type=MAC_STATUS msg=audit(1523293828.657:891): enforcing=0 old_enforcing=1 auid=0 ses=1 enabled=1 old-enabled=1 lsm=selinux res=1
> >>
> >> This record already accompanied a SYSCALL record.
> >>
> >> See: https://github.com/linux-audit/audit-kernel/issues/46
> >> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> ---
> >>  security/selinux/selinuxfs.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> >> index 00eed84..00b21b2 100644
> >> --- a/security/selinux/selinuxfs.c
> >> +++ b/security/selinux/selinuxfs.c
> >> @@ -145,10 +145,11 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
> >>                 if (length)
> >>                         goto out;
> >>                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
> >> -                       "enforcing=%d old_enforcing=%d auid=%u ses=%u",
> >> +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> >> +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
> >>                         new_value, selinux_enforcing,
> >>                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
> >> -                       audit_get_sessionid(current));
> >> +                       audit_get_sessionid(current), selinux_enabled, selinux_enabled);
> >
> > This looks fine.
> >
> >>                 selinux_enforcing = new_value;
> >>                 if (selinux_enforcing)
> >>                         avc_ss_reset(0);
> >> @@ -272,9 +273,11 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
> >>                 if (length)
> >>                         goto out;
> >>                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
> >> -                       "selinux=0 auid=%u ses=%u",
> >> +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> >> +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
> >> +                       selinux_enforcing, selinux_enforcing,
> >>                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
> >> -                       audit_get_sessionid(current));
> >> +                       audit_get_sessionid(current), 0, 1);
> >
> > It needs to be said again that I'm opposed to changes like this:
> > inserting new fields, removing fields, or otherwise changing the
> > format in ways that aren't strictly the addition of new fields to the
> > end of a record is a Bad Thing.  However, there are exceptions (there
> > are *always* exceptions), and this seems like a reasonable change that
> > shouldn't negatively affect anyone.
> >
> > I'll merge this once the merge window comes to a close (we are going
> > to need to base selinux/next on v4.17-rc1).
> 
> Merged into selinux/next, although I should mention that there were
> some actual code changes because of the SELinux state consolidation
> patches that went into v4.17.  The changes were small but please take
> a look and make sure everything still looks okay to you.

Ok, that was a bit disruptive, but looks ok to me.

> >>         }
> >>
> >>         length = count;
> >> --
> >> 1.8.3.1
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
