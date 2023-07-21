Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603DDEB64DC
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGUPfs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUPfs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 11:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD12D47
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689953704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juDB50ep5EziMZB0FQ61LdKKQ78ZVaC7nofAg3guVPo=;
        b=BGM79iArVmXMdhHNgpHPlTj+zQYD+q3O0Pb3m6HQRSh3h8z1YIRpXMSNsQjTBhx+I7NxQ2
        HFNlFartwHDQH6TwGlceclY9BxSocR/A3hig/J22IzC5SgM9dK28Ju+wvlGCaM+lrO182Q
        9KSGMysrb+GzkwhP2/oYE0n8atygFj4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-BgWDY8HTPImN5_aVsDRb5Q-1; Fri, 21 Jul 2023 11:35:03 -0400
X-MC-Unique: BgWDY8HTPImN5_aVsDRb5Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4054c24173dso1864071cf.1
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953703; x=1690558503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juDB50ep5EziMZB0FQ61LdKKQ78ZVaC7nofAg3guVPo=;
        b=cBlkWIOp63vT7bS4Qr4IX5GOedDxLQvifrpjgMGw4wKU1al4Atd2GWNxpXyws8+TtP
         wnG205GJO7TlLq9UGNpvnwU7bZX+8RKXLgaISYxG7Ew2U/y6bBrSfAcM+u4zXSQC/PGy
         1X7XuTaTObSDlZUjmrm5XsDpUvZR7ciYSJK/jfBf6+VyMd5SaEDHnJNYzuzdqKUWKB57
         LvmvBTVhYdvA+8aKOofpNsCPjlHm6u0q56UyCoXH5EfZWi2ULGv6FTEnczm8Vqx+KgFp
         Wlq9plc8iQak7uC1nOZoE2wg8em8QL6IOBS7cV7fRUzVr1gBO3xuOGCBX87AQyEdkWXe
         ek2Q==
X-Gm-Message-State: ABy/qLbCPPnU2tjI2GLj4UpTYA4wY6y9od4hABd4U3k5nNgJS772RpAW
        auZqLRiB8mhn96lShAak6WadH9A6AJ8ey/Zfuc8QH8g2tBnxCuaZVgLdww6zc9c0ADIanSdG5Ub
        LrCOOr5JT3qP56yihXOEaxHC62C5QDhUdmn5JnGG25mLuUxSE734Mze8v6jhpvBzr/BFX+nglbt
        I=
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr2941256qtw.2.1689953703070;
        Fri, 21 Jul 2023 08:35:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtmwbAmIm72vygzZW8jvNGyhiYlMdjFzJTDlqFurwIRYLcPtf6Ix91swrXK0VKRdFtao2bUg==
X-Received: by 2002:a05:622a:16:b0:403:59f8:25d9 with SMTP id x22-20020a05622a001600b0040359f825d9mr2941221qtw.2.1689953702672;
        Fri, 21 Jul 2023 08:35:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003eabcc29132sm1295516qtt.29.2023.07.21.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:35:02 -0700 (PDT)
Message-ID: <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org
Date:   Fri, 21 Jul 2023 17:34:59 +0200
In-Reply-To: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

On Mon, 2023-07-17 at 16:27 +0200, Paolo Abeni wrote:
> The only
> remaining perf-related pain-point I see is the indirect call at the
> security_ level, and tackling it looks much more difficult... :(

I spent a little more time on this latest topic. AFAICS recently such
overhead has increased due to the bpf lsm introduction. My
understanding is that a major LSM and BPF LSM simultaneously enabled is
a common usage scenario. That means 2 indirect calls + 2 untrain trails
and 3 additional cache-lines used per hook.

Under the assumption than having multiple major lsms enabled
concurrently is less common, I hacked some (not exactly spectacularly
beautiful) code to avoid the above. Basically, after initialization,
for a limited number of hooks, it checks if only the default major lsm
and eventually the bpf lsm are registered and if so, converts such
hooks to static call[s], using static branches.

The idea would be to keep the above infra usage restricted to the most
performance-relevant hooks (e.g. one-off initialization or
configuration  are not relevant from that perspective). For obvious
reasons I started from a few of network related hooks ;)

As said the code could be more nice: there is some quite heavy macro
usage and some duplication I was not able to avoid). On the flip side
it shows quite measurable benefit when enabled, 0 impact when disabled,
and it's available to all major LSM, except tomoyo (but even the latter
could be accommodated with some effort).

If there is some shared interest for the above I can share the current
status and try to cleanup the code.

Any feedback more then appreciated!

Cheers,

Paolo

