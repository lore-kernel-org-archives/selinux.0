Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9BFC433F5
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiBPUr5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:47:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBPUr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Feb 2022 15:47:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6187AC3303
        for <selinux@vger.kernel.org>; Wed, 16 Feb 2022 12:47:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so1962551ejc.9
        for <selinux@vger.kernel.org>; Wed, 16 Feb 2022 12:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvjEChs8oB4bFzrOdFEF4f6WDD2x5bbX154HINupHHc=;
        b=6nnmVyblMn2NYTB8bThctxxAF936b0o+WhtLScsHxJQuuXlYCi3NTu30mpelQPplVu
         CBSl9E3VRbHopbQZ2Op0mSStO0330dQD6jbQira4Fj3bhvFkLRuF4qZSn091dYycbvgD
         BTzNibxjh3gholQIqZMgecsv8IXPdQ7ZbyqTQ6/I1KfDe+7H5tVa50V2BivDOfGHosMo
         Lwiptp4PaFzk32tbRgMJqGjplV0WX+ZUXFnQWIfeR+U7lxPDFHtGRYtqcVwHk7vaYuM9
         OpP621kUbODvE5gYIvDMm8m5/plJVzvT3nOdFfpCq7jm+yAKjGnfA69T071bZC79zbMi
         OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvjEChs8oB4bFzrOdFEF4f6WDD2x5bbX154HINupHHc=;
        b=8N+Syoc1fH3IJh8yOcd4XJ8f119W6a5TPBgF6b0yee4KFMYU9K1tEvS6AKGa3wSoiJ
         soqa3Tv0ABf7UgoSEHCExalQ/hV21/2y75BmLhcDCa68ntdRyfSxRQ/5IwR5ExdkySt9
         Y1QPsktVdW3tmekYhkQo83VvlMZycKUX1wxvVEs5ibpxScOzM9pHrai/V7P/ZD3Y6H7+
         1L7S57Qj4kSmiwpDtfZDz6ITbDlMFCrR3Fv3Kk09eDoPo+iA9BNtAIa6zasqIJGSIBB7
         N/Z8uV5tVQ+tlQf1p/V7OeQpJgOwFTSFrQUb5ylr5SDJrvL98zhhwJdOb6HTNfigTDMB
         SeDw==
X-Gm-Message-State: AOAM5320UTnJsBHT+zfyWgFhVzWlg/1BlzMWMs0NVutRlONlBkoH6mmv
        LQdqpKplGTbcQ60su64w3LxyZrmA1/1CxRwjwqz1tm/l/hUe
X-Google-Smtp-Source: ABdhPJw53KebzyYKq4ObwOesZ4Xgi2GpfK9U8pkjMwJBatkW6N2qbSYIpHMcaLrLTDdnKqk7zMd+NIcxv2Z+H1Dik8w=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr3759463ejp.12.1645044458734; Wed, 16 Feb
 2022 12:47:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
 <20220216125206.20975-1-igor.baranov@huawei.com>
In-Reply-To: <20220216125206.20975-1-igor.baranov@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Feb 2022 15:47:27 -0500
Message-ID: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] SELinux-namespaces
To:     Igor Baranov <igor.baranov@huawei.com>
Cc:     hw.likun@huawei.com, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, xiujianfeng@huawei.com,
        alexander.kozhevnikov@huawei.com, yusongping@huawei.com,
        artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 16, 2022 at 7:52 AM Igor Baranov <igor.baranov@huawei.com> wrote:
>
> Hi all!
> Our team at Huawei decided to revive the work on SELinux namespaces.
> We took https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
> as a basis with some patches from selinuxns-xattr.

Hello!

For reference there is a *slightly* more recent forward port of those
patches in the main SELinux repo under the working-selinuxns branch.
I haven't forward ported those patches since v5.10-rc1 as there are
some rather significant technical hurdles around persistent object
labeling which I don't believe have been adequately resolved yet.  The
prefixed/namespaces xattr approach that you mention above may work for
a limited number of namespaces, but I worry there is a scalability
issue that needs to be resolved; we can't simply keep adding xattrs to
inodes.

 * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

Also, are there rest of your patches online anywhere?  Patch 1/1 isn't
very interesting on its own.

-- 
paul-moore.com
