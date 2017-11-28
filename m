Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vASLF0pK000748
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:15:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASLDtc7098624
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:14:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehag0xpj9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 16:14:46 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 21:14:44 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 28 Nov 2017 15:48:55 -0500
In-Reply-To: <20171026084055.25482-2-mjg59@google.com>
References: <20171026084055.25482-1-mjg59@google.com>
 <20171026084055.25482-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511902135.3473.5.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Matthew,

On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett wrote:
> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is started.
> This will not change behaviour unless the system policy is extended to
> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> credentials that it did previously.

< snip >

> @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			security_task_getsecid(tsk, &sid);
> +			security_cred_getsecid(cred, &sid);
>  			rc = security_filter_rule_match(sid,
>  							rule->lsm[i].type,
>  							Audit_equal,

Based on the patch description, I wouldn't expect to see any changes
here, unless this is wrong to begin with.  In which case, it should be
a separate patch.

Mimi
