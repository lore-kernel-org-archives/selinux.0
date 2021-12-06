Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6706BC433FE
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 02:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhLFCs3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhLFCs2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Dec 2021 21:48:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28606C061359
        for <selinux@vger.kernel.org>; Sun,  5 Dec 2021 18:45:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so36847272edc.6
        for <selinux@vger.kernel.org>; Sun, 05 Dec 2021 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPkDgfSi39yTo3lA/qjUWlLR+uwbqkTX1ixff0nrnrA=;
        b=SFmn2wVsvV+hAxDhb7OcQgutgDiQ0TcwF/tXl2AWq0Ff5K2IUrX0rynCLNKdQozDNK
         Se63NXOlWvajuN06XNGP18fkfeARwldpEyDOO7+AC5M9VLfCa+Maykv/mzdBazqpnxzf
         yMziZm2AxVVcuEP+paOzfP2cVkf8+tG+9r7L3fd6B/a7WjR0Jfq1htp0PHS8zGXUl4OC
         XkcM072wzlerKetR69/pYPg+2xVaUZOZ5FvmQFrHAXbXYDFgmIwHKlxKj58WGvKm39y1
         5Hth9HZsjfIvXqVFg9ESfILQx1iIswyVG99BONxVpC7fi6YFyp8htDAqI2kAFRALvOQn
         WB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPkDgfSi39yTo3lA/qjUWlLR+uwbqkTX1ixff0nrnrA=;
        b=TzfJuThgUVdq16oc4QeApS6A5h+FZTrlSFr3dnfrp5SnbqUvLZjoNZe0IaCGW77cBW
         qOAD4kDhO2Ut6mWHinVa7CKep4C7YQnwjlm+ihdl5GTu05UCKRUuc5ih3nYjISPQ/pph
         BtdyXFNvmmteGa/PbypbL89u6c+N+gi+e9+0JjxHvGexxgonai0GRvstBcDwHNjuxZRP
         OcBZ8TfctqvpTQfVSoKYuULzuFg6ts1EXZltJDxGQwFW1nLRVg/syrLRiv41cZ44zi3u
         gcgMRwpMHb2eMEgQWV/yPjhMa4buCFhdw3/MEx2d1HUQEshXAKWC4ZUR/nD5pIiwfJaz
         Q2JQ==
X-Gm-Message-State: AOAM533fu+w89X1VXEF8pCELvJyrxkrP28MVaDmwCCYBZwPlzqc12L26
        IgKszofx39lRytem/9Q5+r9IRAolMP8UG1LNxpYW
X-Google-Smtp-Source: ABdhPJzW5eYEzA65lBlc1aKKHLqgHO6wHSlCcEI7uABDh3oOz2BbJsPx6uCf1VOYbxXAxj1GKlV68FSntswX2zKhjxc=
X-Received: by 2002:a17:907:7dac:: with SMTP id oz44mr11834244ejc.307.1638758698688;
 Sun, 05 Dec 2021 18:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-24-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-24-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:47 -0500
Message-ID: <CAHC9VhRxkbb0L2gjMTt4eo7B0JUvPDT3hyA8FimieErp+vkweQ@mail.gmail.com>
Subject: Re: [PATCH v30 23/28] Audit: Create audit_stamp structure
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 23, 2021 at 9:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 12 +++++++++---
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 24 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul moore
www.paul-moore.com
