Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D24C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B10206D6
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rSfAU2Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEAQrC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728896AbgEAQrB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 12:47:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A797C061A0E
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 09:47:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id re23so7939320ejb.4
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNT4/Sthucicoz3OfYeIi+e2sDpr2i8vBnDynJ35Ebk=;
        b=rSfAU2TmEk6FBuKjKXSTI0LO8nMvtqW2/yjEC3/vzKYlLHOVZLomflZPtCvyqxM9u2
         OoRwF020lTWMsQeX6+ddUBM8M6ARhRapK+2lL6AmOdUJaxHa+MzkFvBYTsm5VyrbfpsK
         ewy9A3qeaVt8vYQOA6dB8s+c5khNFj5uS6iu+yIB1pkz/in8IrlEa4qbDoPi4QSiu9yK
         GbX7LiwGYlZPaYHFhkv7KUGM39Yq7YbY8mztL094aLemI+7Jb64o9xAJoONp1yQ0KcIM
         osDIuyiiKj6GZ59nErVvybAuNw7yJ528u9gf7vLliJgnM/+vGXBGfKWW9DtQWA5rMyJc
         hF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNT4/Sthucicoz3OfYeIi+e2sDpr2i8vBnDynJ35Ebk=;
        b=kbDaWZ8qhEDl0DFS4Fr1A8DfVZlFKIMi9GxNnu3umiy0I+YL5fMH1tx65qqY+xHMMo
         nfrxFZaqN1KdTyS/LrQZ2EpY4T4Ec3ua67ACQ4juPsLGMUFojuxnCNAVCuLxyI1/YkTr
         FFNw2UoLIu6ORuwPFyjCfipMHnPfPWD2Wknaio5InQRmeEQTB0fmYRnDAmO7u+4iFVDf
         K7gQCfWjAvkn/ZtoBOPZ+3s2yGKYuehiUrArqPxEeSOs241+KRLw+NBbT15clmJzizld
         7ngTD6G8R14oAx1PqCutGQzjL+nl8v4l4ciAO8HXJrIiRiP57ENj7NbGwMJy0Nu82Z6f
         cFDw==
X-Gm-Message-State: AGi0PuZe7GTQr91vUsIDo56U9HAjQjQFElLnwtOlqBHPOJOHdAYfAYQa
        HZ5Lfjz5/PDXfOKkZYf3SB8b24C0WB9NfZgDUaRw
X-Google-Smtp-Source: APiQypLgXEdp+smo5hw20ykRw2ysgbMFkkc78aYzE9Xkik+QAnkiiZ9wRky25HWgHLxlILzDmA6dyAEDnNFSY0xWC2o=
X-Received: by 2002:a17:906:29c4:: with SMTP id y4mr4088167eje.95.1588351618822;
 Fri, 01 May 2020 09:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073053.83660-1-weiyongjun1@huawei.com> <20200429130738.GQ2014@kadam>
In-Reply-To: <20200429130738.GQ2014@kadam>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 12:46:47 -0400
Message-ID: <CAHC9VhT1-rV3heNWxcKo58AVsvhGeX5=oTQY8d8uahpMhwbJrA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 9:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > handling case instead of 0, as done elsewhere in this function.
>
> Please add a Fixes tag and Cc Kent.

Kent?  Who is Kent?

-- 
paul moore
www.paul-moore.com
