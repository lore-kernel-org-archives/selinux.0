Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E834DC47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA239206D9
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588290214;
	bh=tcVuwn/92vSjcQAzqrthgtCxQ2DLozN5xuLXK9tbIYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FuQyJ7eLus4M0sdyWvYG9nIQzVixuJtPsssIQiwrsHGywUkvdlIuJz5WMRMy3Tl8m
	 JgE7LvVy1Q2D6oFFn8rBUuvWCYVhQ2VjBRnAxq0FDwjLTQT/oEoBtfrv0BzD2KPylN
	 f5furRrOSfWTq+CoyCim6oO83FYBjHQbMrQkrNrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgD3Xnd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgD3Xnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 19:43:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD86C08E859
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 16:43:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so1199290ljl.6
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05oH2K+vg7L8+W/HnHl99DKxppRnrgZq0ok6k+htQb4=;
        b=XzR5U2YYxGN3xRIy/aE1u4RGhXZsY5P7C3x/9LAExW27SSRvRKmF6+7yld5rqLUCv5
         M+dioQa6yfzUT++eQic0svhLMLCzka1EJVAEfccNUEanl2fjcKkS8eyuWdKS+/VR23fR
         Rs2nhDJNGyWO2uVcPFWhrX9jZNEPFduLjHMXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05oH2K+vg7L8+W/HnHl99DKxppRnrgZq0ok6k+htQb4=;
        b=r8fqA1l1dF79UGpdK7895Z69C6W/sjQtYZdWVQKyijsonhRDCdXoTMGBLn7cn1U0UT
         5omkjvhJXgTB3ffi00qb4oB5kz5gFfK5r4juHSrwdi87YBxpGdwutZ9t1c5wxM7+ODsk
         6zGiJJub/SErcKdULi1bn16v+rpriUvWVy+FzEulXr5EtuS78Otn1PcoOSpYGNuST9eE
         fT5XLjFKjCmJuf1Lhjf7Z17g+FNaPgbrAMZty3UByCVQmD1vnFIHFySN18IhEZ+UwBiJ
         phErZVJcCZdGuGzwRPuiSsd7H9dFQECxscsOGg5+i8GcznXNyrXvxR+YB7cjHMAVrmY9
         E8ng==
X-Gm-Message-State: AGi0Puat4RJ+Xdm848BBaUv3nZn2gra95ntE+gRDAo3OG05z1TGZHKc6
        LnPAapetdcJrNM5ky1OSMaw3mkh1ZwU=
X-Google-Smtp-Source: APiQypJBWBjT4eMGBEKAb0yO8jYK/3IJl/0x3VeMKVMTcKUHQYRLDaBxtJD6XdN/dQVS8uzv/o9iaQ==
X-Received: by 2002:a2e:b057:: with SMTP id d23mr803347ljl.157.1588290209728;
        Thu, 30 Apr 2020 16:43:29 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h15sm881980lfc.77.2020.04.30.16.43.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t11so2714608lfe.4
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr692273lfe.152.1588290208226;
 Thu, 30 Apr 2020 16:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTu3YWPmwtA7RERHDRhQt0wAkmN4GJCmaRY7KSFRwtACQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 16:43:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
Message-ID: <CAHk-=whGjVLwTnYT8euAb_Lzqxd=-TFnJU-k2uu+Fn_hBfMc+w@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.7 (#2)
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 2:24 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Two more SELinux patches to fix problems in the v5.7-rcX releases.
> Wei Yongjun's patch fixes a return code in an error path, and my patch
> fixes a problem where we were not correctly applying access controls
> to all of the netlink messages in the netlink_send LSM hook.

Side note: could we plan on (not for 5.7, but future) moving the "for
each message" part of that patch into the generic security layer (ie
security_netlink_send()), so that if/when other security subsystems
start doing that netlink thing, they won't have to duplicate that
code?

Obviously the "for each message" thing should only be done if there is
any security  hook at all..

Right now selinux is the only one that does this, so there's no
duplication of effort, but it seems a mistake to do this at the
low-level security level.

Or is there some fundamental reason why a security hook would want to
look at a single skb rather than the individual messages?

                Linus
