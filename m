Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA98C05027
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBAPUs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjBAPUq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 10:20:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66203B76A
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 07:20:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ml19so28855925ejb.0
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbDviGvivR0vfMTtGxiHsNqelLmGURMYMtrHdqxEvNQ=;
        b=OcGi5uCi6Q+JghZXpOa7doyGrCbnByT4BvkGRUIGztBGi8zkEnF6/wkHZLI+GDJilt
         0oRXyUJGnEtnttFSGiwUPGjg7UmENYFCve8/m49uKn/t9QJQrBaPoV/ev5JxS0/Qfdxu
         AFXhYnH5nClauFmKaEH6jKU488xWOqm7uDnB6e6xpNh7ltJF8kVL55k3ZPxS+dgXfwGq
         gUvFYt56MLD6oOz6QNov65pBCSr+LYFyANnf3HbdPGF8fnhPm+wbw4F7PRjABouDz9JX
         9OA5a+nN5IqnybOksyGRDVcQOGY7wJud34cNHMEwRk7Xn+zBf8efnQ0GXUZpv0KIeoTw
         1tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbDviGvivR0vfMTtGxiHsNqelLmGURMYMtrHdqxEvNQ=;
        b=XmI8n3Tynn/OhZspOb6bc1HHUzEzIOGomferJ8MixdOC0CKzpjT3GY8iQ7rSboai1A
         A74Ef/sQdD/QTZmlfIAs6jVnR4Phir2vHVAROHDxGL57mwORwliXzP2H3IjlUD6vMpF4
         ExzNdJZLBHU8+uBdk8H8nErRQZe6zcGbxUscqbHAT2qmcGjGWLA2E8E8GidaS2saijQ5
         BKAjAekxSf6gUFB/rJfKktp5vwcZ2HzrnkuXUcG9W2w0NdwoC76XYHaF479foAMho9FP
         l5TYGs+d22ySavW1/gzVXyt1iIRmOPT13/1sGfX+/33d2dhkZ3Vj9EfpaqRCshEEcfmH
         5r5g==
X-Gm-Message-State: AO0yUKWdXuuQPh7dqpYkPoVkIH2oCwBl2xTq0kpIEJn4wi+NSd4d/dYP
        kXk2/mJj4DO1cISbhwydizAa8E26oqOkZD01noLPaIYmc1U=
X-Google-Smtp-Source: AK7set8lMfTtjW3vk31OmLmhqnEiN3OhBqeRaFVK9Hh+80O4/ZSQnSBWfziN1+GQStse3aatvItRC/ZqZXbVloIlgyI=
X-Received: by 2002:a17:906:85c7:b0:878:581b:63ee with SMTP id
 i7-20020a17090685c700b00878581b63eemr718550ejy.244.1675264836777; Wed, 01 Feb
 2023 07:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20230124202607.1953135-1-vmojzis@redhat.com> <20230130175828.2487173-1-vmojzis@redhat.com>
In-Reply-To: <20230130175828.2487173-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Feb 2023 10:20:25 -0500
Message-ID: <CAP+JOzR2e1ppvGr3FTOVJO0G=SqZ+iGza9tSQ1iXSm3YVBSw1A@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolicy: Cache conditional rule queries
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 30, 2023 at 1:01 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Commit 7506771e4b630fe0ab853f96574e039055cb72eb
> "add missing booleans to man pages" dramatically slowed down
> "sepolicy manpage -a" by removing caching of setools rule query.
> Re-add said caching and update the query to only return conditional
> rules.
>
> Before commit 7506771e:
>  #time sepolicy manpage -a
>  real   1m43.153s
>  # time sepolicy manpage -d httpd_t
>  real   0m4.493s
>
> After commit 7506771e:
>  #time sepolicy manpage -a
>  real   1h56m43.153s
>  # time sepolicy manpage -d httpd_t
>  real   0m8.352s
>
> After this commit:
>  #time sepolicy manpage -a
>  real   1m41.074s
>  # time sepolicy manpage -d httpd_t
>  real   0m7.358s
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> * Remove "sepolicy." before TERuleQuery (left over from testing on older
>   version of userspace).
>
>  python/sepolicy/sepolicy/__init__.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index e2d5c11a..c177cdfc 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -125,6 +125,7 @@ all_attributes = None
>  booleans = None
>  booleans_dict = None
>  all_allow_rules = None
> +all_bool_rules = None
>  all_transitions = None
>
>
> @@ -1136,6 +1137,14 @@ def get_all_allow_rules():
>          all_allow_rules = search([ALLOW])
>      return all_allow_rules
>
> +def get_all_bool_rules():
> +    global all_bool_rules
> +    if not all_bool_rules:
> +        q = TERuleQuery(_pol, boolean=".*", boolean_regex=True,
> +                                ruletype=[ALLOW, DONTAUDIT])
> +        all_bool_rules = [_setools_rule_to_dict(x) for x in q.results()]
> +    return all_bool_rules
> +
>  def get_all_transitions():
>      global all_transitions
>      if not all_transitions:
> @@ -1146,7 +1155,7 @@ def get_bools(setype):
>      bools = []
>      domainbools = []
>      domainname, short_name = gen_short_name(setype)
> -    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, search([ALLOW, DONTAUDIT]))):
> +    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, get_all_bool_rules())):
>          for b in i:
>              if not isinstance(b, tuple):
>                  continue
> --
> 2.37.3
>
