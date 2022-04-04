Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF8C433FE
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiDDVzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358071AbiDDVpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 17:45:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7A2B18B
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 14:38:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so22769186ejb.2
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wreKhBNjpxhFIdG1uIbYXh+IiBmghiePSHwhMRF83lc=;
        b=bg9yhYml1s6SgHRBhY3Y+SX+EYkOH+9iMukL8ts4XCQ5Xinc069dclFMqpMUtz74cB
         whzlW+JN93gEyGiaXAQ9KoCkLl/0kChfTAOhKDpNMTq4i6v2stEjcnFClpPWYLVDHFvT
         AsfEcb5XYLXltCGzPQb4WmvkpoJ75XKlyY0JATLA+pFwl/+gqPEOaW4taut3Z4cpF0lf
         PkJ5tQrOaepUJ2KaKfN5rHecGYjB92qFZX7LFmm3H5XlGsSKfuokYBqwSbS4QAFvrZRX
         8cyMskJsupkTF2yKjycw4TqmZF01Cq1RcoveQNuQKYJR9XFQ/5lhGevRe5e7+iFQSRxv
         5QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wreKhBNjpxhFIdG1uIbYXh+IiBmghiePSHwhMRF83lc=;
        b=xPGMXOTRg+l4Ol85rvoDkor3EaiUuXb/ehoAMp7asDO7xbpyTSEN48f7eH17Wsbcus
         nofQ1mPjOmvC08bA6MatDdBH2oTGyL0dJpeVebropLVS2sUSG6b5iZDGDrvcJ9EZIYCp
         putJnpRPcwP2UEujA5b7Bv5iA+vnCQ0oLQjGJE+NkHfoFzvDDW47ybPYj6zdUmGBO8/N
         pYRwxrjdVDQJb6ZCXHdQsmZP+KEOkxKto3dicoVr3WrWb8V1lEtxY2IMaCygKE5UuxxA
         soViDGx1M4ME/VMmKphfcnBa8zdW9aXRfGQvS/qP/zq9mHx7BSiwPmHr+WZOP450ohW9
         8ycA==
X-Gm-Message-State: AOAM532iQ8wMyMER0KeHEZ1NTUD36aboltbTxkCUWw7rn3izdwGD9LuY
        Jiitl+uQLx7vGsN/GwXaFC9jvcZMGjPNlFchjPvP6/62Xg==
X-Google-Smtp-Source: ABdhPJzcpZuKR4NEH4H/BwARdEu+wCzN9t7cdG+YP2RMKxy7MgyqLEcxKZ22++qAb3SEe/R50/xNvaZlkuKJtXTmFrI=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr194416ejb.517.1649108289453; Mon, 04
 Apr 2022 14:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220404093115.6451-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220404093115.6451-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 17:37:58 -0400
Message-ID: <CAHC9VhT++=yTLMOmDpLaJTfz6CLavZ0673sydaXdQhESgd14Vg@mail.gmail.com>
Subject: Re: [PATCH Notebook] checkreqprot is being deprecated
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 4, 2022 at 5:31 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This will be deprecated at some stage, with the default set to 0.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/lsm_selinux.md                | 8 +++++---
>  src/object_classes_permissions.md | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)

Merged, thanks!

-- 
paul-moore.com
