Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD397C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A3E61209
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 22:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhI1Ww3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbhI1WwZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 18:52:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA59C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 15:50:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s17so1069592edd.8
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xOKs2IPVNSP3xDmXru3XAEYJL8T9U4/jdfmcM6rOSpY=;
        b=lvdq/cBMJcSbp3aMyy/IyYgz1BBogX6qfopE+pFUznFr6UK+l+bLS/MYRoL3yfAIol
         NCRrj2ILmk1xHuV+nZwVvtebm3M2a21XQz5qCSHSf7BwcyrPfK9KRduU9A3iB0xOTiTn
         U4GQzECOs+pSyNi5lF2tWHZWeLPgxaqqilLMY4cKZ4EN5PyIgqZhG+muw5dTFpAIdNOf
         tZ/1k0U19HvPxd6CTbDv224m/OidTaSkzDFsNfL26wLVa3+zb1EoCOroo3uxtUd03ZWb
         ekNvxSWuv0XnL05nVh/+FPtflCVG8TpzCgusXi5+yD/RSE1owzb4ge3izKqOfuwMJZXs
         rNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xOKs2IPVNSP3xDmXru3XAEYJL8T9U4/jdfmcM6rOSpY=;
        b=4ZpVUxccGnm3hQWzDRgpgXtyJJcQysACN3UwRM4uUrlxpNichDdYS4zZ1l/BXg5RNi
         8SbmC6NHsGEHTDEkdatZltdD5l1cQ5ZlwHXhXG2JiRXgqTXT6sV47vKOyon9Kve5VMCK
         zXPo2nQzbfe8Q6SD2QStrpVEz2ZKJnqrsK2fm8ZZOcBdfmERe2OL/y+4jnuDm5fET5mU
         T/iTpcGWPTiezcdpagtHxtw/cgrhScqqclnEHetqZpSh26wmBmH+z08oE9xvBHC/oeSw
         7372uArZKJQ6fIUJUswPVSCTXgFJLZl+PWLRairVUXnR2CPBEKkNqu3xN0jyvrh8qDbj
         0b4g==
X-Gm-Message-State: AOAM531ovDd8jA4VtUAFNFXkb7zECoJekqkLj0jRR/cucwpgxkK6JvKk
        SL8zfPwzta20N4438wFtQT6mBGFAfoiuJFbXrHlvPS+f44HZ
X-Google-Smtp-Source: ABdhPJy+RlBYlS/9Ryh42J0HcNv8NFZJLYVhP87tpNK/mr/8PwnwKev1U79SGUo3PODFufMXZ26nuvhuQvcsVdEM+p4=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr9896907ejc.24.1632869443790;
 Tue, 28 Sep 2021 15:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com> <20210928153931.9557-1-cgzones@googlemail.com>
In-Reply-To: <20210928153931.9557-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Sep 2021 18:50:32 -0400
Message-ID: <CAHC9VhTp6bJbf6+hVVBoc8cZ2-7Yzx6Vtz9ih4Jpq1uU8gqNFA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: enable genfscon labeling for securityfs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 28, 2021 at 11:40 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add support for genfscon per-file labeling of securityfs files.  This all=
ows
> for separate labels and thereby access control for different files.
> For example a genfscon statement
>
>     genfscon securityfs /integrity/ima/policy system_u:object_r:ima_polic=
y_t:s0
>
> will set a private label to the IMA policy file and thus allow to
> control the ability to set the IMA policy.
> Setting labels directly with setxattr(2), e.g. by chcon(1) or
> setfiles(8), is still not supported.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   - improve commit description
>
>
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks Christian!

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 012e8504ed9e..549f631e9832 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "tracefs") ||
>             !strcmp(sb->s_type->name, "binder") ||
>             !strcmp(sb->s_type->name, "bpf") ||
> -           !strcmp(sb->s_type->name, "pstore"))
> +           !strcmp(sb->s_type->name, "pstore") ||
> +           !strcmp(sb->s_type->name, "securityfs"))
>                 sbsec->flags |=3D SE_SBGENFS;
>
>         if (!strcmp(sb->s_type->name, "sysfs") ||
> --
> 2.33.0

--=20
paul moore
www.paul-moore.com
