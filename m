Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F262C433FE
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 16:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356657AbiDVQa5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351104AbiDVQa4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 12:30:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E595EDC0
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:28:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so5012036wrv.10
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bDWcRZVjx6GPxFzW3UVWhMMo07Zuw7+gtRI+X12kIY=;
        b=79S0AvECfJoFsHa2OLfcMdtwWILG5UB8TcEvYJkodbNOprYOeNc08ZiU83eUZEhclp
         Q91DiEx3Ph0IS64JucJtoyZPZxIIONW0WL84gOoog140iSkoygCeU+GGZLsz00NlbUsc
         XHL5Y/DXa9FD0dbjT5WsKWLnx6S+/cEIfrhBldN2a2JooajesP3/F8EqE4XXv2Temx6r
         DS9+ndOgLYwsrFFeiInxz5Tcr0hJWQvA8NnU7hWHoPxqlgfpjnfUUOs0TCtj4nLtj1Gc
         h96d1llH8q53gI1vT9jdKBxuVTm9XNdd1JFIs6zzXWJL9R989Uw8V1/jUr7cYts7k6rS
         XCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bDWcRZVjx6GPxFzW3UVWhMMo07Zuw7+gtRI+X12kIY=;
        b=E3/KGGI+kpUmo540vEBtLy917JYgcalz5zwW3MghZaQw1pLK863ktUOtgVQWBGWGEg
         mbbVSDNO5k2q7zKhzIr68hn/RrvG/nVNdbLpDfoJ/1R34ELQ+khZWedn89EKC1xXLt8F
         jRN1Z7D2p12PseakcdZtbDY5epJ3PiEclK7VxmEuWZx2dKLMwa9cSlwZQvfy2hr9pqk1
         2FhDOhu/CbDrq8kCAoTGxfpphquBsfGYTRpLCaEmx+XARAETZJwRdKyBZsMaTWzOtbok
         99DcLNwNGUGLv5amDa6sx3oo6yoApGotCKrZWI9A2C+h7zVASdsZ0OrDqzZiUgoCo80E
         nY3A==
X-Gm-Message-State: AOAM533OfiK5i1b9Y53fgl66LjJpydPblWSxfhRUd6fO0mkNg2zypYf4
        DMP5t8yFwrupzuwTh0DTPtGTCzKGPxxmPv3dv6xk
X-Google-Smtp-Source: ABdhPJwdlLgCr8/r8VUVhCDVqpoOKgB7ViucHZSYkzmPRtbdWPlYnR3ZpOIh8SIIvGQjH5nxZNxeK5ajA4b8BchK7Jc=
X-Received: by 2002:a5d:59a5:0:b0:20a:95c8:7820 with SMTP id
 p5-20020a5d59a5000000b0020a95c87820mr4295435wrr.395.1650644880760; Fri, 22
 Apr 2022 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-26-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-26-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:27:50 -0400
Message-ID: <CAHC9VhTSdTm+91NtwkuKBi=uY9233kFAzPY=wYpeepcFwanZ=w@mail.gmail.com>
Subject: Re: [PATCH v35 25/29] Audit: Allow multiple records in an audit_buffer
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 18, 2022 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 23 deletions(-)

I believe the audit_buffer_aux_new() and audit_buffer_aux_end()
functions from patch 26/29 belong in this patch, but otherwise it
looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
