Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFFBC433F5
	for <selinux@archiver.kernel.org>; Thu, 21 Apr 2022 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbiDUT3Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391597AbiDUT3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 15:29:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CF4D613
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 12:26:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q3so5944343plg.3
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ySAOPa+23Z7nTH02rskOjwIvRMHG3YtFaCPY8ZU0k0=;
        b=s6H/CEU0M9rlX8bLktN0VoCgAlCRTGxyc0VGlXwBSozg7RUaK+K1+aWiRDH3r6miT3
         0oheqQPKVO6qoFh4nmuCmrrxRyEtoPv7ht2pkW+1K8mWfqmW8r+9rWueHT0TBeYgtWlM
         2ZWGT/ky8yARjTWDw1SnBMp1GRckDKo/FFk5FKmX0mQFmPglEehq2t6oXE2tonWr7z7g
         4o9rfIFxgTcippcker8PyIeKoxfbNrdm4HOtDNZpjsDxay2V5Y7ic29k2Bg7W3UuT/bh
         wiqGcYM9ZiSkgaI3Z/RdCzB0JsoJPK3mN94F/g1S/B7hxs8Pt5qdEbKQnfQTVBCHdip8
         HoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=9ySAOPa+23Z7nTH02rskOjwIvRMHG3YtFaCPY8ZU0k0=;
        b=hon3FBta5eSgWaBNL7MUyo/JKVYRVmGK4yw/ZxxgpDYokkNC87ms0GIPIAp0SYfOnY
         R092bR2rykZQFBACocphkqFJ4oE/ZLDgfKR3fy+RZPj2d7VmcuXaTB8KzYJJsRKFZE6B
         AWLGR7t6ZX7kbVs+AtdbYQTYMF8A2CUANZdVREKmngyJ7mvMtWdDow/BdmdNQBCD0U1d
         lq1b3qMWRlCsKqdZrz4PXZ/EWWSriIPdcrUShxymIdnmklPQn7nQeWV5f2MtcEsIq19w
         sXXbuOp9BQavnT4VZpgzvAJgW3M309kt4SyFMAnW1HcFMCKTs9gW3A9Da4R3SfT9nKpq
         R/jA==
X-Gm-Message-State: AOAM5335HjYNM4BVcGv2PwwrBfuFRUzCujZwF575/46Dk1HI2jGkxGRL
        lqDYAh5PrDL+JTRNqq3JrRyz
X-Google-Smtp-Source: ABdhPJxX/XkboAP4RcNnOBZ0jMamva6Y4wmEB5qBHfc4Iw6UAEv2qXc0EMj8bSSqK41QmKhLTSXUkA==
X-Received: by 2002:a17:902:f605:b0:14d:9e11:c864 with SMTP id n5-20020a170902f60500b0014d9e11c864mr945193plg.54.1650569184086;
        Thu, 21 Apr 2022 12:26:24 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id fu2-20020a17090ad18200b001cd4989ff72sm3500398pjb.57.2022.04.21.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:26:23 -0700 (PDT)
Date:   Thu, 21 Apr 2022 19:26:18 +0000
From:   John Stultz <jstultz@google.com>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmGv2lY65NniqWzk@google.com>
Reply-To: 20220404054642.3095732-1-tweek@google.com
References: <20220404054642.3095732-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404054642.3095732-1-tweek@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 04, 2022 at 03:46:42PM +1000, Thiébaud Weksteen wrote:
> Device drivers may decide to not load firmware when probed to avoid
> slowing down the boot process should the firmware filesystem not be
> available yet. In this case, the firmware loading request may be done
> when a device file associated with the driver is first accessed. The
> credentials of the userspace process accessing the device file may be
> used to validate access to the firmware files requested by the driver.
> Ensure that the kernel assumes the responsibility of reading the
> firmware.
> 
> This was observed on Android for a graphic driver loading their firmware
> when the device file (e.g. /dev/mali0) was first opened by userspace
> (i.e. surfaceflinger). The security context of surfaceflinger was used
> to validate the access to the firmware file (e.g.
> /vendor/firmware/mali.bin).
> 
> Because previous configurations were relying on the userspace fallback
> mechanism, the security context of the userspace daemon (i.e. ueventd)
> was consistently used to read firmware files. More devices are found to
> use the command line argument firmware_class.path which gives the kernel
> the opportunity to read the firmware directly, hence surfacing this
> misattribution.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

I recently hit a problem in AOSP: Normally on the device gralloc is the
first processes to open the dri device, which then trips firmware loading.
This worked ok because the firmware is tagged as vendor_firmware, and
gralloc runs in vendor context and the sepolicy allows that.

I had made a change to gralloc, so it no longer opened the dri device,
making SurfaceFlinger the first processes to open the dri device.
Unfortunately, this caused firmware loading to fail due to the sepolicy
blocking SurfaceFlinger from accessing vendor_firmware tagged files.

My initial workaround was to add two silly lines to open and close the
dri device in the gralloc initialization, just to ensure the first
access was in the right context and the firmware would load properly.

But Greg pointed me to this patch, which exactly described the problem and
resolved it (much more cleanly then my workaround). I can't comment on the
change itself, but wanted to say thanks!

Tested-by: John Stultz <jstultz@google.com>

-john

