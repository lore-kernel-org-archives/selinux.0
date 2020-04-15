Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F8C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3BB20787
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 21:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/f3HENc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371355AbgDOVKr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S371352AbgDOVKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 17:10:46 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB1C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 14:10:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t4so3445570ilp.1
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=G7LmK8HTcBKBYMgt498+onyv+e59DdVDxhKkmN7dLMg=;
        b=s/f3HENcT6G72Y6S3hw1cCLwlUEwjiUHiJeHhzxWLHUBmy/e0wDhmyUzh4Gl4E/Zxj
         3gupfOadZ0duGSHXHMIaSWOLggPzRDMW7Uxja/WDA3MG5RFirBBmZiAyIQUFIVYzANWP
         00f7tYxhxGQYeK1Ao13EK0kgPBFEAOCQ9wyIHpr6auzlFWAcemvzcwfNo6xff6x/fHvc
         OWEx879mQsiAWK40FGTfTZrmKuBLc4gW+IOjYjcOJr+vcMbepBM7b55knM7GdgchbIFo
         Nhi4ewT7n9zgDRnrkdnNF7AOJRlgjou/udfng4JoCnFHmKU0daf9fG842vKEb0/6c4J4
         YUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G7LmK8HTcBKBYMgt498+onyv+e59DdVDxhKkmN7dLMg=;
        b=bejVVhi8aunwPENJBRtEJ81CjyYeGqsMY5b9ppx9CHUR8Iotz31nqAUvVYkPewjv6S
         I4spBmahYIDEiAX60xfphB7RUwoFcIVuSeM4UzxTYMQgs2JLdKR3+GGpUTpqCBGc7qGm
         NaGLAr/4Ds15Vh0cBF4Y5cTzMBTobzXPehEHfk7eg8jTvGNgRfZIlb/UYDevIg58s/gh
         tQ2eleNGzhaRFKguGXoOHM9ojQdRjs1x/daXKXscKVLEl0xSk9ISPYIfvIoPIFD+W2bo
         YNiM3O7jJMNChnurYbUZBsceU0poZCFHrjmAWToT+cNV0SmV1+QykjdEinbMAzgoIiNV
         MzIg==
X-Gm-Message-State: AGi0PuZPZYjB6LDbVnhMFjEosU352yyonD3QhUP39ladVZLKY3CXYD35
        7ZfRC/R0IvxGlArqFx9xQXekpxJYYGqKRRh/kmWGeYtw/mw=
X-Google-Smtp-Source: APiQypLz2s1HapyHSJSuOGETtFQCtBWy4kf9L+UtncGUVDKXi79Csz6u5mOVQ93xEHQpc5vGiNbn4gQ4nMXi4Z2bu3Y=
X-Received: by 2002:a92:9f5a:: with SMTP id u87mr7629103ili.174.1586985043671;
 Wed, 15 Apr 2020 14:10:43 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 Apr 2020 16:10:31 -0500
Message-ID: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
Subject: Deprecated Annotations in libselinux
To:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

So I am reviving the work to look at annotating deprecated functions.
I was wondering what folks are thinking around the utility program
matchpathcon, since that interface is deprecated, do we want to:

1. link that statically so we can use internal (non-deprecated) functions
2. update it to use selabel_open and friends.
3. Keep it but have it print out "deprecated" and return 1.
4. Some mix of options 3 and 1
