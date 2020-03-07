Return-Path: <SRS0=kVhJ=4Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BFC10DCE
	for <selinux@archiver.kernel.org>; Sat,  7 Mar 2020 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF297206E2
	for <selinux@archiver.kernel.org>; Sat,  7 Mar 2020 01:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0m3qxHrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCGBtZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:49:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37773 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCGBtZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 20:49:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id m9so4717459edl.4
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 17:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FOniSNLG9NOoiIgdzqrLoGCWO53yN4XOJhLMOwscH4=;
        b=0m3qxHrWHE/4YxYXAHpENQ9CBueHBdg2q92XobXj3OOEVE+twDeNI41qXBZCcURu50
         yg+729gbP4WuGl6x7aUZFe73H+ObwPc18O7EZ904GTmcux9eV04aXVJqcWS56IIEGtd2
         ek+lwtgJEH8VxU91eu0O2tjJNvRLIWH8QDA3ZKmJINtunig/3BOlRsCikHgKKBxKj/K3
         bwGLpaCmryZERuZdrvDLrpgo7geh5FD5fhH2ojK3y3fGatTORrtcWcmcWOTU7AYZs5lY
         vByF/olAWwct1iqRzzVanznQG3K6BEi6dqGvOR7VnaAEcyO8xgqCxTL6dgKnkNq6eJGm
         HqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FOniSNLG9NOoiIgdzqrLoGCWO53yN4XOJhLMOwscH4=;
        b=cmPbqZsxmqDsX3C0ziu3QNrowtgTCmyuYwVlqpQrGuVhKMw9YqcbHx6a1pTrhmUl3g
         6GQuavQrSi+Rl9yMrZXjs8vydV/ZaM1ggzqTQJ5o3ayCUnFOFWI6AZAB6JZ4H5J3JFId
         /vnQIAQvQu0n8Gp4X4MrKDnGx+7//jVpHBPSAAP8mZ002uwDrBTa5ZO3wwEz8rnWrLuQ
         mQDiPv0twzZq1NORe+m+zkj4bGuADVl+rbWaXL1dRV+rFeTGjdtvKs0QFml7Bx401YqP
         n8+9gCyh6CPqZwFQHRtJ2Vtn9MvmjJAKqdOU+n+zHMBOeH0sFvfZ/YRG+NZ5dUjNzRJ4
         yaqg==
X-Gm-Message-State: ANhLgQ17lN0jbkPxhvdkSeHdmk/CRo5s6/DPOdiQVlocB55pzMOxCv1a
        J5eZ/vq+4Xf+eXucXQZYoms6WUNCV8TH22qyixqP
X-Google-Smtp-Source: ADFU+vs/v20p/MGxa6offlJP3Z5TefyfjxW8Vg+MSmjVSScR3nNYQDnHlpPIs6e1P40Ib6ka8pkYzAj1tq4l90bRqdc=
X-Received: by 2002:a17:906:3607:: with SMTP id q7mr5365909ejb.308.1583545763428;
 Fri, 06 Mar 2020 17:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-14-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-14-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 20:49:12 -0500
Message-ID: <CAHC9VhRDwoyBbxSEAN_QAtFTF32sPrYEaH2EWnJOOsCht+ogEA@mail.gmail.com>
Subject: Re: [PATCH v15 13/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 6:44 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new entry "display" in the procfs attr directory for
> controlling which LSM security information is displayed for a
> process. A process can only read or write its own display value.
>
> The name of an active LSM that supplies hooks for
> human readable data may be written to "display" to set the
> value. The name of the LSM currently in use can be read from
> "display". At this point there can only be one LSM capable
> of display active. A helper function lsm_task_display() is
> provided to get the display slot for a task_struct.
>
> Setting the "display" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
>
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/proc/base.c                       |   1 +
>  include/linux/lsm_hooks.h            |  15 +++
>  security/apparmor/include/apparmor.h |   3 +-
>  security/apparmor/lsm.c              |  32 +++++
>  security/security.c                  | 167 ++++++++++++++++++++++++---
>  security/selinux/hooks.c             |  11 ++
>  security/selinux/include/classmap.h  |   2 +-
>  security/smack/smack_lsm.c           |   7 ++
>  8 files changed, 219 insertions(+), 19 deletions(-)

For the core and SELinux portions.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
