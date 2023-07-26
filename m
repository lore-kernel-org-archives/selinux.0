Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB392C0015E
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjGZP4h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjGZP4g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 11:56:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC312109
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 08:56:34 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 133142380B28;
        Wed, 26 Jul 2023 08:56:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 133142380B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690386994;
        bh=g6cY6HfbW8LyrS/6rxfCLn8FoD5dfRasdZT578mRROQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=icjFg4G7AAxOaUOxyQatfrl6FcxWp/96lrZnf/YjdkvhzRvN5eKQOBeYBHCQ3AP4H
         6pX0Yo0vInegmspnZ3Slvg0bsP7ZtHt8cCp/ot+MQoWFWVv23jb3NJFTujVLndlbFl
         PNTSibdb6mAlZZfx0oKC9UHhmhy/XLsg93LXf9hQ=
Message-ID: <3eda4dfc-d489-5cc4-ca99-1d0c06ea62aa@linux.microsoft.com>
Date:   Wed, 26 Jul 2023 11:56:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/9 v3] Add CIL Deny Rule
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20230413193445.588395-1-jwcart2@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/13/2023 3:34 PM, James Carter wrote:
> This patch series depends on the "Add support for notself and other to
> CIL" patch series from April 12th.
> 
> These patches add a deny rule to CIL. Deny rules will be processed after
> everything except for neverallow rules. Unlike neverallow rules, they
> remove the permissions in the deny rule rather than reporting an error.
> 
> See the individual patches for an explanation of what they do.
> 
> Patches 2, 5, 6, and 7 are unchanged from v2. For the other patches, see
> the patch for a list of the changes from v2.
> 
> James Carter (9):
>    libsepol/cil: Parse and add deny rule to AST, but do not process
>    libsepol/cil: Add cil_list_is_empty macro
>    libsepol/cil: Add cil_tree_node_remove function
>    libsepol/cil: Process deny rules
>    libsepol/cil: Add cil_write_post_ast function
>    libsepol: Export the cil_write_post_ast function
>    secilc/secil2tree: Add option to write CIL AST after post processing
>    secilc/test: Add deny rule tests
>    secilc/docs: Add deny rule to CIL documentation
> 
>   libsepol/cil/include/cil/cil.h         |    1 +
>   libsepol/cil/src/cil.c                 |   68 ++
>   libsepol/cil/src/cil_build_ast.c       |   56 +
>   libsepol/cil/src/cil_build_ast.h       |    2 +
>   libsepol/cil/src/cil_copy_ast.c        |   19 +
>   libsepol/cil/src/cil_copy_ast.h        |    1 +
>   libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++++++
>   libsepol/cil/src/cil_deny.h            |   36 +
>   libsepol/cil/src/cil_flavor.h          |    1 +
>   libsepol/cil/src/cil_internal.h        |   10 +
>   libsepol/cil/src/cil_list.h            |    3 +
>   libsepol/cil/src/cil_post.c            |    7 +
>   libsepol/cil/src/cil_reset_ast.c       |    8 +
>   libsepol/cil/src/cil_resolve_ast.c     |   48 +
>   libsepol/cil/src/cil_resolve_ast.h     |    1 +
>   libsepol/cil/src/cil_tree.c            |   35 +
>   libsepol/cil/src/cil_tree.h            |    1 +
>   libsepol/cil/src/cil_verify.c          |    9 +
>   libsepol/cil/src/cil_write_ast.c       |   10 +
>   libsepol/cil/src/cil_write_ast.h       |    1 +
>   libsepol/src/libsepol.map.in           |    5 +
>   secilc/docs/cil_access_vector_rules.md |   67 ++
>   secilc/secil2tree.c                    |    8 +-
>   secilc/test/deny_rule_test1.cil        |  580 ++++++++++
>   secilc/test/deny_rule_test2.cil        |  418 +++++++
>   25 files changed, 2807 insertions(+), 1 deletion(-)
>   create mode 100644 libsepol/cil/src/cil_deny.c
>   create mode 100644 libsepol/cil/src/cil_deny.h
>   create mode 100644 secilc/test/deny_rule_test1.cil
>   create mode 100644 secilc/test/deny_rule_test2.cil

For patches 1-8:

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>

