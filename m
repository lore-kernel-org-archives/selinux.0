Message-ID: <4D8A4462.7010404@manicmethod.com>
Date: Wed, 23 Mar 2011 15:05:06 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 3/5] Handle the class in role_trans structure
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com> <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Harry Ciao wrote:
> From: Harry Ciao<harrytaurus2002@hotmail.com>
<snip>

> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -462,11 +462,14 @@ static int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
>   	return POLICYDB_SUCCESS;
>   }
>
> -static int role_trans_write(role_trans_t * r, struct policy_file *fp)
> +static int role_trans_write(policydb_t *p, struct policy_file *fp)
>   {
> +	role_trans_t *r = p->role_tr;
>   	role_trans_t *tr;
>   	uint32_t buf[3];
>   	size_t nel, items;
> +	int new_roletr = (p->policy_type == POLICY_KERN&&
> +			  p->policyvers>= POLICYDB_VERSION_ROLETRANS);
>
>   	nel = 0;
>   	for (tr = r; tr; tr = tr->next)
> @@ -478,9 +481,18 @@ static int role_trans_write(role_trans_t * r, struct policy_file *fp)
>   	for (tr = r; tr; tr = tr->next) {
>   		buf[0] = cpu_to_le32(tr->role);
>   		buf[1] = cpu_to_le32(tr->type);
> -		buf[2] = cpu_to_le32(tr->new_role);
> -		items = put_entry(buf, sizeof(uint32_t), 3, fp);
> -		if (items != 3)
> +		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> +		if (items != 2)
> +			return POLICYDB_ERROR;
> +		if (new_roletr) {
> +			buf[0] = cpu_to_le32(tr->cclass);
> +			items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +			if (items != 1)
> +				return POLICYDB_ERROR;
> +		}
> +		buf[0] = cpu_to_le32(tr->new_role);
> +		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +		if (items != 1)
>   			return POLICYDB_ERROR;
>   	}
>

You need to do something like range_write if you end up having a class set from 
the parser but you are building a lower version of the policy. The range write 
warning is:

         for (rt = p->range_tr; rt; rt = rt->next) {
                 if (!new_rangetr && rt->target_class != SECCLASS_PROCESS) {
                         if (!warning_issued)
                                 WARN(fp->handle, "Discarding range_transition "
                                      "rules for security classes other than "
                                      "\"process\"");
                         warning_issued = 1;
                         continue;
                 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
