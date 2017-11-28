Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vASMXo0O031103
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 17:33:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3ymdjZ3NsWz19Z1w
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 22:33:22 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3ymdjZ2ggRz19Z1g
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 22:33:22 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASMWSrK075580
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 17:33:19 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehcpya4cb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 17:33:19 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 22:33:17 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 28 Nov 2017 17:33:10 -0500
In-Reply-To: <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com>
 <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com>
 <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511908390.3473.30.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
> On Tue, Nov 28, 2017 at 1:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2017-11-28 at 13:22 -0800, Matthew Garrett wrote:
> >> We need to check against the appropriate credentials structure, and
> >> since we're doing this before commit_creds() has been called we can't
> >> just do it against the one in the task structure.  For BPRM_CHECK
> >> that'll be current_cred(), which means there's no change in
> >> functionality, whereas for CREDS_CHECK it'll be the new credentials
> >> structure.
> >
> > The existing code calls security_task_getsecid() with "current" not
> > "current_cred".  Will replacing security_task_getsecid() with
> > security_cred_getsecid() return the same info for the original
> > BRPM_CHECK?
> 
> security_task_getsecid(current) will give the same results as
> security_cred_getsecid(current_creds())

Unwinding security_task_getsecid(current) looks like it is using
real_cred, while current_cred() is using cred.

selinux_task_getsecid() -> task_sid() -> cred_sid(__task_cred())

#define __task_cred(task)       \
        rcu_dereference((task)->real_cred)

selinux_task_getsecid() -> cred_sid()

#define current_cred() \
        rcu_dereference_protected(current->cred, 1)

Is the change intentional?

Mimi
