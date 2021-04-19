Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C3C433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26B861363
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhDSUQa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhDSUQ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 16:16:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819DC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:15:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v6so53591088ejo.6
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i85B1yKzPIUmHrcKcWRZBBC5wKg0X/imA5RKrQZ9Stk=;
        b=j1lYVDMlz8wR5mBA90CqEo+ZrmVm5nlct7YE7xBbnm+1IJ5mkpneBy9U/AgjJ5Dqq1
         wHmTKLsrbMi/31wkueBz1PUnMy8WJCOxr8OmAj2SHShwfXAnPQxt8+TlOcS+gLAxi6dQ
         Q7xF0x7d6oXbteIanyi8CZExDGOFQbbyQX5h/810uKSU6FSNGB12vDiBjd8hCWJ1izn/
         ruw0uE087egmGwJhF3v1jKW0lOUeoyujmb9m4bpx4fx1ROGgQdIA+tSYLg0WR7+2AX/J
         bGN0lPXnbxEEVCAVC7K1h2IQaODhqZ9J95mVcPEi1IKn/FndBe6iMm6Vo/T6vnVl2Qib
         Rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i85B1yKzPIUmHrcKcWRZBBC5wKg0X/imA5RKrQZ9Stk=;
        b=A3EkFPKayLCDBjZV5fAbKIwZFaJmkcEcgrXs5k0gt3amkgKDRAC7dOLWtoV2TSV/Wl
         2ji8ghj6apHPWuM5HHY4TvXmbSbATxhWleHhWQCnHb4PBf8Y4RMpdKUE5MfTNVhpnuVX
         8qJqFq9tCZQf9wlcJy3Iv+l3vaKb4dEHu3Y7GmjVe8hYBEAqpTgOADIPFw0hjOHdKP8y
         Nys+mZ8IdLLk52mrUXiCSEBJFg3RWM1vCf11ZzZBPeqHQWKeYqUP1+1e892STZcNe18s
         +TabaXIYp2N9pRpY5rxjNN8tpZjOAIVcfQqM9UHeBLV8yli8qy2V0IuInE8/sGhGbGgJ
         9pVA==
X-Gm-Message-State: AOAM532hC9OW6Bg7GhK+YgUG83zuXkBJM1Kt+Zj6wIsiE5uJqlYabpCt
        00BHdZjM2wIsZpNjBFfT1jWFI3Fx1gkLAHNG9baS
X-Google-Smtp-Source: ABdhPJyqR+vTXNonsCTSN164at+XFRS15TQNgx7k+la4e4RwG5osORG+vEkjFeq5eTv32TPrA5T1D9rEVXpdcaxRddU=
X-Received: by 2002:a17:906:f1cb:: with SMTP id gx11mr24419542ejb.106.1618863357071;
 Mon, 19 Apr 2021 13:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQF7L_ecFzBsfG5EydnaZ7_NQeT4Yxi+aY9Q1Xj-N_0c7g@mail.gmail.com>
In-Reply-To: <CAFPpqQF7L_ecFzBsfG5EydnaZ7_NQeT4Yxi+aY9Q1Xj-N_0c7g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Apr 2021 16:15:46 -0400
Message-ID: <CAHC9VhRFeg2KLSy-2frtN=mBhR=5VBVUq1LXfAqjCL0VAvt=uA@mail.gmail.com>
Subject: Re: no SELinux common criteria?
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Joe Nall <joe@nall.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 3:43 PM Ted Toth <txtoth@gmail.com> wrote:
>
> Having read:
> https://www.redhat.com/en/about/press-releases/red-hat-adds-common-criteria-certification-red-hat-enterprise-linux-8
> and seen no mention of SELinux I/we are wondering what others are thinking/doing about the lack of certification? Are we going to have to take this on ourselves and if so what would be a good starting point (LSPP)?

As a reminder, the SELinux developers list is an upstream list for the
discussion and development of SELinux; it is not a distro specific
list.  While the general topic of security certifications such as
Common Criteria can be on-topic for this list, distro specific
security certifications are likely best discussed with the individual
distro/vendor.

Last I checked, a CC eval of a general purpose Linux distro was a
rather expensive undertaking, I doubt that any of the volunteer based,
non "enterprise" distros would be able to go through such a
certification without some form of sponsorship or corporate backing.

-- 
paul moore
www.paul-moore.com
