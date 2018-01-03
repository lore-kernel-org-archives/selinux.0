Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w03FsrN1029646
 for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2018 10:54:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3zBb945qgTzrL3l
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 15:54:48 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3zBb944N9JzrL3f
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 15:54:48 +0000 (UTC)
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Mimi Zohar
 <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
References: <20180103012017.7022-1-mjg59@google.com>
 <20180103012017.7022-2-mjg59@google.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cd89f3cf-b620-b098-a3db-c53f05d330bf@schaufler-ca.com>
Date: Wed, 3 Jan 2018 07:54:38 -0800
MIME-Version: 1.0
In-Reply-To: <20180103012017.7022-2-mjg59@google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH V4 2/3] IMA: Use consistent creds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/2/2018 5:20 PM, Matthew Garrett wrote:
> Right now most of the IMA code is using current->creds, but the LSM
> checks are using security_task_getsecid() which ends up looking at
> real_creds. Switch to using security_cred_getsecid() in order to make
> this consistent.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@tycho.nsa.gov
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  security/integrity/ima/ima_policy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ee4613fa5840..52951ac445ea 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -249,7 +249,6 @@ static void ima_lsm_update_rules(void)
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			    enum ima_hooks func, int mask)
>  {
> -	struct task_struct *tsk = current;
>  	const struct cred *cred = current_cred();
>  	int i;
>  
> @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			security_task_getsecid(tsk, &sid);
> +			security_cred_getsecid(cred, &sid);
>  			rc = security_filter_rule_match(sid,

security_filter_rule_match() is security_audit_rule_match() in
sheep's clothing. Using the cred secid in this case, where the
task secid is used elsewhere is going to lead to tears. It's
going to make *me* cry as I work on untangling secids for
stacking/namespaces. I can't predict how else it's going to
bite us, but I'm betting on it.

 

>  							rule->lsm[i].type,
>  							Audit_equal,
