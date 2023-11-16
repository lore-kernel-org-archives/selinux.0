Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498FC47071
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 18:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjKPSmF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345439AbjKPSmD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 13:42:03 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B7D4A
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-daead9cde1eso1134444276.2
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700160119; x=1700764919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=FiKuO3OLOxYWZbRS088GinMafw6uUbhXXcBbEO20j/tWQcRp1dAjcGC0q3VWHbhB8V
         IgOhkXjX93b/sNUO11ZBFkEvwNedL7qnxmRNq8+Lmtak4Wd6vU5oIh1nxChlzyB+777c
         KI1VVHgBL/FMURxjzqKp3C3+hk9kEhvXW3AiIvxLuE5pB6IqQK8J94ziLaRyh7TlZwcy
         XEXAeZJLLmUmWPxXxIxvhKJoYOJqX6l4aSIxzHCYGROeaNIN00/61kWhXRRKenbdbhvr
         SbI7Ogm+/7Ecr9H04YvmeQ1LocZQhDT8hDsVbn9v+TBniRbj7i1FKZU+ECrpXWudRxPr
         7wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160119; x=1700764919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8WEQSBjc/MfcmSAT4ejxWpUPPmu2uF4kQuqYIUxqKA=;
        b=IOSrrtUD8ok7lSxbxWjOY3M/UtiE1VRdOHiE7N8z6s7Z0PJmAah4nddx8RDPqk6WiG
         JqWlp8g+e1RhBRUXTiyai6v0bFz9vusjWPgC98C8qlRJ0jreT8QINQ4yOvMeJDIMrhGG
         Kf7KRm6jCSXNppy2XQ4tUczJlnFpujF82dN4kM7sqnpW3EcBXNF76QGCYVG7R80fjp0I
         I6bqTaFk2Bw0xZKMBapdFcyEAoX+7kFKsJvwk7TCBW61dzuUi769HNLrSgRQfgj5M9Of
         utfBBTDfT3+KmRlOiHkOHu9x3YO9MypSto4S/K0VdfjEZFIVOiVHnGPjFET9XXHT9udS
         fCUw==
X-Gm-Message-State: AOJu0YzLCT58YUMjQGoQEECOKIzC0fyIUfX+qd1yOYik+Rbjb058aB6p
        U35fslYb1TonUhYTmcIFVfhYT7xzFZzQhst2QTf5
X-Google-Smtp-Source: AGHT+IFrNERH99etoRYFFGcfGckM9eZr5jAdvP3Cqsg4T2YPSq7MZRtVHGkbsnW80wNaWxVnmZXI59XcmNXo2maxlb0=
X-Received: by 2002:a25:7688:0:b0:d9b:e043:96fa with SMTP id
 r130-20020a257688000000b00d9be04396famr15091479ybc.22.1700160118675; Thu, 16
 Nov 2023 10:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20231107134012.682009-14-roberto.sassu@huaweicloud.com>
 <4f8c441e02222f063242adfbf4d733e1.paul@paul-moore.com> <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
In-Reply-To: <5a7a675238c2e29d02ae23f0ec0e1569415eb89e.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 13:41:47 -0500
Message-ID: <CAHC9VhR29VEybYHsx65E=-YYNLuLHOVm6BF2H==bEcrcHU7Ksg@mail.gmail.com>
Subject: Re: [PATCH v5 13/23] security: Introduce file_pre_free_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 16, 2023 at 4:47=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > In preparation for moving IMA and EVM to the LSM infrastructure, intr=
oduce
> > > the file_pre_free_security hook.
> > >
> > > IMA calculates at file close the new digest of the file content and w=
rites
> > > it to security.ima, so that appraisal at next file access succeeds.
> > >
> > > LSMs could also take some action before the last reference of a file =
is
> > > released.
> > >
> > > The new hook cannot return an error and cannot cause the operation to=
 be
> > > reverted.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  fs/file_table.c               |  1 +
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  4 ++++
> > >  security/security.c           | 11 +++++++++++
> > >  4 files changed, 17 insertions(+)
> > >
> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index de4a2915bfd4..64ed74555e64 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -385,6 +385,7 @@ static void __fput(struct file *file)
> > >     eventpoll_release(file);
> > >     locks_remove_file(file);
> > >
> > > +   security_file_pre_free(file);
> >
> > I worry that security_file_pre_free() is a misleading name as "free"
> > tends to imply memory management tasks, which isn't the main focus of
> > this hook.  What do you think of security_file_release() or
> > security_file_put() instead?
>
> security_file_release() would be fine for me.

Okay, assuming no objections for anyone else let's go with that.
Thanks for indulging my naming nitpick :)

--=20
paul-moore.com
