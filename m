Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72FC3524D
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD42070A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbFvezBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCJNX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:13:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbgBCJNX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 04:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580721202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YOTFBDC78Y54R1ZdPML+pzhyWtKQDSDAUsA23By8Wg=;
        b=CbFvezBoL+tNr/uXlsKdId4Y3APQXOg/rJ2ETL18I22mr3cEiXn9Rwcc9fVdWXgGgpCjTi
        TgjHG1twZazyslw4SeKOx3qzduOvyVIULtcegwU8XC67hYfQavTtfyMEXn7uYtSB5c3FYK
        cVK+pCUps966dfu/Oa+4mTCQY1t4wrE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-69Y18HLnP1WGn2nwbahcVQ-1; Mon, 03 Feb 2020 04:13:20 -0500
X-MC-Unique: 69Y18HLnP1WGn2nwbahcVQ-1
Received: by mail-ot1-f69.google.com with SMTP id a20so8709042otl.11
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 01:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YOTFBDC78Y54R1ZdPML+pzhyWtKQDSDAUsA23By8Wg=;
        b=n6qdEYFLdcGJy7kECMVFIcbKQw95MKW5TVgLanCpRSEjEbeIWQ1nBdKMEjDQAgQ9D4
         ErJvto1yG3ANzQhWJUqgOh+WlP3YJ/vbqMod6lx0bIUwKAbAUYqw0tDHbPBGnVw+zbt9
         FKoYr+LUNWNnscy/EjMAvN58X0ZVDFfSyEIqrtn7GCNh6rLsJvSaC4brKqn10mfOo7my
         reuUbiP44bQETkdLBnJXRorOBKx8HbYP+csDnKhkppdJ/ugIXANNZak1IHirqd7jw6co
         rKnBBYDqlZ+ml11ZdxqxLPa4U3PbXjiLSpEP83L98LJPodLpyo79e4TRGGuzvZewKmgu
         6lsw==
X-Gm-Message-State: APjAAAU4E1+V05UiXs8aDdppkbPxBVD7eRlu5zjSNVNBTRm85RA+UkrE
        ZYLpKSa44GPPvJ0NTgVezPi6LTS0ZxeJWGo8O+kg6a4Cv565GEolvfRJOTu0eFhwYt7CE6OPAiK
        BTU4AKwyizKzVHnNFXuNoaykhoX+A5Mi/eA==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr71406oig.156.1580721199894;
        Mon, 03 Feb 2020 01:13:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9lEmpZ5mFZNoh9jalujeDA3QJ4n6tGPcX5wbcVDYxAJIowJZk+AuaY+WGK9xJciFXnYofY5RK/Icjd/RtxUo=
X-Received: by 2002:aca:cd46:: with SMTP id d67mr71397oig.156.1580721199629;
 Mon, 03 Feb 2020 01:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-4-omosnace@redhat.com>
 <CAHC9VhRaZ+OjcoM8=3xvDofVvnGV+4j0Y6i+gYjR6RU=zqTCjA@mail.gmail.com>
In-Reply-To: <CAHC9VhRaZ+OjcoM8=3xvDofVvnGV+4j0Y6i+gYjR6RU=zqTCjA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Feb 2020 10:13:08 +0100
Message-ID: <CAFqZXNtO+_6BKG-CbaKmbcgSLgsBygH-4WQVgfiaWKFNay00sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] selinux: convert cond_av_list to array
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 31, 2020 at 5:17 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Since it is fixed-size after allocation and we know the size beforehand,
> > using a plain old array is simpler and more efficient.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/ss/conditional.c | 125 ++++++++++++------------------
> >  security/selinux/ss/conditional.h |   8 +-
> >  2 files changed, 53 insertions(+), 80 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > index c8a02c9b23ee..b847fd2a6a51 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -255,19 +249,17 @@ err:
> >
> >  struct cond_insertf_data {
> >         struct policydb *p;
> > +       struct avtab_node **dst;
> >         struct cond_av_list *other;
> > -       struct cond_av_list *head;
> > -       struct cond_av_list *tail;
> >  };
> >
> >  static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
> >  {
> >         struct cond_insertf_data *data = ptr;
> >         struct policydb *p = data->p;
> > -       struct cond_av_list *other = data->other, *list, *cur;
> >         struct avtab_node *node_ptr;
> > -       u8 found;
> > -       int rc = -EINVAL;
> > +       u32 i;
> > +       bool found;
> >
> >         /*
> >          * For type rules we have to make certain there aren't any
> > @@ -277,7 +269,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
> >         if (k->specified & AVTAB_TYPE) {
> >                 if (avtab_search(&p->te_avtab, k)) {
> >                         pr_err("SELinux: type rule already exists outside of a conditional.\n");
> > -                       goto err;
> > +                       return -EINVAL;
> >                 }
> >                 /*
> >                  * If we are reading the false list other will be a pointer to
> > @@ -287,29 +279,29 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
> >                  * If we are reading the true list (other == NULL) there shouldn't
> >                  * be any other entries.
> >                  */
> > -               if (other) {
> > +               if (data->other) {
> >                         node_ptr = avtab_search_node(&p->te_cond_avtab, k);
> >                         if (node_ptr) {
> >                                 if (avtab_search_node_next(node_ptr, k->specified)) {
> >                                         pr_err("SELinux: too many conflicting type rules.\n");
> > -                                       goto err;
> > +                                       return -EINVAL;
> >                                 }
> > -                               found = 0;
> > -                               for (cur = other; cur; cur = cur->next) {
> > -                                       if (cur->node == node_ptr) {
> > -                                               found = 1;
> > +                               found = false;
> > +                               for (i = 0; i < data->other->len; i++) {
> > +                                       if (data->other->nodes[i] == node_ptr) {
> > +                                               found = true;
> >                                                 break;
> >                                         }
> >                                 }
>
> Can you explain why you got rid of the "other" variable in this
> function?  It seems like it would be nice in the loop above.

It's probably a result of incremental edits... I agree it looks a bit
nicer with it and it also makes the diff simpler. I'll put it back in
v3.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

