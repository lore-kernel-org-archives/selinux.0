Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D2C433E1
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16CD20729
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="z6tSCGHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGUVEe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUVEe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 17:04:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D87C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:04:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so23025685ejq.6
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0EEaAjeDcfPDcoUtQsAm37o+NI0vbCn2n9ChV6gQ1g=;
        b=z6tSCGHl1d3ial87IeVAPd1sHcL/gFJcoYapvECtaa1s+aa+e2L6GwhPmJFLAHWVpM
         1Dxqn1+AXfjAYlnvOgqYP0E1Dk2EmessoJC1tB2kRpBDDOt2nIMcfD//FKt6q6T0w9J9
         /TO7hN5pmvuz3SqBltgOH4OG636NRLngMNub/zG7AFpUGRVNACybWLpiX8BdmLb13XYu
         mbzSuZU9CsbM3vjoOHiVm5bhNKBalY/rz1Fw/sJqDNZv9mViP09vEsFLQRo9Onobep7b
         GwfWZ95GkXrTaBF868qOxjqqniakHI5Ubn6dwfY2bh6/nMPJivAttEa7nc6zeQ1x22Dc
         f5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0EEaAjeDcfPDcoUtQsAm37o+NI0vbCn2n9ChV6gQ1g=;
        b=L/eMx6yKaQzfm5ZEFl10TuwIQPeKDC+gDxY4MRmPS2+VsqOUj27yj/WkWUdzB2gR4L
         LcuDPjjxuVhPPEhPX/ic4tdpO2occ4t9qHd8olgoq4LWxMsB7GH3WxuQETRthAtwaR01
         VApaHAYafWMCWAcExPfeG84WllHwSJaOyHNmUiFsAdMTnBuxUFqURUBKzwLSq9a9NLj/
         QOMY9YyqeO57Zt5shwoPQzPnZyYtF2AFENMEovIMUdFq+/ba1EL5WIdf1lKu/p296VO/
         szSGNfXfkZe1N7VBGd2MwfKb56qLBbtDsGbusJRrLxffYc6RjTT6HgLTh8jRcHZG5Y6l
         SxEQ==
X-Gm-Message-State: AOAM530gI4oEmQeeE4QnKQcNtvmx6TxVFdH8f7nZt5YhUjnVIyBBUEBL
        z+pDNI+yjfvFwD2IOMgBNIvqDkwNkBfssdYJsxt9
X-Google-Smtp-Source: ABdhPJwP6B8Qk3gKkuNK4Abp9tVbVo5xWHXSdcg868V+DLJFYVEQVTrvepgf2PWfugErBHuQPanD1jMqmj5Dfa/rMGA=
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr26099513ejb.488.1595365472198;
 Tue, 21 Jul 2020 14:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200720074515.1687720-1-dominick.grift@defensec.nl> <CAEjxPJ724s91rh1ji114npX3GZ7HH9jvipNUB46fQgp-XO+FqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ724s91rh1ji114npX3GZ7HH9jvipNUB46fQgp-XO+FqQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jul 2020 17:04:21 -0400
Message-ID: <CAHC9VhTvj0qAY85yZZ5ZKc9vLhpCdzPgs7yzZHqxR=ex8x_Wxg@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] object_classes_permissions: describe bpf
 and perfmon capabilities
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 2:00 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Jul 20, 2020 at 3:47 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > These capabilities were introduced with Linux 5.8
> > The ipc security class is deprecated (kind of at least)
>
> Trying to remember the final resolution on the ipc class.  I think I
> looked at it as part of
> https://github.com/SELinuxProject/selinux/issues/57 but couldn't
> cleanly remove it altogether.  We are no longer assigning SECCLASS_IPC
> to anything but we are using the IPC__UNIX_READ/WRITE permissions in
> selinux_ipc_permission().
>
> > Fix a typo in net_broadcast
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged into main, thanks!

-- 
paul moore
www.paul-moore.com
