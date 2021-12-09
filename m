Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E52C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 17:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbhLIRgk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbhLIRgj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 12:36:39 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49749C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 09:33:06 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso6969020otj.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7DwvbWl/2EQAti55XDCs1pkZUOp9A0waLax+N7kqMQ=;
        b=kADJJZlpdoiIgOi7/cwNm7q+UqvUNv8dETNakol8jhOmixHCrbGxEr4E0myNIoSfqP
         F85h/eX5XhuAhN0tcNGgwFqieAEMRcdrm0c7Bk2uoxvIVDFCIov5uPZxs/s/p+gQRrbg
         EOpFfnvBh2TZnH+LuJRi2EvXfKld5oL57Rb2YyaAq7Zqp8jX+b+hOjp/kuYpy1QoQccw
         tbBZE2TI7LEYZ2NjfhJpVEXLF3uIADF/PMV85zoFVQlSWKWWHf+BsePNc4zHybggy/ud
         rgPNoNBzTz32B5rc0M5Z3k13T4blnZBQKFibG44IddcrrUrpu/xcexnMddyK1VRdCDxL
         HRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7DwvbWl/2EQAti55XDCs1pkZUOp9A0waLax+N7kqMQ=;
        b=cK9htdgo2B7D+JiHK8SA2nETEPRyHUJF9zp2zrgyuf8rJc1KSZaBF+wS5YgxzqV/MT
         FWt6uSfb/FLegkvUvya2t8n1obs+oOe+ps/M1SSlHbn4PZURMLlUjtk/MTzt8gWuka/Z
         0BwHFTgr5TeLZak7DHdvn4uLXH9Do1rtsm0sR864Tn4xeKQbWUMDa88tIA6LHWtDlfAC
         /bz80cjzctp2uUtVeGY1mmmlUHxXi2Ij5cedYwHKCc0cR4mGrW1mTgxsPRsgTsysZToy
         sO0g9w5R+EJdo/mrYF2Iuk32rQcJV63T/EwBuJfWhEicc7URaAwVu7HkwllHsKwNpXVx
         oI7g==
X-Gm-Message-State: AOAM532qUUeq3ARJEM2QUturbOv1UcAphkH2PulxL3h5HArievg7jM+q
        oomXTUjs3uiFWyjscM+pBcv1vfJgeRHug3FSTc0=
X-Google-Smtp-Source: ABdhPJyQUREhR39Kp90GK7kzzN7INrQ67VoDLTfdImp6fds0IBSf07JavomS9Gp3bMOOArwU7wPh4mdceoYYYoLTUKc=
X-Received: by 2002:a9d:685:: with SMTP id 5mr6576019otx.53.1639071185686;
 Thu, 09 Dec 2021 09:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20211110144727.1467744-1-jwcart2@gmail.com> <20211110144727.1467744-2-jwcart2@gmail.com>
 <CAEjxPJ7eGZ-3p-MGyWyg4PAFXWhmaDG+TTaRQujOXEiBzVO4jQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7eGZ-3p-MGyWyg4PAFXWhmaDG+TTaRQujOXEiBzVO4jQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Dec 2021 12:32:54 -0500
Message-ID: <CAP+JOzQsnsdzbiRZb9tGwaza10DQKAYB2Fwpp2NTNkGRkxKRRg@mail.gmail.com>
Subject: Re: [PATCH 1/5 v2] libsepol: Add support for file types in writing
 out policy.conf
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 7, 2021 at 1:31 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 9:47 AM James Carter <jwcart2@gmail.com> wrote:
>>
>> Although rarely used, genfscon rules support the specification of a
>> file type just like the rules in a file context file. The file type
>> is used to make the genfscon rule apply only for a specific security
>> class. Currently, when writing out a policy.conf file from a kernel
>> policy, it is assumed that every genfscon rule applies to all security
>> classes and no file type will be added to the genfscon rule.
>>
>> Write out the appropriate file type if the genfscon rule is only for
>> a specific security class (file, dir, blk_file, chr_file, fifo_file,
>> lnk_file, or sock_file).
>>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged.
Jim
