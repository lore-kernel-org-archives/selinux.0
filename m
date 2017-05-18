Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4ILnxK0010583
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 17:50:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so14106197wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 14:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495120065.5475.10.camel@tycho.nsa.gov>
References: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
 <CAHC9VhSa_0FnaHpFR9jB4tkV-7p_JxFqRaQGC7+LTkfcmdV7mA@mail.gmail.com>
 <1495116094.5475.4.camel@tycho.nsa.gov>
 <1495120065.5475.10.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 May 2017 17:49:16 -0400
Message-ID: <CAHC9VhTkBJ4f6Zkeu=Ufae1XHyxVCgfARyj8Hc6yiEgh55Xz-Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selinux: add brief info to policydb
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 18, 2017 at 11:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2017-05-18 at 10:01 -0400, Stephen Smalley wrote:
>> On Wed, 2017-05-17 at 18:19 -0400, Paul Moore wrote:
>> > On Wed, May 17, 2017 at 1:09 PM, Sebastien Buisson wrote:

...

>> > > diff --git a/security/selinux/ss/policydb.c
>> > > b/security/selinux/ss/policydb.c
>> > > index 87d645d..b37b8e5 100644
>> > > --- a/security/selinux/ss/policydb.c
>> > > +++ b/security/selinux/ss/policydb.c
>> > > @@ -32,13 +32,20 @@
>> > >  #include <linux/errno.h>
>> > >  #include <linux/audit.h>
>> > >  #include <linux/flex_array.h>
>> > > +#include <crypto/hash.h>
>> > >  #include "security.h"
>> > >
>> > >  #include "policydb.h"
>> > >  #include "conditional.h"
>> > >  #include "mls.h"
>> > > +#include "objsec.h"
>> > >  #include "services.h"
>> > >
>> > > +static unsigned int policybrief_hash_size;
>> > > +static struct crypto_shash *policybrief_tfm;
>> > > +static const char policybrief_hash_alg[] = "sha256";
>> > > +unsigned int policybrief_len;
>> >
>> > I'm not a fan of all these global variables, consider it a pet
>> > peeve of mine.
>> >
>> > I'm hopeful that we can drop policybrief_hash_size and
>> > policybrief_len, see my comments below.
>>
>> Hmm...well, they were introduced based on my comments on earlier
>> versions of the patch (v2 and v3).  They can be computed once during
>> init and never change subsequently; they could even be
>> __ro_after_init.

My apologies to you and Sebastien for not reviewing these patches sooner.

>> > >  #define _DEBUG_HASHES
>> > >
>> > >  #ifdef DEBUG_HASHES
>> > > @@ -874,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>> > >         ebitmap_destroy(&p->filename_trans_ttypes);
>> > >         ebitmap_destroy(&p->policycaps);
>> > >         ebitmap_destroy(&p->permissive_map);
>> > > +
>> > > +       kfree(p->policybrief);
>> > >  }
>> > >
>> > >  /*
>> > > @@ -2215,6 +2224,52 @@ static int ocontext_read(struct policydb
>> > > *p,
>> > > struct policydb_compat_info *info,
>> > >  }
>> > >
>> > >  /*
>> > > + * Compute summary of a policy database binary representation
>> > > file,
>> > > + * and store it into a policy database structure.
>> > > + */
>> > > +static int policydb_brief(struct policydb *policydb, void *ptr)
>> > > +{
>> > > +       SHASH_DESC_ON_STACK(desc, policybrief_tfm);
>> > > +       struct policy_file *fp = ptr;
>> > > +       u8 *hashval;
>> > > +       int rc;
>> > > +
>> > > +       BUG_ON(policydb->policybrief);
>> >
>> > I prefer normal error checking (e.g. if statements) over BUG
>> > assertions whenever possible.
>>
>> Technically, this truly would be a kernel-internal bug (not something
>> a user could trigger apart from a kernel bug), since policydb_brief()
>> is only supposed to be called once per policydb from policydb_read().
>> However, I could see just dropping this check altogether; we don't
>> generally assert function preconditions like this.

My first take on this was the same, we really shouldn't need this
check and I have a preference for removing it.  However,
policydb_brief() should be called infrequently enough that I'm not
going to worry about an extra if conditional if Sebastien feels it is
important.

>> >
>> > > +       hashval = kmalloc(policybrief_hash_size, GFP_KERNEL);
>> > > +       if (hashval == NULL)
>> > > +               return -ENOMEM;
>> > > +
>> > > +       desc->tfm = policybrief_tfm;
>> > > +       desc->flags = 0;
>> > > +       rc = crypto_shash_digest(desc, fp->data, fp->len,
>> > > hashval);
>> > > +       if (rc) {
>> > > +               printk(KERN_ERR "Failed crypto_shash_digest:
>> > > %d\n",
>> > > rc);
>> > > +               goto out_free;
>> > > +       }
>> > > +
>> > > +       /* policy brief is in the form:
>> > > +        * selinux(enforce=<0 or 1>:checkreqprot=<0 or
>> > > 1>:<hashalg>=<checksum>)
>> > > +        */
>> >
>> > See my comments a little later down about the brief format
>> > comments.
>> >
>> > > +       policydb->policybrief = kmalloc(policybrief_len,
>> > > GFP_KERNEL);
>> > > +       if (policydb->policybrief == NULL) {
>> > > +               rc = -ENOMEM;
>> > > +               goto out_free;
>> > > +       }
>> > > +       rc = snprintf(policydb->policybrief, policybrief_len,
>> > > +                     "selinux(enforce=%d:checkreqprot=%d:%s=%*ph
>> > > N)
>> > > ",
>> > > +                     selinux_enforcing, selinux_checkreqprot,
>> > > +                     policybrief_hash_alg,
>> > > policybrief_hash_size,
>> > > hashval);
>> > > +       BUG_ON(rc >= policybrief_len);
>> >
>> > This length check should definitely be a normal check and not a
>> > BUG_ON() assertion.
>>
>> This one also would be a kernel-internal bug and would help catch
>> inconsistencies between the policybrief_len computation and the
>> actual string length (e.g. if someone changed the format string above
>> without adjusting the length computation to match).  It could be even
>> stricter, e.g. BUG_ON(rc != (policybrief_len - 1)).
>>
>> I know that BUG_ON is generally frowned upon, but this case seems
>> more justified, as it is a kernel-internal bug (not user triggerable apart
>> from a kernel bug) and would catch an internal inconsistency.
>> Returning a runtime error instead here would cause policy load to fail, but it
>> wouldn't be the policy that was invalid but instead the kernel
>> itself.
>> That said, this may be obsoleted based on your other comments.

Keep in mind that just because we do normal (not BUG) runtime checking
it doesn't mean we need to return an error and fail the policy load
simply writing a message to the ring buffer would be okay.

>> > > +static int __init init_policybrief_hash(void)
>> > > +{
>> > > +       struct crypto_shash *tfm;
>> > > +
>> > > +       if (!selinux_enabled)
>> > > +               return 0;
>> > > +
>> > > +       tfm = crypto_alloc_shash(policybrief_hash_alg, 0, 0);
>> > > +       if (IS_ERR(tfm)) {
>> > > +               printk(KERN_ERR "Failed to alloc crypto hash
>> > > %s\n",
>> > > +                      policybrief_hash_alg);
>> > > +               return PTR_ERR(tfm);
>> > > +       }
>> > > +
>> > > +       policybrief_tfm = tfm;
>> > > +       policybrief_hash_size =
>> > > crypto_shash_digestsize(policybrief_tfm);
>> > > +
>> > > +       /* policy brief is in the form:
>> > > +        * selinux(enforce=<0 or 1>:checkreqprot=<0 or
>> > > 1>:<hashalg>=<checksum>)
>> > > +        */
>> >
>> > Let's drop the exact brief format here and just point people at
>> > policydb_brief() where we describe the format in the functions
>> > comment block at the top.  I like the thought behind this, but with
>> > multiple copies of the same information it is likely that they will fall out
>> > of sync at some point in the future.
>> >
>> > > +       policybrief_len = 35 + strlen(policybrief_hash_alg) +
>> > > +               2*policybrief_hash_size + 1;
>> >
>> > This is another long term maintenance headache.  I realize the
>> > comment above is supposed to make this easier, but I'm still going to have
>> > to count characters by hand whenever we play with this and that is
>> > problematic because I only have 10 fingers ;)
>> >
>> > How often is the Lustre kernel module going to be requesting the
>> > policy brief?  If it is going to be often enough that a strlen()
>> > call is too costly, I think you may be better served by leveraging some
>> > of the LSM notification bits that were talked about earlier (e.g. the
>> > stuff from the IB patches) to reduce your need to update Lustre's
>> > copy of the brief.  This was we can handle the brief length calculation
>> > locally in policydb_brief() and simply use a strlen() call in
>> > security_policydb_brief().
>>
>> v2 and v3 of the patch did essentially what you describe above (v2
>> had policydb_brief() store the length in the policydb for use by
>> security_policydb_brief(), v3 just called strlen() in
>> security_policydb_brief()).  Both looked racy; they each took the
>> policy read lock, extracted or computed the length, dropped the read
>> lock, allocated the buffer, re-took the read lock, and copied out the
>> brief.  Since the length was stored in the policydb or computed each
>> time, it looked like the length could change across a policy reload,
>> in which case the code was unsafe.  I noted that the length was in fact
>> fixed (at least after init) and could be computed once during init.
>> Then we don't need to store it in the policydb or recompute it each
>> time, and we don't need to take the read lock twice or complicate the
>> code to try to prevent something that cannot actually occur (a change
>> in length at runtime).

I'm still interested in hearing exactly how this will be used by
Lustre.  Based on the way some of these hooks are designed I'm a
little afraid that the Lustre kernel module is planning on hitting
this quite frequently, which I don't think is a good thing, I'd much
rather a notification system be used for something like that and only
(re)fetching the policy brief when something has changed.

In some ways it almost might be nice to have security_policydb_brief()
always allocate the buffer to discourage frequent use.  It would
simplify the code quite a bit as well ... although it would require
the notification system, but I think we are going to need that for IB
anyway.

> So, if you truly want to go with the v2/v3 approach instead of this
> one, then I'd suggest:
> 1) Also using kasprintf() as in v4/v5.  Then we don't need a separate
> length computation at all for the policydb_brief() allocation and there
> is no potential for inconsistency.  I only recommended against using
> kasp; Irintf() in v5 because we already had the length precomputed at init
> and therefore it wasn't buying us anything.

Agreed.  It makes sense.

> 2) Compute the strlen() once in policydb_brief() and save it in
> policydb as in v2, to avoid having to recompute it each time in
> security_policydb_brief().  I only argued against that in v2 because I
> thought it should be done once during init, not that we should compute
> it each time in security_policydb_brief().

This is one area where understanding the callers would be helpful.

> 3) In security_policydb_brief(), explicitly test that the length hasn't
> changed after taking the read lock again before copying and treat it at
> least as a runtime error if not a BUG if it has changed (it would again
> be a kernel-internal bug).

We shouldn't use BUG in security_policydb_brief() as we can safely
return an error here.

Once again my comments are dependent on the caller, but I share your
concerns about race conditions and think we can workaround those
problems in security_policydb_brief() through the use of
kstrdup(GFP_ATOMIC) (the buffer should be small enough, and used
infrequently enough that this should be okay) and if the buffer is
provided, strscpy().

> I can somewhat see the argument for handling policybrief_len in this
> manner, since keeping the length computation in sync with the format
> string could be a headache.  But I do think that policybrief_tfm and
> policybrief_hash_size should just be obtained once during init and made
> __ro_after_init.  I don't see any downside to that from a maintenance
> perspective and it certainly simplifies the code and is more efficient.

I understand the need to fetch/allocate the policybrief_tfm value
during init, no arguments there, but everything else is less clear to
me at the moment (see comments above).

-- 
paul moore
www.paul-moore.com
