Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4207C43461
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B32920760
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nW1hxR9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgIFDaw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgIFDas (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 23:30:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85DC061574
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 20:30:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so9482678edo.10
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wHPPkaxeVFFOMr8d/2od9ySdonpQKZ/DXTg8kyqTpY=;
        b=nW1hxR9BoOFoAMMEJzZkNZ/8pLa0l8s1BWfiuIZYkHcQjkmSTXOp0kXnmOl8uN/kGe
         9RGbM6GbTTZCAIDS8SkFOObM2J9NPy2iPMugicicp8AW5GDrCCRqY+O7qJZVEZ5+LwWs
         yOYWhhyJAOlQyWZA5m0Nax5qUr/6Zb7E6ouMzS/lYP0yiKeah+6VC/5LQ5kzM/CDaThq
         FOV+wwXK/a2hH6pn6zCcHjEpLYbnfErBHTuZzAa2ruHxIhKOf9JtO+7EwRc7EemTVafr
         eoRkJRJ73BX3pMwHAnOMXP0Fqk/phdg/40uMh4r2GXkhh/T06NtZt74VFC3eZBFhypr0
         HV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wHPPkaxeVFFOMr8d/2od9ySdonpQKZ/DXTg8kyqTpY=;
        b=lFLlY+h9K9tvSQO4Wkrkba7VfB8BFp2mcpL0VQb0Bl0lxpVr+Hkg1zDG0eswaPpm6o
         iA5t7XGIQoG/akoswyjukpXbiDtwteZRrqxPoPYOnvZFSa8YcLzVC4ZCx/dXzVXemVgh
         bQBIDLQIWfxQewSIyeokaQVOsbOYKweWvkWe8Xe+rbh9tknzlD2J8wQR8UFCE1BZ7AUu
         Ib+L+964tDEh20kPDYthYXlI3wSAKPMQP8seUJdGs/KuV1bZqy4ChoD8UybPx+SjufWT
         8hFcfgy5Pz6nnTsWZZqv4b3U7X9VZGJ1hSAwJz+bfF6YUgb4Qv7O5IDEi8NRBKqV9Zch
         PKlg==
X-Gm-Message-State: AOAM531SNu3n9MbIE83vosyhs9nJniXEGxA42eIC5tx9YSJdKafaUCXR
        zU5xZZF1qymk+ebBEd6uc9rZM3aHdOUx/Q9Q2I+Q
X-Google-Smtp-Source: ABdhPJzVAMR+sYipg/mqKopXx4XD3m78OLyZOYpqhPzK5b9xqhrEJrZoytomjyX1EExMN6zZkGauipOAmeRGRvpBsmQ=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr15381707edv.135.1599363045145;
 Sat, 05 Sep 2020 20:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-20-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-20-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 23:30:34 -0400
Message-ID: <CAHC9VhQsra7H1an4431q_2Fu2G6uCtqYZXfKSKxW6Bp_OfXshw@mail.gmail.com>
Subject: Re: [PATCH v20 19/23] LSM: Verify LSM display sanity in binder
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:22 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Verify that the tasks on the ends of a binder transaction
> use the same "display" security module. This prevents confusion
> of security "contexts".
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
