Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FCC433DB
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 23:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C714C2251D
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 23:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbhASX5S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406118AbhASN5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 08:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611064535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UL7tBLfeDNzkb20cn0pNZbbkOFj8AwurgVQUHqU7+Rc=;
        b=MdBt81czMKcOUCGCqnoVpFu/P8Mq4JW2yQN8p2muipMR0cV2ggRkl0NPRVr5krDKVQyoKr
        nnAneHSaYHF98PDBHxCI26jTNuQsMYG0WdBL+eT7BykGmL072v5C1Ufzr7nkL8A1ab92Uc
        L9Jsw1UgJZ+89utZucNE5gRdLDzyvmA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-NTrpBQaZOquu2DIlRiL3Iw-1; Tue, 19 Jan 2021 08:55:33 -0500
X-MC-Unique: NTrpBQaZOquu2DIlRiL3Iw-1
Received: by mail-lj1-f198.google.com with SMTP id s18so5055550ljp.7
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 05:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UL7tBLfeDNzkb20cn0pNZbbkOFj8AwurgVQUHqU7+Rc=;
        b=d/FMvsArVTbxNblhQxrHrdWNJkAsdqTOT9QmIbkeaMTuTqgJvftUAMIha35l2LAU8w
         BgE5w1WuFSAj5r88zf1MBIAubT7sxYBB5fOu1HYGh1JMbYsWGOs10ezxYk2vtIPb6aPX
         Fqg4QnkE4uBE3ksBnJlHjyLN7Znb8s/2OYug2BaiabIGOW/TMhiTV+mH2VYiryunY45U
         0ra0kfEbCDKcSPj2gM00i/vIdx+2EdJkeNvuCOTStI1kzkDZATdSzW/rjUFcj4246N3i
         6c7oBQvpT2YwdmPxrinwAw3VzF71QZhe2JJqKPfRQIeWnzV8xgsHdCV7COyYqACOqaIo
         5C1w==
X-Gm-Message-State: AOAM532ovDBb1iYLEsqqluTkH8Q3LhNoMWJkhOVONJRssS5fjSa8Futt
        OFkN1XSzWKJMsLIkerprk84A0Hea5LYrXo1pk7n6Rg5rl5y3lG3PBYfvbyCKkIOmA36P9JNMNYF
        Bx8510x0D1QvCGo3dNLmKZwx6DJBSDmFFhQ==
X-Received: by 2002:a2e:7212:: with SMTP id n18mr1957728ljc.399.1611064532180;
        Tue, 19 Jan 2021 05:55:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysPIbvUeLJwPOww4XZeDsQd9gi1ouY8cVYf8I8AaxenMBVxs+FepgRCYcgLZrDAe0tu9LteghDF3EK59ZC0RY=
X-Received: by 2002:a2e:7212:: with SMTP id n18mr1957722ljc.399.1611064531995;
 Tue, 19 Jan 2021 05:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111211405.2215410-1-vmojzis@redhat.com>
In-Reply-To: <20210111211405.2215410-1-vmojzis@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Jan 2021 14:55:20 +0100
Message-ID: <CAFqZXNuE3CbwGDv7mvxh67iX3zeLKTu6AJC_VoeALb_o26+zOg@mail.gmail.com>
Subject: Re: [PATCH] python/sepolgen: allow any policy statement in ifndef
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 11, 2021 at 10:16 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> "ifndef" statements can be used to conditionally define an interface,
> but this syntax is not recognised by sepolgen-ifgen.
> Fix sepolgen-ifgen to allow any policy statement inside an "ifndef"
> statement.
>
> Fixes:
>         $ cat <<EOF > i.if
> ifndef(`apache_manage_pid_files',`
>         interface(`apache_manage_pid_files',`
>                 manage_files_pattern($1, httpd_var_run_t, httpd_var_run_t)
>         ')
> ')
>
>         #sepolgen-ifgen --interface=i.if
>         i.if: Syntax error on line 2 interface [type=INTERFACE]
>         i.if: Syntax error on line 4 ' [type=SQUOTE]
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolgen/src/sepolgen/refparser.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
> index 9f850990..3c69904a 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -434,7 +434,7 @@ def p_ifelse(p):
>
>  def p_ifdef(p):
>      '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> -             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> +             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statement SQUOTE CPAREN optional_semi
>               | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi

IMHO we should be consistent and allow any statements also in ifdefs
(i.e. make an equivalent change in the line before and after).

>      '''
>      x = refpolicy.IfDef(p[4])
> --
> 2.29.2
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

