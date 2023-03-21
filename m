Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E84FC6FD1D
	for <selinux@archiver.kernel.org>; Tue, 21 Mar 2023 18:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCUSnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCUSnV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Mar 2023 14:43:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BF1D903
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 11:43:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p203so18342585ybb.13
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 11:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679424200;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+GewOz3ZsN2fu59QmkGJQHHnbdFQplKZSTafn2QcWg=;
        b=QzHzPdDw5EbSMo81SoObXFqH+i8mnMQFN3f9EultUli9cJay+T0jlkWPKX26OOzmwW
         Z2XallqvIv+066sHI2Rt82cFntFr8FnC1jWz62N8zuzFirvDRwM9jywdlQyzoZck3dFL
         PiqHtM1wF7W8KMNXe0kzo87UJS+3bE7YCVb84kVn5RQSDYvmqtRoPFDLCVKqMnXf0bI9
         bC9vdLSCcQyjcTi5I/kvkpBbwH2FmC2AzRNvRDqZdtbUt9mb87y07YuVQvOBFnAWBWDu
         Et6IL7Qbx297pAB7440onfJP6uWFvYHQXjr/6QhL5jeTrXgIrz/oXuLSTIpnozzmlpte
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424200;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+GewOz3ZsN2fu59QmkGJQHHnbdFQplKZSTafn2QcWg=;
        b=FMYiyWJI3Fa5SoIFg2U/uwgodOG/Wg3TSoB76Nd61P8rtnT2MO+Wpv9waKL3cX/Dpz
         bxe2ECUH+XuiAkdIZTo1qWIl+QBKMadrlf3xcuNv70k08OBSrhf3/qTb+1wl9ewkKhqG
         SKFLP62vgbBd/w4Mp54zrCUfe/IS+qacl32XiaPEi+RfypjmB+FNbX8dFTfqYPF/KVbm
         yFLXlKcrVU7wZWVEaXKwqS7eZzSFNmUmjpiFyaSx2JrQ2fe/zS6vTbKJS2q0GikH61Rw
         lRVfCYYv6eOt9FQD+OozIspmhTnqvxgtHsRhqdQoSu5Q8XzOXoUmB+mAPgsPvsIQoTOH
         nZOA==
X-Gm-Message-State: AAQBX9eGep6GcGsEem7UyWejmV/fLMKFVfFxHsPylRiH1qe/nVOKzbBs
        tZ8SFYLQWMZg0B/aLwAN2NnXKAsW68xxlB7pvnfmbY/gObFZF0Q=
X-Google-Smtp-Source: AKy350aNj3W9bQrQnO2vcNQ+sZSfmTRNQFhr8bFy0bUK6agFSfAVFak2AsfZiPT+bP878R7jZOjmYxBHnuKA4zyMOEk=
X-Received: by 2002:a05:6902:722:b0:b68:7a4a:5258 with SMTP id
 l2-20020a056902072200b00b687a4a5258mr2323922ybt.3.1679424199785; Tue, 21 Mar
 2023 11:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230321184043.119340-1-paul@paul-moore.com>
In-Reply-To: <20230321184043.119340-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Mar 2023 14:43:09 -0400
Message-ID: <CAHC9VhR0dde0HnmbraJ50Y+Fz-i7vAZDWx8SVzu8FLRh9nN_Nw@mail.gmail.com>
Subject: Re: [PATCH] selinux: update the file list in MAINTAINERS
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 21, 2023 at 2:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> When we removed the checkreqprot and runtime-disable functionality we
> also moved the deprecations notices from Documentation/ABI/obsolete
> to Documentation/ABI/removed but unfortunately forgot to update the
> associated entries in the MAINTAINERS file.  This patch corrects that
> problem.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303212204.3G5mRatJ-lkp@int=
el.com
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Since this patch was trivial I've gone ahead and merged it into selinux/nex=
t.

--=20
paul-moore.com
