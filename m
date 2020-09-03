Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34E1C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91A320716
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GJV7WDwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgICOwr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgICOwm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 10:52:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B92C061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 07:52:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b12so2931346edz.11
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8w172oPnK5MVs29uk/vzRnYyo8w0UljolpLj/rIAHiM=;
        b=GJV7WDwrboIWoLDQZjFYOlEc0RdLFBtnBQNSiV1aWkv7OO7Scl62fzPFXxENToQJ9T
         wYLvhWWyA9anvDrqFieaW1fOsiFamhnrUGpDWKpc605gpXVzbiC6cU1jOTonUWDtpgVY
         +P6dAZpCtrKSg/EdKg8pcsEMZevJgWd+T9Mm9KUFA2bjnKtA8soqJa7RxZJZeI98mtEG
         5Boak60495ICuNDVYx6ELEf5UsSpqk34KgKgi5ANwLKV1yMppQEC+hhQdLk5KfvPxb6W
         3pC8ZabGfgxwbDAE6JaMN3j2SQAk22eRaZ7qSWc/3lsN5hJBIXfRzePvJYr2FtQBjzGn
         D4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8w172oPnK5MVs29uk/vzRnYyo8w0UljolpLj/rIAHiM=;
        b=O4iPFNevxLJOiwmmfmKiYkJxNJhzqMJ3SXP3qiDne9qnE/1NBCDtTj96hZn8KRrwFe
         H51G+Xvx+jQZ3n4zc1oyRiIw8XTu8iGH2dgn9SXmC2NRd7DbeXDoqOESZhwQCN8wVd5m
         OnCXk48wPaaLMUftgFm5YakpRkDd+H7hu6odCCouWWjh2lYHsAV1Pms0zEyMXYhK1XWe
         QwEzJ+aAz/dOXv8vBzEZA1Cjve/5LdYJBlUKxQ9sb7tMdmDzP76DrE4ykQWeMto0G05/
         UPjOfDNfCxsP+JvBEYzW9F1FOSh5b9n471dKBnhYusT9S+tVfOgJYA76/UYvpTJ6tbv5
         NGiw==
X-Gm-Message-State: AOAM531TnI3054tJuZUAFXuonVBdOHrCV58f4lbYBbx2t9iSgO+mfD5A
        wQ0KgW8qnRrhLSAVMw089YvwMaWx/8ZPriQRCs2atIXJpw==
X-Google-Smtp-Source: ABdhPJxc/AHs8kE2OPGEmEwfK9OlfPCYcDUvCKGYy91iSkgYm37QwgyNF1PfZnPvyfxD20C1J2gUZreJ7ZBI30VLNTk=
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr3353426edw.196.1599144759122;
 Thu, 03 Sep 2020 07:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Sep 2020 10:52:28 -0400
Message-ID: <CAHC9VhSOsYOYGaqDW+ATR5O5hRGJLbWs0QExNemoK2HRamY0xg@mail.gmail.com>
Subject: Re: [PATCH 00/13] SELinux Notebook: Convert batch 2 to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 2, 2020 at 9:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Converted to Markdown or just tidy up formatting. Added TOC to aid
> navigation where required.
> No text changes.
>
> Richard Haines (13):
>   libselinux_functions: Convert to markdown
>   mac: Tidy formatting
>   modular_policy_statements: Convert to markdown
>   network_statements: Convert to markdown
>   network_support: Convert to markdown
>   objects: Convert to markdown
>   pam_login: Convert to markdown
>   policy_config_statements: Convert to markdown
>   policy_languages: Tidy up
>   policy_store_config_files: Add TOC and tidy up formatting
>   polyinstantiation: Convert to markdown
>   rbac: Minor format fix
>   role_statements: Convert to markdown
>
>  src/libselinux_functions.md      | 2179 +++++++++++++++---------------
>  src/mac.md                       |   34 +-
>  src/modular_policy_statements.md |  229 ++--
>  src/network_statements.md        |  261 ++--
>  src/network_support.md           |  270 ++--
>  src/objects.md                   |  185 +--
>  src/pam_login.md                 |  107 +-
>  src/policy_config_statements.md  |   54 +-
>  src/policy_languages.md          |   26 +-
>  src/policy_store_config_files.md |  432 +++---
>  src/polyinstantiation.md         |  108 +-
>  src/rbac.md                      |    2 +-
>  src/role_statements.md           |  443 +++---
>  13 files changed, 2109 insertions(+), 2221 deletions(-)

All merged into the main branch.  Thanks again Richard, I know how
tedious these conversion patches can be.

-- 
paul moore
www.paul-moore.com
