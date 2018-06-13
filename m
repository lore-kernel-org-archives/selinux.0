To: peter enderborg <peter.enderborg@sony.com>, Joe Perches <joe@perches.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Serge E . Hallyn" <serge@hallyn.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-2-peter.enderborg@sony.com>
 <a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
 <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <b7a048ae-830f-9da0-9548-ea6d34db9756@gmail.com>
Date: Wed, 13 Jun 2018 10:38:36 -0700
MIME-Version: 1.0
In-Reply-To: <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 01/13] selinux: Cleanup printk logging in
 conditional
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 6/12/18 11:23 PM, peter enderborg wrote:
> On 06/12/2018 04:38 PM, Joe Perches wrote:
>> On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
>>> Replace printk with pr_* to avoid checkpatch warnings.
>> I believe it would be nicer to remove the
>> "SELinux: " prefix embbeded in each format
>> and use a specific
>>
>> #define pr_fmt(fmt) "SELinux: " fmt
>>
>> to automatically prefix these formats.
> I cant argument about that, however some of the warnings and debug prints in this set does not have this
> so it will then change the actual output. (And I also think that they should have a the prefix, but I don't
> know why they don't) So I am not sure if it appropriate for a cleanup patch, it supposed to have no functional change.


I would suggest that could be a follow-up patch.

I do like the cleanup, and it's better than the status quo.

Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>


>>> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
>> []
>>> @@ -96,7 +96,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>>>   	if (new_state != node->cur_state) {
>>>   		node->cur_state = new_state;
>>>   		if (new_state == -1)
>>> -			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>>> +			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
>>>   		/* turn the rules on or off */
>>>   		for (cur = node->true_list; cur; cur = cur->next) {
>>>   			if (new_state <= 0)
>> So, for instance, this patch could become:
>> (etc and so forth for each patch in this series)
>>
>> ---
>>   security/selinux/ss/conditional.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
>> index c91543a617ac..e96820d92b61 100644
>> --- a/security/selinux/ss/conditional.c
>> +++ b/security/selinux/ss/conditional.c
>> @@ -7,6 +7,8 @@
>>    *	the Free Software Foundation, version 2.
>>    */
>>   
>> +#define pr_fmt(fmt) "SELinux: " fmt
>> +
>>   #include <linux/kernel.h>
>>   #include <linux/errno.h>
>>   #include <linux/string.h>
>> @@ -96,7 +98,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>>   	if (new_state != node->cur_state) {
>>   		node->cur_state = new_state;
>>   		if (new_state == -1)
>> -			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>> +			pr_err("expression result was undefined - disabling all rules\n");
>>   		/* turn the rules on or off */
>>   		for (cur = node->true_list; cur; cur = cur->next) {
>>   			if (new_state <= 0)
>> @@ -287,7 +289,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   	 */
>>   	if (k->specified & AVTAB_TYPE) {
>>   		if (avtab_search(&p->te_avtab, k)) {
>> -			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
>> +			pr_err("type rule already exists outside of a conditional\n");
>>   			goto err;
>>   		}
>>   		/*
>> @@ -302,7 +304,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
>>   			if (node_ptr) {
>>   				if (avtab_search_node_next(node_ptr, k->specified)) {
>> -					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
>> +					pr_err("too many conflicting type rules\n");
>>   					goto err;
>>   				}
>>   				found = 0;
>> @@ -313,13 +315,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   					}
>>   				}
>>   				if (!found) {
>> -					printk(KERN_ERR "SELinux: conflicting type rules.\n");
>> +					pr_err("conflicting type rules\n");
>>   					goto err;
>>   				}
>>   			}
>>   		} else {
>>   			if (avtab_search(&p->te_cond_avtab, k)) {
>> -				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
>> +				pr_err("conflicting type rules when adding type rule for true\n");
>>   				goto err;
>>   			}
>>   		}
>> @@ -327,7 +329,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>>   
>>   	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
>>   	if (!node_ptr) {
>> -		printk(KERN_ERR "SELinux: could not insert rule.\n");
>> +		pr_err("could not insert rule\n");
>>   		rc = -ENOMEM;
>>   		goto err;
>>   	}
>> @@ -387,12 +389,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
>>   static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
>>   {
>>   	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
>> -		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
>> +		pr_err("conditional expressions uses unknown operator\n");
>>   		return 0;
>>   	}
>>   
>>   	if (expr->bool > p->p_bools.nprim) {
>> -		printk(KERN_ERR "SELinux: conditional expressions uses unknown bool.\n");
>> +		pr_err("conditional expressions uses unknown bool\n");
>>   		return 0;
>>   	}
>>   	return 1;
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
