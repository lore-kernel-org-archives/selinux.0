Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38420C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhLHUNI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhLHUNI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:13:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89EC061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:09:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so12325275edu.4
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oI42o3rOSJCf9TsdssY3bP9s3U4VfzP1kVqaTxre/1c=;
        b=qwyHXUlFLGg4aKkgc7ZJ16XiGdDX4o4WdOBCcigPl6gPuObXmsvI4Bz2JuL6+ratC8
         FRAuiubHTHvJziBYIM7ttZkBAKMh4GuSpkLewj8KZABpNWB5r8VVa6B2mJA4MpkCgcvQ
         PpyERnAk9cs/HytiyeKU1l1MrFw+Ucf07WQf44lh8BpheNY1SailylWLp+O0QN2mhEjc
         qVbBKFYhxKHigbSqgHzqiDgs1HKkKW+d+Z4HQr6+MtWHt8oS/kiSyW8M/eE69c3MRRjD
         PvdLbrif6H9HS6UGvWMSQhITxwDBjPa0zj5LFFSICYaJ+vRbvUxDClJpvEVfLznnIu0N
         HAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI42o3rOSJCf9TsdssY3bP9s3U4VfzP1kVqaTxre/1c=;
        b=lILMp+mQlA1o3Tez2v+YfnadL6nUjt9YMAX0AZL86r1MzKeuXtpnLrHdO11hr8mbn6
         sWnb3c7jaIAll2Egi51wC6B3g+4XnudQxnzSt5PrQ2Q7iZpsWKpSks1nNdSPd4F2kP8l
         3mmjf+Ectk8/NhUqWipjYn1t8uLsMFFIS99826jznfPVpcEAA2z1zBxCNeu6dYLbsz8s
         QGenYSrjBBgoTzLesT7Zt67Cf/jGCROOo0VpUksijZekYldXB3yhHYm/ncxKyPWt//Ra
         U8EZ79XlZFhXhq9kBSFF0XHNxhxL8DOU6a6y3BcD4YDmQLfujT03vnwRVdHgeyjKdfiM
         xxuQ==
X-Gm-Message-State: AOAM532DZP5BK6vC6/TjGPWgMlZzNwaTD7shlx7DJzfyJSNIAyqdL+kL
        GxgmGilnZ3yMTLucVXRMHpi/KNEo86Cl40c/Xubf
X-Google-Smtp-Source: ABdhPJxie5/8Cw6Sro0vrZ6ZfzPWtYd3W6pTqh7FmVUSMiKowpz5AE2ZJlRTqHk/mJzIcYOS3+QiZblTROZs4C0K1Ok=
X-Received: by 2002:a05:6402:34cd:: with SMTP id w13mr22099490edc.112.1638994174489;
 Wed, 08 Dec 2021 12:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-3-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-3-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:09:23 -0500
Message-ID: <CAHC9VhQ7gkDSkVa9ZWkg+m5Hw=b=a+_NjLaXL6um9b+2_usXYQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] object_classes_permissions.md: Correct the context
 object class entry
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Clarify the intent of 'contains' and 'translate' permissions.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/object_classes_permissions.md | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
