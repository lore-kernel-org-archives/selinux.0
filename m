Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB1FC2D0EC
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 01:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939FD20784
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 01:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtwPMuQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDHB64 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:58:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46800 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDHB6z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 21:58:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id y44so2435954wrd.13
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6it2+r65wTxUpkmEzOm4j+IodJQhMPFn4d7D3hDNFZs=;
        b=RtwPMuQr9lIgKoQNC+4PAzzGgoVyaPSR/0yMNvwtoN9QGQGW8xHJciGEblnUiS4Sk1
         dClUDYBm2nVzPNuTYS6EoumitqnZVqmGZo8fBn5r8s58dBl4vntaVAGPHBBI2/fsvcoG
         7CFh7lkYPlzz9cBM66oru35FtysB1LKzNphlXr9PMtHUQLApEmzZRBBCCx50TiwHbcVC
         jhAMm/8J4pOp1c5kR8PQIpAvpeXPJOqWzvMj2mRPs3Tik9s9UFR7FKXq7SofVtEp2q3y
         vwbuUlp6PTGsIkKmb628y9PqOWB6C6KE/b1IIEr9wWAYq0wnwwsURGm4Q+3IudUktoOa
         HhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6it2+r65wTxUpkmEzOm4j+IodJQhMPFn4d7D3hDNFZs=;
        b=t9Nq3wQ6Z6WgCkderMYgmhJ2QP6073mCovoXGpoRiTQdoph3UPSSUr+vPAziX5EkyD
         jQ1+cNrpBAiBA8V+PJWrb9oKWlZKYQT4nxES3Fl51XHqui5oRrFoUB/QyMFMx8Kn9O17
         4YXxYpb8rkSp5R+AuRV4hE7EUJw+2hhKMlGiYiQHeHPR/lJ9XZwf5xS14jstaHLtP+cn
         deYT7opmTwM4s3oNVvPNvqLq0sMoSHmRhuXdssNnRBw5UJO7+5ePDLBmnBofDTRLAx1Z
         G/FKWJGcSUvpCr/OLtWUkV8UckH3Nv23MuCgN8CxoPlq6JqiBLyECXNH6XkQbQm/D0up
         98Og==
X-Gm-Message-State: AGi0PuZvLpg3Ur/vxBZJ2wZLme+fZyA1564NJ2l42uC8E5A38zY9zLWk
        w4wQhczi5Otqo+wOP9KT7TNvy/genZ1qlcZYh96OyWkN
X-Google-Smtp-Source: APiQypJnIelS+oYPzOEWT2XukvqAy5HCyacpRNGaqS0kfH9UeN3wbg6uknP24lR8JuRhj1ZCfPaFOmhCWc1d2Xi2K4M=
X-Received: by 2002:adf:ea82:: with SMTP id s2mr5531005wrm.407.1586311132161;
 Tue, 07 Apr 2020 18:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <23A084A9-66A1-4E02-A766-F9214E63A628@nall.com>
In-Reply-To: <23A084A9-66A1-4E02-A766-F9214E63A628@nall.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Tue, 7 Apr 2020 21:58:39 -0400
Message-ID: <CAB9W1A1QMWOr8Z=d=nNnSsZ5Qy7O1fKxNmwR-6uB-fn9BMaNUQ@mail.gmail.com>
Subject: Re: Question about shell_exec_t
To:     Joe Nall <joe@nall.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 12:19 PM Joe Nall <joe@nall.com> wrote:
>
> When a shell script "fu" is run in a type and has it's own _exec_t
> ls -Z fu -rwxr-xr-x. root root system_u:object_r:futype_exec_t:SystemLow fu
> should futype_t require
>         allow futype_t shell_exec_t:file execute;
> to exec the shell?
> I ask because we seem to be seeing different results on this question between RHEL 7.7 and 7.8 and we could not decide what was actually correct.

Logically, execute should be required here (but not entrypoint).  The
precise behavior may vary depending on changes to the kernel exec
logic outside of SELinux itself, e.g. see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f834ec18defc369d73ccf9e87a2790bfa05bf46
https://lore.kernel.org/selinux/8aaae08c-8fde-45e6-82d6-e75183aa74d2@tycho.nsa.gov/
although those were with respect to the ELF interpreter rather than
the shell interpreter.
