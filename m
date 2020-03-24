Return-Path: <SRS0=gl5k=5J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D3C43331
	for <selinux@archiver.kernel.org>; Tue, 24 Mar 2020 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA512080C
	for <selinux@archiver.kernel.org>; Tue, 24 Mar 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeInHF9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgCXPPC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:15:02 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56055 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgCXPPC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Mar 2020 11:15:02 -0400
Received: by mail-wm1-f53.google.com with SMTP id v25so1764190wmh.5
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2020 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HtevRCSOQ5hImcUXm9Lh3cjcafAxd1tdI8BLZBEYJNQ=;
        b=CeInHF9e/ENXL6yvp3xgZkch3vPM2/+5sKpIqeTpOIrEhV+4WsJ2yebpgg2oEcJ2PF
         GpWD/wZyUE+Rv4fL5v+O+CUWo2PkkJ19cGFJo4fI+7NMiRbJ+tV4w1CZdoidjNj4YpzM
         CWLWZfAs194zWUi3gfST0Hag4UYTuloQ4MFS9uBXkN+6EzygcqZFf2Z1zXn7gpPx9UxH
         MyrRjKNdR+aNdol8E1jP9/gxQ0/rfA7ujotX/ifgbkTKxVd80akprsyS1QteyWMfLmyf
         4DNtOLSESnjlwZkT8gSt3YeO47E4iLXp2Vegknyg04vBSRCFVoxCnm2Io/UxW1MzyLWU
         aOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HtevRCSOQ5hImcUXm9Lh3cjcafAxd1tdI8BLZBEYJNQ=;
        b=VkgiTzw5Gh+B1TpjogjhS7PIX7/9unOJsgj41iivaLYt0zWY7lPEQTkyfxmIWBnUxU
         isFbB+3RnS2NETQJjL/z6tTzWBVE+ryL+dBc8zDDJyyxNS7i2mczIqahnWZ/7g4iZ6zK
         /ug4p1PmT9TsU1f0lijujWioR8UX5Q7ih2D76s2tV2mMmQLozg7+WuUVfmriQAgmZYnq
         kBwcSd38laK1hn89XXVTpGFNzl4RgkZ/Xb6bkr6RJKLTksoPzD5ywIxUL06iLFr/hH7F
         Chg2Ek82bXEeknXZ1uFgIseU3b/ENUZLfbakf/FdqVZ3MBtKFH9ctHDUHBkxbr51vEMC
         +HXw==
X-Gm-Message-State: ANhLgQ3UXLdC1tnpkXoRwfJsVavMkyPa/5RtPXVBrFk1wwrRbe7tF2J6
        xOKVZnHIVqvidLsGdnUB98q5LviEniP5zuS9Eiti2w==
X-Google-Smtp-Source: ADFU+vsX7sSBMueZHcGxB4NXhv2hBgCn2tWNNuzXu3uDVF7Wh5LOJV/PtqjMhJkD+bvVH5I6+toAfkNo72KwKRvXF1Y=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr5999004wma.36.1585062900036;
 Tue, 24 Mar 2020 08:15:00 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Tue, 24 Mar 2020 10:14:49 -0500
Message-ID: <CAFPpqQERRB3ZJv-+gytzt5AE6y0o+UE3vF+cBb=OAaFrcRKn=Q@mail.gmail.com>
Subject: testing for disable-dontaudit in C code
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Is there a way to test whether semodule has be run with
disable-dontaudit? Or better yet a netlink socket event?

Ted
