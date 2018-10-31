Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACCEC0044C
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E962C2054F
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E962C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeKAAhC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:37:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39465 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeKAAhC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 20:37:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id g27so2059852oth.6
        for <selinux@vger.kernel.org>; Wed, 31 Oct 2018 08:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJccLG3Yi8igeK305jkZVQNu81oJcuZtAZhxktRI1hM=;
        b=mKVw5Y9q0Bz0ICJR+zuLtmKecxcGVNFjTIsk72wMeToGGhCijg0e9xT/JvMEiMGaUv
         mP4bPi+NEzQA+IWkjHiGFpQ01m9QJilTZLY0kS0u0+nkMUIJrBUaLEQHvgwzdf/mJuv2
         sOnsOHjn6GdL2Zcx7MMoBpXaK8VWYbwvdJn+LRoLAsPeck2DU5SiH16TuASSz1Vxp+L9
         CkDHhHES9YRQHutyS5JFJnzeQhntnGv7o8x7pRX0aGK9CCfufjkzoe1Y/2M0JgPtMFZP
         e1ZvGQi2Y+5crU98I0zJX0FdM8bFR0DLH8lONab5T0c6+6DnRySnPqkYtX/HOnbKLh6/
         Y5Kg==
X-Gm-Message-State: AGRZ1gKVsIZzC3+UMMfNZk32BSc/gh1xkq2FkKxxoZ3IUZ+k6ApBN0dV
        /UI5PIUKsv3QlzANZNxdsd3NSaHSBu7bflzn/ax1o/y0
X-Google-Smtp-Source: AJdET5dGwExtqKqwgx3cY+yR1lTNsQWMKHTyM0NBY9qyFWi2BFmhSVUFA1lVeawluCZTuyMyXqqXiZ7+455M4pD1JQs=
X-Received: by 2002:a9d:5714:: with SMTP id p20mr2030197oth.250.1541000310128;
 Wed, 31 Oct 2018 08:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181031122718.18735-1-omosnace@redhat.com> <20181031122718.18735-3-omosnace@redhat.com>
 <CAFqZXNv1M-01c+KHH_uXJdHq7b6ewPyZwRPc385xaMRZB83SoA@mail.gmail.com>
In-Reply-To: <CAFqZXNv1M-01c+KHH_uXJdHq7b6ewPyZwRPc385xaMRZB83SoA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 31 Oct 2018 16:38:18 +0100
Message-ID: <CAFqZXNs+WvsZe_EhfepEfBCexkCPUqUUTB8+fa5TwxRzUtio5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: fix ENOMEM errors during policy reload
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 31, 2018 at 4:24 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Oct 31, 2018 at 1:28 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Before this patch, during a policy reload the sidtab would become frozen
> > and trying to map a new context to SID would be unable to add a new
> > entry to sidtab and fail with -ENOMEM.
> >
> > Such failures are usually propagated into userspace, which has no way of
> > distignuishing them from actual allocation failures and thus doesn't
> > handle them gracefully. Such situation can be triggered e.g. by the
> > following reproducer:
> >
> >     while true; do load_policy; echo -n .; sleep 0.1; done &
> >     for (( i = 0; i < 1024; i++ )); do
> >         runcon -l s0:c$i echo -n x || break
> >         # or:
> >         # chcon -l s0:c$i <some_file> || break
> >     done
> >
> > This patchs overhauls the sidtab so it doesn't need to be frozen during
> > a policy reload, thus solving the above problem.
> >
> > The new SID table entries now contain two slots for the context. One of
> > the slots is used for the lookup and the other one is used during policy
> > reload to store the new converted context. Which slot is used for what
> > is determined by a shared index that is toggled between 0 and 1 when the
> > conversion is completed, together with the switch to the new policy.
> > After the index is toggled, the contexts in the now unused slots are
> > destroyed. The solution also gracefully handles conversion of entries
> > that are added to sidtab while the conversion is in progress.
> >
> > The downside of this solution is that the sidtab now takes up
> > approximately twice the space and half of it is used only during policy
> > reload. On the other hand, this means we do not need to deal with sidtab
> > growing while we are allocating a new one.
> >
> > Reported-by: Orion Poplawski <orion@nwra.com>
> > Reported-by: Li Kun <hw.likun@huawei.com>
> > Link: https://github.com/SELinuxProject/selinux-kernel/issues/38
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/mls.c      |  16 ++---
> >  security/selinux/ss/mls.h      |   3 +-
> >  security/selinux/ss/services.c |  96 +++++++-------------------
> >  security/selinux/ss/sidtab.c   | 122 +++++++++++++++++++++------------
> >  security/selinux/ss/sidtab.h   |  23 ++++---
> >  5 files changed, 124 insertions(+), 136 deletions(-)
> >
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index cd637ee3fb11..bc3f93732658 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -441,11 +441,11 @@ int mls_setup_user_range(struct policydb *p,
> >   */
> >  int mls_convert_context(struct policydb *oldp,
>
> I just realized I should update the comment above this function. I
> staged it for v2, but I will wait for more feedback before sending a
> new version.
>
> >                         struct policydb *newp,
> > -                       struct context *c)
> > +                       struct context *oldc,
> > +                       struct context *newc)
> >  {
> >         struct level_datum *levdatum;
> >         struct cat_datum *catdatum;
> > -       struct ebitmap bitmap;
> >         struct ebitmap_node *node;
> >         int l, i;
> >
> > @@ -455,28 +455,26 @@ int mls_convert_context(struct policydb *oldp,
> >         for (l = 0; l < 2; l++) {
> >                 levdatum = hashtab_search(newp->p_levels.table,
> >                                           sym_name(oldp, SYM_LEVELS,
> > -                                                  c->range.level[l].sens - 1));
> > +                                                  oldc->range.level[l].sens - 1));
> >
> >                 if (!levdatum)
> >                         return -EINVAL;
> > -               c->range.level[l].sens = levdatum->level->sens;
> > +               newc->range.level[l].sens = levdatum->level->sens;
> >
> > -               ebitmap_init(&bitmap);
> > -               ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
> > +               ebitmap_for_each_positive_bit(&oldc->range.level[l].cat, node, i) {
> >                         int rc;
> >
> >                         catdatum = hashtab_search(newp->p_cats.table,
> >                                                   sym_name(oldp, SYM_CATS, i));
> >                         if (!catdatum)
> >                                 return -EINVAL;
> > -                       rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
> > +                       rc = ebitmap_set_bit(&newc->range.level[l].cat,
> > +                                            catdatum->value - 1, 1);
> >                         if (rc)
> >                                 return rc;
> >
> >                         cond_resched();
> >                 }
> > -               ebitmap_destroy(&c->range.level[l].cat);
> > -               c->range.level[l].cat = bitmap;
> >         }
> >
> >         return 0;
> > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > index 1eca02c8bc5f..00c11304f71a 100644
> > --- a/security/selinux/ss/mls.h
> > +++ b/security/selinux/ss/mls.h
> > @@ -46,7 +46,8 @@ int mls_range_set(struct context *context, struct mls_range *range);
> >
> >  int mls_convert_context(struct policydb *oldp,
> >                         struct policydb *newp,
> > -                       struct context *context);
> > +                       struct context *oldc,
> > +                       struct context *newc);
> >
> >  int mls_compute_sid(struct policydb *p,
> >                     struct context *scontext,
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 550a00004139..292a2ccbe56f 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1899,12 +1899,6 @@ int security_change_sid(struct selinux_state *state,
> >                                     out_sid, false);
> >  }
> >
> > -/* Clone the SID into the new SID table. */
> > -static int clone_sid(u32 sid, struct context *context, void *arg)
> > -{
> > -       return sidtab_insert((struct sidtab *)arg, sid, context);
> > -}
> > -
> >  static inline int convert_context_handle_invalid_context(
> >         struct selinux_state *state,
> >         struct context *context)
> > @@ -1937,12 +1931,10 @@ struct convert_context_args {
> >   * in the policy `p->newp'.  Verify that the
> >   * context is valid under the new policy.
> >   */
> > -static int convert_context(u32 key, struct context *c, void *p)
> > +static int convert_context(struct context *oldc, struct context *newc, void *p)

Same here.

> >  {
> >         struct convert_context_args *args;
> > -       struct context oldc;
> >         struct ocontext *oc;
> > -       struct mls_range *range;
> >         struct role_datum *role;
> >         struct type_datum *typdatum;
> >         struct user_datum *usrdatum;
> > @@ -1952,23 +1944,18 @@ static int convert_context(u32 key, struct context *c, void *p)
> >
> >         args = p;
> >
> > -       if (c->str) {
> > -               struct context ctx;
> > -
> > +       if (oldc->str) {
> >                 rc = -ENOMEM;
> > -               s = kstrdup(c->str, GFP_KERNEL);
> > +               s = kstrdup(oldc->str, GFP_KERNEL);
> >                 if (!s)
> >                         goto out;
> >
> >                 rc = string_to_context_struct(args->newp, NULL, s,
> > -                                             &ctx, SECSID_NULL);
> > +                                             newc, SECSID_NULL);
> >                 kfree(s);
> >                 if (!rc) {
> >                         pr_info("SELinux:  Context %s became valid (mapped).\n",
> > -                              c->str);
> > -                       /* Replace string with mapped representation. */
> > -                       kfree(c->str);
> > -                       memcpy(c, &ctx, sizeof(*c));
> > +                               oldc->str);
> >                         goto out;
> >                 } else if (rc == -EINVAL) {
> >                         /* Retain string representation for later mapping. */
> > @@ -1977,51 +1964,42 @@ static int convert_context(u32 key, struct context *c, void *p)
> >                 } else {
> >                         /* Other error condition, e.g. ENOMEM. */
> >                         pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
> > -                              c->str, -rc);
> > +                              oldc->str, -rc);
> >                         goto out;
> >                 }
> >         }
> >
> > -       rc = context_cpy(&oldc, c);
> > -       if (rc)
> > -               goto out;
> > +       context_init(newc);
> >
> >         /* Convert the user. */
> >         rc = -EINVAL;
> >         usrdatum = hashtab_search(args->newp->p_users.table,
> > -                                 sym_name(args->oldp, SYM_USERS, c->user - 1));
> > +                                 sym_name(args->oldp, SYM_USERS, oldc->user - 1));
> >         if (!usrdatum)
> >                 goto bad;
> > -       c->user = usrdatum->value;
> > +       newc->user = usrdatum->value;
> >
> >         /* Convert the role. */
> >         rc = -EINVAL;
> >         role = hashtab_search(args->newp->p_roles.table,
> > -                             sym_name(args->oldp, SYM_ROLES, c->role - 1));
> > +                             sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
> >         if (!role)
> >                 goto bad;
> > -       c->role = role->value;
> > +       newc->role = role->value;
> >
> >         /* Convert the type. */
> >         rc = -EINVAL;
> >         typdatum = hashtab_search(args->newp->p_types.table,
> > -                                 sym_name(args->oldp, SYM_TYPES, c->type - 1));
> > +                                 sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
> >         if (!typdatum)
> >                 goto bad;
> > -       c->type = typdatum->value;
> > +       newc->type = typdatum->value;
> >
> >         /* Convert the MLS fields if dealing with MLS policies */
> >         if (args->oldp->mls_enabled && args->newp->mls_enabled) {
> > -               rc = mls_convert_context(args->oldp, args->newp, c);
> > +               rc = mls_convert_context(args->oldp, args->newp, oldc, newc);
> >                 if (rc)
> >                         goto bad;
> > -       } else if (args->oldp->mls_enabled && !args->newp->mls_enabled) {
> > -               /*
> > -                * Switching between MLS and non-MLS policy:
> > -                * free any storage used by the MLS fields in the
> > -                * context for all existing entries in the sidtab.
> > -                */
> > -               mls_context_destroy(c);
> >         } else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
> >                 /*
> >                  * Switching between non-MLS and MLS policy:
> > @@ -2039,36 +2017,31 @@ static int convert_context(u32 key, struct context *c, void *p)
> >                                 " the initial SIDs list\n");
> >                         goto bad;
> >                 }
> > -               range = &oc->context[0].range;
> > -               rc = mls_range_set(c, range);
> > +               rc = mls_range_set(newc, &oc->context[0].range);
> >                 if (rc)
> >                         goto bad;
> >         }
> >
> >         /* Check the validity of the new context. */
> > -       if (!policydb_context_isvalid(args->newp, c)) {
> > -               rc = convert_context_handle_invalid_context(args->state,
> > -                                                           &oldc);
> > +       if (!policydb_context_isvalid(args->newp, newc)) {
> > +               rc = convert_context_handle_invalid_context(args->state, oldc);
> >                 if (rc)
> >                         goto bad;
> >         }
> >
> > -       context_destroy(&oldc);
> > -
> >         rc = 0;
> >  out:
> >         return rc;
> >  bad:
> >         /* Map old representation to string and save it. */
> > -       rc = context_struct_to_string(args->oldp, &oldc, &s, &len);
> > +       rc = context_struct_to_string(args->oldp, oldc, &s, &len);
> >         if (rc)
> >                 return rc;
> > -       context_destroy(&oldc);
> > -       context_destroy(c);
> > -       c->str = s;
> > -       c->len = len;
> > +       context_destroy(newc);
> > +       newc->str = s;
> > +       newc->len = len;
> >         pr_info("SELinux:  Context %s became invalid (unmapped).\n",
> > -              c->str);
> > +               newc->str);
> >         rc = 0;
> >         goto out;
> >  }
> > @@ -2113,7 +2086,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >         struct sidtab *sidtab;
> >         struct isidtab *newisidtab = NULL;
> >         struct policydb *oldpolicydb, *newpolicydb;
> > -       struct sidtab oldsidtab, newsidtab;
> >         struct selinux_mapping *oldmapping;
> >         struct selinux_map newmap;
> >         struct convert_context_args args;
> > @@ -2187,12 +2159,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >         if (rc)
> >                 goto out;
> >
> > -       rc = sidtab_init(&newsidtab);
> > -       if (rc) {
> > -               policydb_destroy(newpolicydb);
> > -               goto out;
> > -       }
> > -
> >         newpolicydb->len = len;
> >         /* If switching between different policy types, log MLS status */
> >         if (policydb->mls_enabled && !newpolicydb->mls_enabled)
> > @@ -2203,7 +2169,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >         rc = policydb_load_isids(newpolicydb, newisidtab);
> >         if (rc) {
> >                 pr_err("SELinux:  unable to load the initial SIDs\n");
> > -               sidtab_destroy(&newsidtab);
> >                 policydb_destroy(newpolicydb);
> >                 goto out;
> >         }
> > @@ -2218,21 +2183,14 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >                 goto err;
> >         }
> >
> > -       /* Clone the SID table. */
> > -       sidtab_shutdown(sidtab);
> > -
> > -       rc = sidtab_map(sidtab, clone_sid, &newsidtab);
> > -       if (rc)
> > -               goto err;
> > -
> >         /*
> >          * Convert the internal representations of contexts
> > -        * in the new SID table.
> > +        * in the SID table.
> >          */
> >         args.state = state;
> >         args.oldp = policydb;
> >         args.newp = newpolicydb;
> > -       rc = sidtab_map(&newsidtab, convert_context, &args);
> > +       rc = sidtab_convert_start(sidtab, convert_context, &args);
> >         if (rc) {
> >                 pr_err("SELinux:  unable to convert the internal"
> >                         " representation of contexts in the new SID"
> > @@ -2242,19 +2200,18 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >
> >         /* Save the old policydb and SID table to free later. */
> >         memcpy(oldpolicydb, policydb, sizeof(*policydb));
> > -       sidtab_set(&oldsidtab, sidtab);
> >
> >         /* Install the new policydb and SID table. */
> >         write_lock_irq(&state->ss->policy_rwlock);
> >
> >         memcpy(policydb, newpolicydb, sizeof(*policydb));
> > -       sidtab_set(sidtab, &newsidtab);
> >
> >         isidtab_destroy(state->ss->isidtab);
> >         kfree(state->ss->isidtab);
> >         state->ss->isidtab = newisidtab;
> >         newisidtab = NULL;
> >
> > +       sidtab_convert_finish(sidtab);
> >         security_load_policycaps(state);
> >         oldmapping = state->ss->map.mapping;
> >         state->ss->map.mapping = newmap.mapping;
> > @@ -2264,8 +2221,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >         write_unlock_irq(&state->ss->policy_rwlock);
> >
> >         /* Free the old policydb and SID table. */
> > +       sidtab_convert_cleanup(sidtab);
> >         policydb_destroy(oldpolicydb);
> > -       sidtab_destroy(&oldsidtab);
> >         kfree(oldmapping);
> >
> >         avc_ss_reset(state->avc, seqno);
> > @@ -2279,7 +2236,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
> >
> >  err:
> >         kfree(newmap.mapping);
> > -       sidtab_destroy(&newsidtab);
> >         policydb_destroy(newpolicydb);
> >         isidtab_destroy(newisidtab);
> >
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index 98710657a596..ac4781a191d9 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -24,16 +24,17 @@ int sidtab_init(struct sidtab *s)
> >                 return -ENOMEM;
> >         for (i = 0; i < SIDTAB_SIZE; i++)
> >                 s->htable[i] = NULL;
> > +       s->context_index = 0;
> >         s->nel = 0;
> >         s->next_sid = SECINITSID_NUM + 1;
> > -       s->shutdown = 0;

Aaand, I forgot to initialize s->convert(_args)? here...

> >         spin_lock_init(&s->lock);
> >         return 0;
> >  }
> >
> > -int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
> > +static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
> >  {
> > -       int hvalue;
> > +       unsigned int index = s->context_index;
> > +       int hvalue, rc;
> >         struct sidtab_node *prev, *cur, *newnode;
> >
> >         if (!s)
> > @@ -55,11 +56,23 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
> >                 return -ENOMEM;
> >
> >         newnode->sid = sid;
> > -       if (context_cpy(&newnode->context, context)) {
> > +       if (context_cpy(&newnode->context[index], context)) {
> >                 kfree(newnode);
> >                 return -ENOMEM;
> >         }
> >
> > +       newnode->new_set = 0;
> > +       if (s->convert) {
> > +               rc = s->convert(&newnode->context[index],
> > +                               &newnode->context[!index], s->convert_args);
> > +               if (rc) {
> > +                       context_destroy(&newnode->context[index]);
> > +                       kfree(newnode);
> > +                       return rc;
> > +               }
> > +               newnode->new_set = 1;
> > +       }
> > +
> >         if (prev) {
> >                 newnode->next = prev->next;
> >                 wmb();
> > @@ -92,34 +105,74 @@ struct context *sidtab_lookup(struct sidtab *s, u32 sid)
> >         if (!cur || sid != cur->sid)
> >                 return NULL;
> >
> > -       return &cur->context;
> > +       return &cur->context[s->context_index];
> >  }
> >
> > -int sidtab_map(struct sidtab *s,
> > -              int (*apply) (u32 sid,
> > -                            struct context *context,
> > -                            void *args),
> > -              void *args)
> > +int sidtab_convert_start(struct sidtab *s, sidtab_convert_t convert, void *args)
> >  {
> > -       int i, rc = 0;
> > +       unsigned long flags;
> > +       int i, rc;
> >         struct sidtab_node *cur;
> >
> > -       if (!s)
> > -               goto out;
> > +       spin_lock_irqsave(&s->lock, flags);
> > +       s->convert = convert;
> > +       s->convert_args = args;
> > +       spin_unlock_irqrestore(&s->lock, flags);
> >
> >         for (i = 0; i < SIDTAB_SIZE; i++) {
> >                 cur = s->htable[i];
> >                 while (cur) {
> > -                       rc = apply(cur->sid, &cur->context, args);
> > -                       if (rc)
> > -                               goto out;
> > +                       if (!cur->new_set) {
> > +                               rc = convert(&cur->context[s->context_index],
> > +                                            &cur->context[!s->context_index],
> > +                                            args);
> > +                               if (rc)
> > +                                       goto err;
> > +
> > +                               cur->new_set = 1;
> > +                       }
> >                         cur = cur->next;
> >                 }
> >         }
> > -out:
> > +
> > +       return 0;
> > +err:
> > +       /* cleanup on conversion failure */
> > +       spin_lock_irqsave(&s->lock, flags);
> > +       s->convert = NULL;
> > +       s->convert_args = NULL;
> > +       spin_unlock_irqrestore(&s->lock, flags);
> > +
> > +       sidtab_convert_cleanup(s);
> > +
> >         return rc;
> >  }
> >
> > +/* must be called with policy write lock (thus no need to lock the spinlock here) */
> > +void sidtab_convert_finish(struct sidtab *s)
> > +{
> > +       s->context_index = !s->context_index;
> > +       s->convert = NULL;
> > +       s->convert_args = NULL;
> > +}
> > +
> > +void sidtab_convert_cleanup(struct sidtab *s)
> > +{
> > +       struct sidtab_node *cur;
> > +       int i;
> > +
> > +       for (i = 0; i < SIDTAB_SIZE; i++) {
> > +               cur = s->htable[i];
> > +               while (cur) {
> > +                       if (cur->new_set) {
> > +                               cur->new_set = 0;
> > +                               context_destroy(&cur->context[!s->context_index]);
> > +                       }
> > +                       cur = cur->next;
> > +               }
> > +       }
> > +}
> > +
> >  static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc)
> >  {
> >         BUG_ON(loc >= SIDTAB_CACHE_LEN);
> > @@ -132,7 +185,7 @@ static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc
> >  }
> >
> >  static inline u32 sidtab_search_context(struct sidtab *s,
> > -                                                 struct context *context)
> > +                                       struct context *context)
> >  {
> >         int i;
> >         struct sidtab_node *cur;
> > @@ -140,7 +193,7 @@ static inline u32 sidtab_search_context(struct sidtab *s,
> >         for (i = 0; i < SIDTAB_SIZE; i++) {
> >                 cur = s->htable[i];
> >                 while (cur) {
> > -                       if (context_cmp(&cur->context, context)) {
> > +                       if (context_cmp(&cur->context[s->context_index], context)) {
> >                                 sidtab_update_cache(s, cur, SIDTAB_CACHE_LEN - 1);
> >                                 return cur->sid;
> >                         }
> > @@ -159,7 +212,7 @@ static inline u32 sidtab_search_cache(struct sidtab *s, struct context *context)
> >                 node = s->cache[i];
> >                 if (unlikely(!node))
> >                         return 0;
> > -               if (context_cmp(&node->context, context)) {
> > +               if (context_cmp(&node->context[s->context_index], context)) {
> >                         sidtab_update_cache(s, node, i);
> >                         return node->sid;
> >                 }
> > @@ -187,7 +240,7 @@ int sidtab_context_to_sid(struct sidtab *s,
> >                 if (sid)
> >                         goto unlock_out;
> >                 /* No SID exists for the context.  Allocate a new one. */
> > -               if (s->next_sid == UINT_MAX || s->shutdown) {
> > +               if (s->next_sid == UINT_MAX) {
> >                         ret = -ENOMEM;
> >                         goto unlock_out;
> >                 }
> > @@ -249,7 +302,9 @@ void sidtab_destroy(struct sidtab *s)
> >                 while (cur) {
> >                         temp = cur;
> >                         cur = cur->next;
> > -                       context_destroy(&temp->context);
> > +                       context_destroy(&temp->context[s->context_index]);
> > +                       if (temp->new_set)
> > +                               context_destroy(&temp->context[!s->context_index]);
> >                         kfree(temp);
> >                 }
> >                 s->htable[i] = NULL;
> > @@ -260,26 +315,3 @@ void sidtab_destroy(struct sidtab *s)
> >         s->next_sid = 1;
> >  }
> >
> > -void sidtab_set(struct sidtab *dst, struct sidtab *src)
> > -{
> > -       unsigned long flags;
> > -       int i;
> > -
> > -       spin_lock_irqsave(&src->lock, flags);
> > -       dst->htable = src->htable;
> > -       dst->nel = src->nel;
> > -       dst->next_sid = src->next_sid;
> > -       dst->shutdown = 0;
> > -       for (i = 0; i < SIDTAB_CACHE_LEN; i++)
> > -               dst->cache[i] = NULL;
> > -       spin_unlock_irqrestore(&src->lock, flags);
> > -}
> > -
> > -void sidtab_shutdown(struct sidtab *s)
> > -{
> > -       unsigned long flags;
> > -
> > -       spin_lock_irqsave(&s->lock, flags);
> > -       s->shutdown = 1;
> > -       spin_unlock_irqrestore(&s->lock, flags);
> > -}
> > diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> > index 2eadd09a1100..85ed33238dbb 100644
> > --- a/security/selinux/ss/sidtab.h
> > +++ b/security/selinux/ss/sidtab.h
> > @@ -11,8 +11,9 @@
> >  #include "context.h"
> >
> >  struct sidtab_node {
> > -       u32 sid;                /* security identifier */
> > -       struct context context; /* security context structure */
> > +       u32 sid;                        /* security identifier */
> > +       int new_set;                    /* is context for new policy set? */
> > +       struct context context[2];      /* security context structures */
> >         struct sidtab_node *next;
> >  };
> >
> > @@ -22,25 +23,27 @@ struct sidtab_node {
> >
> >  #define SIDTAB_SIZE SIDTAB_HASH_BUCKETS
> >
> > +typedef int (*sidtab_convert_t)(struct context *oldc, struct context *newc,
> > +                               void *args);
> > +
> >  struct sidtab {
> >         struct sidtab_node **htable;
> > +       unsigned int context_index;
> >         unsigned int nel;       /* number of elements */
> >         unsigned int next_sid;  /* next SID to allocate */
> > -       unsigned char shutdown;
> > +       sidtab_convert_t convert;
> > +       void *convert_args;
> >  #define SIDTAB_CACHE_LEN       3
> >         struct sidtab_node *cache[SIDTAB_CACHE_LEN];
> >         spinlock_t lock;
> >  };
> >
> >  int sidtab_init(struct sidtab *s);
> > -int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
> >  struct context *sidtab_lookup(struct sidtab *s, u32 sid);
> >
> > -int sidtab_map(struct sidtab *s,
> > -              int (*apply) (u32 sid,
> > -                            struct context *context,
> > -                            void *args),
> > -              void *args);
> > +int sidtab_convert_start(struct sidtab *s, sidtab_convert_t convert, void *args);
> > +void sidtab_convert_finish(struct sidtab *s);
> > +void sidtab_convert_cleanup(struct sidtab *s);
> >
> >  int sidtab_context_to_sid(struct sidtab *s,
> >                           struct context *context,
> > @@ -48,8 +51,6 @@ int sidtab_context_to_sid(struct sidtab *s,
> >
> >  void sidtab_hash_eval(struct sidtab *h, char *tag);
> >  void sidtab_destroy(struct sidtab *s);
> > -void sidtab_set(struct sidtab *dst, struct sidtab *src);
> > -void sidtab_shutdown(struct sidtab *s);
> >
> >  #endif /* _SS_SIDTAB_H_ */
> >
> > --
> > 2.17.2
> >
>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
