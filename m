Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFAFC04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B8E20868
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 18:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBsZ4xdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFFSlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:41:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46903 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFSlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 14:41:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so1817815pgr.13
        for <selinux@vger.kernel.org>; Thu, 06 Jun 2019 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1RvIZcBBHiwbVvIBr1arRbehHK0nHXrZapIdaMQSVw=;
        b=fBsZ4xdkUbk63np1kkziFwGHZcxQN3084zNS+EzhJfrEbMl1syCE5L+INFtlaO/7Ut
         5rgZvVNiZBcdLeSlwIZn5KfuOq0WX1z6nsRSSGQobOiixAm0Rv1N9ToTpwRbWwF7W/B1
         qjIihINcHjPyKB24/ebmEc2kcUiJ5NgdwY89U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1RvIZcBBHiwbVvIBr1arRbehHK0nHXrZapIdaMQSVw=;
        b=NVRUe+HyvNKsMPrJ+6PbOD5dFIXxxr2Gn1n7XaiMbdvuCuRR+S6FcyFs0q2sK41imK
         esY4ofg7BVHg9TM7TAMJObLYwZwbC35hPvyOgt537DPgQDK2nAXgMpgYcnmmqUfmCEJ5
         VVV9wUFX6p4ZD8il1GAkPNDsXkcm1QozQHM5OFBTOeCYcyKRkO6IkN3k4DqnvEOye37X
         4WXANY1ARGw66pwPnqdjKHBaJBLAG1no02a8W7I7zgzPykmfX0n6KSP5CbAGnNOwcM0k
         7+Q99tNFmZgTWctRjrey8Hh9vpeS1xqnN6gR9ZhNuXXCSX4ZffY0og/1kDUVpxVawl2K
         dCBA==
X-Gm-Message-State: APjAAAWllz1MrE6arJBu9fK4r1OoXXwPfgo6teozRVB4tes8VLn6rFjh
        c+sGLZpa5uu0qEep07/9qg0CDQ==
X-Google-Smtp-Source: APXvYqwofJQtEfqLSrwKixcn6znXLSy3/RVIbp0hIpDtGOvNUeKKwWrdAnOryxAMInS2c0PZIkEsCg==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr1167224pjo.137.1559846467669;
        Thu, 06 Jun 2019 11:41:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm3488737pfd.84.2019.06.06.11.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:41:06 -0700 (PDT)
Date:   Thu, 6 Jun 2019 11:41:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906061138.BFE4CFEE@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 03, 2019 at 03:23:07PM -0700, Casey Schaufler wrote:
> Maybe lsm_export_is_interesting()?
> I'd love to discover there's a convention I could adhere to.

I'd agree "lsm_data" seems meaningless. lsm_export does seem a better
name, though it has the "export is also a verb" issue. Would "lsm_context"
or "lsm_ctx"?
be better?

then we get lsm_ctx_is_interesting() and lsm_ctx_to_secid() ?

-- 
Kees Cook
