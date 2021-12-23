Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3374C433EF
	for <selinux@archiver.kernel.org>; Thu, 23 Dec 2021 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbhLWCaX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Dec 2021 21:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbhLWCaX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Dec 2021 21:30:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BDC061574
        for <selinux@vger.kernel.org>; Wed, 22 Dec 2021 18:30:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bm14so15684517edb.5
        for <selinux@vger.kernel.org>; Wed, 22 Dec 2021 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=daghgce28nwyWyjHLTrkYOX/BsLdADwLb4RdOnUkHTQ=;
        b=cW5ug6Gu60oS6C8T1BkTB3i/ValhK+sMrzjJJMO7jf97RtQiUDNYkumpLe0DwkTakD
         FR54U//nlSfWP0fSjfkD0BSIQSCiyDpq5xLlTdiyh8gzpLn0A3JWYuAH2trZN0j6wRIT
         hfNWtgdu8m4DagY88uXb5RGb9UWHAfyl+/0gbR0ixkbdeqZTIU3fYJt6qnj0v8c3ppx0
         yi3I9xVecZOufQLEMxK5Fg3sNfu3HTCJdW8vil4QgzNx+282IBr4dmvueDxHBeIe9YVE
         4G2O+IHiYnwjyJyuuw8XhKhe8fgwwFdYNI+FIira/cVWrPCc6JHrbbL+XyrUKELFsny6
         l2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=daghgce28nwyWyjHLTrkYOX/BsLdADwLb4RdOnUkHTQ=;
        b=M2N7/AJ91XL8O14INATojegF3ltEYv3dYZBpA5fksPGI/qo+9wr811j8IncWXAecIq
         ylBENzjxbLl3wigLZecceYlWTT4UAkGljExq1YHxYKeopUzXTnaFMaqGeqAOcyAMEAFG
         4EnFvVTrYJrBdNs2081EVLRoxUdyTzcugLCw6GNo4n4sbdfgqt2e746I9hL4FSrvyKP7
         WTr9s+TWcubhQg7cdOouJ7UNWDTs4Pg4kguEGz2rs9rVo+IJv4VaRkeD3Fjejinxc4Tg
         ebFaonhoA9GoCJ+/cG8WU0GfMM7ttUQKzpV9o/0aukAt5+xM2dcSagYWAy3cLwCExoH4
         8ZJw==
X-Gm-Message-State: AOAM532QoMUnfcfv0Td5SHxhWJjUJHBmDG9lOBTZpy/Qz+9KD65bNce2
        9z9TIoje0v5GNfWZSBSJYTqYI92MGumR6F0EYplZQdVaSQ==
X-Google-Smtp-Source: ABdhPJwVTAUoea+QrwT4zvCJUVoouT1WDhESk5UdvIKqccBA02Kpm0tJdhRQZJMVoea5754l/J6OcMbcTzitK5/sNAM=
X-Received: by 2002:a17:906:1c51:: with SMTP id l17mr362396ejg.610.1640226620833;
 Wed, 22 Dec 2021 18:30:20 -0800 (PST)
MIME-Version: 1.0
References: <164020380312.90681.9455892274206356279.stgit@olly>
In-Reply-To: <164020380312.90681.9455892274206356279.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Dec 2021 21:30:10 -0500
Message-ID: <CAHC9VhQe1gwUbWhHyG466Ciko+3swJyST0ZxxacjE7z6Y=zTKw@mail.gmail.com>
Subject: Re: [PATCH] selinux: minor tweaks to selinux_add_opt()
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 22, 2021 at 3:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Two minor edits to selinux_add_opt(): use "sizeof(*ptr)" instead of
> "sizeof(type)" in the kzalloc() call, and rename the "Einval" jump
> target to "err" for the sake of consistency.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
