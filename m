Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D146C433ED
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F926112F
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhEFRiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 May 2021 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhEFRiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 May 2021 13:38:10 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFA25C061574
        for <selinux@vger.kernel.org>; Thu,  6 May 2021 10:37:11 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id DC97E2A0072;
        Thu,  6 May 2021 19:37:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl DC97E2A0072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1620322629;
        bh=IfmZMBGGP4qsyRx4Czy+3P+ACbm0wRjcZptEA6FDYYk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XkgvAxwThUathRPpeqyhNBDfycpQ+3fMFIZLEiqAgnxjgA9YBYtIjXSclvHG9PZGP
         DyM+Mh8UDl7VKXExMQk54o5bymrV8T2jM2PPHfJZ5Wsn/oNn3dhfHep1hj1FYnQDL0
         ft1n0JFibVPk5ZhDyEQkVr1Lm4ghX481gFkZN2BI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] libsepol/cil: Fix name resolution involving
 inherited blocks
References: <20210506170537.146337-1-jwcart2@gmail.com>
Date:   Thu, 06 May 2021 19:37:00 +0200
In-Reply-To: <20210506170537.146337-1-jwcart2@gmail.com> (James Carter's
        message of "Thu, 6 May 2021 13:05:36 -0400")
Message-ID: <87wnsbsr0j.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> When resolving a name in a block that has been inherited. First,
> a search is done in the parent namespaces (if any) of the
> blockinherit rule with the exception of the global namespace. If
> the name is not found, then a search is done in the namespaces of
> the original block (starting with that block's namespace)  with
> the exception of the global namespace. Finally, if it still has
> not been found, the global namespace is searched.
>
> This does not work if a declaration is in the block being
> inherited.
>

This example does not make sense to me

1. you shouldnt be allowed to inherit a block that is not abstracted:
(block b) does not have a (blockabstract b)

2. the a typeattribute is not associated with any types and so the
compiler would filter it out since its useless

I tried it out here and surprisingly the compiler does not fail, but no
policy ends up in the result, so I do not know how you get to those results

> For example:
>   (block b
>     (typeattribute a)
>     (allow a self (CLASS (PERM)))
>   )
>   (blockinherit b)
>
> This will result in a policy with the following identical allow
> rules:
>   (allow b.a self (CLASS (PERM)))
>   (allow b.a self (CLASS (PERM)))
> rather than the expected:
>   (allow b.a self (CLASS (PERM)))
>   (allow a self (CLASS (PERM)))
> This is because when the typeattribute is copied while resolving
> the inheritance, the new datum is added to the global namespace
> and, since that is searched last, the typeattribute in block b is
> found first.
>
> This behavior means that no declaration that is inherited into the
> global namespace will actually be used.
>
> Instead, if the name is not found in the parent namespaces (if any)
> where the blockinherit is located with the exception of the global
> namespace, start the next search in the namespace of the parent of
> the original block (instead of the original block itself). Now if
> a declaration is inherited from the original block, the new
> declaration will be used. This behavior seems to be the originally
> intended behavior because there is a comment in the code that says,
> "Continue search in original block's parent".
>
> This issue was found by secilc-fuzzer. If the original block
> is made to be abstract, then the type attribute declaration
> in the original block is not in the policy and a segfault
> occurs when creating the binary because the copied allow rule
> refers to a non-existent type attribute.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index f251ed15..55080396 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4211,7 +4211,7 @@ static int __cil_resolve_name_with_parents(struct cil_tree_node *node, char *nam
>  			rc = __cil_resolve_name_with_parents(node->parent, name, sym_index, datum);
>  			if (rc != SEPOL_OK) {
>  				/* Continue search in original block's parent */
> -				rc = __cil_resolve_name_with_parents(NODE(inherit->block), name, sym_index, datum);
> +				rc = __cil_resolve_name_with_parents(NODE(inherit->block)->parent, name, sym_index, datum);
>  				goto exit;
>  			}
>  		}

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
