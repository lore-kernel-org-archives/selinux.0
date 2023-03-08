Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D18DC6FD19
	for <selinux@archiver.kernel.org>; Wed,  8 Mar 2023 22:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCHWQk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCHWQj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Mar 2023 17:16:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8CB85B01
        for <selinux@vger.kernel.org>; Wed,  8 Mar 2023 14:16:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x34so349070pjj.0
        for <selinux@vger.kernel.org>; Wed, 08 Mar 2023 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678313798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkhViH9kdWNjYXwKnPEs08Xl3095dV6IZ6LM3uHmPgg=;
        b=bPXrjsfNIA8aCilQN80V8tZJJRnYiUaUiYYE6WDP0poZXHmgRnngHO4Lb96J8qrY8s
         0UFv5K7lMRJloKD0tWGMmVKDB1rB7L2PYgY245lC/cGDS2TdHabWAHsD74tYHk7XWX+9
         ctSErcrpU4ra1h7MNt4j2JB1T46qH5KSu8XZMjjoIq7fVYdLws67bRDNtSSAyq5ddIEU
         URzRfvXhHoHE7mhDjTIo/KgBW+4k4yBsfFL5q4a+jwiG/cTxuGsLWCziz32JVyllZ+pC
         DZbdjHIIJFo9Zy6iaSLyCS5thVAOwak49iMLSnuOr6HQ+YCMlQc6/QjcnOmMkEQALnF5
         7qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkhViH9kdWNjYXwKnPEs08Xl3095dV6IZ6LM3uHmPgg=;
        b=7JrjOOXJqiYKYGNsjnGDED87bw4ULZrz2XL3zam8rJfEsC7YDqb3egTetzTDJkrcva
         fZ16wzZ3xvtFyf9QbQSvVl1vNV7rZ9zVQVvroiD5VAXGgf5QIMVvP8ACJ/1ao2yl1OEC
         tyaKf/wXG3R7IREj3XBHIn9M3cdXP8BQ1VP3czK1oT36AJ1DKwMZTJhShb/hcs4DpGUZ
         T2feVhXEszpon37wHJKAANniP7wFG2eiydLam9tS2z+zrWP32PN9Xwd57wC7HG+LPfjk
         DBswuXEM7U1PH/Mbvc/4NddBn4/gSKVDS8SO4L9q9zi/mF0XsYX/lJIyCYjosMl8cT3N
         0A/A==
X-Gm-Message-State: AO0yUKXSF2PyGPsYBJiNX5ntnnQcrTnmz+/RTs7MdPH5FeifTeQrO7Lg
        0/f9EAAUaZUv0OLVO4n6yGUltLfS3zS90hurrc42
X-Google-Smtp-Source: AK7set++0GvPRL/fArYHKN0SqlsLssuQ2AVagfsEuJmq+L5qFprSO0qSDic4f0ylWLwNIoHyQ3gpdgkwfLpUMJ7FI+Y=
X-Received: by 2002:a17:903:2587:b0:19a:9f86:adab with SMTP id
 jb7-20020a170903258700b0019a9f86adabmr7646529plb.7.1678313797868; Wed, 08 Mar
 2023 14:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 17:16:26 -0500
Message-ID: <CAHC9VhTRT=o9Rv+EhZ4aab1FDCyTNa7XEYuhuOiSEkWh0Cdrnw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new inodes
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 1, 2022 at 5:42=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the major goals of LSM stacking is to run multiple LSMs side by si=
de
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them.

Hi Roberto,

The v7 draft of this patchset had some good discussion, and based on a
quick read of the comments it looks like everyone was eventually
satisfied that the v7 draft was good and no further changes were
necessary, is that correct or do you have an updated draft of this
patchset?

--=20
paul-moore.com
