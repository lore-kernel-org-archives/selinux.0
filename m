Return-Path: <SRS0=Zaf8=NX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93362C43441
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F16216FD
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCgF1/Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F16216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeKLUCg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:02:36 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45996 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUCg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Nov 2018 15:02:36 -0500
Received: by mail-qk1-f173.google.com with SMTP id d135so12257078qkc.12
        for <selinux@vger.kernel.org>; Mon, 12 Nov 2018 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=85HXbkZeCFKD7vbKF6/hZd7hbEPI4//fOAdC/+qWuEQ=;
        b=XCgF1/Yb0YJLwIYGQPJKKwlO0DqTR5pBiPTy3FLvYJg3irwGKYHW1qRUjieeFhdUH2
         w3nstA/obrR7tOJ7CxwMF7J44qKtW8TGm7HPRkiTVICophPz3waxh1DFkM+bzcKSznSh
         Jm4evRH5w4utcYIUB+Da9fGnyYg4nnLyrlIhMIvmZRx1PfvgTSGF8ulOUepNmOaZVLA6
         HN9bwSd/cVZsyRsxIzutZwZ9WNlqYiLdb8ouymlvYOYbFqlZ5fR3xEZ1n+o+xeSufoTk
         oNTnmO46X1SebOjIXZBqIPgNP69T+22fL9mPSj9acLiTWZcxD+rMrxp5QFdQVkg9NIvb
         7Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=85HXbkZeCFKD7vbKF6/hZd7hbEPI4//fOAdC/+qWuEQ=;
        b=PXCx3Kwc7wCT1dlwnWUsf9nEuFQzSC8lp48r33KgBGGjj1gY2c4I/zgi43Y7Za9lz0
         BP5Ug0lpo06aVk+DG/tqQzIRARGLP21wT3/gU7xuNR7T7obWXyVyh/tElaClOXqt8zsw
         TY0GDMm1lrNUaJLdB86UiynnrjOOvPjjlGyk5l5Y6bOCHT71v3e/iFTaUF2pXpp3Yq87
         Tp3N4GtK8V7Hnl+UZKjbAVOWfvA0AHCu0+8ZDIpHHHKtAcBLt/jthiOkMl6ZzwYMcidZ
         cyPh+g6rgUApB4J0JxL627QsGErvEI2tb4RzkNqo4dvAhqwRvIFQcq6GrOnZBbVlMuJL
         uZlQ==
X-Gm-Message-State: AGRZ1gIhiCnO5+wL7V2LmoTlg4sL15E0QU0EBJ1jUpQViR9B4Co+aWcj
        DuJ+mDTY2yBq3sOr3aVp9rF3XHm/Kgq5y5AhENz4KvZpPT9ZNQ==
X-Google-Smtp-Source: AJdET5digor+9d7UdU2JIOrFPN8JAYytIQsyvy+QAsQD2rhu1e4xiS/iQUox4vtij4wZZEW3fueuyr8iPhM9rKOY0G0=
X-Received: by 2002:ac8:35eb:: with SMTP id l40mr260579qtb.165.1542017404301;
 Mon, 12 Nov 2018 02:10:04 -0800 (PST)
MIME-Version: 1.0
References: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
In-Reply-To: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
From:   Ravi Kumar <nxp.ravi@gmail.com>
Date:   Mon, 12 Nov 2018 15:39:52 +0530
Message-ID: <CACikiw1_L0Tb5h=MhhZ=8Byu8XcBq+r0DKH8i6kUo+rJi0wq+w@mail.gmail.com>
Subject: Re:
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<<Sorry re-sending in plan text >>
Hi team ,

On android- with latest kernels 4.14  we are seeing some denials which
seem to be very much genuine to be address . Where kernel is trying to
kill its own  created process ( might be for maintenance) .
These are seen in long Stress testing .  But  I dont see any one
adding such rule in general so the question is  do we see any risk
which made us not to add such rules ?

1.   avc: denied { kill } for pid=2432 comm="irq/66-90b6300."
capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0
tclass=capability permissive=0
2.   avc: denied { kill } for pid=69 comm="rcuop/6" capability=5
scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability
permissive=0
3.   avc: denied { kill } for pid=0 comm="swapper/1" capability=5
scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability
permissive=0
4.   avc: denied { kill } for pid=4185 comm="kworker/0:4" capability=5
scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability
permissive=0

This is self capability any one in kernel context  should be able to
do such operations  I guess.


Regards,
Ravi
