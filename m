Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87916C433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiECSJG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiECSIw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 14:08:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1547BF5
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:05:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so24468047wrc.0
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5Dh8zgUF+clDDSF4VJ71yjlCuqjR+QuFSNc95HoPCs=;
        b=LvqrGYRNFNkrxBlEuy5c/zuS8vKuWBFXcpcCPpSscv+hFrPesQkBuhou2fFMXMedXc
         QAnmeh1vQPQoYwaH40pFmnXdhzBNeueUKtHD1iosqL9Bdj4yBzY1U8tcQSY2Rygx2URB
         FtOsUvogM3ihUuW+M08v6tAL+6t79Th4ATBFND8ZnfpUKBoKIy16q2m9XgSBxxTzzqpD
         2729ITSbTdVfJinehMGA2k7k7Qyh4qnXkWfoIaDB7u67+4qJtf5jz7IUOrXQtFFy33jO
         6qBcE4j7fD7VX9d9AbBo3MAeVwU5Ro5yo7UJOwEkl4A9OcgX6QSEsWv/138yCRTbaeIk
         LMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5Dh8zgUF+clDDSF4VJ71yjlCuqjR+QuFSNc95HoPCs=;
        b=qlAVP28qoRmpfA+dM6shFSJvaQf/v48qKiB52OMVoIo3rtwmFj/ZHffDcAfDYC0iww
         0+MADQlaYwoBiP5LNjRrjXfRnkddzHl7dI+qW0LncnwDFD3nbgBxEdNZ1R8Uri1DDev+
         +JCPIaOnLFSFjjuGZUdAUDneWQF5gOtu7eVQmQoFma9Eu7ut+wKqkYIYp9EvvuPz76fs
         bRoFYM2iVkqyezuuEc3om6JJyU1SeDuwWm9Ni6Tw6qdW1QI6fUaB4fYl1Sa/ZD9gzbzd
         WYG1taKDWoMZcDASEumMonifUW43tpb31iTqWhLkbMk9sSsiqgEefwS+pic/WkSm2Qw+
         v4dQ==
X-Gm-Message-State: AOAM533rYNbXFk7NIe/E+OC7sVgJWv75N/bgQCJEt7tdMyDjCbwNYDau
        CspUR3yPKvBeHZ30N3viO+DGr0WsW8t389ELQYkm
X-Google-Smtp-Source: ABdhPJxBqUmGOvsLySN0azIzOT79wpo0DOyC75YwVDOzLW0yJk7R3yP7kP+yA0942vDh6Gu59IJFVmLZGHoGZQ86F9Q=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr10038995wrb.662.1651601116141; Tue, 03
 May 2022 11:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220502140151.31767-1-cgzones@googlemail.com>
In-Reply-To: <20220502140151.31767-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:05:05 -0400
Message-ID: <CAHC9VhQDKVrG7ob1PTH6MF9k7Kdcy+7SBsOYU9XEZv79Zt_ceQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: update parameter documentation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 10:02 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> security/selinux/include/audit.h:54: warning: Function parameter or membe=
r 'krule' not described in 'selinux_audit_rule_known'
> security/selinux/include/audit.h:54: warning: Excess function parameter '=
rule' description in 'selinux_audit_rule_known'
> security/selinux/include/avc.h:130: warning: Function parameter or member=
 'state' not described in 'avc_audit'
>
> This also bring the parameter name of selinux_audit_rule_known() in sync
> between declaration and definition.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/audit.h | 2 +-
>  security/selinux/include/avc.h   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
