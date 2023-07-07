Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BAFC0015E
	for <selinux@archiver.kernel.org>; Fri,  7 Jul 2023 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGGOfP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jul 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjGGOfM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Jul 2023 10:35:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209391FE1
        for <selinux@vger.kernel.org>; Fri,  7 Jul 2023 07:35:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c4d04d50c4cso2096680276.1
        for <selinux@vger.kernel.org>; Fri, 07 Jul 2023 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688740509; x=1691332509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3byNldQYPIXJHmP2gWtnYb97CCpo9o+8rBL4rOGmYI=;
        b=O+sNIMFB87eFKv59KzF3dXdq0akAoOhXxAYsi4up1srWeaMLB3uPvj4RXV1KolJ7J1
         SJ8TnlN6tOOt5IxKn6+QSbfvdVUP2pEx0kK+QtCM3hyO948Vq6sgwkHQfwTpwjkHp8OI
         kTOW/kHq3hukeFIKa8rciOZa7Z1EmENtgr7Z4zERYBUzd/rkYE+S0pgRgQdPolxeZIbI
         ZHjpsm+KzGotamfgtTJPCujYCr4NajLOq11slLTWRC5Wr6wUjlj/r1pNurMweaD5lahD
         ScwzDxMszuEdmarj8a/iONZ4WrhqT5HzAq2Q8YKzk0lW25NyBriZB/GkNnOJwPkdfHVF
         y86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688740509; x=1691332509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3byNldQYPIXJHmP2gWtnYb97CCpo9o+8rBL4rOGmYI=;
        b=XoBbb8kCxqJMDsVsRTkC4lDfGA0BRFHyzwrHZaQCfW7JaJ0GEVYekPgO52WoSpt9q0
         raFoFNuc+Eh1QoZtNR7I5wFLdVMoShX67uYsPPNI9i+Ie5YGS2nw5hxqKJLOV3HxDJK/
         rhwPzn1krHmtfNUzHB6HmU/P3wEPJJ3hfKONdXtXQwF66re932n3Bnrptz+5t9pSQNcH
         y8ELw0vpNUl1wcBeWh1e8PiKocuxfd14pmU4wOKxjTToMD3jnNtTUkdgcsmcGHh2LlRg
         Pj7GsFSds5yiWhH3E+ccq/fINVgZnYLxcKtbHlxGLvL2gRx97yStAikxUY2uZ2ZjjnWT
         ePIA==
X-Gm-Message-State: ABy/qLYzBnHOLpMMmjHT23ugMHCqcMbd4tnUyLXw+J9EyqHXI2qLqqrJ
        S0TD67ltjB0c6H8fxbIPEw9b6suLIS2zf5N8rxvM
X-Google-Smtp-Source: APBJJlECD+Fxdi9BNOzrpj5Usym5F7Y7TYpZF1e7TZ1QWeJ63Ak8CgJ0g21u5oIhLC4SE/PlJ7VT/jXb2Tha32fhQ6Q=
X-Received: by 2002:a5b:40d:0:b0:c12:29ac:1d3b with SMTP id
 m13-20020a5b040d000000b00c1229ac1d3bmr4758615ybp.11.1688740509290; Fri, 07
 Jul 2023 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com> <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
In-Reply-To: <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 10:34:58 -0400
Message-ID: <CAHC9VhQGWWQgA9DBpq+q4XQerbN0SXAB8RG94G8uMD0-J968xA@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "eparis@parisplace.org" <eparis@parisplace.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "nicolas.bouchinet@clip-os.org" <nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 7, 2023 at 2:49=E2=80=AFAM Roberto Sassu <roberto.sassu@huawei.=
com> wrote:
> > From: Paul Moore [mailto:paul@paul-moore.com]
> > Sent: Friday, July 7, 2023 3:44 AM
> > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Currently, the LSM infrastructure supports only one LSM providing an =
xattr
> > > and EVM calculating the HMAC on that xattr, plus other inode metadata=
.
> > >
> > > Allow all LSMs to provide one or multiple xattrs, by extending the se=
curity
> > > blob reservation mechanism. Introduce the new lbs_xattr_count field o=
f the
> > > lsm_blob_sizes structure, so that each LSM can specify how many xattr=
s it
> > > needs, and the LSM infrastructure knows how many xattr slots it shoul=
d
> > > allocate.
> > >
> > > Modify the inode_init_security hook definition, by passing the full
> > > xattr array allocated in security_inode_init_security(), and the curr=
ent
> > > number of xattr slots in that array filled by LSMs. The first paramet=
er
> > > would allow EVM to access and calculate the HMAC on xattrs supplied b=
y
> > > other LSMs, the second to not leave gaps in the xattr array, when an =
LSM
> > > requested but did not provide xattrs (e.g. if it is not initialized).
> > >
> > > Introduce lsm_get_xattr_slot(), which LSMs can call as many times as =
the
> > > number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > > structure. During each call, lsm_get_xattr_slot() increments the numb=
er of
> > > filled xattrs, so that at the next invocation it returns the next xat=
tr
> > > slot to fill.
> > >
> > > Cleanup security_inode_init_security(). Unify the !initxattrs and
> > > initxattrs case by simply not allocating the new_xattrs array in the
> > > former. Update the documentation to reflect the changes, and fix the
> > > description of the xattr name, as it is not allocated anymore.
> > >
> > > Adapt both SELinux and Smack to use the new definition of the
> > > inode_init_security hook, and to call lsm_get_xattr_slot() to obtain =
and
> > > fill the reserved slots in the xattr array.
> > >
> > > Move the xattr->name assignment after the xattr->value one, so that i=
t is
> > > done only in case of successful memory allocation.
> > >
> > > Finally, change the default return value of the inode_init_security h=
ook
> > > from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > > conventions.
> > >
> > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archli=
nux/
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  6 +--
> > >  include/linux/lsm_hooks.h     | 20 ++++++++++
> > >  security/security.c           | 71 +++++++++++++++++++++++----------=
--
> > >  security/selinux/hooks.c      | 17 +++++----
> > >  security/smack/smack_lsm.c    | 25 ++++++------
> > >  5 files changed, 92 insertions(+), 47 deletions(-)
> >
> > Two *very* small suggestions below, but I can make those during the
> > merge if you are okay with that Roberto?
>
> Hi Paul
>
> yes, sure, I'm ok with them. Please make them during the merge.

Great, I'll queue this up for merging once the merge window closes.
I'll send confirmation once it's done but just a heads-up that things
might be a little delayed next week.

--=20
paul-moore.com
