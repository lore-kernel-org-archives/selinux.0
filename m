Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E359BEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGRWBx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGRWBj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17D1BDA
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-401e23045beso47834451cf.0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717682; x=1692309682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJdB/tckdsw1C9JSuGoRZk4dEKtmzYTAAI0Lzw0ckzw=;
        b=BwN2cFWCHh2NX1g8x4fq1pPqcjxWBBGRoPqK8sSu9fYwpACAinG65Ua/ErMWA401Kx
         WpjubZJDAwaquKSQZTzL9tIiY9IuUo1IjXXIphx/GiANa+eok9rRcmj02RhnDnVf37AW
         zC1ggW//kuR2T/ZlnqBZwTHmzgS3jGf4MjQbfyBZ800/DsmHzd2Hizc7hluHBDWpY96g
         w6ALZbOvjmoa/YuqGXB/RdTXYYTA6orF8dodgD8F7o7YFVxo24rj1GVQK/XqBmAMQlGO
         Tb1T8Xjk0dBI9OT6d4JteJeD4pxU8SNqWUpqj8wrdiAP9rfPsJ3l2Yq+8IvKKQBl1u7e
         iBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717682; x=1692309682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJdB/tckdsw1C9JSuGoRZk4dEKtmzYTAAI0Lzw0ckzw=;
        b=jfoHUKR+GKG4I+jqNFmv9lUlMbfJdsDkt7ajI2X0i8d8oZR368gy6mRzUTBcjXYvRO
         7EUlp+GSB/XjWWXVDrHVMz5aq4q9PnZdKpvZRgHv5r7CQKW0YGWdLVbwpFXpYGB6JIV2
         vcIhIR3JJlthHTPXB7T3XT/jEuHdlNRG/xn29tzMlCK70nQ5QJ6SkoMpxKCdTBQMjARb
         +psoTiRINneZusxXmV9CA8bXgN4JhJkjdCOZjr5v6WaxNsobkOuzfUOvPBQuWKmbjLGs
         CiuakTbhCG7lpqMgH61OmYFbQVGpsQwEpcGoXPL2ajeAruNdFzJ81ImMNDmKQad8w23/
         hjyg==
X-Gm-Message-State: ABy/qLanuF3fNlcQC/6K0wQVKv+zZfgTU7Foe5mKnGHZNMlEFQGxQbkU
        WALVCUtwiAYihvWQCP0urzfZ
X-Google-Smtp-Source: APBJJlFZKd3MZ4X8+GBML5T1tSXA9fr1iOheaptzr1M5TlZfDED6hMg9lSFU1+s15annHM/c95amNg==
X-Received: by 2002:ac8:5f83:0:b0:404:e64:f5ad with SMTP id j3-20020ac85f83000000b004040e64f5admr1247007qta.47.1689717682607;
        Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ew13-20020a05622a514d00b00403b1fb1f48sm925936qtb.17.2023.07.18.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:21 -0400
Message-ID: <3232876554476c0f52c3da75d9e21555.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 11/20] selinux: avc: avoid implicit conversions
References: <20230706132337.15924-11-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-11-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use a consistent type of u32 for sequence numbers.
> 
> Use a non-negative and input parameter matching type for the hash
> result.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

...

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 1074db66e5ff..cd55479cce25 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -654,9 +654,9 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  {
>  	struct common_audit_data *ad = a;
>  	struct selinux_audit_data *sad = ad->selinux_audit_data;
> -	u32 av = sad->audited;
> +	u32 av = sad->audited, perm;
>  	const char *const *perms;
> -	int i, perm;
> +	u32 i;

Technically the perm type change doesn't fit with the description, but
it's minor enough that it shouldn't be an issue.

Merged into selinux/next.

>  	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
>  
> @@ -833,7 +833,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
>  			   struct extended_perms_decision *xpd,
>  			   u32 flags)
>  {
> -	int hvalue, rc = 0;
> +	u32 hvalue;
> +	int rc = 0;
>  	unsigned long flag;
>  	struct avc_node *pos, *node, *orig = NULL;
>  	struct hlist_head *head;
> -- 
> 2.40.1

--
paul-moore.com
