Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711DFC433EF
	for <selinux@archiver.kernel.org>; Thu,  5 May 2022 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382464AbiEERvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 May 2022 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380815AbiEERvf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 May 2022 13:51:35 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E92AC70
        for <selinux@vger.kernel.org>; Thu,  5 May 2022 10:47:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so4537879fac.9
        for <selinux@vger.kernel.org>; Thu, 05 May 2022 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rC+LKwlLQp/PS4vroWRtik3Qzbi9imfv4++vcl4r6R4=;
        b=jqHfMNndMdUcNbl1Dr+ZjHTlnyCoP6Tv5/TKz6neHlIAEcpol8hRqk1x6SBczYYSuz
         s3tu8htUOLlzcBbgHz5b8lKXexA6e+hYLwfgv1ENWWTmMgmhuJdz+D3QztiosR2tw8+j
         UYt/rnsZdaJPTUwsgP5gNojzwl9UGpp8EHLWsjR9MIUB3ilLrwdrC3KDD3NogeFKJspL
         /oHlaNz5PAlQpylI4YsCt59xseO0RW5ReB/Ka2khP/ETAxiwkbwCbP77UxNbCnjYRWHs
         3WDhvUlpEBJDNN8hrbhaJ/AUYiEOnYtN2BvqxputKJAuh1DcLEFdn4KI3EcC5GB+NXGg
         0wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rC+LKwlLQp/PS4vroWRtik3Qzbi9imfv4++vcl4r6R4=;
        b=oflQXU60mqvRMbsGLLzFauwzZjNqlnKuaVhPNFbUhC7KYE5gIc4klOKqDP6rE4NyD6
         I4n5FSJbYOMxzjqA83NJAxkHcuPYKlUKELJPfl8/BMZIYZd9nSyXpp8bA1m5juBlkxFk
         JiHPOuKXwBxoLo5YzRkJAU8pIjZ0qQmnjaotFEUwZfmbhcDPM/XfDqtDNMlX+pqY1sQd
         Yy7w0OCqFt5+U/rmeqlPtc1LhZ0ea9G8kIElA/DafuXtN7H75AfIfWaPIKIn6CaPZfGF
         INFOe7uvC2Zw0VpECC76GyspHCqKvIZLOGwUpAn8FGnrIBZYhlw38gBU+xAt7BStQMf2
         dx1g==
X-Gm-Message-State: AOAM532qDgWAnl6Zc0oAcKkP9DVIeXXMeCP8gpKSnFHAq32p5Qq7xqfn
        iYq9frBe2QY8w/qoSc47o0ALGUfm/cizeqqulqw=
X-Google-Smtp-Source: ABdhPJxmVKrmu1sFPcs94Wcdsfv/qOdIxJTJlMkUnudR26r7yvJgvzJc6+WzsxbIBIcah084540uFJqMujbjqH+GeGs=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr2838473oab.71.1651772874834; Thu, 05
 May 2022 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <878rrh877a.fsf@redhat.com>
In-Reply-To: <878rrh877a.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 5 May 2022 19:47:44 +0200
Message-ID: <CAJ2a_Df_p_4Z+oPh--Pp_7wPB82Na4747rqFHwQOUGpZoocE1A@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.4-rc3 release candidate
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 4 May 2022 at 20:48, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> A 3.4-rc3 release candidate for the SELinux userspace is now
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Tarballs are signed with
> https://people.redhat.com/plautrba/plautrba@redhat.com.asc
>
> Please give it a test and let us know if there are any issues.

I think "libselinux: Prevent cached context giving wrong results"[1]
deserves consideration or at least a comment.

[1]: https://patchwork.kernel.org/project/selinux/patch/20220127130741.3194=
0-1-jsegitz@suse.de/

> If there are specific changes that you think should be called out
> in release notes for packagers and users in the final release
> announcement, let us know.
>
> Thanks to all the contributors to this release candidate!
>
> Changes since 3.4-rc2
> ---------------------
> * A new setfiles option [-C] for distinguishing file tree walk errors
>
> * Added missing sandbox translations
>
> Shortlog of changes since the 3.4-rc2 release
> ---------------------------------------------
> Christian G=C3=B6ttsche (1):
>       checkpolicy: mention class name on invalid permission
>
> Laszlo Ersek (5):
>       setfiles: fix up inconsistent indentation
>       setfiles: remove useless assignment and comment (after RHBZ#1926386=
)
>       setfiles: remove useless "iamrestorecon" checks in option parsing
>       selinux_restorecon: introduce SELINUX_RESTORECON_COUNT_ERRORS
>       setfiles: introduce the -C option for distinguishing file tree walk=
 errors
>
> Petr Lautrbach (2):
>       Update missing sandbox translations
>       Update VERSIONs to 3.4-rc3 for release.
>
