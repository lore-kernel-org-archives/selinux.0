Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CIkthe012317
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 14:46:55 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3CIksjr005222
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 18:46:55 GMT
Subject: Re: [PATCH 2/2] libsepol: Only write role trans classes if policy
 version supports it
From: Eric Paris <eparis@redhat.com>
To: slawrence@tresys.com
Cc: selinux@tycho.nsa.gov, qingtao.cao@windriver.com, dwalsh@redhat.com
In-Reply-To: <1302633937-25134-2-git-send-email-eparis@redhat.com>
References: <1302633937-25134-1-git-send-email-eparis@redhat.com>
	 <1302633937-25134-2-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Apr 2011 14:46:51 -0400
Message-ID: <1302634011.2821.24.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm sure this patch is necessary, but I'm pretty sure it is not
sufficient.  It will at least get policies to build.  But I question if
copy_role_trans() is doing the right thing on policy < 26.  It seems to
me that we need to actually set the bit for tclass==process on read if
policy < 26.  I'm looking into that right now......

-Eric


On Tue, 2011-04-12 at 14:45 -0400, Eric Paris wrote:
> The role trans support for classes was being unconditionally
> read/written for policy modules regarless if the binary actually
> understood that bitmap.  Fix this problem!
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libsepol/src/policydb.c |   10 ++++++----
>  libsepol/src/write.c    |   10 ++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 2ecb636..77e3b95 100644
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
> @@ -3064,8 +3065,9 @@ static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
>  		if (type_set_read(&tr->types, fp))
>  			return -1;
>  
> -		if (ebitmap_read(&tr->classes, fp))
> -			return -1;
> +		if (p->policyvers >= MOD_POLICYDB_VERSION_ROLETRANS)
> +			if (ebitmap_read(&tr->classes, fp))
> +				return -1;
>  
>  		rc = next_entry(buf, fp, sizeof(uint32_t));
>  		if (rc < 0)
> @@ -3258,7 +3260,7 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
>  	decl->enabled = le32_to_cpu(buf[1]);
>  	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
>  	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
> -	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
> +	    role_trans_rule_read(p, &decl->role_tr_rules, fp) == -1 ||
>  	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
>  		return -1;
>  	}
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index c4f5035..9b70e3c 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1482,7 +1482,8 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
>  	return POLICYDB_SUCCESS;
>  }
>  
> -static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
> +static int role_trans_rule_write(policydb_t *p, role_trans_rule_t * t,
> +				 struct policy_file *fp)
>  {
>  	int nel = 0;
>  	size_t items;
> @@ -1500,8 +1501,9 @@ static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
>  			return POLICYDB_ERROR;
>  		if (type_set_write(&tr->types, fp))
>  			return POLICYDB_ERROR;
> -		if (ebitmap_write(&tr->classes, fp))
> -			return POLICYDB_ERROR;
> +		if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS)
> +			if (ebitmap_write(&tr->classes, fp))
> +				return POLICYDB_ERROR;
>  		buf[0] = cpu_to_le32(tr->new_role);
>  		items = put_entry(buf, sizeof(uint32_t), 1, fp);
>  		if (items != 1)
> @@ -1636,7 +1638,7 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
>  	}
>  	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
>  	    avrule_write_list(decl->avrules, fp) == -1 ||
> -	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
> +	    role_trans_rule_write(p, decl->role_tr_rules, fp) == -1 ||
>  	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
>  		return POLICYDB_ERROR;
>  	}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
