Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9ILScJc024108
 for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2017 17:28:38 -0400
Received: by mail-io0-f172.google.com with SMTP id h70so7700134ioi.4
 for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2017 13:59:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508267223.4513.23.camel@linux.vnet.ibm.com>
References: <20171016203709.11199-1-mjg59@google.com>
 <20171016203709.11199-2-mjg59@google.com>
 <1508267223.4513.23.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 13:59:53 -0700
Message-ID: <CACdnJutiK+NyD1gAT-muf74zjt7H8gqm3-xqWJYrDCQm8TPz0g@mail.gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] IMA: Support using new creds in appraisal
 policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 17, 2017 at 12:07 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-10-16 at 13:37 -0700, Matthew Garrett wrote:
>>               case LSM_SUBJ_TYPE:
>> -                     security_task_getsecid(tsk, &sid);
>> +                     security_cred_getsecid(cred, &sid);
>>                       rc = security_filter_rule_match(sid,
>>                                                       rule->lsm[i].type,
>>                                                       Audit_equal,
>
> By replacing the call from security_task_getsec() to
> security_cred_getsecid(), I assume you're expecting different results.
>  Will this change break existing IMA policies?

No, for BPRM_CHECK they'll use the same creds that were previously
checked. CREDS_CHECK will behave differently to BPRM_CHECK.
