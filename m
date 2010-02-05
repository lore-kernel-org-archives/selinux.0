Message-ID: <4B6BAFD0.2050607@ak.jp.nec.com>
Date: Fri, 05 Feb 2010 14:42:40 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: method@manicmethod.com
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libsepol: remove dead code in check_avtab_hierarchy_callback()
References: <4AF71B05.8030707@cs.purdue.edu>	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>	 <4B14934F.9050401@cs.purdue.edu> <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil> <4B54339F.8070501@ak.jp.nec.com> <4B5685EC.1000500@ak.jp.nec.com>
In-Reply-To: <4B5685EC.1000500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the current status of this patch?
Its kernel side patch has been already merged into James's -next tree.

http://git.kernel.org/?p=linux/kernel/git/jmorris/security-testing-2.6.git;a=commit;h=7d52a155e38d5a165759dbbee656455861bf7801

Thanks,

(2010/01/20 13:26), KaiGai Kohei wrote:
> This patch removes dead code in check_avtab_hierarchy_callback().
> 
> Due to the historical reason, the type boundary feature is delivered
> from hierarchical types in libsepol, it has supported boundary features
> both of subject type (domain; in most cases) and target type.
> 
> However, we don't have any actual use cases in bounded target types,
> and it tended to make conceptual confusion.
> So, this patch removes the dead code to apply boundary checks on the
> target types in libsepol (when expand-check=1). I makes clear the TYPEBOUNDS
> restricts privileges of a certain domain bounded to any other domain.
> 
>   Signed-off-by: KaiGai Kohei<kaigai@ak.jp.nec.com>
> --
>   libsepol/src/hierarchy.c |   71 ++++++++++++---------------------------------
>   1 files changed, 19 insertions(+), 52 deletions(-)
> 
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index e2df5a4..87a9d9c 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -159,7 +159,7 @@ static int check_avtab_hierarchy_callback(avtab_key_t * k, avtab_datum_t * d,
>   {
>   	avtab_key_t key;
>   	hierarchy_args_t *a = (hierarchy_args_t *) args;
> -	type_datum_t *s, *t1 = NULL, *t2 = NULL;
> +	type_datum_t *s, *t;
>   	avtab_datum_t av;
> 
>   	if (!(k->specified&  AVTAB_ALLOWED)) {
> @@ -169,62 +169,29 @@ static int check_avtab_hierarchy_callback(avtab_key_t * k, avtab_datum_t * d,
> 
>   	/* search for parent first */
>   	s = a->p->type_val_to_struct[k->source_type - 1];
> -	if (find_parent_type(a, s,&t1)<  0)
> +	if (find_parent_type(a, s,&t)<  0)
>   		return -1;
> -	if (t1) {
> -		/*
> -		 * search for access allowed between type 1's
> -		 * parent and type 2.
> -		 */
> -		key.source_type = t1->s.value;
> -		key.target_type = k->target_type;
> -		key.target_class = k->target_class;
> -		key.specified = AVTAB_ALLOWED;
> -		compute_avtab_datum(a,&key,&av);
> -
> -		if ((av.data&  d->data) == d->data)
> -			return 0;
> -	}
> -
> -	/* next we try type 1 and type 2's parent */
> -	s = a->p->type_val_to_struct[k->target_type - 1];
> -	if (find_parent_type(a, s,&t2)<  0)
> -		return -1;
> -	if (t2) {
> -		/*
> -		 * search for access allowed between type 1 and
> -		 * type 2's parent.
> -		 */
> -		key.source_type = k->source_type;
> -		key.target_type = t2->s.value;
> -		key.target_class = k->target_class;
> -		key.specified = AVTAB_ALLOWED;
> -		compute_avtab_datum(a,&key,&av);
> -
> -		if ((av.data&  d->data) == d->data)
> -			return 0;
> -	}
> 
> -	if (t1&&  t2) {
> -		/*
> -                 * search for access allowed between type 1's parent
> -                 * and type 2's parent.
> -                 */
> -		key.source_type = t1->s.value;
> -		key.target_type = t2->s.value;
> -		key.target_class = k->target_class;
> -		key.specified = AVTAB_ALLOWED;
> -		compute_avtab_datum(a,&key,&av);
> -
> -		if ((av.data&  d->data) == d->data)
> -			return 0;
> -	}
> +	/*
> +	 * If the given subject security context does not have any
> +	 * parent domain, we don't need to apply sanity checks on
> +	 * the type boundary constraint.
> +	 */
> +	if (!t)
> +		return 0;
> 
>   	/*
> -	 * Neither one of these types have parents and
> -	 * therefore the hierarchical constraint does not apply
> +	 * Search for access allowed between the parent domain and
> +	 * the type. All the permissions with the child domain have
> +	 * to be allowed to the parent domain also.
>   	 */
> -	if (!t1&&  !t2)
> +	key.source_type = t->s.value;
> +	key.target_type = k->target_type;
> +	key.target_class = k->target_class;
> +	key.specified = AVTAB_ALLOWED;
> +	compute_avtab_datum(a,&key,&av);
> +
> +	if ((av.data&  d->data) == d->data)
>   		return 0;
> 
>   	/*
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
