Return-Path: <SRS0=4esc=C2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ADCC43463
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7920725
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThYfWELp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIQUUa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgIQUUW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 16:20:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A1C06174A
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 13:20:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 185so3961379oie.11
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSZI/qd1suD6OBQieVC7FfqZYY980rHCl+kFAVjr2LU=;
        b=ThYfWELp19IdwH1tijLLpGEGeUQLBPvtijJNkFJjgrEol7fWsTaVn/BCQrVJKdQB/A
         n9Y/d+N2TcsAq0a5IK987XAJao+d5RKTcnxaeCtHM83w50Pw4b1mY/hXpYHIkLv8lgnH
         2ni8IdNd8H09vmHSYJ6DoDwQ92UDOG3asaPPpeMq0JWsqYjLgcJw9WUW6MzGM0wnUzQy
         TZykqCT5a35lfV51fhJFrbWsLvyYQw8aiPqtJ94m5Xf6HZ0QKMdF6PcUTnDOIKv3aPvN
         n8kVUlyUkig6/5xCh/9KASlQ+HsfltX924htdcVJoQHaFn9NQl92eDyP63h0Lwx3SFq8
         ceTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSZI/qd1suD6OBQieVC7FfqZYY980rHCl+kFAVjr2LU=;
        b=BfG1tt7ZX+BAuJgyU3d3QdRj3LAKJqvCy4IpwlSDikAgk/D6gEyjk0yaMMAQyW8D7l
         Y4+T1an2IVDZFMo0SL+SloRLkSZS6ULny2Xn+sHm90g3VYtAYOuEqEOHMfDg69btd5oS
         6hjMR5dsRWUvq2cL7K0BOKa+DnI/f2vOKNMEpHlxZoExQ6HirIjK/tUJ3Y61l6AwHaFd
         MCQPrKH2jCjkOYR0Icng6Ul6baQv62QroAW34/Z2/aj3QdH3DUJrCmQFV8xw+P8qFl1T
         EEiV1Z7r9IIKjrotrhTxCwM63od68wR7ZhiVcXqaQ6SX/yF3zAXYR8M1G+DITJHan8em
         tnSA==
X-Gm-Message-State: AOAM531RokvXCZ9rArMXPm452i5tJ57Vz/2gEOU3fLvVmor2DMmnpJIh
        qR1iFXKFLb/Xylmc2p+yrfJS3TorunVENY7hhws=
X-Google-Smtp-Source: ABdhPJwSMDUPhg9br6NE2i1Hnw5hsVfbSEcXG1gGh3l63LNXDBo+pBQsK6NSvvaNDqRfliN7p4PHul3ANDeg5NfohLo=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr7101877oih.92.1600374021349;
 Thu, 17 Sep 2020 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
 <20200915173332.574700-2-chpebeni@linux.microsoft.com> <CAEjxPJ6Nobke7D+9p5vTg+t0BzW8eUXMxqLNDcS-zzSCAXCkcg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Nobke7D+9p5vTg+t0BzW8eUXMxqLNDcS-zzSCAXCkcg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 17 Sep 2020 16:20:10 -0400
Message-ID: <CAEjxPJ5NfYLcKWz2G=N7z+YR_LJKcvbq9FB+qoWnEXBjJ-niyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: Change userspace AVC setenforce and
 policy load messages to audit format.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 4:43 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 1:37 PM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Both applied.
