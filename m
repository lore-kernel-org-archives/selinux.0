Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A2C2BD09
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 01:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B3320637
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 01:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tMaGBYL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLJBy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:54:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38575 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfLJBy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 20:54:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so17917351ljh.5
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2019 17:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMts+4WHcQ4laHTC8hCiH3zoFk7aR1AwTTcgnU0EBTM=;
        b=tMaGBYL7D2XckNo5Sw2Qn4+NKec842/0OKXP75ty1KXMZT47Fe4vuYQVP2KIWnijUZ
         lv0Mg5mkMwUpPgUw33BIjvXLrDyC5B2w7XVcjgnR4krwuLyeuRQYBjK2evZXcCVmadrj
         F7V1u8fdAOCo6EnSp7A6tQrvnqlRQINe4msXNsrFORMRu1Iktvc7fnQxTB1WCyZDyn9K
         Z1z8YMCmoAYrGOryCvAyMlhpzVjjmcmmfvUXIrW+vVQAqUhfVS/iICv0CyDqQzMdBn+q
         1iQLb6dwIb8AZLKH6x8SPtxZqpx4GQWPK+n+GOkUyMVUfKexGUwyKphoVyztWSgnKmox
         Unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMts+4WHcQ4laHTC8hCiH3zoFk7aR1AwTTcgnU0EBTM=;
        b=Uqa57xXX3UE1oa1EBBRluhn2OdtjxG/giYV0j8EhdLfwQUrI8J2REsKVxMEB1ZfYgQ
         QcSoxC23nMRV1dkABsO0aDsxV3S+H4Ct2Omy7DxjDJxuKU4sov3tQPc0p6/Yj+SPALsV
         l3+uJVbSqGnVccwrgqArvivMc/rHFe8VvW6//53GAyQbyGF3B1hMGTprhhzk2xh8UhSn
         R4rewcTFgx7gupplFdDCj4zzhrqr3bs5o2bTxYCiyTAG53d+0r4O9OUKLEoZrn/dqdrl
         e+UNAsQDBdBTZkXgS7rkJSM+yuvht/9oxGinTDANMX7C/iAzbaEK+cVBtoCg1+AP3Ui1
         sAAA==
X-Gm-Message-State: APjAAAXP0hqhLwC56VoFGrUwtwnggEVhvL1eCE80ctUYw8EfnGIBpfQk
        hwAAnm7BhFxe7qTrAGYKLuNq/lIu7/molWwRfLDt2yA=
X-Google-Smtp-Source: APXvYqz5T6SnVg33gbGJPzTJWFXAAYyO/JYRU8uSRbTxt9I04s36juz+31ciqq6KO8UcIysSGCYxpuSLUTp901nGfsc=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr18983022lja.117.1575942894207;
 Mon, 09 Dec 2019 17:54:54 -0800 (PST)
MIME-Version: 1.0
References: <157594281322.676903.11041338053333686450.stgit@chester>
In-Reply-To: <157594281322.676903.11041338053333686450.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 20:54:43 -0500
Message-ID: <CAHC9VhSoY3amLrsuzSOcu3NogehOhVj9KoiuxiN-vGtCVtLR2g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: ensure we cleanup the internal AVC counters
 on error in avc_insert()
To:     selinux@vger.kernel.org
Cc:     rsiddoji@codeaurora.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 9, 2019 at 8:53 PM Paul Moore <paul@paul-moore.com> wrote:
> In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value.  This patch corrects this problem and does some cleanup
> in avc_insert() while we are there.
>
> Reported-by: rsiddoji@codeaurora.org
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/avc.c |   51 +++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)

FYI, only compiled tested, thus the RFC.

-- 
paul moore
www.paul-moore.com
