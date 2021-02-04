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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80FC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 21:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F3164DFF
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 21:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBDV3m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBDV3k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 16:29:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFDC0613D6
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 13:29:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id r12so8044367ejb.9
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Eap5o23aVtTCc3QhFpP/7PQOlYQorXzCosvgmRX1HY=;
        b=GIdgBxvgpbkEGBpzvgKtK1T3fXQWRBiem78MhAgcxT1iARm1UvR8ZRRsC6+e3fqhqn
         j3+THj/4EInzk9PuTnSynObdawLm9G4HXDlWLUfwqSaCu93W2HZNVp00aN0J6NT2USya
         b3FfZTHh7bxchqSDwwqAmXDdNqn6S+D+pQv9DAkmO2WissvBAUD9d1M1m4NUmeZqpu54
         UFrDZVEguGLy+T4d0Zq/+K8zSmzus3oMzKL7NBNkBLFWGPRw6+swR0PZKlvL4ZqnnCcf
         VA5gFe6Vf/t4PwCBXvULAFl+WU6J0E5UKi4lHMe5g0WhAlrBL6ZEojBb/s3mPh8EyS+R
         Tx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Eap5o23aVtTCc3QhFpP/7PQOlYQorXzCosvgmRX1HY=;
        b=qcic+5joBFm2Kab5U5lH8Roq3tVN0+5WFvURoRhd1rMP5ksaUBvORHtslBN9Yigh0C
         0vqdmPhe2lSlN4zhzxLehhHEXrBJWXla5OOs/AjEuj7Syt/qfOeInTcx+Gr4mRdHabOn
         7uMt/RlzG0e+senERmHpttspzIx61IyWSgzU1dkuMfvUZV0eOtAH3fR9AlNcAGhvSgEz
         d4qAThbKOv+cPPW6O5w01feAAloAjMYcck3LX4pA7RQqZNyd0QV+awfXeytzCqzmsyu8
         cIcA2rdL61xWR3v+qPUriy9k1LXjXoZrQZLG7TQVHt6w4XkAHDqUx9CW5ZURI8LcUKkR
         1nuw==
X-Gm-Message-State: AOAM531AohKq2pndGODAQbhabNq6RSpRPonuRiRoI5iRx8C8oo7956RQ
        eCJkpuBb+a3LmWSyXGxTFoq5c5V2BT4=
X-Google-Smtp-Source: ABdhPJwXFUf3kCIO+SQTGKNQtmCtaTVE9RrpElo5Z4sWTCVpyucaHOqVCNgn3nnEMUWGRc25LqZRXg==
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr1031826ejy.63.1612474139053;
        Thu, 04 Feb 2021 13:28:59 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id q14sm3041465edw.52.2021.02.04.13.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 13:28:58 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
 <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
Message-ID: <82ba2e85-54f6-5a7b-2bc4-b49bc509de18@gmail.com>
Date:   Thu, 4 Feb 2021 22:28:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/21 9:17 PM, James Carter wrote:
> I notice on page 10:
> (block unconfined
>     (user user)
>    ...
> 
> That the second user (which is the name of the user) is highlighted as
> well as the user keyword.
> 
> Similar thing happens further done on page 10 with the rule:
> (portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))
> 
> The "user" part of "unconfined.user" is highlighted.
> 
> "unconfined.user" is used in other examples as well.
> 
> Changing the first statement to be (user user1) would be fine, but I
> would like "unconfined.user" to remain as is.
> I am not sure how hard it would be to fix that.
> 

I thought this would be harder, but just highlighting the first cil keyword in a block is actually very easy, and I can rework the patch to do just that.

It becomes more difficult when trying to add (some) highlighting to everything else since keywords are reused as names very often (I do that by design even):

Some examples from the guide:

(macro all ((type x))
    (allow x bin_t (policy.file (execute)))
    (allowx x bin_t (ioctl policy.file (range 0x1000 0x11FF)))
)
(call all (bin_t))

(mlsvalidatetrans file (domby l1 h2))

(defaultrole char target)

(type t1)
(allow bb.t2 bb.t1 (policy.file (read write execute))))))

In the above e.g. all is name, but is usually a keyword with a very important meaning, so imho it should be highlighted, in a lesser way this also goes for t1, or domby, ...

The only way I avoid highlighting _all_ names as keywords is to implement a lot of the CIL grammar in the syntax highlighter, but I'm not really sure if it's worth the effort.
It could be done for some keywords, e.g. constraints, filecon.

A better alternative might be to just highlight less, e.g. drop `low`, `low-high` keywords entirely.

I've uploaded another version with some small fixes and a debug color theme to better show what-is-what:

https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide2.html

and with more keywords removed:

https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide3.html

; only in version 2: file is considered a keyword (builtin), but this should normally only be the case in filecon statements, here it references a class
(mlsvalidatetrans file (domby l1 h2))

; all, t1, low is considered a keyword (builtin), but is a name
(call all (bin_t))
(type t1)
(userlevel u5 low)

; but here t2, t1 are no longer highlighted erroneously.
(allow bb.t2 bb.t1 (policy.file (read write execute)))

I think Version 3 only has mismatches in the example policy due to usage of `all`, `t1` and `t2` as names, so that might be the way to go.

> I am not sure if this matters to anyone, but if the document is
> printed, the syntax highlighting (particularly for the comments) might
> make it a little bit hard to read.

pandoc can still be run without syntax highlighting (--no-highlight) if you want to actually print the document in greyscale. 

It also looks like I messed up when sending the patches, patch 1, the least problematic one ironically, got lost somewhere.

-- 
bauen1
https://dn42.bauen1.xyz/
