Return-Path: <SRS0=NFTj=2E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1746C43603
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7812320724
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com header.i=@kernelim-com.20150623.gappssmtp.com header.b="k70Pg+az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfLNSuI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:50:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52073 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNSuI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 14 Dec 2019 13:50:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so2268863wmd.1
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2019 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IT4hFqEwmvp7RtwmBJVqtxcXNbbcdnZYZ34jOii3rSk=;
        b=k70Pg+az59Da3g0zVRU8t3/KUtAdjjS1BORuueIy6Eemd/8w9jrKXFYOclyqmS2wOg
         iCLV9C+un3pxnwQ+Rq8SdrVl8X2I+JHqesgwH+4NonjrsjVBMGXXqXY/47OKyE00d6Ly
         MWw0FvUN4fqxqgjkhJfUPxGq8fPiZs4JYvH0hxkLbaDbpgJsh9IBI+yBHwHZgEx6VwR5
         hrFwl48zsTEqptT+d+ZuwVdpAn07DSHrjnLvwKjycOgH8nmroB0IfYdHDKHOqiOB+II1
         qDOlRpIdh1JlhSTPoomBH2+nZJi6LeuLaPfJWMtd+CPgUI0mZtLWumbzC+vp60ObDqdW
         XtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IT4hFqEwmvp7RtwmBJVqtxcXNbbcdnZYZ34jOii3rSk=;
        b=gs0ZurrdcZBemRVWatdC0VMZI+hbMhFQWN6hNB7lSWKHyf3YhWBEhsQ7BTwHodKQdj
         Um46oG6319DCArO0WO9INojIPaHS4YjQqjUbNSE8BbGTqnJw97uIvx6MBxOTVa1cSDZ5
         9EP8fBLWgS6K6DK0dOZk1hAh4u/FuPw/vH/shc+m1vf7hFpWLvjCWh9iFRqqal1uE0f8
         uuJbZer35wWbLA4gYnZgE1ts2vJcW73VlYZLJ+eqA5Gec1EEOr01TkbgyauzyvMJsc3P
         qKIvyayvoNl5sa48nC2YZzBQOf1yMygrLSrR5/0tc/CySeJA3/iPg/A0ruqaKG5CC/XA
         xHXw==
X-Gm-Message-State: APjAAAUcR0HiJZp+yG9eo3eR2Old34/dCwaKWHbqWs2aNb5PZBhRPmyq
        64JPPgDbzK6FqFaGs5TDl+SYww==
X-Google-Smtp-Source: APXvYqwQPuBFiXEGJ3o4wGyOrIyiPGVsw4hMVpEpw0nHY2yO2zUShDELvfKnvidGI9LzvaIUMDPGXQ==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr11685427wmj.33.1576349406367;
        Sat, 14 Dec 2019 10:50:06 -0800 (PST)
Received: from gmail.com ([5.102.220.98])
        by smtp.gmail.com with ESMTPSA id z18sm14689252wmf.21.2019.12.14.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 10:50:05 -0800 (PST)
Date:   Sat, 14 Dec 2019 20:50:02 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        keescook@chromium.org, omosnace@redhat.com, jeffv@google.com
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
Message-ID: <20191214185002.GA8076@gmail.com>
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213202838.7323-1-sds@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> I would have expected that two kernels built with the same config
> with this enabled would have yielded different struct layouts in
> pahole vmlinux output, but that doesn't appear to be the case. They
> do have different seeds.  Am I doing something wrong?
> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
> change if enabled?

There's currently a long-standing bug with the GCC plugin where the
generated debug info is in declaration order, not build order (see:
[1]).  So, to verify it, try looking at the generated machine code.

Planned Clang implementation of this feature does not have this bug.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?format=multiple&id=84052

-- 
Dan Aloni
