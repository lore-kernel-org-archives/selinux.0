Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11313C433E1
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADE420775
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p/zZEbRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgG1Ctx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgG1Ctx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 22:49:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C4C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:49:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n2so13634152edr.5
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEYtt5clN8w/iCk+1eugu5sEylcu4UNKf/F//oSiEEY=;
        b=p/zZEbRyYm/bz55EO3KpkFqvzO4sLLx29iw8lHT7fW0Y/pPvuj549YSV43zpMtmwW8
         eSDfib3QN38/XwzvZlu+XF50X8Xm/5ckLtNy1w0T3rCk+iWFkrVzAfoRgVWUg6jKj5wi
         RvCMU70NNgQIQC/ZXYh3JuhxbEZuO66XJh8VuOf145rj4M45QsGMEJBVIeDgrNK5/9u8
         /SDNlNGKVPSBTpxcagpbejsiqTXFBk00KXhHq2WbNyuA3yBSeB0W3YX9Mv7SZNLmttxS
         Oq9LtnAifFgiZ9Sp+csGNwomk2OyVDnGrP3W2thXDyf1z5uWZLyb+E2iF2/VOaJDo6CY
         ZSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEYtt5clN8w/iCk+1eugu5sEylcu4UNKf/F//oSiEEY=;
        b=PZGJufuUwjmZaiTRW0j5c8auYmE/wFhW2O3AoahhKsbhpjC2ZHV96maFvQAZMlkTTZ
         hRoGb06cJberT1Rhu876q1LGPB0TcHlsanMVo9BhKbKeiyCiklj1K5UarPJMawtwOyx4
         alyoqqwVB8K8fdVSgMWM43IK/konpznEWrPBVK1ctVhVChC7TizQIG/7152nqBrVrn2f
         zXboWbAMdafqWWCh6Fczhtn9yC8VM8tg0mNLcbsmHZ4iWlcbfCs7C1j8Z3Bs0tF7OEUM
         3UTLJvDl1FYqdi3uwf5EF3wyNAmTjk0eGBruuEXPmwqcgTSCCHW5FuTK6pGKMD13ifEp
         sVmA==
X-Gm-Message-State: AOAM5323foCEA/Ci5oq3Slfexj/Gj2dLKQ7FneXL/2JUVv9+9x8Cwb6J
        IJDqOXzHaKS3xNGzRk25BA+24EBtDRogecG7ZKJ4SLaxPQ==
X-Google-Smtp-Source: ABdhPJx9a02K99MkNx2b+8bkHvFPQMJj+tGBFh94XTj0sf14Q0cuolGNSlas4drMg//EZ6WRxxEPkB1kGDoLbKaVDdM=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr23176957edy.135.1595904591178;
 Mon, 27 Jul 2020 19:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com> <ypjlwo2pm56q.fsf@defensec.nl>
In-Reply-To: <ypjlwo2pm56q.fsf@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 22:49:40 -0400
Message-ID: <CAHC9VhR6iM0XGAGFSpnNh1ZQtkXf70zQT7Zpv1V8C_hMh9VhKA@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 9:57 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Probably nothing but I did not understand this: Is reception not
> controlled with the netif ingress permission?

Yes, the netif/ingress and node/recvfrom permissions are checked when
packets are received; in both cases the subject is the peer labels
(think the security context of the remote network peer) and the
objects are the network interface's label or network node's label,
respectively.

This is pretty old, almost twelve years old, but it should still be accurate:
* https://www.paul-moore.com/blog/d/2008/12/network_ingress_egress_controls.html

-- 
paul moore
www.paul-moore.com
