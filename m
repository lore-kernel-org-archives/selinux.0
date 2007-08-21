Date: Tue, 21 Aug 2007 07:00:56 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
Subject: Re: [patch] Tuning avtab to reduce memory usage
In-Reply-To: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
Message-ID: <Xine.LNX.4.64.0708210645130.16813@us.intercode.com.au>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Aug 2007, Yuichi Nakamura wrote:

> Hi.
> 
> I would like to propose patch that reduce memory usage of avtab again.

This looks good, although there are some coding style and other issues 
which need to be fixed.  Also see Documentation/SubmittingPatches and 
Documentation/CodingStyle in the kernel tree.

> 
> Next is a patch.
> Signed-Off-By: Yuichi Nakamura <ynakam@hitachisoft.jp>
> ----

Needs to be 3 --- otherwise scripts will break.

>  avtab.c       |   61 ++++++++++++++++++++++++++++++++++++++++++++--------------
>  avtab.h       |   13 +++++++-----
>  conditional.c |    6 +++++
>  policydb.c    |    9 ++------
>  4 files changed, 64 insertions(+), 25 deletions(-)

diffstat -p1

> 
> diff -ur security/selinux.notuning/ss/avtab.c security/selinux/ss/avtab.c

diff -purN

> +	hvalue = AVTAB_HASH(key,h->mask);

Add a space after the comma.

Also, AVTAB_HASH should be converted to a static inline.

> +	while(work) {

Space after while.

> +	if (shift > 2) {
> +		shift = shift - 2;
> +	}

No need for braces for a one-line statement.

> +	nslot = 1 << shift;
> +	if (nslot > MAX_AVTAB_SIZE) {
> +		nslot = MAX_AVTAB_SIZE;
> +	}

Ditto.

> -	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
> +	h->htable = kmalloc(sizeof(*(h->htable)) * nslot, GFP_KERNEL);

Use kcalloc(), then consider the effect of the memory zeroing & how much 
further code can be removed.

> +	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. Num of rules:%d\n", h->nslot, nrules);

This line is too long.

> +	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> +	if (rc) {
> +		rc = -ENOMEM;

Why are you resetting rc to the same value?

> -		goto out_free_symtab;
> +		goto out_free_symtab;	

Looks like you added a trailing tab.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
