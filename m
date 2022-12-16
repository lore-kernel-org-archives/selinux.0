Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC51C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLPSwT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 13:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiLPSwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 13:52:04 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 567404F66A
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 10:52:03 -0800 (PST)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id D073120B96DB;
        Fri, 16 Dec 2022 10:52:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D073120B96DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1671216723;
        bh=m4LRAijhs6DF81s3NIAwzLiYfoUjRkaoxDEp2v35FKU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=BxLSzlz6g7RjeNjX/pihCPyOoV1ZwteYK/sHxsFE7S7m2VLKd7Zfd3e9Kv/Vxmw9v
         gI2fhwTC4ATTd8KrypWBRg466eTCP4jqcqxFlHiphaNR3TbVtQH++31j71DMO0c/yI
         XvrwPeeaV10feZZBsUcz7pjsWcA8GG1hL3jc3GhM=
Message-ID: <f89d7d5e-2dce-e755-ead9-d575cd6513c2@linux.microsoft.com>
Date:   Fri, 16 Dec 2022 13:51:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/9] Add CIL Deny Rule
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20221215213429.998948-1-jwcart2@gmail.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/15/2022 4:34 PM, James Carter wrote:
> I don't expect this to be part of the upcoming userspace release,
> but I did want to see if this is going to be what Cascade needs.

Thank you!  I've been playing with this series locally all morning and 
so far it mostly works as expected.  The only minor surprise so far is 
if I do something like:

(type my_type1)
(type my_type2)
(type my_type3)
(typeattributeset my_attr (my_type1 my_type2 my_type3))
(allow my_attr my_attr (process (signal signull)))
(deny my_type1 my_attr (process (signal)))

I get rules like this:

$ sesearch -A -s my_attr policy.33
allow deny_rule_attr_11 my_attr:process { signal signull };
allow my_attr my_attr:process signull;

Since deny_rule_attr_11 is a subset of my_attr (specifically, my_type2 
and my_type3), both of those types get the "signull" permission from the 
second rule on the attribute, and only strictly need the "signal" 
permission (which my_type1 doesn't get)

It's obviously not a real problem, since it's just redundant policy and 
both versions are functionally equivalent.  It's just a little weird 
browsing the rules using sesearch, particularly with large permission 
sets (My first attribute test involved using "all" on the file class and 
denying one permission from a type, and it was mildly challenging to 
manually verify the results looking at the allow rules in a large list.)

Anyways, besides that minor issue everything I've tried so far has 
worked well and the overall concept seems sensible and helpful. 
Although, I still need to get my head around the specifics of the 
attribute handling, and I haven't looked thoroughly at the code yet.

I intend to do more thorough testing and code review, but I don't expect 
I'll have time before the holidays, so that will likely come in January. 
  Since I don't have time for anything more thorough now, hopefully some 
first impressions are helpful in the interim.

-Daniel

> 
> This series of patches implements a deny rule in CIL. A deny rule will remove
> the stated permissions in it from the policy. CIL does this by searching for
> allow rules that match the deny rule and then writing new allow rules that
> correspond to the matched allow rule with the permissions from the deny rule
> removed. The rule uses the same syntax as an allow rule, but with "deny"
> instead of "allow".
> 
>    (deny SRC TGT (CLASS (PERMS)))
> 
> Deny rules are processed during post processing (after the AST is resolved,
> but before the binary policy is written). This means that neverallow checking
> is done after deny rules are resolved. Deny rules are complimentary to
> neverallow checking. When an allow rule is found that matches, a deny rule
> removes permissions while a neverallow rule reports an error.
> 
> Patch 4 is biggest and most complex since it is the one doing the processing.
> 
> James Carter (9):
>    libsepol/cil: Parse and add deny rule to AST, but do not process
>    libsepol/cil: Add cil_list_is_empty macro
>    libsepol/cil: Add cil_tree_remove_node function
>    libsepol/cil: Process deny rules
>    libsepol/cil: Add cil_write_post_ast function
>    libsepol: Export the cil_write_post_ast function
>    secilc/secil2tree: Add option to write CIL AST after post processing
>    secilc/test: Add a deny rule test
>    secilc/docs: Add deny rule to CIL documentation
> 
>   libsepol/cil/include/cil/cil.h         |   1 +
>   libsepol/cil/src/cil.c                 |  68 ++
>   libsepol/cil/src/cil_build_ast.c       |  56 ++
>   libsepol/cil/src/cil_build_ast.h       |   2 +
>   libsepol/cil/src/cil_copy_ast.c        |  19 +
>   libsepol/cil/src/cil_copy_ast.h        |   1 +
>   libsepol/cil/src/cil_deny.c            | 957 +++++++++++++++++++++++++
>   libsepol/cil/src/cil_deny.h            |  34 +
>   libsepol/cil/src/cil_flavor.h          |   1 +
>   libsepol/cil/src/cil_internal.h        |  10 +
>   libsepol/cil/src/cil_list.h            |   3 +
>   libsepol/cil/src/cil_post.c            |   7 +
>   libsepol/cil/src/cil_reset_ast.c       |   8 +
>   libsepol/cil/src/cil_resolve_ast.c     |  44 ++
>   libsepol/cil/src/cil_resolve_ast.h     |   1 +
>   libsepol/cil/src/cil_tree.c            |  27 +
>   libsepol/cil/src/cil_tree.h            |   1 +
>   libsepol/cil/src/cil_verify.c          |   9 +
>   libsepol/cil/src/cil_write_ast.c       |  10 +
>   libsepol/cil/src/cil_write_ast.h       |   1 +
>   libsepol/src/libsepol.map.in           |   5 +
>   secilc/docs/cil_access_vector_rules.md |  68 ++
>   secilc/secil2tree.c                    |   8 +-
>   secilc/test/deny_rule_test.cil         | 384 ++++++++++
>   24 files changed, 1724 insertions(+), 1 deletion(-)
>   create mode 100644 libsepol/cil/src/cil_deny.c
>   create mode 100644 libsepol/cil/src/cil_deny.h
>   create mode 100644 secilc/test/deny_rule_test.cil
> 

