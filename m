Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB703C4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjKCSXD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKCSXD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:23:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646C1B9
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:23:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1905762a12.1
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699035780; x=1699640580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd1e89sazM76jBsGJEXEtZz4dDzGegI9rFgaCYn5rbI=;
        b=FR3yuDOoH4q0NtVbbNPw+N6Dx+f1mskn+gkgYLDrlrVbilz5CSjkXWM+BXb5exI88E
         U6oZz9S+WNFN1ug8JhTNZyolnchvMYSXe/w+kHYUONf7vOH+Grn0VLoGaiCR1kpSCYnK
         ++XF38PF8pr6vds/j4q5T1gLgrFob6/Nv5fWUbr+OXxx+2NJKBJRFrMnNKZDLw9bQYp0
         azicyzXd74INlmj4rZM1YoE2nI3PwcDXjgtr4obPsehOh9FCd7Hk5p0r4jhbZzRpvbjS
         FqDG2mMkUTe00OaVP0yKFsrkpLUWlqTPdxrweToBLNCnEvmE4U+TSs5yKojuv1o3OM/i
         S3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035780; x=1699640580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd1e89sazM76jBsGJEXEtZz4dDzGegI9rFgaCYn5rbI=;
        b=nWjELdY/T/+oICur850w6cfIU0FnepWetBSI8fzNKp9HZzzGrWqeDqCvJJPhYRRMxS
         Bpn9aIKTEhjImuwOp8JXia80hm9cXUJW4UtcqY9ESOaOcSTRDFFm9M1FphTfK4po6GWK
         19mVAb73ccRt2gKXPLNYtHfknzKTs21UtzytyyWMakxolIVfzhowNXV9jC8y4tnUjNV5
         NHdleDTW5xfSBx33W4SkCLXHKr8+E5Xd+q0Rqhb5o1SFiEmveanQWzkGH0SLccBLAbBI
         +PTStLzL0V5cVbjOgSWmLOFeVkL61bW2EkN/0Mj7oJMXwfU2TQBOxSfciXM10MKvDFqC
         BFYw==
X-Gm-Message-State: AOJu0YxMaN1xuKhp0sBcze/H0YQul/0o7ZJzpxNNvJ/eHgE+PJrRqn6e
        Y0u/Jc3QdpTNn93CJ0XLf5eanYv8nr2XX0+kQoI=
X-Google-Smtp-Source: AGHT+IFcmvJKAEc+nLiitTLbXXIDu0fyi5z9DLb3ClU2DzKTbA8zTktrrsCPT7BXSVjfR0aXIfHtXsgwkCabgKmQzd0=
X-Received: by 2002:a05:6a20:12d2:b0:17c:cd46:73d with SMTP id
 v18-20020a056a2012d200b0017ccd46073dmr22288067pzg.20.1699035780011; Fri, 03
 Nov 2023 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231103172953.24667-1-jsatterfield.linux@gmail.com> <20231103172953.24667-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 3 Nov 2023 14:22:48 -0400
Message-ID: <CAEjxPJ5R=hZWTzo4bp02=BNZNs3DgndO2wAj289J8ki=KsCfRQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 1:30=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> Due to how conditional rules are written in the binary policy, the
> code responsible for loading does not know how many conditional rules
> there are before creating the avtab structure. Instead, it uses the
> number of elements in the non-conditional avtab as a hint and allocates
> the hash table based on it. In the refpolicy and default Fedora policy,
> the actual sizes of these tables are not similar (~85k vs ~10k) thereby
> creating more slots than needed and resulting in wasted memory.
>
> This patch introduces a two-pass algorithm to calculate the conditional
> rule count before allocating the avtab nodes array. Albeit with a slight
> performance penalty in reading a portion of the binary policy twice,
> this causes the number of hash slots for the conditional array to become
> 4096 instead of 32768. At 8-bytes per slot on 64-bit architectures, this
> results in a net savings of 224 KB of heap memory.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
