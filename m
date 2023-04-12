Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE432C77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 15:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjDLPV5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjDLPVu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 11:21:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD383E7
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 08:21:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j17so20130000ejs.5
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681312887; x=1683904887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxJDf8h9CHt6G3E7I2KWF/JN8QwQqrNl0/6cI31I6Qk=;
        b=ReLKqfAPsIMWEfXn17YMGLg8MBl0zWvgAGVDVo5M7tri90LUehgQ7BWId3nOjddXd5
         YKHvrb6G95Gon/QdYM8mJL71SLWGk/yPHrVyEfjFNh4de7MxY9bmYmxiEK3isbw2Ct5R
         AMP6PiiHJmMhK0KlD4Ll+ExlXG5xF/nm0dBZa7iD17lOnByX2Ow5QBsDtQzv2Igifdpt
         BvRaQb2SbWrk0lTxufT5SyFcKLgx/lseoB9GRd8yd/MtAU5iB6vr7xkuv0yRX6BYGsga
         jWmA9yUMomjXU9JuxYidxbE039YQ0tb/RObgR3BX5eEASFX65o396rqDva0sVdhqnSTF
         WrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312887; x=1683904887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxJDf8h9CHt6G3E7I2KWF/JN8QwQqrNl0/6cI31I6Qk=;
        b=Lw7QAtF9aNTBS19h3p4U1yEEKAbVE/4kf2ua0TNnRpNKfSKEW3M0mB/F2OomOQ7IPw
         zwXEKwOluEnO1JR47FxjYzGuIE14umMOF/LonILyzCsSwuRQASjIZ//JgQsy0WMZIhwK
         NW4kvheJ0xPsapdgLoctPCWuD2VnqniBTgJ0q2nSMFyd6gRygtdlAA1aAabpJJUVNYBV
         FAal9HGMlQBIqAK0rZTKrZb8CuuOIuA1bRtyG1l9rq92aBqrRLYLgymk/LwA+xCUgE7C
         haqmIkSoNuKVxIYBc5V/Hweo3xugYnG7fnPYH65U0zvGqYVYXjAsqxSQ/w3KhEV+yGi/
         LKkA==
X-Gm-Message-State: AAQBX9eBnNkFu+06leT6enJT05zPjoLrqWguzHa67DTI85iMS8Y4ujvb
        elfNQdxHTadloQQ7sm5sVP2XK74tX6XJhVC3BUMNCBzmGqg=
X-Google-Smtp-Source: AKy350aJEwBLYlVhY+GOyJ+bN8roipNwDIUIRIDz59Ogx3nialvraM5Xu2BrVLwE/Uat5AnGJtXV0Qa2E0Q8painVTA=
X-Received: by 2002:a17:906:2f8f:b0:939:a51a:dc30 with SMTP id
 w15-20020a1709062f8f00b00939a51adc30mr1772598eji.2.1681312887167; Wed, 12 Apr
 2023 08:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOdf3gqCNHoFT_U8cDTy2v8oB-UKmzJn-hyai8Cn9=Zk7uuTsw@mail.gmail.com>
In-Reply-To: <CAOdf3gqCNHoFT_U8cDTy2v8oB-UKmzJn-hyai8Cn9=Zk7uuTsw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Apr 2023 11:21:15 -0400
Message-ID: <CAP+JOzReUxaxCDwdF57QuV0UqsNKBzcKk2M_PqUFLg_W-1kRsQ@mail.gmail.com>
Subject: Re: portcon tcp 80 change type
To:     Etienne Champetier <champetier.etienne@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 1:12=E2=80=AFAM Etienne Champetier
<champetier.etienne@gmail.com> wrote:
>
> Hello,
>
> Is there a way to ship a cil module changing the type of port 80 ?
>
> ie something like
> > (portcon tcp 80 (system_u object_r websm_port_t ((s0)(s0))))
>
> When I try to install such module I get an error, I guess because port
> 80 is already defined
> > Problems processing portcon rules
> > Failed post db handling
> > semodule:  Failed!
>
> Best
> Etienne

The portcon rules are all in the base module.

You could do the following (on a Fedora system):
1) Extract the base module into a cil file
semodule -cE base
2) Modify the portcon rule for tcp 80
3) Install the modified base module at a higher priority
semodule -X 200 -i base.cil

The original base module will still exist at priority 100.
You can see that by doing:
semodule -lfull

You can remove the higher priority module later by doing:
semodule -X 200 -r base

That will revert you back to the original base module.

I hope that helps.
Jim
