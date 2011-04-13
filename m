Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3D9CrZl017167
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 05:12:53 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3D9CpJY001269
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 09:12:52 GMT
Message-ID: <4DA568E9.1020206@windriver.com>
Date: Wed, 13 Apr 2011 17:12:09 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: qingtao.cao@windriver.com
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: slawrence@tresys.com, selinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [PATCH] libsepol: support policy modules when roletrans rules
 not supported
References: <1302642701-15441-1-git-send-email-eparis@redhat.com>
In-Reply-To: <1302642701-15441-1-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

Just one minor comment, I think the variable name "new_roletr" would be
better than "new_role" in role_trans_list_write(), we are writing the
tr->classes bitmap for the new kind of role_transition rule anyway:

-	int new_role = p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS;
+	int new_roletr = p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS;


I am a newbie as for policy module compile/link/expansion process. From
my own commits now I can see the gap that the same logics to support
class in role_transition rule for the kernel policy have not been
properly applied to modules. Since we are permanently adding the classes
ebitmap to the role_trans_rule_t structure, we should always properly
set it up no matter for kernel policy or modules or the version they may
have, write it out only if the target version supports it.

I think your patch has complemented these logic for modules, thanks again!

Best regards,
Harry


Eric Paris 写道:
> Although the role trans code had support to handle the kernel policy
> when the version was less that roletrans such support was not in the
> module read/write code.  This patch adds proper support for role trans
> in modules.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libsepol/src/policydb.c |   14 ++++++++++----
>  libsepol/src/write.c    |   37 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 2ecb636..6d8ff91 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3033,7 +3033,8 @@ int avrule_read_list(policydb_t * p, avrule_t ** avrules,
>  	return 0;
>  }
>  
> -static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
> +static int role_trans_rule_read(policydb_t *p, role_trans_rule_t ** r,
> +				struct policy_file *fp)
>  {
>  	uint32_t buf[1], nel;
>  	unsigned int i;
> @@ -3064,8 +3065,13 @@ static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
>  		if (type_set_read(&tr->types, fp))
>  			return -1;
>  
> -		if (ebitmap_read(&tr->classes, fp))
> -			return -1;
> +		if (p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS) {
> +			if (ebitmap_read(&tr->classes, fp))
> +				return -1;
> +		} else {
> +			if (ebitmap_set_bit(&tr->classes, SECCLASS_PROCESS - 1, 1))
> +				return -1;
> +		}
>  
>  		rc = next_entry(buf, fp, sizeof(uint32_t));
>  		if (rc < 0)
> @@ -3258,7 +3264,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
>  	decl->enabled = le32_to_cpu(buf[1]);
>  	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
>  	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
> -	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
> +	    role_trans_rule_read(p, &decl->role_tr_rules, fp) == -1 ||
>  	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
>  		return -1;
>  	}
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index c4f5035..78b3aa6 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1482,26 +1482,53 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
>  	return POLICYDB_SUCCESS;
>  }
>  
> -static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
> +static int only_process(ebitmap_t *in)
> +{
> +	unsigned int i;
> +	ebitmap_node_t *node;
> +
> +	ebitmap_for_each_bit(in, node, i) {
> +		if (ebitmap_node_get_bit(node, i) &&
> +		    i != SECCLASS_PROCESS - 1)
> +			return 0;
> +	}
> +	return 1;
> +}
> +
> +static int role_trans_rule_write(policydb_t *p, role_trans_rule_t * t,
> +				 struct policy_file *fp)
>  {
>  	int nel = 0;
>  	size_t items;
>  	uint32_t buf[1];
>  	role_trans_rule_t *tr;
> +	int warned = 0;
> +	int new_role = p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS;
>  
>  	for (tr = t; tr; tr = tr->next)
> -		nel++;
> +		if (new_role || only_process(&tr->classes))
> +			nel++;
> +
>  	buf[0] = cpu_to_le32(nel);
>  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
>  	if (items != 1)
>  		return POLICYDB_ERROR;
>  	for (tr = t; tr; tr = tr->next) {
> +		if (!new_role && !only_process(&tr->classes)) {
> +			if (!warned)
> +				WARN(fp->handle, "Discarding role_transition "
> +					"rules for security classes other than "
> +					"\"process\"");
> +			warned = 1;
> +			continue;
> +		}
>  		if (role_set_write(&tr->roles, fp))
>  			return POLICYDB_ERROR;
>  		if (type_set_write(&tr->types, fp))
>  			return POLICYDB_ERROR;
> -		if (ebitmap_write(&tr->classes, fp))
> -			return POLICYDB_ERROR;
> +		if (new_role)
> +			if (ebitmap_write(&tr->classes, fp))
> +				return POLICYDB_ERROR;
>  		buf[0] = cpu_to_le32(tr->new_role);
>  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
>  		if (items != 1)
> @@ -1636,7 +1663,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
>  	}
>  	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
>  	    avrule_write_list(decl->avrules, fp) == -1 ||
> -	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
> +	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
>  	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
>  		return POLICYDB_ERROR;
>  	}
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
