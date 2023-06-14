Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547DFEB64D9
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 19:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFNTdq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjFNTdp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 15:33:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90E11C
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:33:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57023c9be80so4619017b3.3
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686771224; x=1689363224;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KvOAIrF6LzcXtyY6sHIJfZBt/wvZ4I6SC5BVY/k9gVs=;
        b=bj4tN+1+Grm5fx7dt7/L1UNYUZhSe/q9hqPOOW/9hIBh6HFSzlhsz9hKteNgHT1kBw
         91e9AoqvmlCnf5yuYQ8voSh+ELiKRUniEgVVSROIz4EvXZjKO68wVeANqll+WV05HJ5r
         4UvqOT0Rpuk3ENVG0gA/5IeWfD6RyMZjyxdrA5UcNWMIM7GnQW9RTAFgslR4WkPJgoxR
         48ZZg+66hFg3sjp9xDneIaRtCEG5tOHl5NGN64BmVEVXSjZqOKgCs5OuiET2/N+smCFt
         COT1Y7DCbMGRvPTK46bhnBBmZ5BrhegfPl4j+HxVQ78ABDekWLVFbQrUSPzPLJlDax6b
         jHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771224; x=1689363224;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvOAIrF6LzcXtyY6sHIJfZBt/wvZ4I6SC5BVY/k9gVs=;
        b=i5cKDtIi593VLRRC9YwW0EN2iXARBzc75TqELlCIl0Y12+OK2LkBw/v/Lt8VbmomoC
         1V6wucjIV7WJfpWdntUEMnmbpCzdQCV2c7AZvqVI8WoN6XOlHvBdu6J3lSg9Z6AijTjZ
         cdq+ocVFSWgZEmsVdiNNQOJdCoOEQv0A/nfZGIrk0Wq0oVnrdejYtsvOiiqB+f/c1euf
         bAAzDDc6f/P0It8TG0sLX5uyZEKS+zZLpapRoxcf+VsHM92+wg3YhnTenbsggWnEF1RN
         s/GwLGRUk4Aqc8Il6ApgXPDXxcJ3Ua8wYoiPqn5EpEyR7cSzhEvAsgcAwmKrOr//9EnB
         eC2g==
X-Gm-Message-State: AC+VfDyTYS5VqYzpKHyZWSJsVFvSioG057qsq7Nn9axoQHijgb05PAzD
        7sVmRuy5kfxpgkOEeH307oYQ48kcYtkERMKTzRAiwvsj5xaPSUyvMw==
X-Google-Smtp-Source: ACHHUZ7sRzY6vSVbCdZIWvhcInjqRQXmfAkfPD9WeWU5clAJcqHZBTs++nTnVFYH/0LpzdQ4UcdGUaY7nOIlfxVFCgw=
X-Received: by 2002:a0d:cbc7:0:b0:56d:a55:4b25 with SMTP id
 n190-20020a0dcbc7000000b0056d0a554b25mr2413487ywd.40.1686771223885; Wed, 14
 Jun 2023 12:33:43 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Jun 2023 15:33:33 -0400
Message-ID: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
Subject: SELinux and systemd integration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Cc:     Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

Amongst Christian's various other SELinux contributions, over the past
several years Christian has been working on improving the SELinux
integration in systemd.  One of the things that Christian has been
working on is revamping the SELinux permissions that systemd uses for
unitfile operations, both to resolve problems and generally improve
the mapping of permissions to systemd operations.  As this work has
been languishing for several years, I would like to see if we can get
things "unstuck" by proposing two things:

1. I've provided links to the systemd GH PRs below, but I think it
might be helpful if Christian could provide a quick summary of the new
permissions, how they map to systemd operations, and how they map to
the existing SELinux/systemd permissions with a focus on helping
policy developers migrate existing SELinux policies.

2. Given the significance of systemd to modern Linux distributions, I
think it might be a good idea if we selected a SELinux "liaison" for
the systemd project.  This person, or group of people, would work with
the systemd folks to keep the SELinux integration in good working
order, review systemd code as necessary, and help represent the
SELinux project within systemd.

How does that sound to everyone?  If we are in agreement on #2, and
assuming he would be willing to help out, I would like to nominate
Christian as our SELinux liaison to systemd; any objections?  Anyone
else interested in helping out?

For reference, Christian's systemd PRs on GH:
* https://github.com/systemd/systemd/pull/10023
* https://github.com/systemd/systemd/pull/20387

--
paul-moore.com
