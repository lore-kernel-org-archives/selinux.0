Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56772C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 02:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D7420732
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 02:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rkZem/xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHUCWt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgHUCWo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 22:22:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F2DC061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 19:22:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so547794ejs.8
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 19:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1QCc14GPT5F3fBeMa9aJ6/+QjqukYcGYpP98XcieAM=;
        b=rkZem/xP//Yw5RcfZCb8d0EXj6/DVgghiIYX4ouKUYXL4ERL6uT3z9/PYcwXrBpuLc
         eWLEEvEkCH2oNtkT+d6wgthUF8PW9ENjWXnmCj01NAX5IdAF6ZBYl4JEMcjb0dXAHve8
         +E4+9H1EXNQLcmcuqoHYIUvx+Z1pxM8IM7Ugrw7HMSd3fjEhW6UWVQzb0a3ye4G/QoBR
         ncjW0WD4h1qyLnCNayIlH6/adY3RT1mR9iGVUiFyPjsx/TZSavmNgZol65w8ZJxjcK8y
         fd7t3uiZBtGH0ySTH6qg5DBbQqCxHTpBJ/x5WUsf3tdcBh+u7NUGh+RQLkIoemQotdyX
         Yvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1QCc14GPT5F3fBeMa9aJ6/+QjqukYcGYpP98XcieAM=;
        b=J1hamV6lZtAcT1i50fOsOwQMRFK6f3NCcfApAlSLxcONlSI3fcTqawOhvaxrT2s64M
         EDH0aHFF50Pq9FI6FDjj3L+uZeXoBxQR8y6w2/yUNYXBoEQ0SPf76ZJsAxrwlCHNauUT
         GpY6TBkzmpJPpBM5Ywqe5oz8/Ce36gVkDnmYJlHFoxEcEXcl3p/dOI4x9l4DYEQp2/xS
         45iGliy5LiaGfCdahPFtORN3erOl7YWIObtWTeQFp4e28TAyxVUTtGXlbKDwlqgHE57O
         fEcw61klo7zR+1Ck6jt1j17yxRyn0bXGTE7B9vaDDwXx4a4NSAZ3nwx5Vex7g64RujOE
         thHQ==
X-Gm-Message-State: AOAM5315amiEhW0D28bES3KpvjLB4gpp0vLkiVKLDPs6rP2iH9ZUZ0Ta
        Hy/nMRET7vhCI4p5iV+Uubn3JMiXEYtyVXYm+Hml
X-Google-Smtp-Source: ABdhPJxDoNqUGswwKhuSmyyuHeuGX8npxTUSizhNwYUXP9URQ7CAZQPQ5Go9M0OJ/H6WfRFApNa0sCSv9uFlANluKwY=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr623897eje.431.1597976562364;
 Thu, 20 Aug 2020 19:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com> <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
 <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Aug 2020 22:22:30 -0400
Message-ID: <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 8:14 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 18, 2020 at 4:11 AM peter enderborg <peter.enderborg@sony.com> wrote:

...

> > Is there any other things we need to fix? A part 1&2 now OK?
>
> They looked ok to me, but Paul should review them.

Patches 1 and 2 look fine to me with the small nits that Stephen
pointed out corrected.  I'm glad to see the information in string form
now, I think that will be a big help for people making use of this.

Unfortunately, I'm a little concerned about patch 3 for the reason
Stephen already mentioned.  While changes to the class mapping are
infrequent, they do happen, and I'm not very excited about adding it
to the userspace kAPI via a header.  Considering that the tracing
tools are going to be running on the same system that is being
inspected, perhaps the tracing tools could inspect
/sys/fs/selinux/class at runtime to query the permission mappings?
Stephen, is there a libselinux API which does this already?

-- 
paul moore
www.paul-moore.com
