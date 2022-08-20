Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A82C25B08
	for <selinux@archiver.kernel.org>; Sat, 20 Aug 2022 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiHTOUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Aug 2022 10:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiHTOUD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Aug 2022 10:20:03 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24282852
        for <selinux@vger.kernel.org>; Sat, 20 Aug 2022 07:19:59 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so8124805fac.12
        for <selinux@vger.kernel.org>; Sat, 20 Aug 2022 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uYTyRK/ggppk1qfefOckjXKBF0O296J6JFH4Dt5eYko=;
        b=3ALe+YZ3NolhHC10gPVij5hIQS/axK6YJX07lmNRawIaEvsi/iw5Z2JoFnAhoi1JAU
         dA2ODGBqWYvFY0NO7TzhLi/A/K+nNxZmGcOejI5GUKxvGE49SJqNSGj8gSpu7LKRrCz+
         Lu5dMcEfVvY7NfMUyK7CcFauqqYS/Fa2Vrr7NbPmkpVLzCn8Ca/9t+YKuL4YFIl7xw+W
         CKf2H0HKbvG5qIxYE9kKwGNzvZlyBSVRMvmjDjDfAM6UyjueJgihZJEHo4W+bg9SdLld
         kbIrqqcPUyAHtmiEguCYTG1kv+5uidjvG0/v5DcvYfSrbL67FP3WUORnqzXKWSzFsCw5
         Of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uYTyRK/ggppk1qfefOckjXKBF0O296J6JFH4Dt5eYko=;
        b=olGh5itCR1fRIWgbbIOd9Ej1v4ZAKPojEmrKvjt+R9YCeTOUoUzG1BdluADSBHNx+D
         6zpeFgryi1tcpBNypPNoNY/TQU2ymWQFbIkaWXfGQxi6ch60RShT/4DAzu9tv03vmx0o
         J8+ec1goyREZ+jQNIkJsEfAjFzqhfrHfJpJiRYQDad9Sdj5m7kNVE8UJ/mycafVvk7WY
         0BHznIqk4nmMmLOPsci/wrnzmq4rY96CZBjl4hbPj6OV2IZOWWTmGvAFpIqf7HsyC7xY
         uVBTS93bTdekBuq2D1wn4+4uwk8ndwu5RBOcXd3n+BA0oPau/uJ9litYT3SsnfTth6ik
         jE1g==
X-Gm-Message-State: ACgBeo2TrDcG0rry2ndsiJmieJn7DcoZqpXjLz1/ossoPfoulVVYJ7k2
        PnTCfQv+g3WdFU2xirhGyflxHLYJT3SDdJE22Bft
X-Google-Smtp-Source: AA6agR52QLPdtjhcKDNfssg95nnqcfijs4du1dcPBXuvnNBCw1vrwolb2DOlfqQoAki939g4m2/nBPAoDkWsSmniqMs=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr6285289oao.136.1661005197815; Sat, 20
 Aug 2022 07:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220820082606.953886-1-floridsleeves@gmail.com>
In-Reply-To: <20220820082606.953886-1-floridsleeves@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Aug 2022 10:19:47 -0400
Message-ID: <CAHC9VhSXMO7FxKAonxowYBCPjPfhhvuAErju8oU8qPgx62tiVw@mail.gmail.com>
Subject: Re: [PATCH v1] selinux/ss/services.c: check the return value of
 audit_log_start() in security_sid_mls_copy()
To:     lily <floridsleeves@gmail.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, michalorzel.eng@gmail.com,
        xiujianfeng@huawei.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Aug 20, 2022 at 4:26 AM lily <floridsleeves@gmail.com> wrote:
>
> The function audit_log_start() can fail, so its return value should be
> checked against NULL.
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  security/selinux/ss/services.c | 3 +++
>  1 file changed, 3 insertions(+)

audit_log_start() can safely return NULL as the audit_log_*()
functions are designed to handle a NULL audit_buffer.  This is an
expected behavior and not a bug.

-- 
paul-moore.com
