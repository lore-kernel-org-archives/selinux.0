Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C6C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D0820702
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N4NNjaQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgAaERU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:17:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44522 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaERU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 23:17:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so6306311eds.11
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 20:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKaUoaM4vVt/hwDFD7jvTS9CnOWCv3EOflNKIGr9NJ0=;
        b=N4NNjaQS8+ft9ziYmA88Rrt4NHR9F+t1Qj7sy3rPRppZzWOedHowx6juEc4L6LWF12
         1xlnwcfAqp7B8yzdR0oaFX/D0dlqzMBhqEimkG2HhNvin1QH/GniwYwq6QuGOPe7MdLK
         w29z6xUnrxT/QdCPzpzirqiVpd+vCbJpm1Z+z/vUD5bBLIznNkw+xUNQHJ22FOh7p8mX
         Eatcj9N2p+w1tDPkFuGB79N/5zYirA/lSJoM5cVCjZxGBlDxsvBwZGhMKwzas8nkcvK1
         U4bzLi2k3VyBdLgQnWWRWKUaU1ft8Qy8fdKK+uGGq0pp3CKTTTAVYn9k4JAuifPtmwTB
         mScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKaUoaM4vVt/hwDFD7jvTS9CnOWCv3EOflNKIGr9NJ0=;
        b=UMxG6hmvKQdM4wRt88wJz2Ebl2y9HghqODmapJSpjjNY9ckRw2sWqo+sSD7y0poTZq
         coq9zPJ+q+PFQtE391tDYCbJ9hIOaJjoLeRiTVE+od9JEo8bktMfi2rafLOUwKC0YTpY
         L7PgT685I/pT+rXLrxn1dQrHZPZkEzlU5ELm0m20r+K9WuvRj3RPjaeTuf40GIQPM/1D
         SW8GK9RBA8ft9ItCu2o1t36BouoHNWCy5ciYYTmN6stCyaKHCnEOptaYX55G7PnmZBtX
         J7E/JuUE6cBLy4sdhTOA7Qa/1mZyEqF8MgR85oRbsq0KHS3qyA+tDfTKCFN1gbefi8qr
         zgpg==
X-Gm-Message-State: APjAAAVsJqHfQu1BA6zcsc17J20MqPaRmO9OYR9nzgsERWgWgHYgjIIy
        iQWoznEW9+tccZFHnZkQFip1qJpHEANRtF40B1w4
X-Google-Smtp-Source: APXvYqz09Qj4Uv6elENzZeHSUzJcI528aAFXesST1eYujG12o96e0zCU09Z1UPFXYoH6LgBNt4rxsjmLpwMYlQs0Pqw=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr6846838eja.77.1580444238722;
 Thu, 30 Jan 2020 20:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-4-omosnace@redhat.com>
In-Reply-To: <20200117085836.445797-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 23:17:07 -0500
Message-ID: <CAHC9VhRaZ+OjcoM8=3xvDofVvnGV+4j0Y6i+gYjR6RU=zqTCjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] selinux: convert cond_av_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/conditional.c | 125 ++++++++++++------------------
>  security/selinux/ss/conditional.h |   8 +-
>  2 files changed, 53 insertions(+), 80 deletions(-)

...

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index c8a02c9b23ee..b847fd2a6a51 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -255,19 +249,17 @@ err:
>
>  struct cond_insertf_data {
>         struct policydb *p;
> +       struct avtab_node **dst;
>         struct cond_av_list *other;
> -       struct cond_av_list *head;
> -       struct cond_av_list *tail;
>  };
>
>  static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
>  {
>         struct cond_insertf_data *data = ptr;
>         struct policydb *p = data->p;
> -       struct cond_av_list *other = data->other, *list, *cur;
>         struct avtab_node *node_ptr;
> -       u8 found;
> -       int rc = -EINVAL;
> +       u32 i;
> +       bool found;
>
>         /*
>          * For type rules we have to make certain there aren't any
> @@ -277,7 +269,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>         if (k->specified & AVTAB_TYPE) {
>                 if (avtab_search(&p->te_avtab, k)) {
>                         pr_err("SELinux: type rule already exists outside of a conditional.\n");
> -                       goto err;
> +                       return -EINVAL;
>                 }
>                 /*
>                  * If we are reading the false list other will be a pointer to
> @@ -287,29 +279,29 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>                  * If we are reading the true list (other == NULL) there shouldn't
>                  * be any other entries.
>                  */
> -               if (other) {
> +               if (data->other) {
>                         node_ptr = avtab_search_node(&p->te_cond_avtab, k);
>                         if (node_ptr) {
>                                 if (avtab_search_node_next(node_ptr, k->specified)) {
>                                         pr_err("SELinux: too many conflicting type rules.\n");
> -                                       goto err;
> +                                       return -EINVAL;
>                                 }
> -                               found = 0;
> -                               for (cur = other; cur; cur = cur->next) {
> -                                       if (cur->node == node_ptr) {
> -                                               found = 1;
> +                               found = false;
> +                               for (i = 0; i < data->other->len; i++) {
> +                                       if (data->other->nodes[i] == node_ptr) {
> +                                               found = true;
>                                                 break;
>                                         }
>                                 }

Can you explain why you got rid of the "other" variable in this
function?  It seems like it would be nice in the loop above.

-- 
paul moore
www.paul-moore.com
