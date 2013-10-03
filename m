Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r93KaFI4012825
	for <selinux@tycho.nsa.gov>; Thu, 3 Oct 2013 16:36:16 -0400
Received: by mail-qa0-f45.google.com with SMTP id k4so381347qaq.4
        for <selinux@tycho.nsa.gov>; Thu, 03 Oct 2013 13:36:14 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Dave Jones <davej@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Kernel <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        james.l.morris@oracle.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] conditionally reschedule while loading selinux policy.
Date: Thu, 03 Oct 2013 16:36:10 -0400
Message-ID: <2297933.rECKfqAcWT@sifl>
In-Reply-To: <20130930211342.GA24001@redhat.com>
References: <20130916173036.GA17950@redhat.com> <5249B6F1.4050507@tycho.nsa.gov> <20130930211342.GA24001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, September 30, 2013 05:13:42 PM Dave Jones wrote:
> On Mon, Sep 30, 2013 at 01:37:53PM -0400, Stephen Smalley wrote:
>  > > With that patch applied, the problem seems to have moved elsewhere..
>  > > 
>  > > BUG: soft lockup - CPU#3 stuck for 22s! [load_policy:8119]
>  > > 
>  > >  irq event stamp: 1590886
>  > >  hardirqs last  enabled at (1590885): [<ffffffff8152c3dd>]
>  > >  __slab_alloc.constprop.78+0x4c0/0x4d7 hardirqs last disabled at
>  > >  (1590886): [<ffffffff8153e06a>] apic_timer_interrupt+0x6a/0x80
>  > >  softirqs last  enabled at (1590336): [<ffffffff810480d9>]
>  > >  __do_softirq+0x169/0x200 softirqs last disabled at (1590331):
>  > >  [<ffffffff8104839d>] irq_exit+0x11d/0x140 RIP:
>  > >  0010:[<ffffffff81223182>]  [<ffffffff81223182>]
>  > >  hashtab_insert+0x62/0x110 > > 
>  > > Call Trace:
>  > >  [<ffffffff812283b5>] policydb_read+0xc25/0x1200
>  > 
>  > ...
>  > 
>  > > We're holding a bunch of locks here, so we can't just cond_resched. 
>  > > Thoughts ?
>  >
>  > Sorry, what locks are we holding there?  You ought to be able to do a
>  > cond_resched() anywhere during policydb_read() AFAIK; it is loading the
>  > policy into a new structure that isn't being accessed by anything else
>  > yet and the policy_rwlock is only held by security_load_policy after
>  > calling policydb_read and only to switch it into place as the active
>  > policydb.
> 
> Hmm, I thought I had tried this already, and got a lot of spew, but it turns
> out for some reason I had previously patched hashtab_search instead.
> 
> I'll try running with this for a while..

Hi Dave,

Just checking to see if this patch solved your problem ... ?

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index 933e735..2cc4961 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -6,6 +6,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> +#include <linux/sched.h>
>  #include "hashtab.h"
> 
>  struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const
> void *key), @@ -40,6 +41,8 @@ int hashtab_insert(struct hashtab *h, void
> *key, void *datum) u32 hvalue;
>  	struct hashtab_node *prev, *cur, *newnode;
> 
> +	cond_resched();
> +
>  	if (!h || h->nel == HASHTAB_MAX_NODES)
>  		return -EINVAL;

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
