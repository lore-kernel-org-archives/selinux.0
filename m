Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43957C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12084206C3
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRAqhihO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGIOdk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGIOdk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 10:33:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE64C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 07:33:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a6so2163251ilq.13
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TBO0rtVbxrVhTg8fRjBOqrHt0W80VfHhG2EIkJRoKoQ=;
        b=hRAqhihONOOvLi4xEcGIJD2V5UhYNW90hS6wZAzTK6CirSgPGVAEl5KRLTIOcAOcqd
         ieHDreETWa71bxiC0JHqc6bG4X3S/IvvMTbRB8riLxP6R3g8sO8GmmL4bL6XnYR+yOq8
         tyGaae0tX/Qrr+fNE7xyy+vTmgjkvTVTSJo9Uqs+OPwHD1snaP6+iofbFAzuua0qmDA0
         H+jqIcyxohudJOpThSusmOQNqRG7nGxx0mPmVwNt/rdfrql3qMTfgnhhBaexhdtdGAZX
         01D/vGbTtiikRg+bJMpU0Nx/zTtXhZjjXOZ/FAUEK53jhqdq63ioe1SzlcSlf8y/zljJ
         ofMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TBO0rtVbxrVhTg8fRjBOqrHt0W80VfHhG2EIkJRoKoQ=;
        b=n5y4CklJeJIRSDZFhVLfxMUAc/w4BWPca/G6+6ZZpcZ82pUGglhHv+Kg6PKoOYVAkZ
         FNTp9iuWrstsstRBVLLrTSROScEXKFUuGCOsHzvKiLL5C9eHKRJvrOqTDxDaVRRJskFn
         Gy4UtJWW8C5PnChM51twNqOmOGyTpS1sLDkSNxpef9SkhQNdMiXN3x2yZz8vwhE5G9Yr
         +/SFoABX+VN0XVnVxUuk77WnT6Sf8FcXED21eAhGhlFGOahsSDHOdZcOiOWlcXv+1Bih
         dAZmcxG0KXqzAZErueXJqs5h/4tgqGp8jVlTeNuQtD1Jf1RaJHu2lShCjWdKfU7sRiWi
         amdQ==
X-Gm-Message-State: AOAM532AwHGKOiw7wUiAeOIDzskzlGOh/I15aXZCYesNpp+lwo4/2RwW
        QpzfdQ0KyugNIeEN5vPUynnTeWgo7AL4TV3q0x6TBv9fCsI=
X-Google-Smtp-Source: ABdhPJxDFkhoSZObROPlLzNwWJ8g/8FB8pA/yuffxdOGolTKUteISZLu2kSFhCQcZtZBg1cG8VSUBUXpqp+uQuQAyi4=
X-Received: by 2002:a92:840b:: with SMTP id l11mr42910581ild.129.1594305219614;
 Thu, 09 Jul 2020 07:33:39 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 9 Jul 2020 09:33:28 -0500
Message-ID: <CAFftDdpDN+8c2hQ+OoX8z+Fx3s-7-g2sn7ZV+Y=D=NZqqFwr6Q@mail.gmail.com>
Subject: travis: any reason we have keep going on make commands
To:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

So Nicolas initially created our travis script in commit c9adfe2d2653
and has -k, or keep going, on the make commands. This causes make to
plow ahead and bury the errors in the logs. Stephen noticed this the
other day, and we have been chatting about it out of band and wanted
to pull in the community.

Are their compelling reasons for keeping this behavior? I am also
concerned that we could get false positives on travis success results.
