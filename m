Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3494C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E98C20870
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FbN/cMXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E98C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeLMOd7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:33:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38014 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeLMOd6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 09:33:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so1969132lja.5
        for <selinux@vger.kernel.org>; Thu, 13 Dec 2018 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZCHkwRLtExK6wBXbZI5RNgcT/wIMz6oxPCmmQaonlA=;
        b=FbN/cMXASrOOCgTCUwBQ5pMzYO7U4tW/Llq8af3Oh/sQu/0Ux3I3YjQqwicNYABO2F
         tXcEM0iNQHH456OT6O0ZjTSNb6mSJWjBfyTNEiDEshGTQDJ7KOHIIgx5su/QeICYb+7U
         qwPFUQe3HXi/tlvXwCHYS6LF1FEMcHYKh07UveuNiEM+IHNIorjLjWF89/nDj7NPNiEE
         p4Fwd+8g/8RY/vWHVhx6ZnvgX2wqktDvnlIFujr0Pzk5PSseFUXAaGWCN0lzH5pzAHul
         8gvhUHXFqEm0bEaDhTx0bdaC41DjsIU/zY9dIWJ8sfHPYw3BPlzItsRaj+jDe4fFmMSj
         yXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZCHkwRLtExK6wBXbZI5RNgcT/wIMz6oxPCmmQaonlA=;
        b=nNlkRZnDzMOVvPSsKWSIRCTowAMQXLyipGYOEygL9whke58JM1tL4q2imrnIZ7mrPI
         pXPBsgOJA8293cwmbMIr42Z8BQXySesc4dme9f/mBwQp2N7UNpwILZu8x0lonFaJ2IiC
         zn6Ifc/EoTKZCuFMR6AFvCWb4ZIy4hFLU9tAoAw4HBHzVLMzj0ZRpVyVUH830bKBjR6Z
         29pFWaJUfVj4Rnd2nJKzJbr7Jc9NH29TuoZ9imKAi7FOUr/m3KfKyJomfhk6Jbbhyen7
         dzXMvPQxE2gbwrb8jcLs9d5uXwKEV7Wk+Q9w+pMlhmLfGJDH1ZQo+eBJuutU5TvB5mfN
         UXZA==
X-Gm-Message-State: AA+aEWaNHv5502sCj5ZwuWvQquV1k68HdRtvJifkJ9516pzVruk9Z4Yc
        zvaX0PqQIsQTBNgtOeAe8+0juRpSfFotgZ2A1rOj
X-Google-Smtp-Source: AFSGD/V5et7adVG5mw0btZDp4Tdedqwb8qUEhXTdkX5IWaRd1+NpS7wFatepQVoBF1tFvVv1msRi5p0JmCQIGk1GRng=
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr16319776ljj.18.1544711636537;
 Thu, 13 Dec 2018 06:33:56 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812130915190.5053@namei.org> <CAHC9VhTGF3SxRh0iTMhqFYExh3HrKVn7Wnko-_hb+y+6BmCRaQ@mail.gmail.com>
 <alpine.LRH.2.21.1812131036590.7600@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812131036590.7600@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Dec 2018 09:33:45 -0500
Message-ID: <CAHC9VhS=+8_AOf2AXuD4KYOPNV-KfTqqNHYNDxdvqHaqwLuNzw@mail.gmail.com>
Subject: Re: SELinux testsuite failure in overlayfs with v4.20-rc kernels
To:     James Morris <jmorris@namei.org>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, mszeredi@redhat.com,
        bfields@fieldses.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 12, 2018 at 6:37 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 12 Dec 2018, Paul Moore wrote:
>
> > I would much prefer if Miklos sent the revert, but if he doesn't send
> > the revert by the end of the week, I'm going to send one next week.
>
> The revert was posted today.

Good news, thanks for the heads-up.  I don't watch all the mailing
lists, I've just been watching Linus' tree.  I don't see it there this
morning, but if it was posted yesterday I imagine it will be merged in
for -rc7.

-- 
paul moore
www.paul-moore.com
