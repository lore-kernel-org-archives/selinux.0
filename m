Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF084C05027
	for <selinux@archiver.kernel.org>; Wed,  8 Feb 2023 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjBHVJv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBHVJn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Feb 2023 16:09:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9028225BBD
        for <selinux@vger.kernel.org>; Wed,  8 Feb 2023 13:09:41 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hx15so589699ejc.11
        for <selinux@vger.kernel.org>; Wed, 08 Feb 2023 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EBEfFAD5so/kKX+c5fDN99cj6jXnS4C8EzBRAXdC4k=;
        b=FbwTpMkHyxPAvxoy1ycAUnqnGDunJNLewPYemZPpTD5kflER5vN5qIUIS7FwIa3pJQ
         WNidSFQpQPlK7FqS4qEJjtADZvrk8KvCxEg2rgJCiVPeJJN7FLNpN3MS1rq3YqqSO20C
         klWsrHxV0VcdHlmT23j5nrQ3mvg7MdJjqAEscU1Yn+pvredvqR69tlf5aVSt3ekpS5oV
         zwfyuPdcaUJyVpZz19H1SUiezdtoqgkRzgc66fTU/rE9bEmo5Tcc1W/n6BVvS/a91fMx
         IntQaknhp5dqDVovyQNabckHj6WPecIQJor0CV8HLmMREIYdVbDHjDVUXFvcjR2/e9YT
         deBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EBEfFAD5so/kKX+c5fDN99cj6jXnS4C8EzBRAXdC4k=;
        b=TWwsdgI0UhVGisBjYtcKmP0K6SVN39JPsNjBLhIQYIovIrpRly8pJa4kMCt7APAJxt
         u4vUepcJY3N3nAXl5XpX93w/puoXTuHuc2vefWKEXyyjHZVdmX8gcuG8d2s2wajrjazk
         JZHrZoV8G8+FhqGRiM7dC9jVOirKxIjrJss3W5KaTsAlfa/caxf+QeMoe61tocqHpDg0
         T4k+10gw6a1Od5wcYhmHjECJIfb2yD2CZPI21ToCN6s67Z14+9psj7fQUlXzap9RYeKm
         bsS9sOGUkE/AavYETDyMa3TMg9E0H0oFI19UWQcTU40bT1nDAOLzwNMu0K8mG3wBnekB
         5D7Q==
X-Gm-Message-State: AO0yUKU+fgFm6jCA3TxEdQgSdkjzW6JWbfLACG91aP0NnyJxl4BCJDe/
        09XPvX+nk56OqgPcyQ//KJ6I5fjbRpdUTF1EdDYdFpx0
X-Google-Smtp-Source: AK7set8sYhCf9FW5mFXmazvYgOJFuvtK7jlG9OGgL3M+ie1Z4LSuOsMk2XRnD0NYNlo6nPGKlFhoEJqz1mAAl3KEuVE=
X-Received: by 2002:a17:906:1e0e:b0:87a:56fc:9df1 with SMTP id
 g14-20020a1709061e0e00b0087a56fc9df1mr20384ejj.3.1675890579946; Wed, 08 Feb
 2023 13:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20221215213429.998948-1-jwcart2@gmail.com> <20221215213429.998948-4-jwcart2@gmail.com>
 <38c131c4-1cd5-b42a-9a30-5aa89646493c@linux.microsoft.com>
In-Reply-To: <38c131c4-1cd5-b42a-9a30-5aa89646493c@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Feb 2023 16:09:28 -0500
Message-ID: <CAP+JOzQpgdsq-zh6ZRgocNSzEtKbPF_aZDtWpFPOHkeYPZuVGw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] libsepol/cil: Add cil_tree_remove_node function
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 3, 2023 at 5:54 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 12/15/2022 4:34 PM, James Carter wrote:
> > Add the function cil_tree_remove_node() which takes a node pointer
> > as an input, finds the parent, walks the list of nodes to the node
> > prior to the given node, and then updates that nodes next pointer
> > to remove the given node from the tree.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   libsepol/cil/src/cil_tree.c | 27 +++++++++++++++++++++++++++
> >   libsepol/cil/src/cil_tree.h |  1 +
> >   2 files changed, 28 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 6376c208..73b4e135 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -248,6 +248,33 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
> >       *node = NULL;
> >   }
> >
> > +void cil_tree_remove_node(struct cil_tree_node *node)
> > +{
> > +     struct cil_tree_node *parent, *curr;
> > +
> > +     if (node == NULL || node->parent == NULL) {
> > +             return;
> > +     }
> > +
> > +     parent = node->parent;
> > +
> > +     if (parent->cl_head == node) {
> > +             parent->cl_head = node->next;
> > +             return;
> > +     }
> > +
> > +     curr = parent->cl_head;
> > +     while (curr && curr->next != node) {
> > +             curr = curr->next;
> > +     }
> > +
> > +     if (curr == NULL) {
> > +             return;
> > +     }
> > +
> > +     curr->next = node->next;
> > +}
> > +
>
> Is there a reason this leaves it to the caller to call
> cil_tree_node_destroy()?  It just feels a little weird to leave the node
> unreachable without freeing.  It looks like both callers in the series
> (cil_process_deny_rule(s)) call cil_tree_node_destroy() immediately after.
>
> -Daniel
>

Not that I can remember. I can't really think of a scenario where I
would want to remove a node, but not destroy it.
It also seems like it would be better to name it
cil_tree_node_remove() to fit the naming scheme of the other
functions.
Thanks,
Jim


> >   /* Perform depth-first walk of the tree
> >      Parameters:
> >      start_node:          root node to start walking from
> > diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> > index 5a98da55..e4b3fd04 100644
> > --- a/libsepol/cil/src/cil_tree.h
> > +++ b/libsepol/cil/src/cil_tree.h
> > @@ -63,6 +63,7 @@ void cil_tree_children_destroy(struct cil_tree_node *node);
> >
> >   void cil_tree_node_init(struct cil_tree_node **node);
> >   void cil_tree_node_destroy(struct cil_tree_node **node);
> > +void cil_tree_remove_node(struct cil_tree_node *node);
> >
> >   //finished values
> >   #define CIL_TREE_SKIP_NOTHING       0
>
