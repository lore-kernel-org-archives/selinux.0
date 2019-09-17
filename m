Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2FBC4CEC9
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36182214AF
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfIQKX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfIQKX5 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 17 Sep 2019 06:23:57 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5F464E938
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2019 10:23:56 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id i20so1435665oib.5
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2019 03:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4w5paCQbx0h/VxhFiWqi15zJohNv/4M1/ki7IJf5EA=;
        b=nd4Dy4VDC7XVIoNS5sYI8VcpeZx9+YCI8F9YgsMKShfJT5a1mcQgeVlrf3JgONZr5G
         OsyO26bw1umAZ6cemfq7OtNuUh1tbUHCal8wOwX8h1rK+wGiwEVa1fBwcoc+2IQgg4Om
         K0tzvCp4EPet61dWFKl9PM+bvjv8lHiUeYgBB4bimHVRYR5e4mcf+bL+IAfteGEo5Ktv
         6X1SjWYokTxkS4+efccLKv9m8RIbnL0KRziuG2eqy3IYQh4LWt5uqnSQ4jKral7b/7+0
         vd8fTtR/JkCnktEzhNbT7mY8sX3fbWBNoWKK++jYXEID3Pq8sxJR3U4VmwerlToEq+aw
         oZ5Q==
X-Gm-Message-State: APjAAAUIbCYdlEDG0vhbSwuf6P5o2b0x5+BkRBzR3FKvL9Pq7ZwwDFPq
        aJ45BmF80BrPSSv+zKxfw4y2enDzxXfv4D6k1DG9oJR2lG7aGQX6i0hTq0ZVSmUVl9dsYAByPi8
        o/CzA9GowaEDb3/5kGUM1M6MRYJ240rRetw==
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr2097382otn.197.1568715836072;
        Tue, 17 Sep 2019 03:23:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyETlncDHn0NddteETu+pjKD59VeyJ15p1+2jd4A2Xo9DxY+25S0gmdjWxQTWGOiQqvG63w9wsDZiHBQi4IGpQ=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr2097362otn.197.1568715835637;
 Tue, 17 Sep 2019 03:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190730124852.7670-1-omosnace@redhat.com> <2412f6e1-8f70-1ede-2776-79470083b912@tycho.nsa.gov>
 <e4390a08-4043-49bc-e792-c600d3183d5b@tycho.nsa.gov>
In-Reply-To: <e4390a08-4043-49bc-e792-c600d3183d5b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 17 Sep 2019 12:23:44 +0200
Message-ID: <CAFqZXNuEF9u7+HbeougzHjt294oMNF3YCbD+NqdXbf=x3g+hpQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize MLS context to string conversion
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 16, 2019 at 7:30 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/16/19 10:43 AM, Stephen Smalley wrote:
> > On 7/30/19 8:48 AM, Ondrej Mosnacek wrote:
> >> When mls_compute_context_len() or mls_sid_to_context() encounters a
> >> context with large category ranges, it behaves suboptimally - it
> >> traverses each positive bit of the category bitmap, each time calling
> >> find_next_bit() again.
> >>
> >> This has a large performance impact on UNIX datagram sockets with
> >> SO_PASSSEC set, since here the peer context needs to be converted to
> >> string for each recieved datagram. See [1] for more information.
> >>
> >> This patch introduces a new helper for ebitmap traversal, which allows
> >> to efficiently iterate over positive ranges instead of bits -
> >> ebitmap_for_each_positive_range() - and converts the two mls_*()
> >> functions to leverage it.
> >>
> >> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> >>
> >> Reported-by: Michal Sekletar <msekleta@redhat.com>
> >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >> ---
> >>   security/selinux/ss/ebitmap.h | 46 +++++++++++++++++++++
> >>   security/selinux/ss/mls.c     | 76 +++++++++++++----------------------
> >>   2 files changed, 73 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/security/selinux/ss/ebitmap.h
> >> b/security/selinux/ss/ebitmap.h
> >> index 6aa7cf6a2197..a415741cb206 100644
> >> --- a/security/selinux/ss/ebitmap.h
> >> +++ b/security/selinux/ss/ebitmap.h
> >> @@ -42,6 +42,10 @@ struct ebitmap {
> >>       u32 highbit;    /* highest position in the total bitmap */
> >>   };
> >> +struct ebitmap_range {
> >> +    unsigned int start, end;
> >> +};
> >> +
> >>   #define ebitmap_length(e) ((e)->highbit)
> >>   static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
> >> @@ -80,6 +84,43 @@ static inline unsigned int
> >> ebitmap_next_positive(struct ebitmap *e,
> >>       return ebitmap_length(e);
> >>   }
> >> +static inline unsigned int ebitmap_next_negative(struct ebitmap *e,
> >> +                         struct ebitmap_node **n,
> >> +                         unsigned int bit)
> >> +{
> >> +    unsigned int ofs;
> >> +
> >> +    ofs = find_next_zero_bit((*n)->maps, EBITMAP_SIZE,
> >> +                 bit - (*n)->startbit + 1);
> >> +    if (ofs < EBITMAP_SIZE)
> >> +        return ofs + (*n)->startbit;
> >> +
> >> +    for (*n = (*n)->next; *n; *n = (*n)->next) {
> >> +        ofs = find_first_zero_bit((*n)->maps, EBITMAP_SIZE);
> >> +        if (ofs < EBITMAP_SIZE)
> >> +            return ofs + (*n)->startbit;
> >> +    }
> >> +    return ebitmap_length(e);
> >> +}
> >
> > This is likely moot given that the patch was deferred on exploring the
> > cache option, but if/when this patch is revisited, you don't seem to
> > account for the possibility that there could be a hole between the
> > bitmaps represented by (*n) and (*n)->next, and that might be where the
> > next negative/zero bit is.
>
> You can see this bug manifest by doing the following:
> runcon -l s0:c0.c383,c768 bash
> id -Z
>
> The correct output of course would be s0:c0.c383,c768, but your patched
> kernel will report s0:c0.c768.

Yes, good catch! This patch would really need some focused testing
(and fixing) before being committed... Some simple fuzz test over
/sys/fs/selinux/context should be enough, but I didn't get as far as
to write it. Probably should have initially sent the patch just as
RFC, though...

>
> >
> >> +
> >> +static inline void ebitmap_start_positive_range(struct ebitmap *e,
> >> +                        struct ebitmap_node **n,
> >> +                        struct ebitmap_range *range)
> >> +{
> >> +    range->end = range->start = ebitmap_start_positive(e, n);
> >> +    if (range->start < ebitmap_length(e))
> >> +        range->end = ebitmap_next_negative(e, n, range->start);
> >> +}
> >> +
> >> +static inline void ebitmap_next_positive_range(struct ebitmap *e,
> >> +                           struct ebitmap_node **n,
> >> +                           struct ebitmap_range *range)
> >> +{
> >> +    range->end = range->start = ebitmap_next_positive(e, n, range->end);
> >> +    if (range->start < ebitmap_length(e))
> >> +        range->end = ebitmap_next_negative(e, n, range->start);
> >> +}
> >> +
> >>   #define EBITMAP_NODE_INDEX(node, bit)    \
> >>       (((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
> >>   #define EBITMAP_NODE_OFFSET(node, bit)    \
> >> @@ -122,6 +163,11 @@ static inline void ebitmap_node_clr_bit(struct
> >> ebitmap_node *n,
> >>            bit < ebitmap_length(e);            \
> >>            bit = ebitmap_next_positive(e, &n, bit))    \
> >> +#define ebitmap_for_each_positive_range(e, n, range)        \
> >> +    for (ebitmap_start_positive_range(e, &n, &range);    \
> >> +         range.start < ebitmap_length(e);            \
> >> +         ebitmap_next_positive_range(e, &n, &range))    \
> >> +
> >>   int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
> >>   int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> >>   int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32
> >> last_e2bit);
> >> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> >> index 5e05f5b902d7..3abd6b950c66 100644
> >> --- a/security/selinux/ss/mls.c
> >> +++ b/security/selinux/ss/mls.c
> >> @@ -35,10 +35,12 @@
> >>    */
> >>   int mls_compute_context_len(struct policydb *p, struct context
> >> *context)
> >>   {
> >> -    int i, l, len, head, prev;
> >> +    int l, len;
> >>       char *nm;
> >>       struct ebitmap *e;
> >>       struct ebitmap_node *node;
> >> +    struct ebitmap_range range;
> >> +    unsigned int rlen;
> >>       if (!p->mls_enabled)
> >>           return 0;
> >> @@ -49,24 +51,14 @@ int mls_compute_context_len(struct policydb *p,
> >> struct context *context)
> >>           len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
> >>           /* categories */
> >> -        head = -2;
> >> -        prev = -2;
> >>           e = &context->range.level[l].cat;
> >> -        ebitmap_for_each_positive_bit(e, node, i) {
> >> -            if (i - prev > 1) {
> >> -                /* one or more negative bits are skipped */
> >> -                if (head != prev) {
> >> -                    nm = sym_name(p, SYM_CATS, prev);
> >> -                    len += strlen(nm) + 1;
> >> -                }
> >> -                nm = sym_name(p, SYM_CATS, i);
> >> +        ebitmap_for_each_positive_range(e, node, range) {
> >> +            rlen = range.end - range.start;
> >> +            if (rlen > 1) {
> >> +                nm = sym_name(p, SYM_CATS, range.start);
> >>                   len += strlen(nm) + 1;
> >> -                head = i;
> >>               }
> >> -            prev = i;
> >> -        }
> >> -        if (prev != head) {
> >> -            nm = sym_name(p, SYM_CATS, prev);
> >> +            nm = sym_name(p, SYM_CATS, range.end - 1);
> >>               len += strlen(nm) + 1;
> >>           }
> >>           if (l == 0) {
> >> @@ -91,9 +83,11 @@ void mls_sid_to_context(struct policydb *p,
> >>               char **scontext)
> >>   {
> >>       char *scontextp, *nm;
> >> -    int i, l, head, prev;
> >> +    int l, first;
> >>       struct ebitmap *e;
> >>       struct ebitmap_node *node;
> >> +    struct ebitmap_range range;
> >> +    unsigned int rlen;
> >>       if (!p->mls_enabled)
> >>           return;
> >> @@ -109,43 +103,27 @@ void mls_sid_to_context(struct policydb *p,
> >>           scontextp += strlen(scontextp);
> >>           /* categories */
> >> -        head = -2;
> >> -        prev = -2;
> >> +        first = 1;
> >>           e = &context->range.level[l].cat;
> >> -        ebitmap_for_each_positive_bit(e, node, i) {
> >> -            if (i - prev > 1) {
> >> -                /* one or more negative bits are skipped */
> >> -                if (prev != head) {
> >> -                    if (prev - head > 1)
> >> -                        *scontextp++ = '.';
> >> -                    else
> >> -                        *scontextp++ = ',';
> >> -                    nm = sym_name(p, SYM_CATS, prev);
> >> -                    strcpy(scontextp, nm);
> >> -                    scontextp += strlen(nm);
> >> -                }
> >> -                if (prev < 0)
> >> -                    *scontextp++ = ':';
> >> -                else
> >> -                    *scontextp++ = ',';
> >> -                nm = sym_name(p, SYM_CATS, i);
> >> -                strcpy(scontextp, nm);
> >> -                scontextp += strlen(nm);
> >> -                head = i;
> >> -            }
> >> -            prev = i;
> >> -        }
> >> -
> >> -        if (prev != head) {
> >> -            if (prev - head > 1)
> >> -                *scontextp++ = '.';
> >> -            else
> >> +        ebitmap_for_each_positive_range(e, node, range) {
> >> +            if (first) {
> >> +                first = 0;
> >> +                *scontextp++ = ':';
> >> +            } else {
> >>                   *scontextp++ = ',';
> >> -            nm = sym_name(p, SYM_CATS, prev);
> >> +            }
> >> +            nm = sym_name(p, SYM_CATS, range.start);
> >>               strcpy(scontextp, nm);
> >>               scontextp += strlen(nm);
> >> -        }
> >> +            rlen = range.end - range.start;
> >> +            if (rlen > 1) {
> >> +                *scontextp++ = rlen > 2 ? '.' : ',';
> >> +                nm = sym_name(p, SYM_CATS, range.end - 1);
> >> +                strcpy(scontextp, nm);
> >> +                scontextp += strlen(nm);
> >> +            }
> >> +        }
> >>           if (l == 0) {
> >>               if (mls_level_eq(&context->range.level[0],
> >>                        &context->range.level[1]))
> >>
> >
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
