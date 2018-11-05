Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF2C0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F81F2084F
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="g7+FWPc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F81F2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKFFzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:55:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44655 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFzD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 00:55:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so9308094lji.11
        for <selinux@vger.kernel.org>; Mon, 05 Nov 2018 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBEYYj7N2p/3gkBxcZ1enSoSIFA1w2mzrxKUsNxVI/w=;
        b=g7+FWPc4RffppaZpwcgho7k1sBOFIRrtjJQ69w5GvIMl+2Upvt6i/NRaJMnmiGfRWS
         sEYrOnBKvLcLVC2kIfyZcGadSOAnppjcLFT8SfrHaPqJ5B3gJTogQXwrBftzWuRa1LhU
         VTZ8eJg9XOrB1MiuDu+y2fjY4EJeRxsPQyGR0lF2orYMXOzPi7BavJq96MtDX9ZGyNAY
         yQKP/+3RDqXQYVDP85/GeqBt03yO4nhN27sx50Bse78n71cMFI9Ib9sVaeCpwLJsWMrt
         l2DvvWoJYJqBq98M0SOF91IBXmK/mwAXtpmeCokJHduByZIzTNsZQVCdFuri/2M2GVu/
         aazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBEYYj7N2p/3gkBxcZ1enSoSIFA1w2mzrxKUsNxVI/w=;
        b=K2bUIcC5xEU8MJ+Sb3lQNVrAHiysKCmU7q0m11G0voYV7erfr+5jvELF+jUtzStmgc
         nS6CGfKtFx8D+C6AXxodsyi3F9sH/m9pU2UbSGn3iiRgIHBeKKNyl09kQhSFIhnFGtQN
         7Z3NyO3hYUKd14nmKvkw1gaIofeEKjAt29NaZkYLHlK9fQiyVMxOKucAgMORxbDaNWkN
         4fN2eNgzh4LV4re4FkTZIVvwHBgmoBt+tUPiCjHivNgz2obxOz3951+Iz+finYyFEdMx
         6eM2LTPtoItxv1PCikJt7Zy6k8QkGc4/3wwRM9W6HjRGr+AuMNGwyvPx9SzKCEOaETyF
         bUxQ==
X-Gm-Message-State: AGRZ1gJldXWnYsrCkK2sXPr5n7Ev7yxNv+IZqYCTmsLD080HKpHdJ4Ns
        XC86/T3iBDnymfYPBZSEbqTfzzOjCcBMcKKyWZeO
X-Google-Smtp-Source: AJdET5fIgbaTcunca649X7IhRW1FEmVOiZVG00QYsFEsO8Qpt9sxQ/OijbRghQQweK0r9YSM/jcJP/CV9+63GI6clII=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr15668345ljk.55.1541450015130;
 Mon, 05 Nov 2018 12:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20181023070217.17015-1-omosnace@redhat.com>
In-Reply-To: <20181023070217.17015-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Nov 2018 15:33:24 -0500
Message-ID: <CAHC9VhRPuH3qdwOPstMNqwsmiua=avqTHdkm-YdU-8cbbjwHiQ@mail.gmail.com>
Subject: Re: [PATCH v6] selinux: policydb - fix byte order and alignment issues
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, danielj@mellanox.com, eli@mellanox.com,
        James Morris <jmorris@namei.org>, dledford@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 23, 2018 at 3:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Do the LE conversions before doing the Infiniband-related range checks.
> The incorrect checks are otherwise causing a failure to load any policy
> with an ibendportcon rule on BE systems. This can be reproduced by
> running (on e.g. ppc64):
>
> cat >my_module.cil <<EOF
> (type test_ibendport_t)
> (roletype object_r test_ibendport_t)
> (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> EOF
> semodule -i my_module.cil
>
> Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
> use a correctly aligned buffer.
>
> Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
> should be used instead.
>
> Tested internally on a ppc64 machine with a RHEL 7 kernel with this
> patch applied.
>
> Cc: Daniel Jurgens <danielj@mellanox.com>
> Cc: Eli Cohen <eli@mellanox.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: <stable@vger.kernel.org> # 4.13+
> Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 51 ++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 15 deletions(-)
>
> Changes in v6:
>  - use U8_MAX as the limit for ibendport.port value to emphasize that it
>    is an 8-bit value
>
> Changes in v5:
>  - defer also assignment to 8-bit ibendport.port
>
> Changes in v4:
>  - defer assignment to 16-bit struct fields to after the range check
>
> Changes in v3:
>  - use separate buffer for the 64-bit subnet_prefix
>  - add comments on the byte ordering of subnet_prefix
>  - deduplicate the le32_to_cpu() calls from checks
>
> Changes in v2:
>  - add reproducer to commit message
>  - update e-mail address of James Morris
>  - better Cc also the old SELinux ML

You know what they say: sixth time is the charm :)

Merged into selinux/next, thanks all.

-- 
paul moore
www.paul-moore.com
