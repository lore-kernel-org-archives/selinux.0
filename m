Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF14C5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9238C2084C
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VobnE/PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKGQ1G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:27:06 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:33788 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQ1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 11:27:05 -0500
Received: by mail-vs1-f42.google.com with SMTP id c25so1701488vsp.0
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FEA0D0NmarT7tUgLdsOaYqwEoxubXch8vLkkSaZiwgA=;
        b=VobnE/PMyoZrDg9xPZ7BXs5E+7GlwCv6vRIqUlpLkVR7Us0Jj2kH1k3+yLDO2+ozal
         oUECQwbe3Pja/cf9c8th0vCVVUppBfEi0kfiQdmz0WF7eLKd0rlOlpuv8JkQQLr2CNrY
         Fj6oxHCTVSkqkriwLuHKyCgADgkcANpSsFsviMgFaAuAIAcNu2294leGrytXqX9uaXvN
         F050MVt6kleJpVlAvPWud9LYJd2t96Mw6uwZ4o4ieeU6oEw/JUe6PNMsoj4apx36mbUY
         QLgsqqFqUPD14frPJa81LBkQx4+ouXCGD3ArMGN9XvrUHoKyJr0SwOsXX5RVCJ8oKo1t
         7e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FEA0D0NmarT7tUgLdsOaYqwEoxubXch8vLkkSaZiwgA=;
        b=ndMZ3WeKmYYP+ans3Z+gjoalys3A9d4cWyu6XB3ysINranYqZs4ro/8YUDLIN4U3qU
         vlqKGo8tjunc8SGguxzJL6CeOxOmvaU6//GL+77g5mnFCx/L4g6K8qaqktvo54epPs8W
         wCFyArearNlGYRA5tga6U2s8VfvQQVbBezNhH7LD9D1bQjT4m9voGggx9Do3/fS6ROue
         ozkSBMlWe0+MJxkKg5IEeXFPNzhvYnivavHhiyXDgWMZBSQrAXbnsBihUXpnbFaD2s/u
         I70+k9efmLQIHpyqbal1y7Qy1BpnPAeZADDQpE9kOgdnUHY5TWpXWgwz+Yfpv9nzhH3a
         rMdg==
X-Gm-Message-State: APjAAAUbnK+ajQxHpbLkQ9ToX1FhuQlnVXdhYLMgE+bLyrXEeKucMRCA
        /+uPjTEdDJnvjE2Z2b4Woj05qqKKUAFTQalzlSVvbg==
X-Google-Smtp-Source: APXvYqzgLQmRZieAv0NVXzwZ4sCVCofZ6YQgmLsLd86lBmjIE1ohXlj4d+g1rI/1/RNW4bwj9Mf+Y3Yn9BuLgwVcnEI=
X-Received: by 2002:a67:e44c:: with SMTP id n12mr3542951vsm.200.1573144024336;
 Thu, 07 Nov 2019 08:27:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Df4Mwf8eiatG92fywoCoEDpozYGz+jvPLRN8vcXy2a70g@mail.gmail.com>
 <57bbaee4-4338-30f2-3d12-bbf6a6aaabe6@tycho.nsa.gov> <CAJ2a_Dc9mxQzuhxrbhq90LMfDVx0i-33GPegrhxVeRgXg2A4zA@mail.gmail.com>
 <20191106164811.GB1528184@brutus.lan>
In-Reply-To: <20191106164811.GB1528184@brutus.lan>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 7 Nov 2019 17:26:53 +0100
Message-ID: <CAJ2a_DfGQntpOryx-KG1tUyQLnx_frzT_9RBoBHLsMY8M-DHUg@mail.gmail.com>
Subject: Re: Odd systemd source context for non pid 1 process
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All-clear, nothing was wrong:

* systemd runs in pid 1
* to start a service systemd fork()'s
* child has same SELinux label but different pid
* systemd internally replaces the program name of the child, so the
proctitle is no longer 'systemd' but '(#name of service to start#)',
with these brackets
* after creating the environment, the child exec's into the service
daemon, thereby keeping the pid but changing the SELinux label and the
proctitle (brackets disappear)
