Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A614C2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85CD2075E
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iP/ULyy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgDMNaa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMNa3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 09:30:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8CC0A3BE2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i27so6133799ota.7
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=iP/ULyy8lWG1nhEGn0gppspS4F2JhILJ4nTAtiYGhdrZL51cxqVWhs6D3Y9wyc2ADf
         A2rwUCP45WAPoWNbSBZGTGVFxJmmDPHe19L3gxm7+w8E5f22GKJOLIMHoMQQI7v3c5XY
         DlMUV5+ZlbBmFxdLOO2VDbc7W9ESDWYt4QtLLqRZFkEOi9gTP3STkSTcSJo+WdBU2ZMP
         cbKcszDV9RPwFi/D+lHgC6golJOLYJdAkURkw7hbGoqznT8eWbtFkjjpTaIqirsxJh7L
         wdqYlNLP395ub4iQIUl47edMIk3+i+NAk1eC0wEHnaBVffHHOQq3Dv9hRllCWWuEG7fQ
         v+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=HzkYQBI3eRaEP0oC7+RuaAc+15BZ6WZscI3yvNMl4MsA9kd0+It0Mp3hLFBb2H/GJA
         00W1ryB+y6pgkrGmu/KN5ZiyzTeAo206KsSIiZiSWVPL/ev0WSXRE3app/BO3fWrqIYO
         v3BBpupRuRR+OCU5Kn/ZJji8QuJPFkxKUFSLSXs86W5h93EQg52kI5rrHrl60CwJssCI
         F3cG/TP8MFXnWMT3qv9yRwVRaFB0VFF4Bs2zePxKcapMX9NhqJNrBK2LgR5eCM3Pbfou
         K55UJLSOXdvU1+hxQ+7c3awTWbqdjETKF7NLSA70Nx4iwkyRfAPLR7DUoGIMs7m3vz5s
         j8zQ==
X-Gm-Message-State: AGi0PuY6obHzRL8rXoD4V8GgRw59WKLPnmqkzSxvaXF2G6rscYksW9uQ
        ltsThJznnSZytIM/SxcXOZ8yWbn9wiSZ5kK+4hTl0Q==
X-Google-Smtp-Source: APiQypLFU/9OTkw8I8yoSnsZBoCJl2kmbnPrqcYyRtFa4kS0eBylKtgliJY99Emg2IXzWabr7J0d9UY0bd1bcIemaS0=
X-Received: by 2002:a4a:da55:: with SMTP id f21mr14363752oou.34.1586784627519;
 Mon, 13 Apr 2020 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Apr 2020 06:29:50 -0700
Message-ID: <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>
> Changes from the fourth version of the patch:


Is there anything else that needs to be done before merging this patch series?
