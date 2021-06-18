Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF4C2B9F4
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 03:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90C1613B4
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 03:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFRDUs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jun 2021 23:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhFRDUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jun 2021 23:20:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EBC061760
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 20:18:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g8so13494398ejx.1
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLggwlEz9KvaqTsvD1N67bjXjYEPfw0xJN+eofsbIEg=;
        b=LeS2JjPwBohnWSN3UMBVdfjycTPlOisHQcuIJVwOlO9eR1p8p0xWOrm91+3FZl6C97
         G1rwNnlyYPzxy4McN2Y037p0crdsF8/zAOMC2sXR+QxnLekiwdb2BA+MMd4JepSPJy4j
         CtB3r+X1EkC31clb9Iw+5PQUXoOjC9nRmepkaZcWiAgX1oufedkU7HIKEpZokMf2qH7H
         RoEZKXdE3J0HnWEGuz8BKlTKHms1uoIqXENdI0+x5J0wBZHBJ74G78bGhvGT5wvq2Etw
         VAuHVTYtD4nanHpASudOb+OmfBfxWJlFH8e/oxrCBqWm+l60T8FlLlDOj+Nq6rDyxqaA
         a1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLggwlEz9KvaqTsvD1N67bjXjYEPfw0xJN+eofsbIEg=;
        b=ukuTYD1DzDJyUkcQCHpAcGaf1qYq6og+fnm4YJbAppcsFd93do4oKlXxY6jHd+9ppX
         9KNymAOSk47dwcdJBVuDbHw/J8mMGcsSC7hLVxeHgVy4f9bx/hj/QWsjIjmV2TBksfjQ
         Oy3Lo7LodrUaRI1gmd/REiCSGmIHWFDTqsMzd8eI6/hsskvbQQJDnxPvR1N6U8tdib6B
         BwcqU65xPdLpAX7XuB5qqC9e5GPgWfGVeSCamgSNqjWQbB6G7n8kgV7E0Jk+sjQVa6wI
         ncDPlBdesNX6mZU/rzQfO4DVEXmxpJACGFQYly7BFFtPdA/kPfoQAby4wLJdyzGvNLlT
         aCHQ==
X-Gm-Message-State: AOAM533atTFzCtbE7KdIcYyQ5Tr5GgsN9CL64O4bH08rP2y31i0ls3Qi
        Wv5oWgRXWuuBgqNAZT199Ew4aX8lCZDBrC+HvwKI
X-Google-Smtp-Source: ABdhPJzN+mYgtC0eBkhZhzGJhLQjFCbBuFlJghEgoQO/wcTYdvnFAIXrjFWrVDier3cOEKa4xAydvckxOEAYsT5C+1Y=
X-Received: by 2002:a17:907:a8f:: with SMTP id by15mr8609968ejc.91.1623986316521;
 Thu, 17 Jun 2021 20:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <ee75bde9a17f418984186caa70abd33b@huawei.com> <20210616132227.999256-1-roberto.sassu@huawei.com>
 <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com> <9cb676de40714d0288f85292c1f1a430@huawei.com>
 <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
In-Reply-To: <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jun 2021 23:18:25 -0400
Message-ID: <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:

...

> > An alternative would be to do the EVM verification twice if the
> > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > new function that behaves like vfs_getxattr()).
>
> Unfortunately, I don't see an alternative.

... and while unfortunate, the impact should be non-existant if you
are using the right tools to label files or ensuring that you are
formatting labels properly if doing it by hand.

Handling a corner case is good, but I wouldn't add a lot of code
complexity trying to optimize it.

-- 
paul moore
www.paul-moore.com
