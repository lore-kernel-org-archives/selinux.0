Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2565C433E0
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 03:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D294B21744
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 03:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l4AOArTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG1DIn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgG1DIn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 23:08:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB5C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 20:08:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so5321051ejc.9
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 20:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzvqN9z7+EMCqlOT9t269yClh4L2X4GKH4V6D5leCeM=;
        b=l4AOArTlNYEqi/ipTtSMpFTRZT8PAC1SzeKwhbPJndLoGtT+M6sq83mkfrfjzy3xV5
         FP/i9ypQniIGqAxsmOkXdP1ypHfZqvCneqnsfATffAQOn1ZWAsaVsUGHbCPZMOURCX8n
         xBQ4wEUIe9/p1W/EEc10DF58xv7anKEeUua2egHzKtv9UocnamPKpgBq2aFlBPqR8UPH
         9QZi3xYDodnSRmO1OIke7oFiz6kQuRpwlaT6nUznm8eQCEd5bJt5+Fl2to8/TkTSGJ86
         j3PZQ8gn1iMclIR1o4Nc9jL8GKwt/BtRYbPVphF/TqpN/geEYF0kY9L4DT7T5Ld8LzI4
         AH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzvqN9z7+EMCqlOT9t269yClh4L2X4GKH4V6D5leCeM=;
        b=RxdirVnRt5VQalji2IFWTLGEKm1/aTiA6ASCQLNRhRPVsoBbS/51AYxWMXkfmbNLrn
         8tFVBuw5PTFh+fLe55WfTw25VzkIhfowXoOaiidU1/Pqbl9sJ4jFmc5ZOPH74HoN2Pm4
         a84R8+NxWEETQ1qPtGpg38Is7Zw5lG17UHewPdyU+R2DTcpVl21TkuhHm1qrXOd+sUF1
         narUvWgtDVFcAginLgOX5mhGwvtEK8jnv07vYr9jibZ8kCbWVxbhIvX/WnauvrFLf60n
         2xfN8R+VzC60gls/286eXxaupwc0cFTShEVA4hBdlk0jX3pnEcM/NQWunvOdPuFuim64
         q32A==
X-Gm-Message-State: AOAM530kptzIrx5crSVGUY6o6xXQp5ZgZ+u2zsPIVnF7FhGd+IV9Yycv
        bVGM6PI1DHLTh9JBjGBFAF8i9TQCwu/iGd4kB4Bw
X-Google-Smtp-Source: ABdhPJwwaKSyK25ylgvCBFJkMGKmGDef68jCuaUBohuxe0be+0UPcH6iVcejBA4gnM6XREPX4gORJuJqjkKFFwQE1oo=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr13234613ejo.178.1595905720323;
 Mon, 27 Jul 2020 20:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130428.8234-1-toiwoton@gmail.com> <ypjlwo2pm56q.fsf@defensec.nl>
 <100b1c8c-a756-c6e5-5514-a8a9dc6fc117@gmail.com> <ypjlsgddm0gv.fsf@defensec.nl>
 <5ec03092-decb-d861-aeb3-800bc4ff0574@gmail.com> <ypjlo8o0n1a5.fsf@defensec.nl>
In-Reply-To: <ypjlo8o0n1a5.fsf@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 23:08:29 -0400
Message-ID: <CAHC9VhT+XuZir3grtsAiucmXYL18MB_TU-FBtq7grJYhKXUPbw@mail.gmail.com>
Subject: Re: [PATCH v2] Improve network_support.md
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 4:36 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> The thing, i think, is that netlabel is limited and really geared
> towards MLS, it will only send levels over the wire i believe (except for loopback)
>
> By AFAIK the point of netlabel is to be able enforce mult-level security
> on secure networks. For example you could have a ssh server running on a
> particular level. In other words netlabel AFAIK should be able to send a
> process/peer level over the network AFAIK.

The original motivation behind NetLabel was to provide an
interoperable labeled networking mechanism that would allow SELinux to
talk to (at the time) existing trusted UNIX systems such as Trusted
Solaris.  The NetLabel framework abstraction was created both to be
able to support multiple different labeling protocols (CIPSO, CALIPSO,
fallback/static) as well as to support multiple LSMs (SELinux, Smack).

Beyond this, we start getting into a bit of a rathole of comparing
network labeling designs and implementations which gets very ugly,
very quickly.

-- 
paul moore
www.paul-moore.com
