Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42DC6FD1C
	for <selinux@archiver.kernel.org>; Thu, 23 Mar 2023 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCWXdy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWXdx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Mar 2023 19:33:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75FE23C63
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 16:33:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r187so289475ybr.6
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679614431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4UQt9s0uViyb6ofhmfjXLpk2tpOHMTrFO4xtiTE1F0=;
        b=B/0sSV7njn/GnbdGsZmwGqohjHyQKCvOu/6lA3UnCwY5crL557lHVTU44KJxZHT7yP
         aPP+W3L7LsThfn1d73iOPDaxJ4xaogwioYx8PIMl/sbmCYK2QpbhQ/C3TGah4c41AH7d
         34VK1xWYZtimyZLICoxE+b9Eqs8qV62zR0LZst+Hl5muiDzrsbLT4VjJQjVnxo20RgOx
         QS6XgqmI6PTjN2jji+M23xYUJA5aMnZhcnEc1UWcg8cyTAqJUozNTyGh4D0U2mOYANmT
         m2TjS6e7s7ht3ZDMN60F3ByMAURAMBiNlLvT9cSW4f6JHrOJwK9tvY7F3QFHQYSulqjZ
         TNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4UQt9s0uViyb6ofhmfjXLpk2tpOHMTrFO4xtiTE1F0=;
        b=I8sZQ1U3iV/AQigW0rlgbsC4HZ0+w2zBFG08xsmDEbsyKVI2JiD8uY57l+/HAysV83
         3OijQm+jGBhFbLLF5gIU6GsF+WbmomuWHbKCFb8h0cCovUWXHwBeuSmeYLjb2Bf7XYny
         MZEv823D0W8Xu2Lw6PjQMCCS4UP9uLT+RB7Z3VzM8trNQ6l5Da8SMYcUn+rD9m8s5ckm
         Q+YzAwFhPE2QIDeTbv64V8xkYtIjgcQPqXe33BRUKYGVZ2jC6kgXgVEu0QXATWmhpWk+
         fgVbVKsayw2WSYogDdNW+NLU00VcmvWutTaZDQWCmtj3RytRbkuDprJRL0EG1m+AKQuL
         UKyQ==
X-Gm-Message-State: AAQBX9dsDOJkPxPj9GLtUdo5t8+4KLxEitFS6M+ee0SUDxJIAHz8ipiE
        YGWnyMSZqaM4Kx9JiGYNTuVSn97aP1cE0n7YMRcu
X-Google-Smtp-Source: AKy350Ythv2mrmo7XSEuLMBIjFRTDHgBFPhqt6X4Wf9cwlS+qXqGx6EuJGwGC9z42MtKE37zO8JrjgFxkcxJXq4nSaI=
X-Received: by 2002:a25:abee:0:b0:b68:7a4a:5258 with SMTP id
 v101-20020a25abee000000b00b687a4a5258mr211351ybi.3.1679614430992; Thu, 23 Mar
 2023 16:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com> <20230314081720.4158676-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230314081720.4158676-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 19:33:40 -0400
Message-ID: <CAHC9VhS1htA=cFqbc3KJsrZ3by6_m=f3Bd0sTbztC=qMZEvedA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] reiserfs: Switch to security_inode_init_security()
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

On Tue, Mar 14, 2023 at 4:18=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for removing security_old_inode_init_security(), switch to
> security_inode_init_security(). Commit 572302af1258 ("reiserfs: Add missi=
ng
> calls to reiserfs_security_free()") fixed possible memory leaks and anoth=
er
> issue related to adding an xattr at inode creation time.
>
> Define the initxattrs callback reiserfs_initxattrs(), to populate the
> name/value/len triple in the reiserfs_security_handle() with the first
> xattr provided by LSMs. Make a copy of the xattr value, as
> security_inode_init_security() frees it.
>
> After the call to security_inode_init_security(), remove the check for
> returning -EOPNOTSUPP, as security_inode_init_security() changes it to
> zero.
>
> Multiple xattrs are currently not supported, as the
> reiserfs_security_handle structure is exported to user space. As a
> consequence, even if EVM is invoked, it will not provide an xattr (if it
> is not the first to set it, its xattr will be discarded; if it is the
> first, it does not have xattrs to calculate the HMAC on).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/reiserfs/xattr_security.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Merged into lsm/next, thanks.

--=20
paul-moore.com
