Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA9AC433F5
	for <selinux@archiver.kernel.org>; Thu, 17 Mar 2022 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiCQSCD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiCQSCC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Mar 2022 14:02:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238021C076
        for <selinux@vger.kernel.org>; Thu, 17 Mar 2022 11:00:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so12482725ejb.0
        for <selinux@vger.kernel.org>; Thu, 17 Mar 2022 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqOTgbn5JoS8GUzPPnDeVdofJ2XZDkdckHrFx34HH8g=;
        b=JqPXAusWWWVZrTXd6BrSnTF0q0Tx3D0t9T0aEsf0DerIYnQyvUhstKJIOSTN+J+3w1
         OBdQVst0p93XZ2OVU5iTwa7BNExF6W4z8Cs0VrRvQMW6l0BS/pDvlc0r+KyV6IGBVsbL
         tPs8219Mho3dyn25D+y2ymAaU9zOgJdRYiReTo/+WWJcFv0cofCxRrMxKeRVrWeYc/Zw
         YaLe9yrHTmvWnn+HNMv2tlCAqTQMkxqi930v/w1GsZ6DQREqZHorL3pnm7DZiFh1tEdH
         u1TmeP2tMz7tQVqD201iOclyF7NsfalqjPx/fXUo8rdqm5krKH0gRSZr8VpNAm+L+j70
         Ip5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqOTgbn5JoS8GUzPPnDeVdofJ2XZDkdckHrFx34HH8g=;
        b=vtq/IvoYGxd78faiUbEECD+t3Tgoc/dKCSjCYwtijkx9fRgnY84wXRd5Q1U9gGByVP
         VPIYxX+avRRYPfPybNpiaoXm7ANc5LKY9CCHH11JyP+Nni++M+0Ju2O85RCRK+teVouU
         CjaF5ZJ0p3GsTOXjD+5qcufsbHqKNvP6igM+ixIBB36Rf9eoq7JybSuWAK15L5xPWRtg
         mrrfbQKNFHZNz9kqNc96oGNq4vvAIDoMZtYj/G41KaiKAN2XibzWIKuYrMMrk/qd66Fs
         svyu0V1Ls0xS4VSE3FKxmMylroTpOqQV6i7RC4ePY7mM3v8NpH8Y2VbxVsuCJwhBLwpc
         dViw==
X-Gm-Message-State: AOAM533LYBS6fGc4vkTFhdupcgdfMhGfZSngVzJ5/8X8NL4ycukVYWlH
        b4SBtoTehZY1FI7KoSuva1RTtk6yV+9PYk9YsGnRGadK8g==
X-Google-Smtp-Source: ABdhPJzwS4WbiwzB1Kal8oosolk0Czm5fTWkeCJceb4xgn2Cnu7k5PTEMqVauhqz1HP/ND2nfMGLUXAmsEo4OQEHkbY=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr5411060ejc.112.1647540043024; Thu, 17
 Mar 2022 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <9dd0a3d6-26b0-4689-ee28-ff8cb8af4d46@linux.microsoft.com>
In-Reply-To: <9dd0a3d6-26b0-4689-ee28-ff8cb8af4d46@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Mar 2022 14:00:33 -0400
Message-ID: <CAHC9VhTL67DNKdj9K-bY+ToXnDu1B0bxWG++V=JWGwJVzR72mg@mail.gmail.com>
Subject: Re: Pwnkit and SELinux
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 17, 2022 at 12:07 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Some on this list may in interested in this blog post I wrote up to
> discuss the ability of SELinux to mitigate against a recent high profile
> security vulnerability (CVE-2021-4043/pwnkit):
>
> https://dburgener.github.io/2022/03/16/pwnkit-and-selinux.html

Thanks Daniel, I *really* like seeing stories like this where SELinux
helps prevent exploited vulnerabilities from doing serious harm.

-- 
paul-moore.com
