Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vASLZd4X026506
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:35:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 3ymcQz1v3qz2VpLc
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:35:39 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 3ymcQz17H5z2VpLW
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 21:35:39 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASLYHRp043380
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:35:36 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ehfbyhcyv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:35:35 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 21:35:22 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 28 Nov 2017 16:35:17 -0500
In-Reply-To: <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
 <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511904917.3473.15.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-11-28 at 13:22 -0800, Matthew Garrett wrote:
> On Tue, Nov 28, 2017 at 12:48 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Hi Matthew,
> >
> > On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett wrote:
> > > The existing BPRM_CHECK functionality in IMA validates against the
> > > credentials of the existing process, not any new credentials that the
> > > child process may transition to. Add an additional CREDS_CHECK target
> > > and refactor IMA to pass the appropriate creds structure. In
> > > ima_bprm_check(), check with both the existing process credentials and
> > > the credentials that will be committed when the new process is started.
> > > This will not change behaviour unless the system policy is extended to
> > > include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> > > credentials that it did previously.
> >
> > < snip >
> >
> > > @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> > >               case LSM_SUBJ_USER:
> > >               case LSM_SUBJ_ROLE:
> > >               case LSM_SUBJ_TYPE:
> > > -                     security_task_getsecid(tsk, &sid);
> > > +                     security_cred_getsecid(cred, &sid);
> > >                       rc = security_filter_rule_match(sid,
> > >                                                       rule->lsm[i].type,
> > >                                                       Audit_equal,
> >
> > Based on the patch description, I wouldn't expect to see any changes
> > here, unless this is wrong to begin with.  In which case, it should be
> > a separate patch.
> 
> We need to check against the appropriate credentials structure, and
> since we're doing this before commit_creds() has been called we can't
> just do it against the one in the task structure.  For BPRM_CHECK
> that'll be current_cred(), which means there's no change in
> functionality, whereas for CREDS_CHECK it'll be the new credentials
> structure.

The existing code calls security_task_getsecid() with "current" not
"current_cred".  Will replacing security_task_getsecid() with
security_cred_getsecid() return the same info for the original
BRPM_CHECK?

Mimi
