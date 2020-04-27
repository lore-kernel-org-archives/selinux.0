Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7920BC4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6ED206D9
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QWTukSf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD0UJn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0UJm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:09:42 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121EC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:09:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 36so14811726uaf.9
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1PozxmtFNC4HPpmNAZs/silepGarptlge/nYJ2VVOjc=;
        b=QWTukSf/BTP17U6u8a7P9VUYNuB1q519BbVUe6FYGFGOcS/+Sxhrhaj/SEWLhHXRgh
         NhdZKy5snqjR5uBmFe6OjKrQ2O0inHiSxs3CdIe7fCmTwwrOzg/MIYIk+Hcin3Ja31yx
         DiOlKT4/LHv6g7f0cqwtNDlQ4dhx1jrUWVfNOydAAPMQcPP/ZT/BHyzN/9OByu1JC3Li
         /J0jdUsl1VSipIJJ3tIeFDpei0EimXp5OWNOHU0w18tQzWnKtLZQPYEGaX1Utm4q7sOx
         8pegWOBFknbJqMk+cvVLXK+07YZpv+ojLznNi1jFZnK+hdIIcKkaDdCLz33WVMEBheqE
         gj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1PozxmtFNC4HPpmNAZs/silepGarptlge/nYJ2VVOjc=;
        b=swOI1FW7CcQI4L/Q9x8y6Amlb27gqthrapxVufqKgHpzG+/ZXGz7sVejnUPrAwPTMV
         pKsHYd/QwZ1UdpGvudTplIVn/gorTn/pJynm0s0M0qwjlQvNw2W3h8vwznpBSGL83LIN
         zFT4zxcNesoXU2lBXUK0Bi1gw8dHQ1RB0zIoQrhtWKkXN8hLsqVda43RmHUw689e4mPu
         p24Fw9D1etCuw2Ly9Eqw/dr7W3up6HRqvKT4m2jcbGVw005tG64A1Piywx9zBnnsOhcr
         z1AxX7lHW/XB2EU19WUQjJ7eUI7JkIs6kAanXZ3yMNcg6k0GBSEul3ewb23A70pdQS5d
         +zbg==
X-Gm-Message-State: AGi0PuZLIVT88YHdJ6nToKgkmLUDZekUQrkUfA96AGImEhn0ml3LoBmF
        v+r3rH6zy2KCIyGJhXthSt4Ig1Kh5GD3qj6Zxh4=
X-Google-Smtp-Source: APiQypLc+Cz9duQ5BVKvZdukupIUkqE5dtZpvc1Qzp3nzUVX03QNIfSqR3PNIRdqqFAFufgZ1qeR2PnfM9x7/LiDD/o=
X-Received: by 2002:a05:6102:a0c:: with SMTP id t12mr5263450vsa.144.1588018181884;
 Mon, 27 Apr 2020 13:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200420114650.19093-1-cgzones@googlemail.com> <CAJfZ7=ky1rwB3jDMEdXjqSL=Vctut_2Cc6gsj475Et_nLo7B4A@mail.gmail.com>
In-Reply-To: <CAJfZ7=ky1rwB3jDMEdXjqSL=Vctut_2Cc6gsj475Et_nLo7B4A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 27 Apr 2020 22:09:30 +0200
Message-ID: <CAJ2a_Deu8VTHQCpc_k1Nn__Kh+oL2NV3CUp3-t4rd9CkeLr9Pw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: mark security_context_t typedef as deprecated
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am So., 26. Apr. 2020 um 20:14 Uhr schrieb Nicolas Iooss
<nicolas.iooss@m4x.org>:
>
> On Mon, Apr 20, 2020 at 1:47 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of sec=
urity_context_t and fix const declarations.")
> >
> > Use a wrapper macro, because swig does not accept typedef attributes.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody raises an objection, I will merge the patch tomorrow.

Maybe this should be delayed after the deprecation patch series from
William Roberts to match the same style;
e.g. this patch uses a helper macro.

I'll prepare an updated patch.
