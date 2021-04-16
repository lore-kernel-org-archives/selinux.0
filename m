Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB4C433ED
	for <selinux@archiver.kernel.org>; Fri, 16 Apr 2021 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649DA610F7
	for <selinux@archiver.kernel.org>; Fri, 16 Apr 2021 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbhDPMyt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhDPMys (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Apr 2021 08:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618577663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HYNZnN/jcxCU9TA1A50oOrW68ECjycgVhgYeaOwX0/Y=;
        b=NkjKP8Uj7O6XZ1tRQcF0v5mUwaMCl8sTaxoAts1lyWfJMo22P6z+gfU5RD4B73pNrmbF7r
        0OeAAQQQORx/hayQLwDHfq88/scYhQ5Z2If67j8ak1ZkRvGdR4uhMRcyPQ/O0vQyz2GdaV
        wGkwd0GIUijP9JU2+zf9MTGxmE2w+ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Nujcf1s5Mkexhgs3YO71bA-1; Fri, 16 Apr 2021 08:54:21 -0400
X-MC-Unique: Nujcf1s5Mkexhgs3YO71bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA6D9A0BC8;
        Fri, 16 Apr 2021 12:54:20 +0000 (UTC)
Received: from localhost (unknown [10.40.196.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3927660C0F;
        Fri, 16 Apr 2021 12:54:20 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 12/12] secilc/docs: Update the CIL documentation for
 various blocks
In-Reply-To: <20210330174003.281613-3-jwcart2@gmail.com>
References: <20210330174003.281613-1-jwcart2@gmail.com>
 <20210330174003.281613-3-jwcart2@gmail.com>
Date:   Fri, 16 Apr 2021 14:54:19 +0200
Message-ID: <87fszq9ypw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Update the documentation for macros, booleans, booleanifs, tunables,
> tunableifs, blocks, blockabstracts, blockinherits, and optionals to
> tell where these statements can be used and, for those that have
> blocks, what statements are not allowed in them.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  secilc/docs/cil_call_macro_statements.md  |  2 ++
>  secilc/docs/cil_conditional_statements.md |  6 +++++
>  secilc/docs/cil_container_statements.md   | 28 +++++++++++++++--------
>  3 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
> index 332eb28f..352a9fb0 100644
> --- a/secilc/docs/cil_call_macro_statements.md
> +++ b/secilc/docs/cil_call_macro_statements.md
> @@ -58,6 +58,8 @@ When resolving macros the following places are checked in this order:
>  
>  -   Items defined in the global namespace
>  
> +[`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockinherit`](cil_container_statements.md#blockinherit), [`blockabstract`](cil_container_statements.md#blockabstract), and other [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
> +
>  **Statement definition:**
>  
>  ```secil
> diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
> index a55a9b6c..d0c8e2ce 100644
> --- a/secilc/docs/cil_conditional_statements.md
> +++ b/secilc/docs/cil_conditional_statements.md
> @@ -6,6 +6,8 @@ boolean
>  
>  Declares a run time boolean as true or false in the current namespace. The [`booleanif`](cil_conditional_statements.md#booleanif) statement contains the CIL code that will be in the binary policy file.
>  
> +[`boolean`](cil_conditional_statements.md#boolean) are not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) blocks.
> +
>  **Statement definition:**
>  
>  ```secil
> @@ -126,6 +128,8 @@ Tunables are similar to booleans, however they are used to manage areas of CIL s
>  
>  Note that tunables can be treated as booleans by the CIL compiler command line parameter `-P` or `--preserve-tunables` flags.
>  
> +Since [`tunableif`](cil_conditional_statements.md#tunableif) statements are resolved first, [`tunable`](cil_conditional_statements.md#tunable) statements are not allowed in [`in`](cil_container_statements.md#in), [`macro`](cil_call_macro_statements.md#macro), [`optional`](cil_container_statements.md#optional), and [`booleanif`](cil_conditional_statements.md#booleanif) blocks. To simplify processing, they are also not allowed in [`tunableif`](cil_conditional_statements.md#tunableif) blocks.
> +
>  **Statement definition:**
>  
>  ```secil
> @@ -164,6 +168,8 @@ tunableif
>  
>  Compile time conditional statement that may or may not add CIL statements to be compiled.
>  
> +If tunables are being treated as booleans (by using the CIL compiler command line parameter `-P` or `--preserve-tunables` flag), then only the statements allowed in a [`booleanif`](cil_conditional_statements.md#booleanif) block are allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block. Otherwise, [`tunable`](cil_conditional_statements.md#tunable) statements are not allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block.
> +
>  **Statement definition:**
>  
>  ```secil
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
> index 76e9da51..c75c2d7c 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -4,7 +4,11 @@ Container Statements
>  block
>  -----
>  
> -Start a new namespace where any CIL statement is valid.
> +Start a new namespace.
> +
> +Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](cil_container_statements.md#optional) blocks.
>

FYI:

Applying: secilc/docs: Update the CIL documentation for various blocks
.../devel/github/SELinuxProject/selinux/master/.git/worktrees/patchwork/rebase-apply/patch:62: trailing whitespace.
Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](cil_container_statements.md#optional) blocks. 
warning: 1 line adds whitespace errors.





> +
> +[`sensitivity`](cil_mls_labeling_statements.md#sensitivity) and [`category`](cil_mls_labeling_statements.md#category) statements are not allowed in [`block`](cil_container_statements.md#block) blocks.
>  
>  **Statement definition:**
>  
> @@ -47,6 +51,8 @@ blockabstract
>  
>  Declares the namespace as a 'template' and does not generate code until instantiated by another namespace that has a [`blockinherit`](cil_container_statements.md#blockinherit) statement.
>  
> +Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`optional`](cil_container_statements.md#optional) blocks.
> +
>  **Statement definition:**
>  
>  ```secil
> @@ -97,6 +103,8 @@ blockinherit
>  
>  Used to add common policy rules to the current namespace via a template that has been defined with the [`blockabstract`](cil_container_statements.md#blockabstract) statement. All [`blockinherit`](cil_container_statements.md#blockinherit) statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.
>  
> +Not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
> +
>  **Statement definition:**
>  
>  ```secil
> @@ -199,15 +207,11 @@ This example contains a template `client_server` that is instantiated in two blo
>  optional
>  --------
>  
> -Declare an [`optional`](cil_container_statements.md#optional) namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy. [`tunableif`](cil_conditional_statements.md#tunableif) and [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in optional containers. The same restrictions apply to CIL policy statements within [`optional`](cil_container_statements.md#optional)'s that apply to kernel policy statements, i.e. only the policy statements shown in the following table are valid:
> +Declare an [`optional`](cil_container_statements.md#optional) namespace. All CIL statements in the optional block must be satisfied before instantiation in the binary policy.
>  
> -|                     |                |                    |                    |
> -| ------------------- | -------------- | ------------------ | ------------------ |
> -| [`allow`](cil_access_vector_rules.md#allow)             | [`allowx`](cil_access_vector_rules.md#allowx)       | [`auditallow`](cil_access_vector_rules.md#auditallow)       | [`auditallowx`](cil_access_vector_rules.md#auditallowx)      |
> -| [`booleanif`](cil_conditional_statements.md#booleanif)         | [`dontaudit`](cil_access_vector_rules.md#dontaudit)    | [`dontauditx`](cil_access_vector_rules.md#dontauditx)       | [`typepermissive`](cil_type_statements.md#typepermissive)   |
> -| [`rangetransition`](cil_mls_labeling_statements.md#rangetransition)   | [`role`](cil_role_statements.md#role)         | [`roleallow`](cil_role_statements.md#roleallow)        | [`roleattribute`](cil_role_statements.md#roleattribute)    |
> -| [`roletransition`](cil_role_statements.md#roletransition)    | [`type`](cil_type_statements.md#type)         | [`typealias`](cil_type_statements.md#typealias)        | [`typeattribute`](cil_type_statements.md#typeattribute)    |
> -| [`typechange`](cil_type_statements.md#typechange)        | [`typemember`](cil_type_statements.md#typemember)   | [`typetransition`](cil_type_statements.md#typetransition)   |                    |
> +Not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) blocks.
> +
> +[`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_container_statements.md#in), [`block`](cil_container_statements.md#block), [`blockabstract`](cil_container_statements.md#blockabstract), and [`macro`](cil_call_macro_statements.md#macro) statements are not allowed in [`optional`](cil_container_statements.md#optional) blocks.
>  
>  **Statement definition:**
>  
> @@ -266,7 +270,11 @@ This example will instantiate the optional block `ext_gateway.move_file` into po
>  in
>  --
>  
> -Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statement is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. This only works for containers that aren't inherited using [`blockinherit`](cil_conditional_statements.md#blockinherit).
> +Allows the insertion of CIL statements into a named container ([`block`](cil_container_statements.md#block), [`optional`](cil_container_statements.md#optional) or [`macro`](cil_call_macro_statements.md#macro)).
> +
> +Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_conditional_statements.md#booleanif), and other [`in`](cil_container_statements.md#in) blocks.
> +
> +[`tunable`](cil_conditional_statements.md#tunable) and [`in`](cil_container_statements.md#in) statements are not allowed in [`in`](cil_container_statements.md#in) blocks.
>  
>  **Statement definition:**
>  
> -- 
> 2.26.3

