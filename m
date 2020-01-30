Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F252FC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5720CC7
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="O8CqhWRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA3TvT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:51:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41217 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgA3TvS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 14:51:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so5141646eds.8
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCcrlq873MRuTkO6WET3JdlsImHIiVmCMq9AUA0Rtxw=;
        b=O8CqhWRoxUw5nMFh3RcMP0kKrSQxppbXev1SA/H1dVm+oNCyMKKxByGqM2bC612dfA
         odoXkBy5HI3/bxkPKx933KrCPq72iWzW9DN+jIFkEw2DkB1WNmwVw46P/0fLm4EEP0MS
         sWfuNeeLjQw6PTDXiaytizlesasCaPro62Z34JVNWKrtBq69WiK4TAD6i0WPjy7Zl+sf
         w80pQJEL2Df7Uj+L+zmymXahVhqgD5rKPUjFnVNKl7qAPbWjg43n9I50iw4ATpPtSq8x
         lExG4gHgto2dAO/LfPOuX6nXBlENt8S3t/2zoPohmed6rWbpHs3W6A9g4Gy/p6edtFPQ
         BJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCcrlq873MRuTkO6WET3JdlsImHIiVmCMq9AUA0Rtxw=;
        b=hZXLu7XNVOXnzmyqBdjgHRwcdDv1brqqxyRHZQvY4WAdkmNDjUKtM/nGD653cqjQdp
         +/yED+3aLSeQzYS6X/DV+1g4CQjIALThpRxuxvXTzwLZzLdAUW/LM2SWawHfrbNpRtjX
         Hb+qo22sAjCDHz6fgocB2SU+YU6pXyftAmoQQQyqxgok6qBYO9vGo8rLaRpj4ra+/T5A
         tQS8/J3vI8swonjDVI7dXMMbfm8CN8QHPR4fIKiINvdveVyz//i0ACDql6np8uIkp21d
         nngDYZm7pjBdc2I6b++w8Nf9iOUvQH9KY6u0SZJDKBTJbcexv1z/svexqL7ZTmYBhciQ
         iNfw==
X-Gm-Message-State: APjAAAU8kZ6EedFT91MROW/3MUQXI0vNZcwn0JsQBvGfPZai6ygBK8a/
        CJ2IOqEmLk5BdxF4cCWq1xZR7LL5xopOI1MpkckW
X-Google-Smtp-Source: APXvYqymxNkFKwZ63CeTOrBvrpQgw/gC/xYnIVDAIxX8b2hwJu6AEmxdXi/iDhGMxW1pH7c7CdR3xeZSCz7I3BUbvSA=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr5358631edw.269.1580413874965;
 Thu, 30 Jan 2020 11:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20200130192735.247499-1-sds@tycho.nsa.gov>
In-Reply-To: <20200130192735.247499-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 14:51:04 -0500
Message-ID: <CAHC9VhRFMsnn_sCOzO54FSUF8q2U=2ef5o_6yU5SS=sr6YN46g@mail.gmail.com>
Subject: Re: [PATCH] testsuite: add further nfs tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 30, 2020 at 2:26 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> In addition to testing full NFS security labeling support,
> make sure that context mounts continue to work independent
> of whether the mount was exported with security_label, and
> add a simple test of the default NFS file labeling.
>
> With the previous changes, this completes addressing
> https://github.com/SELinuxProject/selinux-testsuite/issues/32
>
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Perhaps this belongs under tools/ and not the root of the test suite?

-- 
paul moore
www.paul-moore.com
