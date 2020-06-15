Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31BC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F3720663
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ0IyjSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgFOUdy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUdy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 16:33:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F1C061A0E
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 13:33:54 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id k4so17160778oik.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYdJ+pTZYl5UcolIlpRhXHpmbr2bVLdL8qQHnOj4ALo=;
        b=SQ0IyjSVBbG5cmMjM4AOAf8L1RHkGfZA/fA4XMjv5TBT8QKmolSj/PlUXADZjnaUz1
         RADNDCmOn3hUeRgfRpZki4+d2R2CnyQ1A/dpSvW1ZKpMWQsJ+g2DnFCl63MHj2djG/m9
         +nhKPL5A8qbDJJBXNPBfVst+D4bC4QfTfCKScwmWBb6izfmCeodhnM5c3nugTPyKdu0z
         IWXN7o+kQRg5L+CGA6Rpn5WPVZbJFsnwTvIdHPenYJIOZdNkNlooPCs4MQOJtREKiB0O
         uEdqh02oRzCjFI6gRau0KLvIQPD8eFvGFLlRFFXGEM6t9vjHwABRTinajECp54hKOI54
         K23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYdJ+pTZYl5UcolIlpRhXHpmbr2bVLdL8qQHnOj4ALo=;
        b=KbQvQaan/lfhddb1GEhFU9dvJrVfiZyCoq8oUPtrZ0Mye71k1atIhBuYN+3dXfX6gl
         SsToPlfvQtxRVhTBASg4K7s+TItpCOEnoU4lMurqRarPzE9SW55lg+Q6o4ZipkQIG7Bl
         u7p1R0M+dTXqDmc6rRbqGmNyQXjs73K4ls074yeVFkuMW9gsCNqNL83xWHW6ysDa4CRb
         Tn3Ux7bo31G7NPG1XFzsDAiTepuf2+GRRyoGJ5HxHvHyNmzWmWyxaNaaqWbn01Q0rXuW
         9Qexm56YcR/OmPVkreS/FD4x+mOXyX0v8kn4oDp9l5koSHZHDC2VvnKgBrxRXaDjIgPG
         iP0Q==
X-Gm-Message-State: AOAM531XwgBj22Vk9pyGWbv2Oe6VdbfdeQIxjhYTYleaWSzjv9nYObqg
        YKvvdtncVZJnm+Mw+xivuR6ZeDfJ7LNpFsKENps=
X-Google-Smtp-Source: ABdhPJziNhZ7NL71xH52rvY6TqeUNDPFc/ABDLhjv7ZcFiEv618WMp98zCCKNZ2ykJo15FRqV4/YZ4vmN5MZTdXJ1SI=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr910106oib.160.1592253233485;
 Mon, 15 Jun 2020 13:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
 <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
 <1741fd62-ec03-9d70-d2b6-e1416cf8ae05@gmail.com> <CAEjxPJ72S4nXS=D_4O1WaaoSR7Dc08TRofWpi75cZU-NXtYv1A@mail.gmail.com>
 <CAHC9VhR5f+yanLSX1R2B7R5Qb37Fr91WrUpCQbESjzq2DyyaJA@mail.gmail.com>
 <ceaa212b-20aa-ac1d-6857-ffe4569bc466@gmail.com> <22a5ff40-f5b9-e14a-40be-5848c68c3dab@gmail.com>
 <3640d302-434c-9ab0-d5c6-f566bb91ca62@gmail.com>
In-Reply-To: <3640d302-434c-9ab0-d5c6-f566bb91ca62@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 16:33:42 -0400
Message-ID: <CAEjxPJ5tmn8fsd9xhkUKRogbWU6dQQccE5NH1h=Hv+-1nDKeAg@mail.gmail.com>
Subject: Re: Better management of dynamic networks?
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 15, 2020 at 4:26 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 15.6.2020 0.30, Topi Miettinen wrote:
> > On 12.6.2020 12.21, Topi Miettinen wrote:
> >> Perhaps instead this would work (I haven't tested it yet): don't use
> >> netifs or nodes for anything (label everything with generic types
> >> netif_t and node_t, which is actually the reference policy) but
> >> instead use netlabel tools to label peers according to interfaces and
> >> IP subnets.
> > The problem here is that flow outwards is not restricted by peer rules.
> > The rules below don't prevent ping_t from sending packets to the local
> > network, only from receiving the responses:
> >
> > type localnet_peer_t;
> > allow ping_t localnet_peer_t:peer recv;
> >
> > The peer was labeled like this:
> > # netlabelctl unlbl add interface:wlan0 address:10.0.0.0/8
> > label:system_u:object_r:localnet_peer_t:s0
> >
> > To stop sending, also nodes and/or netifs need to be used, for example:
> >
> > type external_if_t, netif_type;
> > type localnet_node_t, node_type;
> >
> > allow ping_t external_if_t:netif egress;
> > allow ping_t localnet_node_t:node sendto;
> >
> > # semanage interface -a -t external_if_t -r s0 wlan0
> > # semanage node -a -t localnet_node_t -p ipv4 -M /8 10.0.0.0
> >
> > It would be most flexible if peers could be used to restrict outward
> > flow too (since semanage interface & node are slow and require writable
> > policy). Would this be possible?
>
> It would seem to need a small change around
> security/selinux/hooks.c:5801 to add a check matching
> security/selinux/hooks.c:5024 but with PEER__SEND (which does not exist,
> so this would actually become a much bigger change). Would such a patch
> be acceptable? How should compatibility to earlier versions be handled,
> with policycaps maybe?
>
> This would let me use rules like
>
> allow ping_t localnet_peer_t:peer { recv send };
>
> without node or netif rules and netlabelctl could be used to manage
> dynamic interfaces.

This seems more along the lines of what SECMARK is for, along with the
PACKET__SEND check.
