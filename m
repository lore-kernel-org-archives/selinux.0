Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47649C77B73
	for <selinux@archiver.kernel.org>; Tue, 30 May 2023 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjE3UoH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjE3UoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 16:44:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329599
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 13:44:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75b0df81142so572003985a.2
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685479443; x=1688071443;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3b6DJXDHbh5GF3m9xX7f8I5wETK6FJ7eZD5W780N34=;
        b=H8aFyZm3Qhu8NIYvE1PRPnX288KvaYVZZXkoFuMHVfJqFodJ5I7+uxHp3Gtj0CJTzE
         TbTKl/nZUghbEzPW8yYzymxrBjiFDLmxyuXBxD2KpcFqRaaQqHa4rtJiRWrzND50AGAp
         CvBbnVex8eVuiT3ydy+eknz0OivaSFH3IbQEtM8On+3WtBaqbfQA/5R4asixjaHLD/K9
         w89M6yUQyavCuKSAqrGhpuO6p+BAfVwP945XC9m90O7MRpjTTqY2uNxeVzeudrPtIyJX
         Xmm+Kv5EaYwd9K55z7cfpovLQqtS/Mnc0sj8hHrca9cVOjaYU96qo2z4B4KQ2xBbZEp9
         I1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685479443; x=1688071443;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3b6DJXDHbh5GF3m9xX7f8I5wETK6FJ7eZD5W780N34=;
        b=b2UjbZTvN0JIPikgfPz36Ru2Y5yfmSso+bmGgG7x72MFo7IOrb/6uQWSG/n6aiMpmo
         aqKp1pwxwtiHdunxNNSSdQjM9zm5L8TTpYjxWxdGLru7cfQ7WxV6xTYbhfPp9jygKUCS
         EzFuGoXi6TRPzUuVtrfYu2K5Vpht13u91MU6nostcr8XgY1ICHkJ3O/QeVXdlRLCXyaX
         D1Lu+Eq693tqOA1rEgt9kW9gYZgXm+uVw3C5WsBhGjyl8Le+S11f5I6g0DxpS5EtYYrv
         JrcebNTCBjZutCl3grpxD+n9jrUYNGS7IFsucu+VdS/8cFJGqOxwk/J/oJSr96FZReZF
         Ta1A==
X-Gm-Message-State: AC+VfDxD4cWu3pTL3DyLA2F5qoB6pZFCl+yc7HIRkgtw/Auqu/wFCDJa
        1tl5y7q3O89nthdETLukVGr5
X-Google-Smtp-Source: ACHHUZ6f1GRV0UvgvtPovTzxRNuNEYf9LHwcVykqRhwmJG0WLF3q48vPcI++gmwVj4HdFGuZNETV/A==
X-Received: by 2002:a05:620a:8c93:b0:75b:23a0:de93 with SMTP id ra19-20020a05620a8c9300b0075b23a0de93mr3049981qkn.17.1685479442851;
        Tue, 30 May 2023 13:44:02 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a146200b00759300a1ef9sm4409270qkl.31.2023.05.30.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 13:44:02 -0700 (PDT)
Date:   Tue, 30 May 2023 16:44:01 -0400
Message-ID: <cdf6d7b33765b8509a6a700175f0fa09.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: cleanup exit_sel_fs() declaration
References: <20230529130018.89391-1-xiujianfeng@huaweicloud.com>
In-Reply-To: <20230529130018.89391-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On May 29, 2023 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
> 
> exit_sel_fs() has been removed since commit f22f9aaf6c3d ("selinux:
> remove the runtime disable functionality").
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/include/security.h | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
