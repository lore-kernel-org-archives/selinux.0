Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1177BC433EF
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449700AbiDVQbt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449654AbiDVQbr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 12:31:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427355EDEA
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:28:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so11826704wrd.2
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbhKna1yAX3vL1E68yszR6PG2CBxYv3cVCcWr9+en7c=;
        b=7pOr70f1owMTZgrc7ZCZvQuy2xFgEp4/XmgBMO93KqqgRaYiQIh8bdSPLZwt0jODo+
         bBlgmobXCg9pEqpdOvdJ6YVb45HdL35/QQUQlLjYCXAtPblQoN3qdhtC3sGE1WlvxHYJ
         pS2YQu6hjBVXPZQ5bQ+efylVhIH7DD3AwUOH9UIyc8qx5VUvso55SYllvwwgPiMMJ/1A
         NdcYXcnahGzRIKhQzdfb9mTKYTqXo0G92f/g+MSflbszqK3REqJTRjdHn3EzgbkJROQ8
         /sfBJ7MYDiv5Q2qq5GgFhqKTLWT990JMOEhJ+rPUoQIham/09g24ShjgPFvIT03OjzJu
         A10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbhKna1yAX3vL1E68yszR6PG2CBxYv3cVCcWr9+en7c=;
        b=UgKMfA93ICLQOE3qotzup/N5OnXvDfTVMSLhLGOhVsqVvYhC3BNsg/n/blYioWBvbr
         HLFBookobagogHjtJrH4411aQAnjFt+mWHruoDn5k11lZkBoomECv8bu+60p4LJ9Kk67
         yh9ZhU85sXsR0oFiVkKPs6Qyy8qRMZdaY+yhEgH5dkCEa/qPjUtqPCZEpjL1MrGdtdHY
         WPyta7yWUZFNYBqfqJo97v0VSv49xwwv7CMdjsUyHqBo4G6FQPJ7hRZW847F96CIVcNa
         Vf+Si7xz2qYcmQadD6kmlFH6crsRexygGVGW6JReeG8tlrr+YgoTj/K5N9xiAWxh6e1m
         1U+A==
X-Gm-Message-State: AOAM533ruXRdOeZSfX/tTtyBDrmD/Rq5rkXeVIqn2g1eGvfLKIKY8u6b
        kSb4TqBKMfRHUe7XrQsGigPGYQNs5B/uDN0yF0fM
X-Google-Smtp-Source: ABdhPJwQ1jC1RmyMkg7l+lup6yVZCnYcTCU78s1KhJxUZZF6/lHXlOwbFPlFndpfHc76z1k3WZyDpcf9D1oXXYONROY=
X-Received: by 2002:a5d:5847:0:b0:20a:ae08:8d42 with SMTP id
 i7-20020a5d5847000000b0020aae088d42mr4315402wrf.650.1650644931675; Fri, 22
 Apr 2022 09:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-27-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:28:40 -0400
Message-ID: <CAHC9VhSaUHp=zGtU-yQ++uayfaLig_airHVo_8WcvPVZO2MemQ@mail.gmail.com>
Subject: Re: [PATCH v35 26/29] Audit: Add record for multiple task security contexts
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
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1420) record is:
>
>     type=MAC_TASK_CONTEXTS[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
>
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
>
> Functions are created to manage the skb list in the audit_buffer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 93 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 88 insertions(+), 6 deletions(-)

The audit_buffer_aux_new() and audit_buffer_aux_end() belong in patch
25/29, but otherwise this looks okay.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
