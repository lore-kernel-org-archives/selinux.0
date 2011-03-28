Message-ID: <4D90FD99.90009@manicmethod.com>
Date: Mon, 28 Mar 2011 17:28:57 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov, Stephen Lawrence <slawrence@tresys.com>
Subject: Re: [v2 PATCH 5/5] Userspace: display the class in role_transition
 rule
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com> <1301032323-20363-9-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1301032323-20363-9-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've reviewed the 5 userspace patches and they look good. I'll wait until 
someone (Steve Lawrence?) actually compiles and tests before acking.

Harry Ciao wrote:
> Add support to display the class field in the role_transition rule
> in the checkpolicy/test/dismod program.
>
> Signed-off-by: Harry Ciao<qingtao.cao@windriver.com>
> ---
>   checkpolicy/test/dismod.c |   27 ++++++++++++++++++++++++++-
>   1 files changed, 26 insertions(+), 1 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 4d31597..33a29e4 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -451,13 +451,38 @@ void display_initial_sids(policydb_t * p, FILE * fp)
>   #endif
>   }
>
> +void display_class_set(ebitmap_t *classes, policydb_t *p, FILE *fp)
> +{
> +	int i, num = 0;
> +
> +	for (i = ebitmap_startbit(classes); i<  ebitmap_length(classes); i++) {
> +		if (!ebitmap_get_bit(classes, i))
> +			continue;
> +		num++;
> +		if (num>  1) {
> +			fprintf(fp, "{");
> +			break;
> +		}
> +	}
> +
> +	for (i = ebitmap_startbit(classes); i<  ebitmap_length(classes); i++) {
> +		if (ebitmap_get_bit(classes, i))
> +			display_id(p, fp, SYM_CLASSES, i, "");
> +	}
> +
> +	if (num>  1)
> +		fprintf(fp, " }");
> +}
> +
>   void display_role_trans(role_trans_rule_t * tr, policydb_t * p, FILE * fp)
>   {
>   	for (; tr; tr = tr->next) {
>   		fprintf(fp, "role transition ");
>   		display_mod_role_set(&tr->roles, p, fp);
>   		display_type_set(&tr->types, 0, p, fp);
> -		display_id(p, fp, SYM_ROLES, tr->new_role - 1, " :");
> +		fprintf(fp, " :");
> +		display_class_set(&tr->classes, p, fp);
> +		display_id(p, fp, SYM_ROLES, tr->new_role - 1, "");
>   		fprintf(fp, "\n");
>   	}
>   }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
