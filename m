Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC48C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDDB218D3
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPFHHgru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfBRD5q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:57:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32813 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfBRD5q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 22:57:46 -0500
Received: by mail-vk1-f193.google.com with SMTP id l62so1223998vkh.0
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=lPFHHgruNQsGLwdT6TH5+K5HkaAvs54hgg8I+9lpT8zJJT90R+8fGdQhpnSnLdoT/1
         /zu/zyHI3Oqk8te3MqN0NvqNRNOFQVN8eM0Z03NZ62Uq5DZ7cuCZg6PzAXI2L+6bAd6c
         +pi/uIn8MrUihRld/jD2bcWL1eBT1XuclwbFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=MflZUvMxfXm42ttHSn+T2IqVUmavbS2Qy90lVoVyaq7QM33WaREAIeIB/bnLY8hrrG
         r0OWNVpeAQL/Vx9I2nkiLyan2kpCiw319l/4yUVV+UvYAyhfQrrrq5KLP92tn9xZBIoA
         NqYJtkDWiY0GDXqSkYVNAN6uLdn8T1+4xruO0xNSdpon41/iQ52y2/ZYdVtmktNsNVkN
         B0286E11jcFV7RsFoCg+IUyIvd0seY9V6BjvCprgGMRQ9zOBU4ZdArdkfoWeXqgXFoLI
         NxvSWGrWoPG+KDlHboKiXXY2KVYneRK1B9aF9//FhWjAJKdfz6TLrHFPTruVoKIvT41r
         ZH5g==
X-Gm-Message-State: AHQUAuaxYTvTkoDXP7TIXGCXfuc4zLp5SIg4HOtOH0E0OvNfQforBfji
        U5ewaQhLYFMFdM1zLaeI19owBVflyuE=
X-Google-Smtp-Source: AHgI3IaKr1mlLFCLi4+ftXqLhJP80p43x/uURArWNkzossl8Qg1pg/8QnEzPqqhq4xq4qzf4KmnkYA==
X-Received: by 2002:a1f:30c6:: with SMTP id w189mr2971987vkw.57.1550462264780;
        Sun, 17 Feb 2019 19:57:44 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id j28sm1031398vsl.10.2019.02.17.19.57.42
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:57:43 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id e10so8884654vsp.1
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 19:57:42 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr10275404vsc.222.1550462262332;
 Sun, 17 Feb 2019 19:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212182318.GA16669@beast> <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
 <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp> <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
In-Reply-To: <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 19:57:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        SELinux <selinux@vger.kernel.org>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 17, 2019 at 6:46 PM Paul Moore <paul@paul-moore.com> wrote:
> My main concern is that "selinux={0|1}" continues to work as it has
> for years.  It doesn't look like this affects that, but I can't say
> I've dug into these changes very far.

Yup, no worries; it does. :)

-- 
Kees Cook
