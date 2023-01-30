Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1475C636D3
	for <selinux@archiver.kernel.org>; Mon, 30 Jan 2023 19:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjA3TzZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3TzY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Jan 2023 14:55:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6148598
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 11:55:04 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g9so6588457pfk.13
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wroI2sMWC0hXR6IggiRH5+K7kTm1YS1sDXcsvXxLmtI=;
        b=gUAr4HEQ79iXuCHbOuT7Q/rThsV2zLqrws/HcJAjtZ9WmQkvE9DrfMKmkt369sRtEt
         cCg9NkTE46rD/fAUUegd4KJptBhTITmpyPihBBOuvvbtUbD+BJ6TQHKSC0Imv6luJkxK
         4yUcnLk33YbWcIAr3Jfc+FQ7Q/c6ihNHJ73KDGOug3waHLgfoKyUeTzXBGh5qD3vkbn1
         KxcWJkx+dGj0FqUya7ZFPU3QCtwFR+liUiLcgdE8etKcysU6mu21/zX65/X7ER7Z+jr+
         5b3hJlERAIRTn4YO3Y/zSQKgWo7ak8AE/e5o1yGdQ3q4fk6kISMrMr0FTpX39xc3sIJw
         dG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wroI2sMWC0hXR6IggiRH5+K7kTm1YS1sDXcsvXxLmtI=;
        b=t91lk2NtqfcdbjXq66ZeAI/2/CC5qEHj3yTiqGcfc09hhNpzUnE+u/XKnUl6a+vWdj
         LjqR4Ty1kczJpH+HhyJOALkkkRkb4d8MJj874UDtchlf0wc83YW/yz+wXUfm/Ro+LOdb
         7P04/RzK7J/5DQ6Ip63s2fiHqbmg4/DNCPb8CZrKQtVnbiANZffJXTpi9l1QlX8djLzK
         37d1QUW9LvCqOezTh9of5+kAd0zt2RD7hQN4lNQqrAr4v3WfPWUC7rI8/DF9VcLyXWGt
         TBiP55XR8TOQDLSaU6xTrN0U35nKhYw2kLUv7iVEHJSPnv2D6R1byPZo+dm4j0dY4tMI
         5P7Q==
X-Gm-Message-State: AO0yUKWIuvpcHl12Y2S1AJD773kQzISOnI+tTBpTwf5b12NWfxIi0XM9
        Qyom1UYfyQYQGMyjxr+4PIcOZN5IYEX33jqT1Y1wjd/202CD
X-Google-Smtp-Source: AK7set92ujEiOQDO8U9co29DZRt9rL3FtSitATJf8/02hW8dAjmitCVkWhKHlRAlfi9sa4qO+0yx87ruFwEksHGZsdA=
X-Received: by 2002:a05:6a00:1892:b0:593:dec8:4384 with SMTP id
 x18-20020a056a00189200b00593dec84384mr392167pfh.67.1675108504209; Mon, 30 Jan
 2023 11:55:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
 <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
 <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
 <CAHC9VhRWz2N6ezZckSwtZvM3J75prdq7ckaoQgAO+ECz527qCw@mail.gmail.com>
 <CAHC9VhRgR2BV3v_1o3JGdBT80UxiMSGUcrLVG8Tj3JiKynZYNw@mail.gmail.com> <CAHk-=wiHX5wpnFSOgWNgNxMk+xHA2Gbh+7_eiJjTPGqpJ1kxog@mail.gmail.com>
In-Reply-To: <CAHk-=wiHX5wpnFSOgWNgNxMk+xHA2Gbh+7_eiJjTPGqpJ1kxog@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Jan 2023 14:54:53 -0500
Message-ID: <CAHC9VhSvmbSC9CraaipWjNmbZYadOcHQJ7oMjiieSc+Fv2Y+AA@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 30, 2023 at 1:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 30, 2023 at 9:47 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > I should add, do you have any particular test script you use?  If not,
> > that's fine, I just cobble something together, but I figured if you
> > had something already it would save me having to remember the details
> > on the perf tools.
>
> So I've done various things over the years, including just writing
> special tools that do nothing but a recursive 'stat()' over and over
> again over a big tree, just to pinpoint the path lookup costs (big
> enough of a tree that you see actual cache effects). Then do that
> either single-threaded or multi-threaded to see the locking issues.
>
> But what I keep coming back to is to just have a fully built "make
> allmodconfig" tree - which I have _anyway_, and then doing
>
>      perf record -e cycles:pp make -j64
>

...

> Put another way: there's nothing _special_ about the above, except for
> the "it's a real load that does actually show a few core kernel
> areas".

Thanks.

-- 
paul-moore.com
