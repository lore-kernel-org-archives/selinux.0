Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA18C433B4
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5052B613E9
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhENTBw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 May 2021 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhENTBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 May 2021 15:01:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DE5C061756
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 12:00:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so282648pjb.2
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCybwO0TaczTSlpLwTibNxV8SjBVCUt+aJC9ueKaUsc=;
        b=bhrjbmVoLzZrE0Ye3zSI7lNoZD7nvh/L3Yqq95EI4+CnJ0Syo1J7GFnmqO+AtMBM8/
         DSAbWGDASNfIDYGnB9BKkvavgGmYfk/6erDQCmQsoQ106PaAkQQ3spPJfedq3hnR/Bzy
         8f0VEPWrBOduCQjJsJTse8mAMQi2RJssi2Png=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCybwO0TaczTSlpLwTibNxV8SjBVCUt+aJC9ueKaUsc=;
        b=N/RV//2PrIPaxCjUJyAb0/L/MPB2fK2rca3FQDeiT4xBBLY+4s+9oesIIn/pgz4qjR
         X5jOyhRNQrNinSRDbwnIQAduqhPzGeDQmVjlPYLVSfHm4iHfcFK1O2CF4U5NkkEogpTn
         3L+g/lZ3GcEHUz7gtIkWhlFyK4mSV5FmG+aQR1IFckf/iA+JVWLKqUXPiSD/bMVKcdyN
         IYVfZHNilaq2cxUHSThWeMpZ33YJT+1YQ3jGYWQGsMyIdIMtqvpV0VXJTOb77SWb6Ed2
         0mVzmyRxyoiWWz/pXaLqh3kNhm2JkFVX/7fm5c24OYI9Z6yPWJP3Zas7ByXpYXjyG+iQ
         bf8A==
X-Gm-Message-State: AOAM531t6abZ+tyF0MHEBGrhrELEloNlnw4m6R6W5W8IQ+zQUGr7udI7
        3HTGnstDll4L9KphE7rmA3ToRw==
X-Google-Smtp-Source: ABdhPJzwydOqrNEs8BGiriz1WpXA2XMtZmviya9EPj7XrWMKzuXa+83JaN7GU/Lf5l1HjO2uimqTAA==
X-Received: by 2002:a17:90a:b38c:: with SMTP id e12mr4308880pjr.134.1621018838886;
        Fri, 14 May 2021 12:00:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm10577030pjc.12.2021.05.14.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:00:38 -0700 (PDT)
Date:   Fri, 14 May 2021 12:00:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v26 03/25] LSM: provide lsm name and id slot mappings
Message-ID: <202105141200.F0001143A@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-4-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 01:07:45PM -0700, Casey Schaufler wrote:
> Provide interfaces to map LSM slot numbers and LSM names.
> Update the LSM registration code to save this information.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Seems a reasonable set of utilities. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
