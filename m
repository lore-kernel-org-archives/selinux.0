Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v584jRIY010219
 for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2017 00:45:28 -0400
Subject: Re: [PATCH] security: selinux: use kmem_cache for ebitmap
To: Paul Moore <paul@paul-moore.com>
References: <1496653814-3653-1-git-send-email-junil0814.lee@lge.com>
 <CAHC9VhTU9fgZxfeyo_ViPcdEONxYaBxnMGCgM8yb35-52CBNtw@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 william.c.roberts@intel.com, adobriyan@gmail.com,
 akpm@linux-foundation.org, dledford@redhat.com, danielj@mellanox.com,
 mka@chromium.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
From: "=?UTF-8?B?7J207KSA7J28L+yXsOq1rOybkC9NQ+yXsOq1rOyGjCBCU1Dsi6QgQlNQNg==?=
 =?UTF-8?Q?=ed=8c=80=28junil0814.lee@lge.com=29?=" <junil0814.lee@lge.com>
Message-ID: <36d05b88-53c1-4a3d-ac35-f2826ab6f7fe@lge.com>
Date: Thu, 8 Jun 2017 13:15:18 +0900
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTU9fgZxfeyo_ViPcdEONxYaBxnMGCgM8yb35-52CBNtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



Paul Moore wrote on 2017-06-07 오후 10:50:
> 
> 
> 
>>> On Mon, Jun 5, 2017 at 5:10 AM, Junil Lee <junil0814.lee@lge.com> wrote:
>>>> The allocated size for each ebitmap_node is 192byte by kzalloc().
>>>> Then, ebitmap_node size is fixed, so it's possible to use only 144byte
>>>> for each object by kmem_cache_zalloc().
>>>> It can reduce some dynamic allocation size.
>>>>
>>>> Signed-off-by: Junil Lee <junil0814.lee@lge.com>
>>>> ---
>>>> security/selinux/ss/ebitmap.c | 24 +++++++++++++++++++-----
>>>> security/selinux/ss/ebitmap.h | 3 +++
>>>> security/selinux/ss/services.c | 4 ++++
>>>> 3 files changed, 26 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/security/selinux/ss/ebitmap.c
>>> b/security/selinux/ss/ebitmap.c
>>>> index 9db4709a..076c96f 100644
>>>> --- a/security/selinux/ss/ebitmap.c
>>>> +++ b/security/selinux/ss/ebitmap.c
>>>> @@ -24,6 +24,8 @@
>>>>
>>>> #define BITS_PER_U64 (sizeof(u64) * 8)
>>>>
>>>> +static struct kmem_cache *ebitmap_node_cachep;
>>>> +
>>>> int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
>>>> {
>>>> struct ebitmap_node *n1, *n2;
>>>> @@ -54,7 +56,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap
>>> *src)
>>>> n = src->node;
>>>> prev = NULL;
>>>> while (n) {
>>>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>>>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>>> if (!new) {
>>>> ebitmap_destroy(dst);
>>>> return -ENOMEM;
>>>> @@ -162,7 +164,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>>>> if (e_iter == NULL ||
>>>> offset >= e_iter->startbit + EBITMAP_SIZE) {
>>>> e_prev = e_iter;
>>>> - e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
>>>> + e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>>> if (e_iter == NULL)
>>>> goto netlbl_import_failure;
>>>> e_iter->startbit = offset - (offset % EBITMAP_SIZE);
>>>> @@ -299,7 +301,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned
>>> long bit, int value)
>>>> if (!value)
>>>> return 0;
>>>>
>>>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>>>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>>> if (!new)
>>>> return -ENOMEM;
>>>
>>> I believe there is a kfree() in ebitmap_set_bit() that also needs to
>>> be converted.
>>>
>>
>> Thanks for your advice Paul.
>> reattach patch v2.
> 
> Please submit patches inline, just as you did for your original
> posting. It make it easier to review and apply.
> 
> Thanks.
> 

I'm sorry for inconvenience.
I'll resubmit the patch as I did for my original posting.

Thanks.

> -- 
> paul moore
> www.paul-moore.com
