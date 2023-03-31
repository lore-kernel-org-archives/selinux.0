Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3EC76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 13:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjCaNW2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjCaNW2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 09:22:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0961A46E
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 06:22:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t10so89367694edd.12
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680268945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFsKj+Gkbgv5Eh63ZzYcKLH/Q/JfYKfBgm22VrKZeWw=;
        b=EBIkdcxHDjJorh7lZ9NeSbxcJKEbAxlmXROpTVZCAaJfZNT0ngM8gPM/uKfUg07iVo
         3FVuA1MEPB7HXf6RdbC7i0LkyBGS6cW/cBEeMHGRyAWQw9Ht8ki6owE2+q+HE7icwPhp
         Q0mb8NXoHmobG7ffeEWmryVWITxc79PY6jm0n4fWqmnxIlwc3o4972LE34YuYSQbeQK4
         TdvEIH4ZlEpB066c0+xFOfaluVgwTQPAhU5X5giNLjTgw6ob9RVMMZNJAuV4lgOUdFlV
         UrpQ4RwkbCvM7xwlKhdnCJdO6S0Yls1ww9bkFy+72TQYvoy2qsJF3m9fhwc3nFKzyJvd
         Yc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680268945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFsKj+Gkbgv5Eh63ZzYcKLH/Q/JfYKfBgm22VrKZeWw=;
        b=R9kAVKbe9ej/AxSDP1n5Xsqf4jXcb832UIUPmbY6aLOzheMwBnmFYgu4E94mGqNKX2
         XmiJ4XQNlEfceLuw8xO92plb5mjFkepOicTkIJNK7OAkkcUlKUX1/BXF+IlqsB9YD3iY
         qGCZ5zzBwsjV1TWThPu+9VnCrbdMUFs5V01DA6EDM/sXCsSRezuHjsIAU+eo00OvYFPw
         e5aRiPFguN9tfztx2ERB9n6FWQfKfYJQwDT0MT2ZmvqfgkmU+3rmBqox0RbiLJQNhYND
         9GhELKfjQ/MnQauKFfnAhh4uJsSghGsHgDFt/eLdjqHFL9Nf6fUTN4Vpua2VVXElqcu1
         agnA==
X-Gm-Message-State: AAQBX9cP6mTJZXxp83E3vbTUwbUJScin3m10V65EXEazhfofLstR671X
        ybCgubV2NmVYDBo1aj6AUEamfATWIa4L+wmeMkk=
X-Google-Smtp-Source: AKy350YmUSKB3S+AiCSVwHyhEMWrXQp7d5lLFx3+PkMojNAHDtdurRbHGRN852n7bIKkI8xzQMuMKG8h9OgOv+IOJgA=
X-Received: by 2002:a50:8d12:0:b0:4af:70a5:5609 with SMTP id
 s18-20020a508d12000000b004af70a55609mr5143075eds.1.1680268945167; Fri, 31 Mar
 2023 06:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
In-Reply-To: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 31 Mar 2023 09:22:13 -0400
Message-ID: <CAP+JOzR_nL0Y12hOU2gTU6=U+J4YaZsyE6TLMQWFSUi0dJ3NCA@mail.gmail.com>
Subject: Re: Possible bug in policy compilation
To:     Jonathan Strauss <john@pleasantsmoke.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 9:14=E2=80=AFAM Jonathan Strauss <john@pleasantsmok=
e.com> wrote:
>
> I'm not sure if this is the right place to post this, I was writing a
> policy for an API gateway and couldn't figure out why I wasn't getting
> a domain transition. Turns out I was missing `type init_t;` in my
> require block in the type enforcement file, but the compiler did not
> complain about the missing type.
>
> This was in stark contrast to the policy I wrote for a JVM application
> (JVM apparently needs the world + dog to operate) using audit2allow and
> forgetting to put the proper type requirements in the require block.
>
> Seems like it should have failed with the missing `type init_t;`
>

It is hard to say what is going on without seeing the policy you were
trying to compile. Are you able to share it?
Jim


> OS: Alma 9.1
> Kernel version: 5.14.0-162.18.1.el9_1.x86_64
>
> libseccomp.x86_64, 2.5.2-2.el9
> libselinux.x86_64, 3.4-3.el9
> libselinux-utils.x86_64, 3.4-3.el9
> libsemanage.x86_64, 3.4-2.el9
> libsepol.x86_64, 3.4-1.1.el9
> selinux-policy.noarch, 34.1.43-1.el9_1.2
> selinux-policy-devel.noarch, 34.1.43-1.el9_1.2
> selinux-policy-targeted.noarch, 34.1.43-1.el9_1.2
> setools.x86_64, 4.4.0-5.el9
> setools-console.x86_64, 4.4.0-5.el9
>
>
> - Jonathan Strauss
