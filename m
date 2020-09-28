Return-Path: <SRS0=s25y=DF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CFC2D0A8
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 03:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790AA239EB
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yPVMFhQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1DXy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1DXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 27 Sep 2020 23:23:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C44C0613CE
        for <selinux@vger.kernel.org>; Sun, 27 Sep 2020 20:23:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so8486437eds.9
        for <selinux@vger.kernel.org>; Sun, 27 Sep 2020 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSlRevBCHKBIyzA5ueyWw4NzSIEO5ZTbxqzS7GUrtpU=;
        b=yPVMFhQUcWE+d2o+8pz6oj1wv3noFNqU/Jzp2Pr7PRm0zj3NKVBi74z70QqGc1lCHt
         3R3CfwcmoFnKWYk2mWuIbxpddF8lBGs5RZs4TvwdKyUIZhPNjZppKxn+4AE20Lmn1bhO
         DkgHgFwPT9S8zSIZkLUFRdzWF6DqAFHRqgLeRRCvD1B10P0XOaw6Dkb3avOVQBleTtjV
         jYb+wfLvfoLYuEq2CMA2l+nR8UOpTSakS6Fr8j0kWg11TWTSglCwN1DZfI2iOG6JpICv
         cTF29RyRXb3En15P2L+Gp7/j3tT2b3DzQhColg/VvLOPB7bt0TCgwnl4q+zNTGI98nA1
         4cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSlRevBCHKBIyzA5ueyWw4NzSIEO5ZTbxqzS7GUrtpU=;
        b=OT7KY+mjqduHBQ3aNs6YOkiDsJKL2YuFBGM9WteghZkazEG0odYu+7kQ/r4+dsoiDZ
         v9JeJZ4u+ngO3w6bjzSRNEw0NKmiRDCEw+HJhVySR04W8IqAXEUPnbbQ6+JNTfs7ipyh
         vD8hN6K3nkn4wQGUBWL72i8ikPoh4uI/uFeYe5Xl1GEpVnB1nR0hKFqjJti9JLT6VzMp
         LCLtUB/vsk0EiA2l02ILIoebxUC1FbSmaM3o+Y6WnjFeqzATEB8+/iwMK7lQ1MgyF4U6
         kjRGQTHhCqAClpDqt66Jew0EQJgr2XqNIbcYLjjZ1bLP5GCsfNho1YLrWtRqv7GUijdg
         eYAw==
X-Gm-Message-State: AOAM531a+N+iUwvXRWI0MVUbVf13XUoyJ/mqmQvuXcaCw0VyWXdkVxGz
        qhAUvGtnNuoOxeuCC/fw5yx3ly5GCZrdlk9mpkFcvoWdpg==
X-Google-Smtp-Source: ABdhPJwegknZKgScIlf+L3dKu4VXLEp9bpaidQa4ngHH/eL16txOqMHop8uORJsNG1t7RUvVjnINWg4lyUcha/OkXq4=
X-Received: by 2002:aa7:ce97:: with SMTP id y23mr13827308edv.128.1601263432697;
 Sun, 27 Sep 2020 20:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
In-Reply-To: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Sep 2020 23:23:41 -0400
Message-ID: <CAHC9VhSKDtp_YoNf=AopcxF19bp=WZsx7hR1rRb6gVPaUTeuRg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     rentianyue@tj.kylinos.cn
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Sep 27, 2020 at 5:44 AM <rentianyue@tj.kylinos.cn> wrote:
> From: Tianyue Ren <rentianyue@kylinos.cn>
>
> I think there is a error initialization for isec->sid when the dentry is NULL,
> when we do "remount -o rw,remount ${rootmnt}" action before selinux policy loading.It's
> leading kernel getting wrong security label "unlabeled_t" when the userspace access
> files such as /etc/fstab.

Out of curiosity, can you provide some background information
regarding why you made the decision to remount a filesystem before
loading the SELinux policy?

-- 
paul moore
www.paul-moore.com
