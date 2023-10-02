Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE28E743C3
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbjJBQFV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjJBQFU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 12:05:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8CB8E
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 09:05:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4a25f6390so9734364a34.2
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696262718; x=1696867518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT3yPArnqljknYomrGyRnrNut0OXy3hVY9z4XZJjBlI=;
        b=WVDuIsH24lxFZh8MqmKek28THrjLASPWs726zxDqRz2KZqu/TAR369Cm3JtBPZ5IJx
         IofbN2Dod2jyM78hPO++9QEB3xC5S9G2g4E96By2gC9uXeZqN8FDtmxlS3iNC6MH/Aq4
         SylOjIkaZ/veK8nlPoC6V67XEsepqFN6pufWkm1NOxauYNR+dALlp9FXG1Pd/s+YvUQI
         f88i8W5vzMXrtyDKekJJa5zEGmMnzQsRdzGRi1KIdFgYCAdh/hoFqRoSxMoi3w6LyPf8
         AkLDtpROHwb312msTbo8UNm278IU80BE/4+6YH7DGwSOucGoZBnJVo6ydrYXmHGxYpwX
         JKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262718; x=1696867518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT3yPArnqljknYomrGyRnrNut0OXy3hVY9z4XZJjBlI=;
        b=HRR5DrX/jOaJiiylIF3Larkj4mT7im+cgCUauX+BzBPSsrNJF6R5udqjt6MgkjT7Bs
         RzYRUBHMK2PV9JpYNvlODJjev17yqNxp7ogEqTYs/9fHiG7DmKoy6whL71eYe0Wx0a0l
         zH6rtfV2bfAjdEKW+oxa7sTOb0cZqk2TAOo5fpB5mRdGWkP9YUcK8+c2QypVcM7K3pKj
         DqW4/yfmn3FFQomIzvcNu/FpRSaa95tS5sl9DvXUf+rfZQ7uldmewlhHMAmNwi60mLMO
         apwxpe471DNIentsfRk4MssCP2O+Qof8CS2eG191haUOQe6UnQN+R1mrzYKCMGUK/kyp
         0rbw==
X-Gm-Message-State: AOJu0YxNi/xC43GTDnlibbaplfwWzDP60ueXzCoqVCP22mVqzsPhFQ8p
        PKElaq/ID6X9Yqq7OQroUryvYiGpya64a5hEcmJqtDW7
X-Google-Smtp-Source: AGHT+IEeFEFXCVTgehJoAzyK7synx/HDAjUDtuiuhLsFD4W+MkQcNxEj6dAdnf66v4wunucIDJx400TukZ2S6nET0II=
X-Received: by 2002:a05:6830:1259:b0:6c4:fc6d:88fb with SMTP id
 s25-20020a056830125900b006c4fc6d88fbmr12223683otp.33.1696262717726; Mon, 02
 Oct 2023 09:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com> <20230929195617.65120-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20230929195617.65120-2-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Oct 2023 12:05:06 -0400
Message-ID: <CAEjxPJ7fZFN+MMnF9pbz7+cXcJKR8J9W60T8MceR=PQW=kzAVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] selinux: simplify avtab_insert_node() prototype
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 29, 2023 at 3:56=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> __hashtab_insert() in hashtab.h has a cleaner interface that allows the
> caller to specify the chain node location that the new node is being
> inserted into so that it can update the node that currently occupies it.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
