Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F33C3524D
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA5C20661
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 09:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvQYzGa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgBCJFa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:05:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727133AbgBCJFa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 04:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580720727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AT1BB0colRNZMgWo4Fi++KzJPoh/TwCjoISH08zVIRs=;
        b=ZvQYzGa+80xJ8eImjmr+04vuaRYVamdbALv2SUMpDiUijOYA7QpuQkjNBXNwAYhCB3IdAK
        tUAK5X+YuOE+MoKKgZI15PLv+Ewr0YafzTCu0jpBDfWzQq78WXARagxIRSD77WdwPQD8nu
        tuwgrl98qvUyzm7mhbSItE4WlaeATOM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-MB3gTUvJOeq4-b-WxjqixQ-1; Mon, 03 Feb 2020 04:05:23 -0500
X-MC-Unique: MB3gTUvJOeq4-b-WxjqixQ-1
Received: by mail-ot1-f72.google.com with SMTP id 39so4446956otb.8
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 01:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT1BB0colRNZMgWo4Fi++KzJPoh/TwCjoISH08zVIRs=;
        b=n4xUpEmlWQ/yF2a9+vTQDDdIyMKX5B5elKs5KriRb+nI7zt97kbjEYI+LlsBH58XAU
         Nvxs6RzmmXxg3x0y7QYFyEOAH3ZEcg0o+3VNFOEBUpo3jTOlJkPD5BAqLManQbPHJO83
         GCeailxeOyFBB96/1V40IgmSXcgYa1V/DF99Z+wkOAdlCdQm3i3Z/HDUXGOH6j60Z041
         hUvQ0F/WQAKnvdR3iQm2y5QigXGrjd8iKctgjwQZHv4LQuWrJ3qyP+Oqu0VSonaqmu6w
         AS6zU7CNv1njNXjVnlx9IQrgpFftQw7yvZ7rqIEKmyWrRI4hDH3Vf65irgUwXBEIKK8g
         o/4Q==
X-Gm-Message-State: APjAAAV0z7mQ2xdAJ7+0D9D7xr6iBqW7SHjUCW6oZoWY1Ijv35a8wR+W
        bSwhShQ8W4hJ/GeDTzYkyjdqUavRzq8mzgV//MvexpZd3zDMRDXTI/SZ/+M2X4l57IDUHM+fWAV
        AlRF3rsLo4ALeQScBijrimIBnhMsibA774w==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr14186768oid.26.1580720721895;
        Mon, 03 Feb 2020 01:05:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTrZE1dDtbK31tUhfXNmA3gF+KLkclLuZMMi4RmWUclxv9jpbCu9xutNGJ1Tjq1TkKIG2Oex4cwN4W8iXEqLE=
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr14186746oid.26.1580720721495;
 Mon, 03 Feb 2020 01:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-3-omosnace@redhat.com>
 <CAHC9VhSNBR1kJHrn4Z-eu4NTj09Y6Vrwu3h7MU+UHac3+g_jCg@mail.gmail.com>
In-Reply-To: <CAHC9VhSNBR1kJHrn4Z-eu4NTj09Y6Vrwu3h7MU+UHac3+g_jCg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Feb 2020 10:05:10 +0100
Message-ID: <CAFqZXNs0ciPRSDVc7Vn469oZwJRTLRMm6PEsMsS796z+pNm6=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] selinux: convert cond_list to array
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 31, 2020 at 5:05 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Since it is fixed-size after allocation and we know the size beforehand,
> > using a plain old array is simpler and more efficient.
> >
> > While there, also fix signedness of some related variables/parameters.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/include/conditional.h |  6 +--
> >  security/selinux/selinuxfs.c           |  4 +-
> >  security/selinux/ss/conditional.c      | 54 ++++++++++----------------
> >  security/selinux/ss/conditional.h      |  3 +-
> >  security/selinux/ss/policydb.c         |  2 +-
> >  security/selinux/ss/policydb.h         |  3 +-
> >  security/selinux/ss/services.c         | 28 ++++++-------
> >  7 files changed, 43 insertions(+), 57 deletions(-)
> >
> > diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> > index 0ab316f61da0..ffb9a33341f8 100644
> > --- a/security/selinux/include/conditional.h
> > +++ b/security/selinux/include/conditional.h
> > @@ -14,12 +14,12 @@
> >  #include "security.h"
> >
> >  int security_get_bools(struct selinux_state *state,
> > -                      int *len, char ***names, int **values);
> > +                      u32 *len, char ***names, int **values);
> >
> >  int security_set_bools(struct selinux_state *state,
> > -                      int len, int *values);
> > +                      u32 len, int *values);
>
> In the future, if you're making changes like this, you might as well
> put it all on one line (it fits under 80 chars).

Good point, will do that in v3.

>
> >  int security_get_bool_value(struct selinux_state *state,
> > -                           int index);
> > +                           u32 index);
>
> Same here.
>
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > index 04593062008d..c8a02c9b23ee 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -119,6 +119,7 @@ int cond_policydb_init(struct policydb *p)
> >
> >         p->bool_val_to_struct = NULL;
> >         p->cond_list = NULL;
> > +       p->cond_list_len = 0;
> >
> >         rc = avtab_init(&p->te_cond_avtab);
> >         if (rc)
> > @@ -147,27 +148,22 @@ static void cond_node_destroy(struct cond_node *node)
> >         }
> >         cond_av_list_destroy(node->true_list);
> >         cond_av_list_destroy(node->false_list);
> > -       kfree(node);
> >  }
> >
> > -static void cond_list_destroy(struct cond_node *list)
> > +static void cond_list_destroy(struct policydb *p)
> >  {
> > -       struct cond_node *next, *cur;
> > +       u32 i;
> >
> > -       if (list == NULL)
> > -               return;
> > -
> > -       for (cur = list; cur; cur = next) {
> > -               next = cur->next;
> > -               cond_node_destroy(cur);
> > -       }
> > +       for (i = 0; i < p->cond_list_len; i++)
> > +               cond_node_destroy(&p->cond_list[i]);
> > +       kfree(p->cond_list);
> >  }
> >
> >  void cond_policydb_destroy(struct policydb *p)
> >  {
> >         kfree(p->bool_val_to_struct);
> >         avtab_destroy(&p->te_cond_avtab);
> > -       cond_list_destroy(p->cond_list);
> > +       cond_list_destroy(p);
> >  }
> >
> >  int cond_init_bool_indexes(struct policydb *p)
> > @@ -447,7 +443,6 @@ err:
> >
> >  int cond_read_list(struct policydb *p, void *fp)
> >  {
> > -       struct cond_node *node, *last = NULL;
> >         __le32 buf[1];
> >         u32 i, len;
> >         int rc;
> > @@ -458,29 +453,24 @@ int cond_read_list(struct policydb *p, void *fp)
> >
> >         len = le32_to_cpu(buf[0]);
> >
> > +       p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
> > +       if (!p->cond_list)
> > +               return rc;
> > +
> >         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> >         if (rc)
> >                 goto err;
> >
> >         for (i = 0; i < len; i++) {
> > -               rc = -ENOMEM;
> > -               node = kzalloc(sizeof(*node), GFP_KERNEL);
> > -               if (!node)
> > -                       goto err;
> > -
> > -               rc = cond_read_node(p, node, fp);
> > +               rc = cond_read_node(p, &p->cond_list[i], fp);
> >                 if (rc)
> >                         goto err;
> > -
> > -               if (i == 0)
> > -                       p->cond_list = node;
> > -               else
> > -                       last->next = node;
> > -               last = node;
> >         }
> > +
> > +       p->cond_list_len = len;
>
> Hmmm.  Since we don't update p->cond_list_len until here, if we fail
> in the for-loop above and end up jumping to "err" we might not cleanup
> all the nodes, right?

You're right. I'll fix it by moving the p->cond_list_len assignment
before the for-loop - since the array is zero-initialized by
kcalloc(), cond_node_destroy() can be called safely also on unread
items. (That is a bit inefficient, but I see little value in
micro-optimizing the error path.)

>
> >         return 0;
> >  err:
> > -       cond_list_destroy(p->cond_list);
> > +       cond_list_destroy(p);
> >         p->cond_list = NULL;
> >         return rc;
> >  }
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

