Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6422C3A59F
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67520828
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uadQDARM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfHZPTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:19:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34111 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 11:19:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so4077089lfe.1
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Yxm1YpM5+HvB4PCmbQhZyVO5mxc5JDBpL24xPUQG7P4=;
        b=uadQDARMtw+xzX86FaTZrDVYdv/+2AIk/h8HPYPo79emmQg+1CuTuxbwIfp9Nr0Cyq
         P4wWOAljIuX5DyeIV94o0eLM8PESpbOzKs3JJbkvCrvAxMLwA3jpptccHnPPpyW6DkEg
         m22N6PgW3uGG+LECOnWkLtmnxfor8lmSqS6Jgsdf4k5PDUmwM1S89OsOMMDeJ1i5rZoC
         4fKcyY0X8rz0k3MT07R1qxNolbSFDrMiOsdpK9/GYKK9uq36figAIM4kZ1MR8ARenLrM
         rAFnFHqAnNqz7vuLOqzY4m0t3A9OPFiMBuOsRAPF/IU5DnNEdY1RyavSwiyoRLcchH1R
         /Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Yxm1YpM5+HvB4PCmbQhZyVO5mxc5JDBpL24xPUQG7P4=;
        b=OVaz2gybOZhD8tRKULUeNpDZfO9mzwsocp3ADwNUIkeeDRvzGN/bKTIHXvVpLn4cbp
         VxDz5kWMTpnB0ZSZ+8ISXGVxeK7geP0p5a68qY7W7VPA90DrvFalprSowBpHz59ictK6
         DPBH3pTlr1xIMscsmUQXSUqbSJcQQ0iveXcf1bYyCGupVCNRBbI9Uv1h73lKpqT3KR61
         i4lIfyXmCPeUlYRXBZ82CaG8AqIGL1miVnrJmKJjNsPpZWO1+9MWAmQLRHb3g9hl+LQg
         3rYKxemJEBbq+oRBP1gS2AueeUd9fWvaxBSgEK5L9IjTPFgevtN90cDiJBnYe+mX5+v/
         Wc+g==
X-Gm-Message-State: APjAAAXERVRr/4RzrwzQVztJctiAbAj/itRII6po0qI8rdzu1fCITVVH
        YOzOZdv0j2Y9UcYz8mOWdnm70o2DozM4Dmz6PsD/BrlKSw==
X-Google-Smtp-Source: APXvYqwlqbteqEFwVURFIM6ydB1Y+6lP8NzqsdRMfptzTTmKHAHk8ez+gqu9UGvWTtdroTPARLbqq/FzuKzMqyVaK9Q=
X-Received: by 2002:ac2:4474:: with SMTP id y20mr1814758lfl.31.1566832778235;
 Mon, 26 Aug 2019 08:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <156683229042.27016.12674072161480134335.stgit@chester>
In-Reply-To: <156683229042.27016.12674072161480134335.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Aug 2019 11:19:27 -0400
Message-ID: <CAHC9VhQ3gZ_VFsRSXO_i0vFCJdHbWxGVB69mGAfCOvwsePyOLw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix the cgroups_label test
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 26, 2019 at 11:11 AM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> We can't rely on /sys/fs/cgroups/unified anymore, use our own directory.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/cgroupfs_label/test |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

This seemed like a trivial fix, and broken tests are a Very Bad Thing,
so I merged this without the usual day-or-two delay.  However, if
you've got comments on the patch please feel free to send mail.

-- 
paul moore
www.paul-moore.com
