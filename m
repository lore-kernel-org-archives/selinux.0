Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E5ECAAD4
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiH3VEw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiH3VEw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 17:04:52 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75BA1BA
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 14:04:50 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11edd61a9edso13731362fac.5
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=vhplHiofN1IwDs+sPIAVXi1uUH/q8bkxHPA+4MeuY6w=;
        b=rx6STPbUMXOjJIkpPmYFzYBv/zqYhXUEdfrB6LuyHYoBbf3T/Gr0ZH5BgFZbl4C6zu
         sa8QVfciMeSp2ItILMkdzkPoz3hkE3CMX80Tbu0oF/AkiX1l48AjQvvfu97kbqKC1EP8
         B7F5edsosTU4gu5LnQGSlCii3iSTehQr1VRgJS4jCUqXHyA4ZVtLRw60chbW2YYoXwL7
         8vq1vmSHND8w+RyUQU2Icxoc+lTCcuNZBoJUQGqZUy+cryNcEqpiHejBdo58t71eNR1X
         6xONRKOcU2KgR67IVjHqgCdwMOcF4VCM8ZgqUxNgivmULN5QO9Y92Nf/7i+ux0xK/eNI
         YlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vhplHiofN1IwDs+sPIAVXi1uUH/q8bkxHPA+4MeuY6w=;
        b=6UlNiTcHtaVbFUQlJZZ9pFI/w2cDExTmU88sdP03rhuZBfDlxv0v24IF0rRGEly4Ik
         frMavEazMMbSfdskRc/aZRJItnRrjk3T8vHnhtC6QRNWPWUiLfe4ew0ulvWG7ug3rpSu
         LWnSWF5z2nndxafqzoM/Oes19BcL9/xTKqOjhHmLyLJGixv0/Z0dT8MgZjtK63B7iRhm
         p+euK9G0juUp7mX19M1gcOslvEcJaOMCDqtr/BBit88GN5CJEARyWHwWZILyZ5i/ZfbE
         KmXLb9fDJ/XdW1QvlWpQO/UjeyCv8CCunhGLJXuY4lXx1n0cOoW8EejwkWkBVpRDf0ym
         ZZ0A==
X-Gm-Message-State: ACgBeo2jqqf4nrH3b8vRaoTxuc/hK2axiUmpjfkTgfiyT+aBzk7FugX+
        shBXFMI4Y8a7IPeh3s9oA3lszSG8DA0CXgfW23DZ
X-Google-Smtp-Source: AA6agR6CdgbXULQ7dGtNu5GDf9fktFU8ysMzqSs4r3qAn4FCoK9GqEenVLzT8tm2ugfY1EenJehJS1YSnVi9Z/NQ6bI=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr44936oie.41.1661893489715; Tue, 30 Aug
 2022 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220830154500.18165-1-cgzones@googlemail.com>
In-Reply-To: <20220830154500.18165-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 17:04:38 -0400
Message-ID: <CAHC9VhTe92h-FR0GOepVrPqWwOgKLPV6NcXxi4sRpAjEbPkt5w@mail.gmail.com>
Subject: Re: [PATCH] selinux: use int arrays for boolean values
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 11:45 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not cast pointers of signed integers to pointers of unsigned integers
> and vice versa.
>
> It should currently not be an issue since they hold SELinux boolean
> values which should only contain either 0's or 1's, which should have
> the same representation.
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1485:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1485:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1485:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1402:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1402:48:    expected int *values
>     security/selinux/selinuxfs.c:1402:48:    got unsigned int *bool_pendi=
ng_values
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> Previous patch proposal: https://patchwork.kernel.org/project/selinux/pat=
ch/20220502135907.31035-1-cgzones@googlemail.com/
> ---
>  security/selinux/selinuxfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
