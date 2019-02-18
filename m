Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D208C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3CB218D3
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bh3D4ALV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBRD7f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:59:35 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34548 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfBRD7f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 22:59:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id a42so4914428uad.1
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 19:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5mPZbc1CaMt6frrgcbK8kk9usGEYeIzQLFIP+/1HEI=;
        b=bh3D4ALVp/1uxirXriqpy+0d0htmuuK2ut3iHHmO5ryWLjCfx+oUyZKz7bPT45KlQU
         STjjesa67Zy3fHPPYghBlEMAynx+DSzHp/CC+M7qtarJ/Gpz3u/zK3vv/Sw74y91M0Cn
         Ly4gKmxLh4XrnWR9Y7CvW5uYUvoVDlOfm20+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5mPZbc1CaMt6frrgcbK8kk9usGEYeIzQLFIP+/1HEI=;
        b=K6mldHWRtZyOlH1UAp6wURxYbfEw4pKCEtC0qiS8zQdBMEhTGxJKdhM6WGaIO5gktM
         JPiKgtm44dpIznc01j42sKGxwzbaciIrQP4OjBWuqkezIQg57mpj5u+7e39glO8BM3nN
         PpqkJgqwMr9HRZcemBno1uacB+TCu8lBgsrATyA+FstHXn1kbkGT5C0xfkOUuCzsj65W
         o5ZGtSPHAfK/LDKtTZg6g9HUR1v1/2fHfuWDv5+rlsZ01wq3PMZGcF+2PBxK1/OsZWG5
         QyMOX8yHMODHCqIM2Zv18u/TUvqNMUKa+i4fi5yT6utBEj5imWDKQK6VjnZEuYrEJm8C
         97LQ==
X-Gm-Message-State: AHQUAub6J5hgz2uZFlOnKBm1nELpmjU88RyG2zwcm4leXkoOfUJglX/6
        o0zsX4b6ZCUJdtClkR+sFmyrGCRAJ7c=
X-Google-Smtp-Source: AHgI3IbebpZpUGc/2Yaa3TdB5Gi8oeAj8HfmFBxiiWZ5QHHbEJUnEP2QDdgXZdRD/yQ3IrDNc6eqNg==
X-Received: by 2002:ab0:2b93:: with SMTP id q19mr10407862uar.130.1550462373710;
        Sun, 17 Feb 2019 19:59:33 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id l14sm2641926vke.54.2019.02.17.19.59.32
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:59:32 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id s15so5379872uap.6
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 19:59:32 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr10634505uac.122.1550462372286;
 Sun, 17 Feb 2019 19:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20190217220836.GA41179@beast> <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 19:59:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
Message-ID: <CAGXu5j+Cy_Ku=1zyLpXLnJXNKieu3L_SZq3Rn_D0jm=N5szt9Q@mail.gmail.com>
Subject: Re: [PATCH] doc: sctp: Merge and clean up rst files
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Haines <richard_c_haines@btinternet.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 17, 2019 at 6:56 PM Paul Moore <paul@paul-moore.com> wrote:
> On Sun, Feb 17, 2019 at 5:08 PM Kees Cook <keescook@chromium.org> wrote:
> > The SCTP sections were ending up at the top-level table of contents
> > under the security section when they should have be sections with the
> > SCTP chapters. In addition to correcting the section and subsection
> > headings, this merges the SCTP documents into a single file to organize
> > the chapters more clearly, internally linkifies them, and adds the
> > missing SPDX header.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> [NOTE: adding the SELinux list to the CC line]
>
> Looks good to me, thanks for the fixes/cleanup.
>
> Are you planning this to go via the doc tree, or would you like me to
> grab it for the SELinux tree?  Either way is fine with me.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks! I figured it'd go via the docs tree since it's mainly moving
files around in there. I figure it's up to Jon. :)

-- 
Kees Cook
