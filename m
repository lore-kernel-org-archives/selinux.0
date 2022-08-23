Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98236C32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHWS2x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiHWS2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 14:28:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B35FDC
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 09:49:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11dca1c9c01so593518fac.2
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=V3gIx0/iz2IpSOrJXxSrSzDLBZ8gouoBDdSWGS957I4=;
        b=iMj05GYlnz592M2SJ+84MEaIyaOU4aD+TDkDijWCcDjBKg7eY1AKZr3v3Dt3d2uJDl
         jsE5XajRjNnFa5BPA2EU6RpizRpJEk+S5iYZfw3qNhVpXOdeulkqe7bkIjTOE/BVO4YC
         69pExpJ+602ZyPoW4PwHuCmu7mGMPW7HirLGoqMGp3B7X0wul8eem5g75RSmYEZc0ZJz
         sDyqVggcw4wqoFWfcC1gW3U4J9J2RE5CLANEA+wIGRwxHDEuklsKBR4WOY0tF6ATlljz
         i53xYWImDpnYeHzA/HCnRgNfBXJjEHJj0hCUipVuFewJNV1a4i6ogUXLeiclOGzhZG3t
         g+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=V3gIx0/iz2IpSOrJXxSrSzDLBZ8gouoBDdSWGS957I4=;
        b=C6ir9/QcBbDfZ3G1Wm0/a9TUT/t7I4UdMuxSjohZl6v+tt4a6qt/u2wPMeVNzT/CFi
         hJne7lWOHj80Sgza0lah7y8k+8J4b8p0Kl2pCqubiGYZGU09gUD5hclcSU+Wud4uHPFb
         TTZxvM2zMX9yZh8GZMv2ruh6LGBQ/dXdnruIXOd77q/7PRHezgKsFBIAmYki/7MgNQ3+
         RNzDRy6R1+1zYVKJxSgFNfsR7PpYtGT8mLEXLPRVFQMLA/a7grbu1LRe8xV2dTarVqi4
         qph+9910dRtXHaaIzg89AgRxEGqDKyPI2dLqGGv4fwl3ichnJlZ/RR8NvAKLjAoC5++8
         2TOw==
X-Gm-Message-State: ACgBeo3qGzBwHvvE9+PaX9xv/d1uzFU4lWTVDi0PrmSYHCImbNHvy9wP
        K2lYZBGQrF8uKsD8VQPYIPQ5f7Gg/n+bCQqwDglf
X-Google-Smtp-Source: AA6agR6YAA/EliMosNOFZlKU3FbX7Edq0nNdiCzH/CpOwCu2ISzQ6G9JQ8ZjLFNttkmDQTVphvQ8c+dSjGaEWVgGbw4=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr1824943oae.41.1661273359114; Tue, 23
 Aug 2022 09:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327379.369593.4939320600435400704.stgit@olly> <YwR5OZ+tsu51pB8l@kroah.com>
In-Reply-To: <YwR5OZ+tsu51pB8l@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 12:49:08 -0400
Message-ID: <CAHC9VhT_r0+=407KrVGinSEFKo-FAGboSXtmqjrqdj95b=Gh8w@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: implement the security_uring_cmd() LSM hook
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 23, 2022 at 2:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 22, 2022 at 05:21:13PM -0400, Paul Moore wrote:
> > Add a SELinux access control for the iouring IORING_OP_URING_CMD
> > command.  This includes the addition of a new permission in the
> > existing "io_uring" object class: "cmd".  The subject of the new
> > permission check is the domain of the process requesting access, the
> > object is the open file which points to the device/file that is the
> > target of the IORING_OP_URING_CMD operation.  A sample policy rule
> > is shown below:
> >
> >   allow <domain> <file>:io_uring { cmd };
> >
> > Cc: stable@vger.kernel.org
>
> This is not stable material as you are adding a new feature.  Please
> read the stable documentation for what is and is not allowed.

Strongly disagree, see my comments on patch 1/3 in this patchset.

-- 
paul-moore.com
