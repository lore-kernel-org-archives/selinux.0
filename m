Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D396C2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675DE20672
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 19:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="msldQU5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFTzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:55:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44651 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTzu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 15:55:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id i16so1014473edy.11
        for <selinux@vger.kernel.org>; Mon, 06 Apr 2020 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSb7AH5GYzuTI/Za4Xql7OFjV0h6EpWLvwAAOHWgMyI=;
        b=msldQU5FUpYo6oxBcgWNZQBrQa4xdusuyoHe2jugWJuKQfY9iGzDKn6tIQWuxIiTKv
         C5Rxm87wpWha1IrsDEKJTbeuGT8doE5RlC0laQ3OjScW7IZC/Y0slNi6jEJD3NidzQY+
         xqYbUsx3sQTcdqSqGX4lFztBktKtUzuS90rIVcdnKeqM6VjGe2SRtANTEubiz4U0kBGc
         6JQ6tcLOwI3bO99HAwloyF51auDU9hyU/YB0MPWCWFJEFlLsRJtMUd/9BuNV0Ia9fn6g
         wy0HUp2beN5ZJDIZUqGthrIsCmzQ+MW09V9sZvlg+dc8hudBwWBiUvSmMKYhFjQhDDPD
         ZVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSb7AH5GYzuTI/Za4Xql7OFjV0h6EpWLvwAAOHWgMyI=;
        b=oimUNDYoSapjPF6BSBaa5gFAVFDmJMcHfXs2gAYJ7cMoiQ5ZsuM5DcUbyqMWk2oZ1M
         Nw+GzdfF5Ki+WD8NpoWuHROE51uKpZt0mnds0+t+Q3GOxDDxmpSfngK2We8Y8V7AynLp
         BGyU/2xFITd424mmjt18M4H5EwIE+N8N8J6LMBMSxy/CYf9uwJ7sfhmnCa9gzeWsWv7S
         CEbnLJ66ttu3gYHwaRt90OvEXVAR1fn2fcNQpe1KTH41t6a3ciQ7w1YlP+fjgaaVHmCZ
         iHlZP/sJb+YlhazS+XHnovgeKa2ekOxBADw+Ue8URja4n4PU6l9OavqoKn31chk5lwjz
         N+jQ==
X-Gm-Message-State: AGi0Pub7nakkYJ9PQNon+F4s/1vOzj+ItqFjLef6sC+kcDPUDdByUolo
        PI0SeKxQNFN+XbN2hXGLiHnsrVUMHSlSs7q9rouS
X-Google-Smtp-Source: APiQypKz+yONNLcA+hAv9wA/zsbTZHCrgRNqLRuv6mwlLEbGqWGrCk94Js0p+WHr73s1StUiOWv1VyVXXIMOoIwy6hI=
X-Received: by 2002:a17:906:b2c7:: with SMTP id cf7mr1098786ejb.271.1586202947128;
 Mon, 06 Apr 2020 12:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200406163556.997001-1-omosnace@redhat.com> <CAFqZXNtV93fZ88iC4tddLai-vxteZvB-whAogjd6Ak7xBpZ-eQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtV93fZ88iC4tddLai-vxteZvB-whAogjd6Ak7xBpZ-eQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Apr 2020 15:55:37 -0400
Message-ID: <CAHC9VhQcGuySwk514CidUT6w_++pKHOTv+GzsjwY8nN96ns7ag@mail.gmail.com>
Subject: Re: [PATCH] selinux: store role transitions in a hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 6, 2020 at 3:42 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Apr 6, 2020 at 6:35 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Currently, they are stored in a linked list, which adds significant
> > overhead to security_transition_sid(). On Fedora, with 428 role
> > transitions in policy, converting this list to a hash table cuts down
> > its run time by about 50%. This was measured by running 'stress-ng -t 30
> > --metrics-brief --msg 0' under perf with and without this patch.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
> >  security/selinux/ss/policydb.h |   8 +-
> >  security/selinux/ss/services.c |  21 +++--
> >  3 files changed, 107 insertions(+), 60 deletions(-)

...

> I just spotted a copy-paste bug here - the type should come from
> tcontext, not scontext... Will send a fixed version tomorrow.

No rush, while we can obviously review it at any point in time, the
earliest it could be merged would be next week (assuming the merge
window closes this Sunday).

-- 
paul moore
www.paul-moore.com
