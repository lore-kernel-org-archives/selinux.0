Return-Path: <SRS0=Ozag=TN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94E9C04AA7
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979E2208CA
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfEMLQU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 May 2019 07:16:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36105 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfEMLQT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 May 2019 07:16:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so11348229otr.3
        for <selinux@vger.kernel.org>; Mon, 13 May 2019 04:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm6wx1lL6p0rOJ10CuG+sDRGSxH5VPlIs+mQh5TdjKA=;
        b=mHYoV7eT2zs+dg++q4SmeomwXF5+4jWlWOtalKQ1onXgOndxuy0MWRSU4U1I+xAkQl
         eaDMSjqPScVRXBcYm7WSzOHNHf4/0H3fTqHqHa1OLFrQtPxTY3LnvVU2hRgjUve5zQ4h
         3U6YRER3r5YmV/FCC9YfTcIouGq/AuOBSb/SRIMc/zuLmeY59DuCgQe0xFliLHWOf7t2
         MEMJxaMYMX7evK14TPnjshTrnTWQSKUXBk33S+QK2y7EWaVdCSxzc60oRfQrANSvwlWG
         NFfE0kGbeapLcUwUtd9RoP7W1AkC71a1Nl/A1HouFU+q6lN0lyox2iTZKT5jx3xlh/Nh
         LP8w==
X-Gm-Message-State: APjAAAWEXwsz097MsqXhxCHpXKzoOPzVcBOeU50YYVbX8Wn5ySucZXGP
        IcyKMvuwESlJ7t93UQ14w5bi2x5LTKD1uzH9Tx9/Hw==
X-Google-Smtp-Source: APXvYqz0xTgkcEBNhEsMj17KrwqRECbE4Evzuz/oCBtB4/msLAV5QyEwz0vV7z6stHqFecsfXpRQaIfqwPmthB0Va6E=
X-Received: by 2002:a9d:5e07:: with SMTP id d7mr15395251oti.21.1557746177940;
 Mon, 13 May 2019 04:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190506131213.31044-1-omosnace@redhat.com> <d0a812be-ab7c-4674-2125-c7156152db2c@tycho.nsa.gov>
In-Reply-To: <d0a812be-ab7c-4674-2125-c7156152db2c@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 May 2019 13:16:06 +0200
Message-ID: <CAFqZXNsUBtek6YY2qnCpqfTSJxpyyDfdf_zh_+f4LN2K0-nF_Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: support attributes in type transitions
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 6, 2019 at 11:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 5/6/19 9:12 AM, Ondrej Mosnacek wrote:
> > The amount of filename transition rules used in Fedora has grown a lot
> > due to many domains needing rules for correct /dev file labeling. This
> > has in turn caused the binary policy to increase in size a lot, too.
> >
> > To mitigate this, start properly handling type attributes in type
> > transitions so that userspace can avoid always expanding them and
> > generate smaller policies. (Note: adding attribute support only for
> > named transition rules would be enough, but this patch adds it to all
> > type transition rules to keep better consistency.)
> >
> > As an illustration, this change will reduce Fedora 31 binary policy from
> > ~8.4 MiB to only ~2.8 MiB (~250K type transition rules to ~28K). These
> > numbers only take into account named file transition rules; the
> > reduction from basic type transition rules is likely going to be much
> > less radical.
> >
> > The fact whether the kernel supports this feature is signaled to
> > userspace by an increment in policy version. With older policies the
> > transition computation is handled as before to avoid performance
> > regression.
>
> NB I haven't looked at the code itself yet.  However, my concerns with
> this change conceptually are:
>
> 1) The AVC does not cache security_transition_sid() results and
> therefore doing the attribute expansion at runtime versus policy
> build-time is likely to have a more significant runtime performance
> impact (for operations that involve security_transition_sid, e.g. file
> creation, socket creation, msgsnd(2)) than the corresponding impact from
> when we introduced attribute support for allow rules in the kernel
> (commit 782ebb992ec20b5afdd5786ee8c2f1b58b631f24), which was at least
> mitigated by caching.  This could perhaps be addressed by augmenting the
> AVC to cache security_transition_sid() results as well, as has already
> been done in the userspace AVC in libselinux (where the equivalent to
> security_transition_sid is security_compute_create(3) and the AVC
> provides an avc_compute_create(3) interface).  You note that you avoid a
> performance regression for older policies by falling back to the old
> logic, but that won't help with newer policies of course.

Yes, I'm probably underestimating the performance impact of the
change... I'm trying right now to collect some statistics to help
quantify the difference and try some optimization ideas.

>
> 2) Even with caching of results, we have seen performance problems with
> security_compute_av() having unacceptable latency when called on AVC
> misses due to types with many attributes, requiring a number of changes
> to the policy toolchain to allow better control over attribute expansion
> and retention, which would presumably also be needed here.  This change
> would further require retaining attributes used in type transitions in
> addition to those used in allow rules, which could impact the
> performance of security_compute_av() in addition to
> security_transition_sid().
>
> 3) IIRC, the pattern we saw when we made the equivalent change for allow
> rules was likewise an immediate drastic reduction in kernel memory usage
> (as reported in the commit message) followed by a long period of
> explosive allow rule growth in policy, ultimately bringing policy size
> and kernel memory usage back up to its prior levels (or worse).
> Subsequently there was significant work to shrink the policy through a
> major rewrite of allow rules to use attributes whenever possible. This
> in turn required the introduction of more attributes per type, which
> then harmed security_compute_av() performance as above. We want to avoid
> a similar cycle here.

Again, this is something that I will need to analyze via statistics
and think it through...

>
> 4) This change does not fix the limitation in the ability to support
> more flexible name-based transitions (e.g. simple wildcarding, file
> globs, or regex matching), which is another factor in the large number
> of name-based transition rules in Fedora policy and would benefit a
> wider set of use cases IMHO.

Yes, this feature remains relevant and no doubt would be very useful,
however I'm not sure how much work that would require... Implementing
even simplified regexes in the kernel sounds tricky... (or is there
already some library that we could use? I didn't check). But maybe in
the end it will be easier than going in the direction of this patch :)

>
> 5) It is unclear (to me) that Fedora truly needs to rely so heavily on
> name-based type transitions for /dev node labeling, or to define the
> transitions for so many domains, which ostensibly is the motivation for
> this change.  Fedora didn't appear to need these rules prior to the use
> of devtmpfs, and even with the use of devtmpfs, arguably these rules are
> only needed for kernel_t and maybe unconfined_t, not all unconfined
> domains. Name-based transitions were not designed to support general
> purpose /dev node labeling; they were supposed to only be to handle edge
> cases where userspace could not be modified to correctly label files and
> per-file granularity was required.  Neither upstream refpolicy nor
> Android employ large numbers of name-based transitions to my knowledge.
> We don't want to encourage misuse of these rules or further growth in them.

I don't have a deep understanding of this, but I'm not sure if we can
reliably enforce correct devtmpfs labeling in userspace (at least in
Fedora). There shouldn't be too many services that need/may create
files in devtmpfs, so they should probably be fixed, but now we have a
chicken-and-egg problem: we can't remove the rules before all these
cases are found and fixed, but as long as the rules are there, there
is no push for the issues to be fixed...

I'll see if I can implement this without adding too much complexity
and without killing performance. If not, then I'll probably just give
up on this front...

>
> That said, I'm willing to consider such a change, but I'd like to see
> that the above issues are adequately explored before accepting it.
>
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Very mildly tested by applying a proof-of-concept patch against
> > libsepol [1], which disables type attribute expansion on src/target of
> > named file transition rules, and running the following on Fedora Rawhide
> > (from an unconfined root shell):
> >
> >      mknod /dev/ram0 b 252 16
> >      ls -lZ /dev/ram0
> >      rm -f /dev/ram0
> >
> > Without this patch, the corresponding transition rule (which happens to
> > have an attribute specified as the source type) didn't apply and the
> > file got label device_t (as expected). With this patch (+ the policy
> > version fallback condition disabled), the rule applied as it should and
> > the file got labeled correctly as fixed_disk_device_t.
> >
> > We don't have a proper corresponding userspace patch yet, but I'd like
> > to have this patch out and get some feedback before moving on further.
> >
> > See RHBZ 1660142 [2] for original discussion leading to this patch.
> >
> > [1] https://github.com/WOnder93/selinux/commit/26283729657ec33b6743e929e1b5b40a54294043
> > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1660142
> >
> >   security/selinux/include/security.h |  33 +++---
> >   security/selinux/ss/services.c      | 177 ++++++++++++++++++++--------
> >   2 files changed, 147 insertions(+), 63 deletions(-)
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 111121281c47..aa6b5a689cb7 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -22,28 +22,29 @@
> >   #define SECCLASS_NULL                       0x0000 /* no class */
> >
> >   /* Identify specific policy version changes */
> > -#define POLICYDB_VERSION_BASE                15
> > -#define POLICYDB_VERSION_BOOL                16
> > -#define POLICYDB_VERSION_IPV6                17
> > -#define POLICYDB_VERSION_NLCLASS     18
> > -#define POLICYDB_VERSION_VALIDATETRANS       19
> > -#define POLICYDB_VERSION_MLS         19
> > -#define POLICYDB_VERSION_AVTAB               20
> > -#define POLICYDB_VERSION_RANGETRANS  21
> > -#define POLICYDB_VERSION_POLCAP              22
> > -#define POLICYDB_VERSION_PERMISSIVE  23
> > -#define POLICYDB_VERSION_BOUNDARY    24
> > -#define POLICYDB_VERSION_FILENAME_TRANS      25
> > -#define POLICYDB_VERSION_ROLETRANS   26
> > +#define POLICYDB_VERSION_BASE                        15
> > +#define POLICYDB_VERSION_BOOL                        16
> > +#define POLICYDB_VERSION_IPV6                        17
> > +#define POLICYDB_VERSION_NLCLASS             18
> > +#define POLICYDB_VERSION_VALIDATETRANS               19
> > +#define POLICYDB_VERSION_MLS                 19
> > +#define POLICYDB_VERSION_AVTAB                       20
> > +#define POLICYDB_VERSION_RANGETRANS          21
> > +#define POLICYDB_VERSION_POLCAP                      22
> > +#define POLICYDB_VERSION_PERMISSIVE          23
> > +#define POLICYDB_VERSION_BOUNDARY            24
> > +#define POLICYDB_VERSION_FILENAME_TRANS              25
> > +#define POLICYDB_VERSION_ROLETRANS           26
> >   #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS        27
> > -#define POLICYDB_VERSION_DEFAULT_TYPE        28
> > +#define POLICYDB_VERSION_DEFAULT_TYPE                28
> >   #define POLICYDB_VERSION_CONSTRAINT_NAMES   29
> > -#define POLICYDB_VERSION_XPERMS_IOCTL        30
> > +#define POLICYDB_VERSION_XPERMS_IOCTL                30
> >   #define POLICYDB_VERSION_INFINIBAND         31
> > +#define POLICYDB_VERSION_TYPE_TRANS_ATTR     32
> >
> >   /* Range of policy versions we understand*/
> >   #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> > -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
> > +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_TYPE_TRANS_ATTR
> >
> >   /* Mask for just the mount related flags */
> >   #define SE_MNTMASK  0x0f
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index cc043bc8fd4c..1e8293201184 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1610,30 +1610,137 @@ out:
> >       return -EACCES;
> >   }
> >
> > -static void filename_compute_type(struct policydb *policydb,
> > -                               struct context *newcontext,
> > -                               u32 stype, u32 ttype, u16 tclass,
> > -                               const char *objname)
> > +static void compute_type_noattr(struct policydb *policydb,
> > +                             struct context *newcontext,
> > +                             u32 stype, u32 ttype,
> > +                             u16 tclass, u32 specified,
> > +                             const char *objname)
> >   {
> > -     struct filename_trans ft;
> > -     struct filename_trans_datum *otype;
> > +     struct avtab_key avkey;
> > +     struct avtab_datum *avdatum = NULL;
> > +     struct avtab_node *node;
> >
> >       /*
> > -      * Most filename trans rules are going to live in specific directories
> > -      * like /dev or /var/run.  This bitmap will quickly skip rule searches
> > -      * if the ttype does not contain any rules.
> > +      * if we have a objname this is a file trans check so check those
> > +      * rules
> >        */
> > -     if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
> > +     if (objname) {
> > +             struct filename_trans ft;
> > +             struct filename_trans_datum *otype;
> > +
> > +             /*
> > +              * Most filename trans rules are going to live in specific
> > +              * directories like /dev or /var/run.  This bitmap will quickly
> > +              * skip rule searches if the ttype does not contain any rules.
> > +              */
> > +             if (ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype)) {
> > +                     ft.stype = stype;
> > +                     ft.ttype = ttype;
> > +                     ft.tclass = tclass;
> > +                     ft.name = objname;
> > +
> > +                     otype = hashtab_search(policydb->filename_trans, &ft);
> > +                     if (otype) {
> > +                             newcontext->type = otype->otype;
> > +                             return;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* Look for a type transition/member/change rule. */
> > +     avkey.source_type = stype;
> > +     avkey.target_type = ttype;
> > +     avkey.target_class = tclass;
> > +     avkey.specified = specified;
> > +     avdatum = avtab_search(&policydb->te_avtab, &avkey);
> > +     if (avdatum) {
> > +             newcontext->type = avdatum->u.data;
> >               return;
> > +     }
> > +
> > +     /* If no permanent rule, also check for enabled conditional rules */
> > +     node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
> > +     for (; node; node = avtab_search_node_next(node, specified)) {
> > +             if (node->key.specified & AVTAB_ENABLED) {
> > +                     newcontext->type = node->datum.u.data;
> > +                     return;
> > +             }
> > +     }
> > +}
> >
> > -     ft.stype = stype;
> > -     ft.ttype = ttype;
> > -     ft.tclass = tclass;
> > -     ft.name = objname;
> > +static void compute_type(struct policydb *policydb, struct context *newcontext,
> > +                      u32 stype, u32 ttype, u16 tclass, u32 specified,
> > +                      const char *objname)
> > +{
> > +     struct avtab_key avkey;
> > +     struct avtab_datum *avdatum = NULL;
> > +     struct avtab_node *node;
> > +     struct ebitmap *sattr, *tattr;
> > +     struct ebitmap_node *snode, *tnode;
> > +     unsigned int i, j;
> > +
> > +     sattr = &policydb->type_attr_map_array[stype - 1];
> > +     tattr = &policydb->type_attr_map_array[ttype - 1];
> > +
> > +     if (objname) {
> > +             struct filename_trans ft;
> > +             struct filename_trans_datum *otype;
> > +
> > +             ebitmap_for_each_positive_bit(tattr, tnode, j) {
> > +                     /*
> > +                      * Most filename trans rules are going to live in
> > +                      * specific directories like /dev or /var/run.  This
> > +                      * bitmap will quickly skip rule searches if the ttype
> > +                      * does not contain any rules.
> > +                      */
> > +                     if (!ebitmap_get_bit(&policydb->filename_trans_ttypes,
> > +                                          j + 1))
> > +                             continue;
> >
> > -     otype = hashtab_search(policydb->filename_trans, &ft);
> > -     if (otype)
> > -             newcontext->type = otype->otype;
> > +                     ebitmap_for_each_positive_bit(sattr, snode, i) {
> > +                             ft.stype = i + 1;
> > +                             ft.ttype = j + 1;
> > +                             ft.tclass = tclass;
> > +                             ft.name = objname;
> > +
> > +                             otype = hashtab_search(policydb->filename_trans,
> > +                                                    &ft);
> > +                             if (otype) {
> > +                                     newcontext->type = otype->otype;
> > +                                     return;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* Look for a type transition/member/change rule. */
> > +     avkey.target_class = tclass;
> > +     avkey.specified = specified;
> > +     ebitmap_for_each_positive_bit(sattr, snode, i) {
> > +             ebitmap_for_each_positive_bit(tattr, tnode, j) {
> > +                     avkey.source_type = i + 1;
> > +                     avkey.target_type = j + 1;
> > +                     avdatum = avtab_search(&policydb->te_avtab, &avkey);
> > +                     if (avdatum) {
> > +                             newcontext->type = avdatum->u.data;
> > +                             return;
> > +                     }
> > +
> > +                     /*
> > +                      * If no permanent rule, also check for enabled
> > +                      * conditional rules
> > +                      */
> > +                     node = avtab_search_node(&policydb->te_cond_avtab,
> > +                                              &avkey);
> > +                     for (; node;
> > +                          node = avtab_search_node_next(node, specified)) {
> > +                             if (node->key.specified & AVTAB_ENABLED) {
> > +                                     newcontext->type = node->datum.u.data;
> > +                                     return;
> > +                             }
> > +                     }
> > +             }
> > +     }
> >   }
> >
> >   static int security_compute_sid(struct selinux_state *state,
> > @@ -1650,9 +1757,6 @@ static int security_compute_sid(struct selinux_state *state,
> >       struct class_datum *cladatum = NULL;
> >       struct context *scontext = NULL, *tcontext = NULL, newcontext;
> >       struct role_trans *roletr = NULL;
> > -     struct avtab_key avkey;
> > -     struct avtab_datum *avdatum;
> > -     struct avtab_node *node;
> >       u16 tclass;
> >       int rc = 0;
> >       bool sock;
> > @@ -1748,33 +1852,12 @@ static int security_compute_sid(struct selinux_state *state,
> >               }
> >       }
> >
> > -     /* Look for a type transition/member/change rule. */
> > -     avkey.source_type = scontext->type;
> > -     avkey.target_type = tcontext->type;
> > -     avkey.target_class = tclass;
> > -     avkey.specified = specified;
> > -     avdatum = avtab_search(&policydb->te_avtab, &avkey);
> > -
> > -     /* If no permanent rule, also check for enabled conditional rules */
> > -     if (!avdatum) {
> > -             node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
> > -             for (; node; node = avtab_search_node_next(node, specified)) {
> > -                     if (node->key.specified & AVTAB_ENABLED) {
> > -                             avdatum = &node->datum;
> > -                             break;
> > -                     }
> > -             }
> > -     }
> > -
> > -     if (avdatum) {
> > -             /* Use the type from the type transition/member/change rule. */
> > -             newcontext.type = avdatum->u.data;
> > -     }
> > -
> > -     /* if we have a objname this is a file trans check so check those rules */
> > -     if (objname)
> > -             filename_compute_type(policydb, &newcontext, scontext->type,
> > -                                   tcontext->type, tclass, objname);
> > +     if (policydb->policyvers < POLICYDB_VERSION_TYPE_TRANS_ATTR)
> > +             compute_type_noattr(policydb, &newcontext, scontext->type,
> > +                                 tcontext->type, tclass, specified, objname);
> > +     else
> > +             compute_type(policydb, &newcontext, scontext->type,
> > +                          tcontext->type, tclass, specified, objname);
> >
> >       /* Check for class-specific changes. */
> >       if (specified & AVTAB_TRANSITION) {
> >

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
