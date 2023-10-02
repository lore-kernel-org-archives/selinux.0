Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203EE784BF
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjJBQGB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjJBQGA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 12:06:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56693
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 09:05:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4b9e09521so9300557a34.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696262756; x=1696867556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgqGq/Qef2sQHfvhvtCu0UAQbcYPEnyE0cXOqIwV/+4=;
        b=RZM60Ld7LGtSe/naexYpVqUy+w7WJO6FiD+saJMb9mnInxtbiIxlSNzNwi6uCTR55J
         cY6ET8uW0HQNmoB6IoQfbQpsxjFi6kq4FR1O4MYyYfkDHqeKcwniBNFpRznz2cgfuztH
         yixTPbEAc3yxqW8WjDFHll4Yb2erHhgQuKsu8qHdnxviePmCwPSE0wckGW2qUb+eu+eP
         LdCRzBLFNBOvwcCOHTXgMKVmvIlU8w8Np9NYd+vHsLfB4w0DmFvdmYJ5awYYQRjCSgW4
         /zXk8O3fvKhV6OBBNU1MSepxZ36iJygBPcS1T+t09H+qvXIK2hHgclytyupIoLKIThSu
         4d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262756; x=1696867556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgqGq/Qef2sQHfvhvtCu0UAQbcYPEnyE0cXOqIwV/+4=;
        b=jpuF7XmMRGca0zq3COSvrC+dacVjKH37XO060xCHp5d+Ruh7uVv6sUNTAgf3XSTqB4
         CQwhm+2IUXjNO37ufd1xV9Im9nZmaGfElspjZLJAkBNLoISUcIypLW21hmpU1tU1+lAu
         3d9Iwt0dqRrf/oh8wPMB8UQJ+AEfCbQwIXOFm3oGWBC91rL/A1vnXBtinRh8cFn95H6b
         FJ5ZrIQnj/r5gblSlr3sVFoyKciPXVecsIUAVJXT4b/9Or/FAzFAzkSfjEA+kZAHh96T
         Ckom9Ilo3wgMRlDYEg9hNFV7T1umoAGXavJRzRWJNKkIefGmiUthikqFJqsqsMJRW6K8
         OP7Q==
X-Gm-Message-State: AOJu0YzLAL2bjk3tg7wTW4pyI6iTAlV7tbqSSSCQei80gMwjd+PeTtWs
        P/3mBeHQOFYOeYxDOZWsCiaamE580rALShDRPXfqazd3NiU=
X-Google-Smtp-Source: AGHT+IGcbSpgzOzDhgswI+XPCEsgo3/fc5YaRvClnHVfubBoAPc6n2D7YxxEHwj2FLmOHLUeocN51inWsD85R0RG6MM=
X-Received: by 2002:a05:6830:3d17:b0:6c4:cdce:5de8 with SMTP id
 eu23-20020a0568303d1700b006c4cdce5de8mr11766925otb.26.1696262756304; Mon, 02
 Oct 2023 09:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com> <20230929195617.65120-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20230929195617.65120-3-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Oct 2023 12:05:45 -0400
Message-ID: <CAEjxPJ5d=w_AcADCJJgKcHoQiDc3KWmSHmdJb9dmniJgGVsHDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: refactor avtab_node comparisons
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
> In four separate functions within avtab, the same comparison logic is
> used. The only difference is how the result is handled or whether there
> is a unique specifier value to be checked for or used.
>
> Extracting this functionality into the avtab_node_cmp() function unifies
> the comparison logic between searching and insertion and gets rid of
> duplicative code so that the implementation is easier to maintain.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
