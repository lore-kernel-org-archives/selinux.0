Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30C3C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 02:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhLFCsR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbhLFCsR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Dec 2021 21:48:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E308DC0613F8
        for <selinux@vger.kernel.org>; Sun,  5 Dec 2021 18:44:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so36599463eda.12
        for <selinux@vger.kernel.org>; Sun, 05 Dec 2021 18:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwrOTleNvelk5p5BDjcQ97ZYJxlrPxB5VMlww1oIuLE=;
        b=y2wuwSzXt84lZj63b2WI7/Ekw0WAaeL+GkQ/WfSRUm5yOH600JCdGyra8wrwKGTV/a
         gXbLSCE/8PkSnFSKzXmSNgfTCgYQ6frUoz12quMOSJ7jpCxcNmhmkKOH8N2MBFBbhbOR
         8gsLoVAPHWNyKxAs5hgtL6lORTWUkw7g1NP62RwFxzAT2mjaUR57eRyMAAQsRh0+D8nS
         JrKZvi3HqGNuMWgcDSJo2CQ35JhrJBha30Qh4O6f8R9gsW82Rx5t9iLZXOf1GywOAYxs
         HIJMKwQ9kbZZBHz6SUEpM5Q3VGj1KXfH0gyw4ecs41Sm4HHZ0A5WLynWq0dq5/SHveBw
         c5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwrOTleNvelk5p5BDjcQ97ZYJxlrPxB5VMlww1oIuLE=;
        b=AWfI/EOc8Hvz1yP0HTN2yd4sE7m5iiraPR2NT1b7wiP+0mZf6fqCy+vCYaMYFRWpuV
         RtWUWWIRVacLU6OKXC5Z8al7n3xUmG74CzTQFClDbHNOu3uaE3D2aVQpV5G68B08I999
         8WNgxq+3lgdddjIo3oSOQTBSyu6owmv4uxGSzBWZt3hRIHceanv4GIMFfI9GIPCC4ooK
         6Ke9uTBFrshjQpdK4BHoO8mldxHZoU0NI4FTXiCUnLXB0ExwVJKjZFZ65g72AjsMfKg0
         5/PUdBKOKdtSwvI1WJKpxNcCZgw2EvC2Vrg6epPkXMzpB9soQ/XUeMccMAaKmprWOvQr
         fC2Q==
X-Gm-Message-State: AOAM532E52f5zC7VHJWEsgdc1hvaS2bLXl1QSRgU+BufCG4Sd/pyZk0t
        6Me7GI5+8MYgc+x1IgLNvYevbbt/nkLF2ae4PPJ7
X-Google-Smtp-Source: ABdhPJwxvsJ8Ii2vt7If/p7huJgKo6ZVH6nQnuWVUB09BvQKN1/5/qWv8/v9f67OJ4VChwQbr5Rc8EVGUbg9IXxtziE=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr41344264ejb.104.1638758687494;
 Sun, 05 Dec 2021 18:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-23-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-23-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:36 -0500
Message-ID: <CAHC9VhSupFaTHp7FZ1y8XM1ZTUebyaQCVs0McMM40rJKi8qqgw@mail.gmail.com>
Subject: Re: [PATCH v30 22/28] Audit: Keep multiple LSM data in audit_names
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

On Tue, Nov 23, 2021 at 9:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the osid field in the audit_names structure
> with a lsmblob structure. This accomodates the use
> of an lsmblob in security_audit_rule_match() and
> security_inode_getsecid().
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.h   |  2 +-
>  kernel/auditsc.c | 22 ++++++++--------------
>  2 files changed, 9 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul moore
www.paul-moore.com
