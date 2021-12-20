Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D4C433EF
	for <selinux@archiver.kernel.org>; Mon, 20 Dec 2021 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhLTSTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbhLTSTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Dec 2021 13:19:43 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E344C061574
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:19:43 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso13657271otf.0
        for <selinux@vger.kernel.org>; Mon, 20 Dec 2021 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=w5OGmATVnPxVogQPrrsua1sWWnpBQ6691p23fwc4s0I=;
        b=BPG3zD3gnKySXtdkAjYsL46AxsYUxqO1Qoh392MDgQmL9dR3lNLvsgSApYSN7ukKqN
         EWjLPhOBMkSMJSmweln+eS9d3r86wXxzEZSOSmLxZImSPKRLLDGwsfI6X+KyRFlBIc/Q
         WNUPoPEXVyR9iJj4SyS+7DUiUvRDzo5eKq+aC6OOeFDS+qp64EAhbuS08HDDbdMlgIvN
         yuSISWZDIgXxjUQ3h4Dq13M5AKFD5iDa40szb2hMskDN/cXM0LV0k45idYBMZUyr6x6c
         R/Y4UUNpTBF4NSRXDk6UQ0Xe13vOSlbyuwC8rHV4lhGfOCpiONBrO5dMDh6Jv4Ipy2GM
         4lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=w5OGmATVnPxVogQPrrsua1sWWnpBQ6691p23fwc4s0I=;
        b=JmVoLi/CoxVeslXADYlLxe+AqaQlSiQQDwF9qD5BIETYYvu8Swj9z7cewLJYt06Roi
         Bc8Hq7gN+Wt/hdVUuj9gcRA1om6ytDrdDhLu9xbg5btrycSxBfhQQrdlu8REBAQnh8ow
         s41AEYP3Tnk4NyTviSSqS+KOITYgtbTLfiHoCxY4DkvWEZswpB3bNRltALKHySJ1BFun
         FrGnT6Pe4OKZQJs6pTZGfJBx7H+NTeFBI03SCGiIwp6YwuXSmm5BEbnny6Pg98mDsIJF
         Jew3O3oTZslNn/M/M/vU15GmYIFyoNTCkpoL1zszfuPq0ww9+AwE5a65v9MaLmiAaber
         vXtQ==
X-Gm-Message-State: AOAM531AsH4+RwgVZg0wJjdGagDr+8h3BPOy1IARFqjRlgSedC7rOKjg
        Usucug65WfvO7mscyprdtBebHOyBGLT7vrVuKYx3lrdp0ag=
X-Google-Smtp-Source: ABdhPJz5TYTPjPszx4JgtYrIpJME7szSKb5opJSJnp84RFJxpQMwWtRViPlo7nzCpY0oer5AQM2Q/odFMKjUxvikJlI=
X-Received: by 2002:a9d:63d2:: with SMTP id e18mr12316805otl.28.1640024382446;
 Mon, 20 Dec 2021 10:19:42 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 20 Dec 2021 19:19:31 +0100
Message-ID: <CAJ2a_DcbGirAaWFZFuk6z4SsbVpZSY8WfeCDJKkVPWpzE3f1WA@mail.gmail.com>
Subject: Granting myself access on oss-fuzz issue reports
To:     SElinux list <selinux@vger.kernel.org>
Cc:     evverx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

while working on the fuzzer for libsepol, regarding parsing binary
policies[1], and its oss-fuzz integration Evgeny Vereshchagin
suggested[2] adding my email address to the receiver list[3] of
oss-fuzz issue reports.
This would give me access to those issue reports, also to the secilc
fuzzer ones, and enable myself to provide potential fixes.
Would this be fine to you or do you prefer only maintainers having access?

Best regards,
     Christian G=C3=B6ttsche



[1]: https://github.com/SELinuxProject/selinux/pull/316
[2]: https://github.com/SELinuxProject/selinux/pull/316#issuecomment-939014=
453
[3]: https://github.com/google/oss-fuzz/blob/master/projects/selinux/projec=
t.yaml
