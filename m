Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3DI7MQG013415
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 14:07:22 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3DI7KiC008195
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2011 18:07:21 GMT
Subject: Re: [PATCH] libsepol: support policy modules when roletrans rules
 not supported
From: Eric Paris <eparis@redhat.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "qingtao.cao@windriver.com" <qingtao.cao@windriver.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>
In-Reply-To: <4DA5DEDB.9020005@tresys.com>
References: <1302642701-15441-1-git-send-email-eparis@redhat.com>
	 <4DA5BFF0.2090209@tresys.com>  <4DA5DEDB.9020005@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Apr 2011 14:07:14 -0400
Message-ID: <1302718034.8639.4.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-04-13 at 13:35 -0400, Steve Lawrence wrote:
> On 04/13/2011 11:23 AM, Steve Lawrence wrote:
> > Thanks for the patch. This solves the problem, but I'm still seeing
> > issues that seems related to support of older version of policy when
> > using role_transition with non-process classes. I'm now seeing an mls
> > range overflow error:
> > 
> > libsepol.role_trans_write: Discarding role_transition rules for security
> > class other than "process"
> > libsepol.mls_read_range_helper: range overflow
> > libsepol.context_read_and_validate: error reading MLS range of context
> > libsepol.policydb_to_image: new policy image is invalid
> > 
> > I'm still looking into it, but I'm not too familiar this part of the code.
> > 
> > 
> > On 04/12/2011 05:11 PM, Eric Paris wrote:
> >> Although the role trans code had support to handle the kernel policy
> >> when the version was less that roletrans such support was not in the
> >> module read/write code.  This patch adds proper support for role trans
> >> in modules.
> >>
> >> Signed-off-by: Eric Paris <eparis@redhat.com>
> >> ---
> >>  libsepol/src/policydb.c |   14 ++++++++++----
> >>  libsepol/src/write.c    |   37 ++++++++++++++++++++++++++++++++-----
> >>  2 files changed, 42 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> >> index 2ecb636..6d8ff91 100644
> >> --- a/libsepol/src/policydb.c
> >> +++ b/libsepol/src/policydb.c
> >> @@ -3033,7 +3033,8 @@ int avrule_read_list(policydb_t * p, avrule_t ** avrules,
> >>  	return 0;
> >>  }
> >>  
> >> -static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
> >> +static int role_trans_rule_read(policydb_t *p, role_trans_rule_t ** r,
> >> +				struct policy_file *fp)
> >>  {
> >>  	uint32_t buf[1], nel;
> >>  	unsigned int i;
> >> @@ -3064,8 +3065,13 @@ static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
> >>  		if (type_set_read(&tr->types, fp))
> >>  			return -1;
> >>  
> >> -		if (ebitmap_read(&tr->classes, fp))
> >> -			return -1;
> >> +		if (p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS) {
> >> +			if (ebitmap_read(&tr->classes, fp))
> >> +				return -1;
> >> +		} else {
> >> +			if (ebitmap_set_bit(&tr->classes, SECCLASS_PROCESS - 1, 1))
> >> +				return -1;
> >> +		}
> >>  
> >>  		rc = next_entry(buf, fp, sizeof(uint32_t));
> >>  		if (rc < 0)
> >> @@ -3258,7 +3264,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
> >>  	decl->enabled = le32_to_cpu(buf[1]);
> >>  	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
> >>  	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
> >> -	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
> >> +	    role_trans_rule_read(p, &decl->role_tr_rules, fp) == -1 ||
> >>  	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
> >>  		return -1;
> >>  	}
> >> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> >> index c4f5035..78b3aa6 100644
> >> --- a/libsepol/src/write.c
> >> +++ b/libsepol/src/write.c
> >> @@ -1482,26 +1482,53 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
> >>  	return POLICYDB_SUCCESS;
> >>  }
> >>  
> >> -static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
> >> +static int only_process(ebitmap_t *in)
> >> +{
> >> +	unsigned int i;
> >> +	ebitmap_node_t *node;
> >> +
> >> +	ebitmap_for_each_bit(in, node, i) {
> >> +		if (ebitmap_node_get_bit(node, i) &&
> >> +		    i != SECCLASS_PROCESS - 1)
> >> +			return 0;
> >> +	}
> >> +	return 1;
> >> +}
> >> +
> >> +static int role_trans_rule_write(policydb_t *p, role_trans_rule_t * t,
> >> +				 struct policy_file *fp)
> >>  {
> >>  	int nel = 0;
> >>  	size_t items;
> >>  	uint32_t buf[1];
> >>  	role_trans_rule_t *tr;
> >> +	int warned = 0;
> >> +	int new_role = p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS;
> >>  
> >>  	for (tr = t; tr; tr = tr->next)
> >> -		nel++;
> >> +		if (new_role || only_process(&tr->classes))
> >> +			nel++;
> >> +
> >>  	buf[0] = cpu_to_le32(nel);
> >>  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >>  	if (items != 1)
> >>  		return POLICYDB_ERROR;
> >>  	for (tr = t; tr; tr = tr->next) {
> >> +		if (!new_role && !only_process(&tr->classes)) {
> >> +			if (!warned)
> >> +				WARN(fp->handle, "Discarding role_transition "
> >> +					"rules for security classes other than "
> >> +					"\"process\"");
> >> +			warned = 1;
> >> +			continue;
> >> +		}
> >>  		if (role_set_write(&tr->roles, fp))
> >>  			return POLICYDB_ERROR;
> >>  		if (type_set_write(&tr->types, fp))
> >>  			return POLICYDB_ERROR;
> >> -		if (ebitmap_write(&tr->classes, fp))
> >> -			return POLICYDB_ERROR;
> >> +		if (new_role)
> >> +			if (ebitmap_write(&tr->classes, fp))
> >> +				return POLICYDB_ERROR;
> >>  		buf[0] = cpu_to_le32(tr->new_role);
> >>  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> >>  		if (items != 1)
> >> @@ -1636,7 +1663,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
> >>  	}
> >>  	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
> >>  	    avrule_write_list(decl->avrules, fp) == -1 ||
> >> -	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
> >> +	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
> >>  	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
> >>  		return POLICYDB_ERROR;
> >>  	}
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 
> I think the below patch fixes the problem I was seeing. Some rules were
> getting discarded in role_trans_write during a policy downgrade, but the
> count was not being decreased. This fix is similar to your fix in
> role_trans_rule_write.

Looks as appropriate to me as when range trans does it.

-Eric

> ---
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 78b3aa6..3a9c35a 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -474,7 +474,9 @@ static int role_trans_write(policydb_t *p, struct
> policy_file *fp)
> 
>     nel = 0;
>     for (tr = r; tr; tr = tr->next)
> -       nel++;
> +       if(new_roletr || tr->class == SECCLASS_PROCESS)
> +           nel++;
> +
>     buf[0] = cpu_to_le32(nel);
>     items = put_entry(buf, sizeof(uint32_t), 1, fp);
>     if (items != 1)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
