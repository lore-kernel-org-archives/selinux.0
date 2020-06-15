Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C41C433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DFA20644
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zMoNMLK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFOXJt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXJs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 19:09:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C6C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 16:09:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so7541665edi.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x62STNua+0qzu46pHsMSBpai4VSTM7DmyXfK08X00OM=;
        b=zMoNMLK3dOZ6dq5nKAM7ln+hnHWzd/d7P+drb77lmpSfytmPDLt4be8BMwBDvW+uRL
         Gt0OYuuLSqJ3ZDgYyLOnsPQMAPSgiQ75TGZzhZYLoI/dyLtKhO5/NdGAcGPxVfPqDl3Y
         EfaGUo/zqEymAMoT9hyd5/gSPARfZXCmM9fX0Gn6QpkwmatMM2WswUuVqlGZOGvAnLCw
         XdFMo9ftouNXLae35jMXuJjwHQeMfCklygQE+ejownIbOYaDWSC9cC9E3NPWkCbsFeaP
         6HmGYdoLzbQqK/Gk22/buXj3qur405sE/tybWPvlILZgx4Tct7Zm7Kq/RREdHECbKpMz
         foUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x62STNua+0qzu46pHsMSBpai4VSTM7DmyXfK08X00OM=;
        b=gE6bRI+Ql1IW3w0e7EZOevA0vWvVB/WDJSejTc6V6Mr040sutVr5J7Tky66uAqtcuv
         BRdaJ3eQosX0mJoBdJbIqglFhiEhc41U4BmGpm4KSFoVQKrkUSiKENOOBGwTaiwLZ2Jh
         RLKqdWU/VNyhlIo2GWXDe1DTjuWRTUlj12rlGHnUatZo3LHfP5Gxlt1MurFd8+3Co76X
         NnJ7tg7fi9eJHIjLbl3yyDmE5FPthI5HxNpNMWgdfWrWSQDIcqTcmEAb3G6GKRtb2GsS
         KR0eaI7Zmnzh+1Ck+N5D0om2r876/HzsGLOV+LEHoUTXKP/w1ODA7qQvEhyDBLbMhme+
         oTgA==
X-Gm-Message-State: AOAM532qF3gAG1fjubwNOn9L/NG4zWb2wsHV2xlBsSYlTki6WigecVNR
        jkn+ZQncpoqGA+J40XiKlvWHdQcqDt2Gh3JDYmmv
X-Google-Smtp-Source: ABdhPJx5e6aqwWmCjrgYtHGsiOAloy0DEtFOROy8EPhTxIKq9yRvaSJhsRwcRvSIIHafgwAg6zSPdZDWl73W0PXPF2E=
X-Received: by 2002:a50:fb92:: with SMTP id e18mr84734edq.135.1592262587203;
 Mon, 15 Jun 2020 16:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com> <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
 <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
 <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com> <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
In-Reply-To: <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jun 2020 19:09:36 -0400
Message-ID: <CAHC9VhQyLKUqJBzHY8pR7gLdx5AuELv_XWmHGcKw5_OJo7x_bQ@mail.gmail.com>
Subject: Re: Better management of dynamic networks?
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 14, 2020 at 5:30 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 12.6.2020 12.21, Topi Miettinen wrote:
> > Perhaps instead this would work (I haven't tested it yet): don't use
> > netifs or nodes for anything (label everything with generic types
> > netif_t and node_t, which is actually the reference policy) but instead
> > use netlabel tools to label peers according to interfaces and IP
> > subnets.
> The problem here is that flow outwards is not restricted by peer rules.
> The rules below don't prevent ping_t from sending packets to the local
> network, only from receiving the responses:
>
> type localnet_peer_t;
> allow ping_t localnet_peer_t:peer recv;
>
> The peer was labeled like this:
> # netlabelctl unlbl add interface:wlan0 address:10.0.0.0/8
> label:system_u:object_r:localnet_peer_t:s0
>
> To stop sending, also nodes and/or netifs need to be used, for example:
>
> type external_if_t, netif_type;
> type localnet_node_t, node_type;
>
> allow ping_t external_if_t:netif egress;
> allow ping_t localnet_node_t:node sendto;
>
> # semanage interface -a -t external_if_t -r s0 wlan0
> # semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0

If you are using secmark, you also have the following access control check:

 allow ping_t secmark_t:packet send;

... for locally generated traffic.  The combination of the peer label
and the secmark label is particularly powerful.

> It would be most flexible if peers could be used to restrict outward
> flow too (since semanage interface & node are slow and require writable
> policy). Would this be possible?

Not in a general sense since you don't reliably know the destination's
peer label.  If it is a stream based connection you could make a solid
guess, but that might not always be correct if the remote peer is
running with multiple labels/levels.

-- 
paul moore
www.paul-moore.com
