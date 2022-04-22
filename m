Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683EFC433F5
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 16:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiDVQcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449707AbiDVQcS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 12:32:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8F5EDEA
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:29:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so8303604wmb.4
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSXwiLWEWjQOdj+ybEhSxWqUg5Aax1i9HRhflZyjuwo=;
        b=YCU9p6462BVx82HSLv9Rf5QhBNUN0F8YsJmOSNG2sWhZmCf1cXergh6irXe9A/wyEn
         6MNuFfw8IkFKwTdu6Rw+ue6TJntl7y47Qnm1B9Aq0IzM9re4QeMDFJ7BPFsKuMNWXhxI
         qUAMlh2gxQm3v7wHRPs9SGge4q8MFimzFQPs5L/vK1xKaDuwTZmPOB0hixa5HFf6OAkN
         6gpZ6/opOqYIVv8BsnEWihRUFm8Ea9nAHtpMr9p69y15/M0lXX7FLzEk2Fv4ki8S3osQ
         BAqbRK/e/4InBnr8JBMUoaX4U29jks4nwhKPkZFZmy2/vARNJKz96fhyw18tqKOSekww
         LkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSXwiLWEWjQOdj+ybEhSxWqUg5Aax1i9HRhflZyjuwo=;
        b=5/wL8n7MEbINIpiS3sbJoKENJaKnMpOZttfpTyDG83Tp1IkiIyMBizvnZH7fPz5j3N
         Brg2f7JsiG3SCLT6vaqX6zSd+TsIdhTLUEKChcsX/o3LgEjVFxv4c3OUS8SByB/+sj2M
         RtYAv8OTTAFC7gxVgbrN26pIf3A0tqTIrv/CxyRtLtp9mrTkw8VM5OtjU/VcQtglpMl6
         vKaah0kSJ2QezQjNVTUBVfvE45iDlPxxoiVoQJQIw2sSbTow708QRILtaIBVK7RQZNYz
         JD3n46D0e57vM7T9vczCb05sikl09irDLOZXJNR8Ju7PI5tRRmC/KYxA0TUZh+NXSh8H
         NdEQ==
X-Gm-Message-State: AOAM530wV7sPh3rvAgxBwS7QKK7DBuWfyGuPIm2LsSxt9E6cUMiYBjmM
        vlZjaN9P/n8RRgPiZCmnDRKA5WEYCwnDwYbMjaYsH8JTnQ==
X-Google-Smtp-Source: ABdhPJxQf0nrVX6OvvkN/qAXo2l6q28oSGFqJEwPgjpsntDi6y99ItonZP/WXwbNbd2zYvOdWqbpvOTiwT37SYWMkC8=
X-Received: by 2002:a05:600c:4fc9:b0:392:8906:7e5d with SMTP id
 o9-20020a05600c4fc900b0039289067e5dmr4839993wmq.179.1650644963298; Fri, 22
 Apr 2022 09:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-28-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-28-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:29:11 -0400
Message-ID: <CAHC9VhSzk6dq9wbhAtv07XvRvFwD3yZJ5qAPHyLBHV4Kh1eUHA@mail.gmail.com>
Subject: Re: [PATCH v35 27/29] Audit: Add record for multiple object contexts
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

On Mon, Apr 18, 2022 at 11:14 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>
>     type=MAC_OBJ_CONTEXTS[1421]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  5 +++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 47 +++++++++++++++++++++++
>  kernel/auditsc.c           | 79 ++++++++++++--------------------------
>  4 files changed, 77 insertions(+), 55 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
