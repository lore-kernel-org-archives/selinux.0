Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9HJ7P0J010760
 for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2017 15:07:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HJ5kha109510
 for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2017 15:07:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnmaaj5qk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Tue, 17 Oct 2017 15:07:17 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 20:07:14 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org
Date: Tue, 17 Oct 2017 15:07:03 -0400
In-Reply-To: <20171016203709.11199-2-mjg59@google.com>
References: <20171016203709.11199-1-mjg59@google.com>
 <20171016203709.11199-2-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508267223.4513.23.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] IMA: Support using new creds in appraisal
 policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-10-16 at 13:37 -0700, Matthew Garrett wrote:

>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 95209a5f8595..c9d5735711eb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -247,10 +247,9 @@ static void ima_lsm_update_rules(void)
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> -			    enum ima_hooks func, int mask)
> +			    const struct cred *cred, enum ima_hooks func,
> +			    int mask)
>  {
> -	struct task_struct *tsk = current;
> -	const struct cred *cred = current_cred();
>  	int i;
> 
>  	if ((rule->flags & IMA_FUNC) &&
> @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			security_task_getsecid(tsk, &sid);
> +			security_cred_getsecid(cred, &sid);
>  			rc = security_filter_rule_match(sid,
>  							rule->lsm[i].type,
>  							Audit_equal,

By replacing the call from security_task_getsec() to
security_cred_getsecid(), I assume you're expecting different results.
 Will this change break existing IMA policies?

Mimi
