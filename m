Return-Path: <SRS0=wSC+=X2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE34ECE58A
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EC020815
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 13:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AdazWGWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJANgv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:36:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41166 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfJANgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Oct 2019 09:36:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so9880338lfn.8
        for <selinux@vger.kernel.org>; Tue, 01 Oct 2019 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBHO7zBu/6JjDHFy+rHD3rg8Vl+Sb1j1Pek5jxU6ZD4=;
        b=AdazWGWUFIyD1sBv4VN3jWkjxF8KZsfmGLNEB+AOCQrwf9H5TKah7C32mjVx0HggPM
         UvS0IiPmZ0QSqRAAyzyefIJpdePRtf6t67jd015f2xyeXDM2oj2GQKG5V+7xMRyipYTO
         +KdP5LS9A0EopIg7+32qBeCvhE+/PjTMOJjrzFVUr22kvW21ZWxKlxkpFY0UgXQErZRm
         BIPPvzdZu7sTFlv/71tFIVriM7zAme+57LSP9fDv9fuxzUX3SSg5MrP+6W+uHK5XIY0E
         X1Qzw78D1nBUfSBhkynn9nbbKL7EP4LPf5H6TxJHevmxBKxnDsO58CtUWljPNrg3g0PU
         uABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBHO7zBu/6JjDHFy+rHD3rg8Vl+Sb1j1Pek5jxU6ZD4=;
        b=NZjmKMm4EjTCjPg3Uf5yyL+zMnfDSIdyyLCIxAN2ipBIy6CWHYr6jiDhBbj0T3qwPi
         C9rkJ6SfU1SEt4cucWraYPGlIA2N2lfN2lGctVJ9Y4a/mgKLCBprrR7kHva/75q03/j2
         kMpmY/aAfdMP7LH/SJggGmAv19RHZLaFdyBPQMsZ+mdgAi0FRavNM7xasDBoTlF9x1Js
         b7AwgTfLPDCPF5V9zLxoaFsc0HeSv67s4reRctLBwdSoz9NhdVgtoPdDZ0NhrlpSfWEz
         XcMuxOk6VzQSGaqJoAFb5X5TZdYvho49r1YpRctNOBbn9CkgFkZGQ0hlS49LZ+OIPXn9
         i84g==
X-Gm-Message-State: APjAAAVO7vk5tNs1aDA6ZRdudlaaP/Qp845SCgIvpPJXDyRAzp5ldRqN
        XbLygR3cARF4zvhRT83aWjk/7fdSDHQj/JWVjjlKG60=
X-Google-Smtp-Source: APXvYqyn3WvKwkQ8R2SsJsa1lUJ37RrWTw8cnwUVmRKmiAS+K1joAjAV0/Phh08yXh4Y90F0uYGWDelT/md22wBnlMQ=
X-Received: by 2002:a19:6517:: with SMTP id z23mr8803595lfb.31.1569937007561;
 Tue, 01 Oct 2019 06:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <1569031035-12354-1-git-send-email-zhang.lin16@zte.com.cn>
In-Reply-To: <1569031035-12354-1-git-send-email-zhang.lin16@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Oct 2019 09:36:36 -0400
Message-ID: <CAHC9VhQsupyDDYSNm3VvyqnfZ8-cQGcjqNfBTK=_dJzo-8qBRA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove load size limit
To:     zhanglin <zhang.lin16@zte.com.cn>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 20, 2019 at 9:55 PM zhanglin <zhang.lin16@zte.com.cn> wrote:
> Load size was limited to 64MB, this was legacy limitation due to vmalloc()
> which was removed a while ago.
>
> Limiting load size to 64MB is both pointless and affects real world use
> cases.
>
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> ---
>  security/selinux/selinuxfs.c | 4 ----
>  1 file changed, 4 deletions(-)

I just merged this into selinux/next (thank you!), but I removed the
last sentence in the description that mentioned "real world use cases"
since that appears to be a cut-n-paste artifact and not a reflection
of what we are currently seeing from users.

-- 
paul moore
www.paul-moore.com
