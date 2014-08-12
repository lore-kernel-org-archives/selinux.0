Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7CJ8D8m015767
 for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2014 15:08:14 -0400
Received: by mail-qc0-f171.google.com with SMTP id r5so3183739qcx.2
 for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2014 12:08:17 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Andy Lutomirski <luto@amacapital.net>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
Date: Tue, 12 Aug 2014 15:08:14 -0400
Message-ID: <1781230.AAtiyApM3R@sifl>
In-Reply-To: <CALCETrV=MbtkRR8qk-Eu++pn3z3gZ9sEp2RUZXyhKj_-kzOEpw@mail.gmail.com>
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <53EA578A.3090907@tycho.nsa.gov>
 <CALCETrV=MbtkRR8qk-Eu++pn3z3gZ9sEp2RUZXyhKj_-kzOEpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, August 12, 2014 11:56:42 AM Andy Lutomirski wrote:
> On Aug 12, 2014 11:07 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> > On 08/12/2014 02:01 PM, Andy Lutomirski wrote:
> > > On Mon, Aug 4, 2014 at 10:36 AM, Stephen Smalley wrote:
> > >> If the callee SID is bounded by the caller SID, then allowing
> > >> the transition to occur poses no risk of privilege escalation and we
> > >> can therefore safely allow the transition to occur.  Add this exemption
> > >> for both the case where a transition was explicitly requested by the
> > >> application and the case where an automatic transition is defined in
> > >> policy.
> > > 
> > > This still wants something like security_bounded_transition_noaudit,
> > > right?  (Or just a parameter about whether to audit -- there will only
> > > be two callers, I think.)
> > 
> > I think generating an audit record is correct in this case; the
> > operation would have succeeded if the type were bounded, so it is
> > correct and helpful to report this to the audit log for diagnosing
> > failures.  I think Paul's prior objection was that you could end up with
> > an audit record even when the operation succeeded when we allowed the
> > transitions on either a bounded transition or dyntransition permission,
> > but that is no longer the case.
> 
> Fair enough.

Yes, the audit problem is no longer an issue and the comments look good to me.

> Does this have any chance of making 3.17?

No.  That ship has sailed.

However, I would still like to see some more Reviewed-by/Tested-by mails 
before we merge this for 3.18.  Andy, based on discussion on this thread and 
previous threads, I assume you're happy with this patch?

-- 
paul moore
www.paul-moore.com
