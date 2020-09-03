Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA2C433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5278206E7
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 21:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NuusExy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgICVLk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICVLj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 17:11:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C6C061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 14:11:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z22so5777476ejl.7
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cs3Fl8XEYk726uKJTBP72rGQw+FjA+zH01CqlETK7xY=;
        b=NuusExy7g4ow3FgT9BEPQ0zyD8hFAeFj9RuP396yPUmBxJLGu/zw9FLZLxg4jMjYvY
         FMadMQfagrMhs5u3z8t05xqMw0OoJPPfnKmMs/WWZxjAMWduSSBWn4RbnZa6JdiVTdgS
         0TED8yymzXhxhqE4s3JQFUbgqFB6ZDkQx6S6EdF1DcIjMVmwGeDpwTPl68yKuFbLc/n8
         zgTukafDyj8bDP6m0fDMIVjlqWTHyCLJVW6eE7WOrUeojvMXd37j8sPNONECu9qDs3Ty
         XFiPDIOqcmftbbG46oD469pcbMhZd+O3Ha/mnqZgU6EcvViWCrcLePNMrOZeyOkNmqhS
         QxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cs3Fl8XEYk726uKJTBP72rGQw+FjA+zH01CqlETK7xY=;
        b=M/duGXQXAuBz03UUgWrhrmuOcBPwvTfUvH9iqP/XGlxaB9ueDn9yvkClBor9fU2iDF
         esQ6tlTgCTDdiGjoLgyqaydEbKG16gmWMEoBD8/CjIZj3co3b4MBif6HUrPPPAyxklr4
         xx6zlIsqPNSSqGSUnlUq3Fe+hkCBmQdmcXowQi41l0HTLhvalOuFU83hQ0qBXUJQHqJN
         tiDki2iG3NX1x1OeOrKU+KeR0slEpeCZ4rGhq21FdU/XMlf9208O+fH2zzjc9bLEF/uS
         trR15tYTu0hhdmcuLqjdAy+SfgJfiA0+e816adBKha1U6Q/yPl43z1FrTQ+b7NQxIRox
         Z90A==
X-Gm-Message-State: AOAM533AypAlF+RfN1zbRWw8KIYHUzIuzmGM27+onU4lwqcfdGRobh7a
        GorLoa1rzY6s4P8ZYv+SoQYRuICA5s+ebyKNdo3D6OYutg==
X-Google-Smtp-Source: ABdhPJxVTFyp9fQym1wigphnqwMMsxYRh7mkmCkXucqyG22L4PJeCtbLzqBiZjAryi0e3vxeWg+/MZriJtwmx7c+a+E=
X-Received: by 2002:a17:906:15d4:: with SMTP id l20mr4063240ejd.178.1599167497801;
 Thu, 03 Sep 2020 14:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
 <CAHC9VhSOsYOYGaqDW+ATR5O5hRGJLbWs0QExNemoK2HRamY0xg@mail.gmail.com> <6702e7d809369332b73c6612a641115d360414ec.camel@btinternet.com>
In-Reply-To: <6702e7d809369332b73c6612a641115d360414ec.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Sep 2020 17:11:26 -0400
Message-ID: <CAHC9VhRaUM16zFtXLPePDNBaSmizWsZMmjmRDhi8qbMiZRj_eA@mail.gmail.com>
Subject: Re: [PATCH 00/13] SELinux Notebook: Convert batch 2 to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 12:11 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Thu, 2020-09-03 at 10:52 -0400, Paul Moore wrote:
> > All merged into the main branch.  Thanks again Richard, I know how
> > tedious these conversion patches can be.
> >
>
> Yes I know !!. I'll post the final batch early next week

 :)

Thanks.

-- 
paul moore
www.paul-moore.com
