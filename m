Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F41C433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 22:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiDDWxk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiDDWxa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 18:53:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A434B849
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 15:11:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id yy13so22914492ejb.2
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=03G+ISMoy1jLWeWaov6SzUgH2M6Hbrw0dvW5LCM2wbk=;
        b=Ul4uxm92/LPnHi7osYJ9g56/dsR+iEsWJZzoxHxLIJej05apnRAChlfwxWN1oNy9iW
         Jh5mlhKWKSIZgkmnTp/O1Sp/UjlxH5NPNyuCoQfDkIGsJkB6Eg1adWfEUiiIz3tIjg+0
         ohyYaoGOVt4p0ivx1myDvbJcnZEAwbzVRMbYqTKc4f8VJzZArrtKyx/03MkN8YdUPT6V
         YjRCSXm5F2erZMwwtrm04vxcunSGXAPe7wCOKTQ67zBum7tzseXuPJdR8sLKqIpK0MiD
         dvoq+z/in4DagfSEKN4x1PsN56BCy2eAio4smxiqSi7OH8tnccdrUFlPTG9THszVG6fp
         OtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=03G+ISMoy1jLWeWaov6SzUgH2M6Hbrw0dvW5LCM2wbk=;
        b=3Yy9TF46D/3cqt4fxmOrZ58Wgx2l3f7bRC+NtdMofSMtNnldmyc7XooluOIYZwVILA
         dH5Sc7PqEtru25/X4aneqbI0OAbomCerTHYVtuG++wx24genYBbBmqE98YAfdmwre7kr
         J35rKl7kQAZ73/YmYTRTH/6G3GlwiiyiS+VMMsNLpF6rYcRbOaSRJUpXotrXjvqtHEzD
         BLGjZgO29VwApuNo3JjKnHi3D4nL1mTaKZ8psTsu1WkJWhCzoRAZLiIPlOMZ70TSlH1q
         HIADGCvXmuWm5TJ6EnVcAfKbG5ECJdf9ufs2G06JerCrqvXZER5mffvyTU0L5oYgvtbo
         fb0w==
X-Gm-Message-State: AOAM532hbeFuuIQEvluRxRewZIK/lDjmQzZNrVLejxwA2QxDw+jdWiHf
        AeAOnbWQBdU1dpOxKYQR2MDJY6iZnHkz+PAq621Djzh1Fg==
X-Google-Smtp-Source: ABdhPJxVcdqq7H1UFQgyfPwITT8IZeJ06ARen4hzMDFpCfhAZtio6N6ulrntru5w7KvvdbEl4foWwIP45hRAtvSSl0A=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr366870ejc.112.1649110303036; Mon, 04
 Apr 2022 15:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <164911024356.258070.13216631741313822218.stgit@olly>
In-Reply-To: <164911024356.258070.13216631741313822218.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 18:11:32 -0400
Message-ID: <CAHC9VhSjNFMoFvB-Y1f8j6+=GDYMNxX6ef-_2MVPXYU_2Yn-4w@mail.gmail.com>
Subject: Re: [PATCH] github: add some basic GH Actions to build the notebook
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 4, 2022 at 6:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patch adds GH Actions to built the HTML, PDF, and EPUB variants
> of The SELinux Notebook when the GH repo is updated or a pull request
> is submitted.  This should make it much easier for people to validate
> their changes as well as providing fully rendered copies for each
> revision moving forward.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  .github/actions/setup/action.yml |   16 ++++++++++++++++
>  .github/workflows/epub.yml       |   26 ++++++++++++++++++++++++++
>  .github/workflows/html.yml       |   26 ++++++++++++++++++++++++++
>  .github/workflows/pdf.yml        |   26 ++++++++++++++++++++++++++
>  4 files changed, 94 insertions(+)
>  create mode 100644 .github/actions/setup/action.yml
>  create mode 100644 .github/workflows/epub.yml
>  create mode 100644 .github/workflows/html.yml
>  create mode 100644 .github/workflows/pdf.yml

Since this is more of a tooling patch and not a content patch I'm
merging this now.

-- 
paul-moore.com
