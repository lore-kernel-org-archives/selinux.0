Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE396C4708C
	for <selinux@archiver.kernel.org>; Tue,  6 Dec 2022 17:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiLFRmr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiLFRmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Dec 2022 12:42:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8779BF63
        for <selinux@vger.kernel.org>; Tue,  6 Dec 2022 09:42:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o12so15119739pjo.4
        for <selinux@vger.kernel.org>; Tue, 06 Dec 2022 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyzVekhNwXrBzVIiy7bWi/8qP0xjRI2c86GG2ZN9wMo=;
        b=VlvjJ4dQ0xlNZPdHgyi2Cya/vFuKK/+AIEJR//JrqdnDjGeHwQXIBGVOolm9Yrj2pO
         OdsjmZ+UHdJoNKz1po/1UhJwFV+OV3lAJYj34aIDy5U57daYjmQIA0+13Pi2JvVuFft1
         E/ya5KV8/2lYoE1smOlPd95jPTd8Jlt8n4kt62uEZqUzDc4j69LKKj1wkCV4gTk++Eej
         /MDzkOCwrYzaoGPSbenjU9s/V68H/Wo6rlLyyxC2AbmdlH7FHtTeKMD2GfH5VpkBW864
         JJDdgQ4Vg3mPz4wYb0doaLkKiXjKVdm/eh6orhIgrllA5iaqoCVPFs98Ohhua1kpqV4W
         WjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyzVekhNwXrBzVIiy7bWi/8qP0xjRI2c86GG2ZN9wMo=;
        b=RCK4ay8Gy1wo5D1gvgs6I4XsRdreg77mJm9IVmYexxJa0taqTxRzspRxwpb+Gy2UAP
         JQHSzXa3xpJV3nw0uKmV5XdNdHWxJIkdNyuEwMNSy3tzFbj4roGXhNHb4pyotQkEwNSE
         CWzuVPmQ2PyJqkWYUhjhwUfPd3b971GFN80Quuad5imNpuG5J4OrU5csKs4N0PK97PsU
         DQZtzB+ErXwPOvhEGlowKLP2qEbbuSQU/wyVVwQbBIFq5zTDLTsGKrCA1SdiMWoVJbmf
         RrKGrTMq/qipkp2oeGfkpOqTlBmmCE0N3VNqLY4ceNlbCqp89hKxuqLMWCp1no4QdP+o
         HlRw==
X-Gm-Message-State: ANoB5pmReNdbJHkQeL8W3CdgsgW8rcbpqKmcF+hCdRVK36UNam+a6AL3
        xogAVXODi3OkFgD7Y3dBh+fBPePQWK7r6NTXssU=
X-Google-Smtp-Source: AA0mqf56MUG4vYZ7P68JPAfUeYVKqXrIzUWEI/tgR/tx9CHjnFfCfP69n16O5dqd6zu/Z/87qU9BtA==
X-Received: by 2002:a17:902:cecd:b0:189:c72b:986f with SMTP id d13-20020a170902cecd00b00189c72b986fmr16785650plg.98.1670348562819;
        Tue, 06 Dec 2022 09:42:42 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id gw24-20020a17090b0a5800b00212e5fe09d7sm11160460pjb.10.2022.12.06.09.42.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:42:42 -0800 (PST)
Date:   Tue, 6 Dec 2022 09:42:41 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: Intent to release SELinux userspace 3.5-rc1
Message-ID: <Y49/EaE6aHZ5Pse9@anduin.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi All,

It has been about 6 months since the last SELinux userspace release so
we're starting the release process for 3.5.
I will tag the 3.5-rc1 release on 21st Dec 2022, then rc2 will be in the
second week of Jan 2023. Then most likely weekly after that as needed.

With Kind Regards,
Jason
