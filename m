Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18136C47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD62E20721
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 21:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZlKWn7nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgEEVS0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729031AbgEEVSX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 17:18:23 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0AC061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 14:18:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so19189ejx.5
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Le9mloFQF4ZBVhTjMDvWSzNViYIvllrzVbL7WlRQcxY=;
        b=ZlKWn7nwFHwbfOrIKKk1QVHFTwjxzwkPusN4OtuF3nxuzsj4b+kvUU3+arnlhDb/Jo
         dEUD2SAxoPllntKUrQMpTza8i5OGubQqoeT33DbeFYat1fUtsZ3qAUN3fU7IObvvYB38
         YNSXTWIwRVvjTH+rWR0mrmgfiQo0w5FCxugIRLDBS3dDbFKPeZIFh1kTIsCvLyuPb1cb
         Rv4Tny+SZvoG6BSFIBipZgQVI73EtUbH8LcFxlV/4W/2mspSTXcSJ1cnkOkrHjmOPLy8
         ny8cqa7z0nZC/+t3JU1+mhyTiCntsOLjjxrUdHMcJKcs1WdFP8nV2sJNpv7SrTCaUFbf
         GBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le9mloFQF4ZBVhTjMDvWSzNViYIvllrzVbL7WlRQcxY=;
        b=Qc4TblW99sZhiuhTpL3OyX2VruqFFuHUP8+IMbkXCBkjxmWkKp1WEB7rIoAmo/zl0E
         YZxv8f+Ztr9+tslFPnp5VgJX7f2UEJ3KGxBrZhQYrVQgb1UD6MPov0qmpFz+7U6mzlaT
         bTbBp2BB7T0UfViraNrAFyy2XaaPExQyBypRc37VTIcfkyBfsUuXJCantp7ieC3UUgOR
         z7pWwke6DHpfO8ErM++vqonHowV+IbVuiC6/HosTTvV3+ulPpjcPpTYjNWf2FRfCWnsq
         1J2+EbfFgSis7lexctF2SZJ5RMf0Ekpi89zHOmFRC0Ho3VQZL6fs2GBpMU6P2TWucWZR
         5TSg==
X-Gm-Message-State: AGi0PubfHb/jkp7r9klEw7FSz3H60vh5HpjTPLMdnAcVEMgrvalClIeW
        dvIRL1MXwrUBHtC07qnBWelvg8PLSzOfF4Fpc0+m
X-Google-Smtp-Source: APiQypJe9VjQZf7Yui/SimhYE/pQMYKP7NGTo+3JN/NE4JZ9fYEDToHHDyTSispABhO5iOkshW41ghLScueuKcX6giM=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr4680643ejb.271.1588713500879;
 Tue, 05 May 2020 14:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com> <20200429202941.18320-3-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200429202941.18320-3-siarhei.liakh@concurrent-rt.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 May 2020 17:18:09 -0400
Message-ID: <CAHC9VhRKpWzaPrF3SGwC1J_DGGuSE0Z0tiYrVV_Rdkam0JosGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] SELinux: Introduce hash3() as alternative to shift-xor
To:     siarhei.liakh@concurrent-rt.com
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 4:29 PM <siarhei.liakh@concurrent-rt.com> wrote:
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
>
> This change improves performance of hashing functions used in AVC and
> AVTab to hash 3x 32-bit values. As compared to original shift-xor function
> used in AVC, substantial improvement in quality of hashing is gained by:
> 1. replacing shifts with rolls, thus preserving all of the incoming
>    entropy
> 2. adjusting shift/roll constants to reduce overlap between the input
>    values
> 3. use of arithmetic addition instead of XOR, as a way to spread out
>    collisions
> 4. use of hash_32() to level out the distribution of hash output values
>    throughout the range
>
> Within the scope of particular application, these changes bring hash
> quality to that of much more complex MurmurHash3 (which is currently used
> in AVTab), while maintaining trivial simplicity of the original code.
>
> The only price paid for the improvements is introduction of a single
> 32-bit multiplication instruction upon which hash_32() is built, which is
> not a problem on almost any modern platform where fast multiplication is
> available. For example, 32-bit MULs have had latency of 4 on pretty much
> all Intel x86 CPUs for at least a decade or so (while ADD/XOR/SHL/ROL have
> latency of 1). Platforms without fast multiplication provide their own
> alternative mechanism for hash_32().
>
> New hash function hash3() had been applied to two key parts of SELinux:
> Access Vector Cache (AVC) and Access Vector Table (AVTab) with results
> that follow.
>
> AVC:
>
> Below is the content of hash_stats, as observed on Fedora 32 in its
> default configuration with targeted policy, averaged over 100 samples. The
> stats show that new hash function not only cuts the longest chain almost
> in half, but also provides a much better distribution throughout the table:
> about 39% more buckets are being used, with at least half of all non-zero
> buckets consistently staying at length 1, with 75% at 2 or below.
>
> /sys/fs/selinux/avc/hash_stats:
>             Old     New
> Samples:   100      100
> Entries:   504.43   503.67
> Buckets:   219.73   304.61
> 1st Qu.:     1.00     1.00
> Median :     1.39     1.00
> 3rd Qu.:     3.00     2.00
> Maximum:     9.32     5.37
>
> Next, performance of avc_lookup() is analyzed by timing it with ftrace on
> a system with same configuration as above:
>
> acv_lookup(), latency in us:
>             Old     New
>  Samples: 261534    244168
>  Min.   : 0.1320    0.1310
>  1st Qu.: 0.2410    0.2360
>  Median : 0.4220    0.4240
>  3rd Qu.: 0.5580    0.5600
>  Max.   : 9.9300    9.9890
>
> Considering small size of AVC in default configuration, the change does
> not show any latency improvements. In fact, median and 75th percentile
> timings appear to be in line with addition of extra 4 clock cycles for MUL
> (roughly 2ns on a 2.2Ghz CPU), or 0.47%. This appears to be a small price
> to pay for substantially better distribution of hash values, reducing a
> probability and/or severity of potential pathological behavior on some
> larger configurations.
>
> Note that absolute max latency is likely not indicative, as it is
> susceptible to one-off events such as interrupts, cache misses, etc.

Thanks for providing more performance information, this is helpful.
Right now as I look at the results, I'm trying to decide if I care at
all about the chain length information as ultimately the latency is
really what we care about, yes?  I'm also trying to reconcile the
chain length information with the latency information; based on the
difference in chain lengths I would have expected more of a difference
in the latency numbers.  As you mention the latency numbers are
basically the same (give or take two clock cycles) between the two
hash implementations, assuming we exclude the worst case.  If we
include the worst case the old implementation is better, at least in
the data you've provided.

Is the added complexity of the hash3 implementation, as compared to
the current avc hash, stealing from the performance improvement
brought by the improved hash table utilization?  If true, I would
expect the penalty to be constant regardless of the chain length, but
it seems like the latency difference between old and new gets worse
(from a "new" perspective) as the chain length grows.  Can you explain
that?  Or are we simply playing in the noise of the measurement since
we are only talking about a clock cycle or two?

> AVTab:
>
> Unlike AVC, AVTab hash table is much larger and much more densely
> populated. In the past, need for better hashing in AVTab was demonstrated,
> resulting in transition to a local copy of custom implementation of much
> more complicated (and better) MurmurHash3, adapted for hashing of 3x u32s.
> This change replaces MurmurHash3 with a much simpler, faster, yet just as
> effective (at least, in this particular use case) hash3() function
> described above.
>
> As evidenced by debug output produced during the boot process, despite
> being much simpler, hash3() yields quite similar (if not just a tiny bit
> better) hash distribution quality within AVTab:
>
> Old:
> rules:  81014 entries and 29600/32768 buckets used, longest chain length
> 11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 290030
>
> New:
> rules:  81014 entries and 29645/32768 buckets used, longest chain length
> 11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 288810

Oh, one nit against the first patch - you might as well use all
lower-case letters in the stats (e.g. "q1" not "Q1" and "med" instead
of "Med") to be consistent with the existing output.

> Performance, though, is a different matter: a clear savings of 8ns to
> 10ns (75th and 50th percentiles respectively) had been measured with
> ftrace for the most frequent AVTab lookup method:
>
> avtab_search_node(), latency in us:
>           Old       New
>  Samples: 5953243   5458099
>  Min.   : 0.136     0.129
>  1st Qu.: 0.199     0.189
>  Median : 0.219     0.209
>  3rd Qu.: 0.294     0.286
>  Max.   :10.000     9.990
>
> The results are not as clear for much less frequently (that is 1500x call
> frequency difference) used avtab_search(), though they appear to lean
> towards a positive side:
>
> avtab_search(), latency in us:
>             Old     New
>  Samples: 3863      3638
>  Min.   : 0.165     0.157
>  1st Qu.: 0.297     0.293
>  Median : 0.510     0.517
>  3rd Qu.: 0.803     0.774
>  Max.   : 9.343     7.701

So with the avtab we see similar chain length numbers between the two
hash implementations but we manage to save a couple of clock cycles
across the board from best to worst.  I'm guessing this is almost
surely due to the simpler hash3 implementation over the current avtab
implementation, yes?

(more comments inline)

> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> ---
> Please CC me directly on all replies.
>
>  security/selinux/avc.c           |  8 +++--
>  security/selinux/include/hash3.h | 44 ++++++++++++++++++++++++
>  security/selinux/ss/avtab.c      | 57 ++++++++++----------------------
>  security/selinux/ss/avtab.h      |  1 +
>  4 files changed, 67 insertions(+), 43 deletions(-)
>  create mode 100644 security/selinux/include/hash3.h
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index c3bbdb083371..ed092324bef1 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -30,12 +30,14 @@
>  #include "avc.h"
>  #include "avc_ss.h"
>  #include "classmap.h"
> +#include "hash3.h"
>
>  #ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
>  #include "median.h"
>  #endif
>
> -#define AVC_CACHE_SLOTS                        512
> +#define AVC_CACHE_BITS                 (9)
> +#define AVC_CACHE_SLOTS                        (1 << AVC_CACHE_BITS)
>  #define AVC_DEF_CACHE_THRESHOLD                512
>  #define AVC_CACHE_RECLAIM              16
>
> @@ -125,9 +127,9 @@ static struct kmem_cache *avc_xperms_data_cachep;
>  static struct kmem_cache *avc_xperms_decision_cachep;
>  static struct kmem_cache *avc_xperms_cachep;
>
> -static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
> +static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
> +       return hash3(ssid, tsid, tclass, AVC_CACHE_BITS);
>  }
>
>  /**
> diff --git a/security/selinux/include/hash3.h b/security/selinux/include/hash3.h
> new file mode 100644
> index 000000000000..21e2408f5227
> --- /dev/null
> +++ b/security/selinux/include/hash3.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* (C) Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>, 2020, GPL 2.0+ */
> +
> +#ifndef _SELINUX_HASH3_H
> +#define _SELINUX_HASH3_H
> +
> +#include <linux/hash.h>
> +#include <linux/bitops.h>
> +
> +/*
> + * hash3(): Mix and hash 3 x u32's with minimal overhead,
> + * truncate result to requested number of bits.
> + *
> + * This hash function produces very good results for inputs where most of
> + * input entropy is contained within the lower 11 bits of each of the words.
> + *
> + * For example, AVC hash table (in avc.c) is indexed by a 3-tuple (u32 ssid,
> + * u32 tsid, u16 tclass), where (on Fedora 32 Beta, as of March 2020) ssid and
> + * tsid appear to be sequential indexes between 0x0 and 0xA00, while tclass
> + * appears to be confined to the lower 8 bits, resulting in almost perfect
> + * packing of the indexes into a single 32-bit value.
> + *
> + * The function still produces reasonable hash values even when input value
> + * ranges span beyond 11 bits, as long as the placement of entropy within the
> + * input values is roughly the same for each of the componets (a, b, c), and
> + * the address space (a, b, c) is sparsely populated. Such behaviour is the
> + * result of two conscious choices: (1) use of rol32() to preserve all of the
> + * incoming entropy (as opposed to simple shifts which discard some input bits)
> + * and (2) use of arithmetic addition which carries over colliding bits (as
> + * opposed to binary XOR, which does not carry).
> + *
> + * The function will produce horrible collisions if input entropy is distrubuted
> + * within (a, b, c) such that it ends up within the same bit ranges after
> + * rotations, and the address space is densly populated. If that is the case,
> + * then two options are available:
> + * 1. Try switching around some of the inputs. EX: (a, b, c) => (b, c, a)
> + * 2. Use a real hash, such as jhash_3words() from linux/jhash.h
> + */

I'm not one to throw stones as my spelling is terrible, but I wouldn't
be doing my job if I didn't ask you to run spellcheck on the comment
above.

> +static inline u32 hash3(u32 a, u32 b, u32 c, int bits)
> +{
> +       return hash_32(a + rol32(b, 11) + rol32(c, 22), bits);
> +}
> +
> +#endif /* #ifndef _SELINUX_HASH3_H */

...

> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 5fdcb6696bcc..bf24d8094019 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -85,6 +85,7 @@ struct avtab {
>         u32 nel;        /* number of elements */
>         u32 nslot;      /* number of hash slots */
>         u32 mask;       /* mask to compute hash func */
> +       u32 bits;       /* number of bits in mask */
>  };

We can get rid of the "mask" field, right?

-- 
paul moore
www.paul-moore.com
