Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09537C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB600217D9
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 09:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StTPh9WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfI0JYJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:24:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725890AbfI0JYJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 05:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569576248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+XOHutj5h2W/z8lzNx5f4Lx0C3naGQu0st7ymtrQhk=;
        b=StTPh9WNWN/V7iDYTui5TAVPSjxOO7L8uPzQigtz2xSfWUWA+dlegwDw8T3Lp1PO+Qtaq7
        O9YeHgQLxY2bz3n6Mgtk9JHvK9VpqtMTB2XnRQnvfFFcFYjWi1toVjzUM+sNeZoA9ppkn3
        u57yMXKl7D1p3XwbLVYwdprImtmoaQQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-lPuvc5BNPRiM8RKGxMoeZw-1; Fri, 27 Sep 2019 05:24:06 -0400
Received: by mail-oi1-f200.google.com with SMTP id l24so2635766oii.16
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 02:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cfz81ENyKB6lxOqbH6ytizWfly2jQEB0S/3ncP/3iIs=;
        b=TGBlJOPQxS0MorWqy8tSliTQSPp3+luMCFB+njxtqldAOyC7aGSxc/TfMusg1Yt0KC
         BDzI9Yti1rStTzliniIkyh7wSpw7K0EXCtz1vi+YxyaDWyKjYC+6nooyfgz5y0QuL5IC
         67SKEXN9UcYgvSmNYJg/ugtI897tZNZkFNI2y7xUkrhzJBXJ+x3n/rWzU9xppRLhRhfv
         D6QvtMwc9QAYYUVdn1JCVskAqjo0N5R21KseSFEN7syrhbXu5wdO+GnX2WIWWY2+E/vD
         SYo0HtAsy2leMryZc5DZWIDEe38NtxXbsAgtN3JLuN/2haoPykNOpRCodxLKyZNUvLCA
         RiCw==
X-Gm-Message-State: APjAAAXXLfdlat7NiTMfSajZOERjS/vAr+37/FQyeuLSQ01PBBpdUfhD
        Ma7DI5qDvsPMuTQXmfQTdb99XUSh9PCZ73snXLZi6mB9H4oI9RP+QFxzWGSuqBBB+zJoYv3w2xz
        XPY7Cgpnzdg4EmXzl/rsWCm8KazWQW+Sl2g==
X-Received: by 2002:aca:4993:: with SMTP id w141mr6321856oia.127.1569576245558;
        Fri, 27 Sep 2019 02:24:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAFSqepN0TeEWf7BNLYscxIFGwN/RS2SISOvPjJIIpH4d1JnOFvWrRGwucdiomn74LvrqiH4IZ0DM9WmmK1jw=
X-Received: by 2002:aca:4993:: with SMTP id w141mr6321837oia.127.1569576245216;
 Fri, 27 Sep 2019 02:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190926171934.9786-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20190926171934.9786-1-jwcart2@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 27 Sep 2019 11:23:53 +0200
Message-ID: <CAFqZXNvjkB=gi5-OZwfRSj7e4FrNQPxjP6uf95av+o5oPW0MhQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Further improve binary policy optimization
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: lPuvc5BNPRiM8RKGxMoeZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 26, 2019 at 7:19 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> This improves commit b8213acf (libsepol: add a function to optimize
> kernel policy) by Ondrej Mosnacek <omosnace@redhat.com> by always
> removing redundant conditional rules which have an identical rule
> in the unconditional policy.
>
> Add a flag called not_cond to is_avrule_redundant(). When checking
> unconditional rules against the avtab (which stores the unconditional
> rules) we need to skip the actual rule that we are checking (otherwise
> a rule would be determined to be redundant with itself and bad things
> would happen), but when checking a conditional rule against the avtab
> we do not want to skip an identical rule (which is what currently
> happens), we want to remove the redundant permissions in the conditional
> rule.
>
> A couple of examples to illustrate when redundant condtional rules
> are not removed.
>
> Example 1
>   allow t1 t2:class1 perm1;
>   if (bool1) {
>     allow t1 t2:class1 perm1;
>   }
> The conditional rule is clearly redundant, but without this change it
> will not be removed, because of the check for an identical rule.
>
> Example 2
>   typeattribute t1 a1;
>   allow t1 t2:class1 perm1;
>   allow a1 t2:class1 perm1;
>   if (bool1) {
>     allow t1 t2:class1 perm1;
>   }
> The conditional rule is again clearly redundant, but now the order of
> processing during the optimization will determine whether or not the
> rule is removed. Because a1 contains only t1, a1 and t1 are considered
> to be supersets of each other. If the rule with the attribute is
> processed first, then it will be determined to be redundant and
> removed, so the conditional rule will not be removed. But if the rule
> with the type is processed first, then it will be removed and the
> conditional rule will be determined to be redundant with the rule with
> the attribute and removed as well.
>
> The change reduces the size of policy a bit more than the original
> optimization. Looking at the change in number of allow rules, there is
> about a 10% improvement over the old optimization.
>            orig    old    new
> Refpolicy 113284  82467  78053
> Fedora    106410  64015  60008
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Nice improvement, thanks!

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  libsepol/src/optimize.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 10399a43..1e5e97e8 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -123,7 +123,7 @@ static int process_avtab_datum(uint16_t specified,
>
>  /* checks if avtab contains a rule that covers the given rule */
>  static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
> -                              const ebitmap_t *type_map)
> +                              const ebitmap_t *type_map, unsigned char n=
ot_cond)
>  {
>         unsigned int i, k, s_idx, t_idx;
>         ebitmap_node_t *snode, *tnode;
> @@ -146,7 +146,7 @@ static int is_avrule_redundant(avtab_ptr_t entry, avt=
ab_t *tab,
>                 key.source_type =3D i + 1;
>
>                 ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k)=
 {
> -                       if (s_idx =3D=3D i && t_idx =3D=3D k)
> +                       if (not_cond && s_idx =3D=3D i && t_idx =3D=3D k)
>                                 continue;
>
>                         key.target_type =3D k + 1;
> @@ -223,7 +223,7 @@ static void optimize_avtab(policydb_t *p, const ebitm=
ap_t *type_map)
>         for (i =3D 0; i < tab->nslot; i++) {
>                 cur =3D &tab->htable[i];
>                 while (*cur) {
> -                       if (is_avrule_redundant(*cur, tab, type_map)) {
> +                       if (is_avrule_redundant(*cur, tab, type_map, 1)) =
{
>                                 /* redundant rule -> remove it */
>                                 avtab_ptr_t tmp =3D *cur;
>
> @@ -279,7 +279,7 @@ static void optimize_cond_av_list(cond_av_list_t **co=
nd, cond_av_list_t **del,
>                  * First check if covered by an unconditional rule, then =
also
>                  * check if covered by another rule in the same list.
>                  */
> -               if (is_avrule_redundant((*cond)->node, &p->te_avtab, type=
_map) ||
> +               if (is_avrule_redundant((*cond)->node, &p->te_avtab, type=
_map, 0) ||
>                     is_cond_rule_redundant((*cond)->node, *pcov_cur, type=
_map)) {
>                         cond_av_list_t *tmp =3D *cond;
>
> --
> 2.21.0
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

