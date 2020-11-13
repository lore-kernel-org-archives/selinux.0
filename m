Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8DC2D0E4
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64F221D7F
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 01:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AZTMbeyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMBRi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgKMBRh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 20:17:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5EC0613D4
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 17:17:37 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so10921909ejg.1
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ohq8+x9eEOak/Ig85gQN21Sgb5PYQa0/81WkrT87xo=;
        b=AZTMbeyQim36UjRMz7YoSpVXaJezM0rRkJDniP8CycMhtXc3jX100IMVlGafpRzQ5m
         IxM7tSm631jtIcfjURSsgjotpUmRRPxq1NyfnF/vNkizNROukZTYP6x2aZKaxPLu8SYt
         wUbAA914pWcemdNr7F8LQdDJGzWMZgAWxIQFWCkLjrqDUxLXJorl5rPu5IHKB0EjlqsU
         EFgrkJVMnd4jO9YmJxMek60uYCKuKmmh5dvRplFVtk1mTa5zBOxRKO0tPJj3+ormfoHN
         XzwliKHnymUirTxCiUHig9JVTFJdhrJyhbbCM/YUyek2Fw/tPQfgA5NGJMkbfeJp+jKG
         AwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ohq8+x9eEOak/Ig85gQN21Sgb5PYQa0/81WkrT87xo=;
        b=KBa7z7tAuY5T9W5HRU/WYqgFIqjPOQlCqEf37IOQUYTixlbNLY5NWOBWgxGHcgoHE8
         nU/racWerX0itjNGsK/P88q9EG70RcX2nkIAYNgPzlCDosWdJhWW8dz14WVObboaGtsn
         ru+8Zz3IsuUUL2WuwVTf+Jg/fuQphAv8gcqmoM1sk/+UApahVzc9xkYX7cVxisAZCCqc
         ZKYHjuDRaSZeD6a+ZaDz4z4Nc5z0Y/xbIFVJz6L9EgdRHoH8S1g8w0SA4Xi0htcG8d7x
         Dc/e2ate6hs1eC5xNOc9ZC6lXhqSeabiSKEpjRk4V932c//K1mo4AEJ4bPlAvlM36ays
         lF3A==
X-Gm-Message-State: AOAM533UGZ/mI8fuzPrV/4D0uHGwdl3Iuq8d4t+fh02Hjh+BzieQJFlH
        L6y0UmU09FEo6+bH6Fbt31AH7y4QuYdkjqhMKgxK
X-Google-Smtp-Source: ABdhPJzJ15t+2ga5rDM57/GFm5+T4e0h0LIJ4QXUh8f4Gz1+sUrPZ4NWEulbwER/egBpKhQQ+TwdTBMRiyezBe6IJfQ=
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr710224ejc.91.1605230255955;
 Thu, 12 Nov 2020 17:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20201112135332.89062-1-chenzhou10@huawei.com>
In-Reply-To: <20201112135332.89062-1-chenzhou10@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Nov 2020 20:17:23 -0500
Message-ID: <CAHC9VhS-XL0AL8wUY62pZSRb_545Vgic-dQqS_RDZKPk32=_gg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Fix error return code in sel_ib_pkey_sid_slow()
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 12, 2020 at 8:48 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling case
> instead of 0 in function sel_ib_pkey_sid_slow(), as done elsewhere
> in this function.
>
> Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of PKey SIDs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  security/selinux/ibpkey.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the fix!  I've merged this into the selinux/stable-5.10
branch and I'll send this up to Linus tomorrow or early next week.

-- 
paul moore
www.paul-moore.com
