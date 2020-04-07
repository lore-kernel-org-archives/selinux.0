Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864CDC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494520730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEYSZsVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDGQTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:19:01 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41779 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgDGQTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 12:19:01 -0400
Received: by mail-oi1-f178.google.com with SMTP id k9so1997536oia.8
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:content-transfer-encoding:mime-version:subject
         :message-id:date:to;
        bh=sKqRYBxK9cLDP+r5kQyTMrc0HDoPC5h3bKEa0wERBvQ=;
        b=XEYSZsVC7Qvtms2/0QUiy1xI+7WRMPWeSqEtUbm1pvPwmjylSIDMZlhCw4QV23Rocz
         BnP5hj2mr16Px+muzi8X4WT4/X3FgaYtpyS3lAQjgCTLuYTXtkCr0PhOs1EaVKNsjgon
         jOYjXq8se1avlof3ZaJHoMADhqUNtl0EOYeQGt873KlXtJun0aU/B57X/vMuWzujpvpL
         bb0MgaiKZ19iqZ1gFImM3suwBJ85cGsfCQ0OwkV0FG2Ta5WdcwFMEwjT18550Bng/XFn
         bPpmodYtuN4avw0XWZ5rpecyqKMo6DOr0hLNyGsMPqmPNColJ4ZaYYrvL5qHV/+2EX5X
         7kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:content-transfer-encoding
         :mime-version:subject:message-id:date:to;
        bh=sKqRYBxK9cLDP+r5kQyTMrc0HDoPC5h3bKEa0wERBvQ=;
        b=FwYVQr99+wmw/1cKr92hI+QbjX5spLgAzty8AE33kFlERXZDo3euHU5Z3HfPsmM6C/
         kxo25bUxeQt45U9vETbtPb3VH5kMWZuPirifXvbhalnFfGiSdkezjZ8kiNYpQdeTs0hS
         F9VS5l19ple+BfCi9FBVv+bspI5a2Q9Ee4kxT/vYDtc/rcDMmchR1rMtYJPuOkjOAEKL
         mAZCjkQ6AXTRIr3bQK33DkV+tzPyFglRYdKURQ80mc12631FxsYzGSWXC+SXtProp1mx
         50W23kq8vMn0O9RorpcrD33zat11QKOWpOo2Y520iavVkJO143LfVy3FrrgLJsrUfG3h
         qwQA==
X-Gm-Message-State: AGi0PuZfpHJ8fFLrFKBSKuDhxXAMGA3SbX7HEVcTXygQ3pDuZypQf5QW
        gxP/p0HaEuT7X06/p42CnIOBtXHAR2s=
X-Google-Smtp-Source: APiQypJG+vwI++tpH00nS5jIjxo3hwdABF8Fohc1F5QV/X/lbmSGaxi0lSiVMKo8D9Hoz3+mfN9bvA==
X-Received: by 2002:aca:b382:: with SMTP id c124mr91344oif.64.1586276340379;
        Tue, 07 Apr 2020 09:19:00 -0700 (PDT)
Received: from [192.168.20.239] ([136.49.78.73])
        by smtp.gmail.com with ESMTPSA id l29sm5387980ota.55.2020.04.07.09.18.59
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:18:59 -0700 (PDT)
From:   Joe Nall <joe@nall.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Question about shell_exec_t
Message-Id: <23A084A9-66A1-4E02-A766-F9214E63A628@nall.com>
Date:   Tue, 7 Apr 2020 11:18:58 -0500
To:     SELinux <selinux@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When a shell script "fu" is run in a type and has it's own _exec_t
ls -Z fu -rwxr-xr-x. root root system_u:object_r:futype_exec_t:SystemLow =
fu
should futype_t require=20
        allow futype_t shell_exec_t:file execute;
to exec the shell?
I ask because we seem to be seeing different results on this question =
between RHEL 7.7 and 7.8 and we could not decide what was actually =
correct.

joe

