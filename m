Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vASLN4gg010691
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:23:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3ymc8L5hxCz1pJJR
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:22:58 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3ymc8L4Dh9z1pJFM
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:22:58 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id s19so1475406ioa.1
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 13:22:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511902135.3473.5.camel@linux.vnet.ibm.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 28 Nov 2017 13:22:54 -0800
Message-ID: <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 28, 2017 at 12:48 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Hi Matthew,
>
> On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett wrote:
> > The existing BPRM_CHECK functionality in IMA validates against the
> > credentials of the existing process, not any new credentials that the
> > child process may transition to. Add an additional CREDS_CHECK target
> > and refactor IMA to pass the appropriate creds structure. In
> > ima_bprm_check(), check with both the existing process credentials and
> > the credentials that will be committed when the new process is started.
> > This will not change behaviour unless the system policy is extended to
> > include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> > credentials that it did previously.
>
> < snip >
>
> > @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >               case LSM_SUBJ_USER:
> >               case LSM_SUBJ_ROLE:
> >               case LSM_SUBJ_TYPE:
> > -                     security_task_getsecid(tsk, &sid);
> > +                     security_cred_getsecid(cred, &sid);
> >                       rc = security_filter_rule_match(sid,
> >                                                       rule->lsm[i].type,
> >                                                       Audit_equal,
>
> Based on the patch description, I wouldn't expect to see any changes
> here, unless this is wrong to begin with.  In which case, it should be
> a separate patch.

We need to check against the appropriate credentials structure, and
since we're doing this before commit_creds() has been called we can't
just do it against the one in the task structure. For BPRM_CHECK
that'll be current_cred(), which means there's no change in
functionality, whereas for CREDS_CHECK it'll be the new credentials
structure.
