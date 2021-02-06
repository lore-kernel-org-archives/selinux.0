Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB0C433E6
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597E364E33
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 20:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBFUaF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Feb 2021 15:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUaB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Feb 2021 15:30:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F1C06174A
        for <selinux@vger.kernel.org>; Sat,  6 Feb 2021 12:29:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id sa23so18601887ejb.0
        for <selinux@vger.kernel.org>; Sat, 06 Feb 2021 12:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p30Qx9DRFbfS1AlucdRVH8UZnocU5x0bi2tViztCWcg=;
        b=EApo1L+hYOKfRsSKaH+nEqwAje8Y6XDc5/ufYyO4dkfnlgyUYU6geDnLrVRh2qGAQG
         RmnhupgytcWz3KnKpuxQqpnlEUwhgOlzlzfCHo+hKjmIL7dvjslsHlwYFEqDL3T2G6Z6
         ZFowrCUMnkniy67WVxBFs6AyNQvAahOhb9e5yk3TQfZ4TLMnN6I+C4i0rYLF1XVV2Y9j
         kMUtDhJ1YqINkzagjspaPDmo21+6SjPB4S3+qDXXMKBJtKLnhZozJWj15Y5AgN6jFT73
         eKd6DEm5qRo7M6jnqBdwJ8dToWYVRXjb2DVL0Q+cQWbiu1hf1dzZycLcbA7cqTLXONz/
         sVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p30Qx9DRFbfS1AlucdRVH8UZnocU5x0bi2tViztCWcg=;
        b=WdA+eJeEQhEbUGVqVB6p9UoO48l8n/QnMiVVicvHoPddyCOpXILfyGNb6fmQBaKn6e
         aI5CgRu5xt6Y/L68TjsEzpAhww+CF6p1KNKtb4JMOAYakINz8fNzkPYHv2AIrx9KvcxH
         z6eeXdFXcjDbP3ikWwbgle+e/p4O+2FhIS7HxNbiMPNsrx/wmjWDxYPD0YMA2UD0TEfe
         FAf6DjW5C5ngTSvI2PWGhp3oLUSbdty6KaGSPOV2uTvBfJAFia0AVx1b3At1XbFKddOh
         8+D7DfxWpy5zewJ52rVxO1vWA4rouLDq9yRNhXYZjqx66MhXtlReN/kJGuufJUkOsLcp
         vITQ==
X-Gm-Message-State: AOAM5307I36kQ6nZMu5JBQuRvwtPtan4oKGXT27dwgmVdASQcWpISKek
        X7NykUv3ttDKL4UVsnKURSxZVlRr8n4=
X-Google-Smtp-Source: ABdhPJx875963J/eRS8efwI2WJna3a7DQAFqJbT0KsyZyxBbw8q6u9pftaOHYzuyBlAQzTEaeCZFDA==
X-Received: by 2002:a17:906:5846:: with SMTP id h6mr10021074ejs.521.1612643359954;
        Sat, 06 Feb 2021 12:29:19 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id s15sm5732630ejy.68.2021.02.06.12.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 12:29:19 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
 <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com>
 <82ba2e85-54f6-5a7b-2bc4-b49bc509de18@gmail.com>
 <CAP+JOzT3Ee=WnMfnME3N=MCytb1um3F=iBZnNUzV6xN6R8PYpg@mail.gmail.com>
Subject: Re: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
Message-ID: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Date:   Sat, 6 Feb 2021 21:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP+JOzT3Ee=WnMfnME3N=MCytb1um3F=iBZnNUzV6xN6R8PYpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/21 12:19 AM, James Carter wrote:
> On Thu, Feb 4, 2021 at 4:28 PM bauen1 <j2468h@googlemail.com> wrote:
>
>>
>> https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide3.html
>>
> 
> I like version 3 the best, but I really don't like the color used for
> "self", "object_r", "h1" , etc. It just stands out too much.

This was originally meant to be a test color scheme to showcase all different "classes" of keywords that could be highlighted, not intended as an actual color theme.

I've changed the purple to a lighter pink:

https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide4.html

In case someone can come up with 6 different colors that go well together, I can put together an updated theme (Colors for Strings+SpecialChars, Function, Operator, BuiltIns, Comment, Keyword).

I will send a v2 of the patch, including the color theme as a separate patch.

> ...
> I find it easier to maintain if the items were sorted in alphabetical
> order (this enables inserting new items if the need comes one day,
> without wondering whether the new items should be at the end of the
> list or if the order should match the one used in some source
> files...). Or, if you want to keep this order, please add comments
> describing how the lists were created, in order to ease future
> modifications.

Thanks for the feedback, will be implemented.

-- 
bauen1
https://dn42.bauen1.xyz/
