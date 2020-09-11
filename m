Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF011C433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 20:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5A221E7
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 20:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM0fv4B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgIKU1m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKU1k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 16:27:40 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD0C061786
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 13:18:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so9402902otg.5
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJJldJAgUyrlQ6xD44dk6Bwran62q8v59gEq/gfXwM0=;
        b=tM0fv4B1W35eZiTf4RU8W5Fgyum9IQ/A6Zb2IKCBqyDC2uFQoOpo+nmLmCtz4xF6wN
         +6gH67k38q5KXXNxnm9RRYejl3ZYGPdv8SYOQtFlBod9el4ElrkYMlBihqeSS5uHj1CQ
         zT+1Z/a6rzWfYeCGMndtqCTBbpoz+g62oj6P2iygpVbv4yHLi0t7OcOXg1fe+T/2bsEF
         uXmUbd5Ih2oJAO3FhhX7zp+pqXNWqleKRTYeIDmSwWEg0oX6Q+czzlxxxUqoMZoykU6t
         qPihnxH4crpgzle+FYhI+vdZoBaV6F+7uUSEMFZYSUp7E8yojoV4kxaObnqwi+wYj2In
         RU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJJldJAgUyrlQ6xD44dk6Bwran62q8v59gEq/gfXwM0=;
        b=U1R2/E6VT0aBnxT1dl4F+rcgTWw1xjfUZzUzXt1OOwSDakua09vququRxCmOw0MZkI
         RnirXlJQskJm2OkdWuhSqUFghV7+8VrvMntcxhlN0sJydwxYvHlhIUW7KP5AZkQkA69/
         mEPYStb81s7NMdjf3j/7lr+aNtE0FgIUkSxs/2JK5nowyuLqYrfi7DZOyICE2QXLLPG2
         N0etPNxKycEKFIptcF2Oq9Jj7Bmz8oeOuFtHVO+JgbYtodqAQlQSrz8P0EcXTXIU3ryv
         cte0Ahvig/sB6E559shliTH6CWrxFIDJmAmfTGeC3bMpaL9TTamo1Pf/DnMGfGdgLygL
         fksw==
X-Gm-Message-State: AOAM533DPACz5zbzhQ9MKgEqwncF5DpQZgucILTtjiYqtZEhdzzr1sRh
        OigpA+3fuAFmTBMa0V+GsPnw3mKpXlgfo6hSUYj7YwYJ
X-Google-Smtp-Source: ABdhPJyVtrHUSJtRRZujyePuJ8x8SLw8XS9Dn3A17h/+Zuz+EWMl0Uq3HJp+lYGg6LoBXOXJeyqXqbL0bBXdOX6rzsU=
X-Received: by 2002:a9d:185:: with SMTP id e5mr2370987ote.135.1599855532686;
 Fri, 11 Sep 2020 13:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200911195614.429223-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200911195614.429223-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 11 Sep 2020 16:18:42 -0400
Message-ID: <CAEjxPJ5P0sv4v88xYnf=tadNk=y5+D_z6dDX-JTqQ=dgGjBarg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libselinux: Fix selabel_lookup() for the root dir.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 3:57 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> 9e4480b921bb ("Remove trailing slash on selabel_file lookups.") introduced
> a bug which turns the root directory lookup "/" into an empty string.

Thanks.

> v2: Fix commit message

This should go after the --- so that it doesn't get included in the
commit message since only the final version gets committed.  But don't
worry about re-posting just for that; I can just amend it before
merging if I remember or if not no big deal.

> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
