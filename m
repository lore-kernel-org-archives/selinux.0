Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFCC0044C
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57512080A
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 19:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2Pr9mN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57512080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nall.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeKAE1h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:27:37 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:52597 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKAE1h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Nov 2018 00:27:37 -0400
Received: by mail-it1-f177.google.com with SMTP id r5-v6so17982467ith.2
        for <selinux@vger.kernel.org>; Wed, 31 Oct 2018 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:content-transfer-encoding:mime-version:subject
         :message-id:date:to;
        bh=vmSekUNTDjjO+VEoC0TXdHtwKZNBeIXerw3juCqOqkw=;
        b=o2Pr9mN9JU0+L6neisptMteqZ5OlS8iTkN+imT1YOILYY8YAr4lYp9nGq69oA36X+F
         57EfA5kb6qitVousj97YE2l1aN3XmG5KAnOdzz0n+tKCozoGyZWs5LZyXvRc5q25r7+W
         3TBi1vwfUdSVxkvh3vd1oARIeUqaSjRx+Xt1mp8wwcj05jRPV7WQLhNXZGztIkNQ0rv1
         LnV3DmJnzRNbFWFm4anlxPxb2rQQzbbNwsU4UNbHcJxxqXYDPEB9z4x42bmopRIGNnlO
         T7CF12Y0h/gkbrL6aTRC3m3cQBVaClFIBSQAEV0FWzYcA1/bmGxmYVTCN1JgH9jvaHzY
         qJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:content-transfer-encoding
         :mime-version:subject:message-id:date:to;
        bh=vmSekUNTDjjO+VEoC0TXdHtwKZNBeIXerw3juCqOqkw=;
        b=hQoFbtIS4RKENSKbskFOzOGOw4gjZvU9rbDocmutoqSLLQ2MbaemKEck7OpmrechAX
         2L4DWFyPZ42rSGtPXi6RsBFoy8JNLBPpWmaIqWum/ir3VvKLTe/BCcZqpS+hm2M1OJdc
         lVnruzm9ZPPMRG38XEdQvlTbMd+ibo7jiEgg7UH9PnHbDfApFFzL8D6LHVBQT9E4PbX6
         fmhst9GgLhysBrQaO7rSzr4oh9VvonIpisw+1F/ZD4U3cQh035V7/7o0FukSvMr+EuNJ
         kDbZf2t18yBVaInXQ285ns159u3pzfZa0lHDA3yM7J8KjT4JR8qLb69deNHXYFExJQRe
         AzYw==
X-Gm-Message-State: AGRZ1gLIeIE3fy2Vqphuk2AJNQ1w4ilbSAJSYAran0f4P6wyDcinzN1M
        bVBZYX9x4C1D4nFqRLxRLjz+ru0n
X-Google-Smtp-Source: AJdET5fiJm86N0yB/4mGs9/tQGRy23nL+EQo/WlAnsEHfGKCTAhoclSYG3Y+45VcuV8nHCcD/7yW2w==
X-Received: by 2002:a02:9951:: with SMTP id d17-v6mr3236117jak.78.1541014091451;
        Wed, 31 Oct 2018 12:28:11 -0700 (PDT)
Received: from [192.168.20.149] ([136.62.246.171])
        by smtp.gmail.com with ESMTPSA id a17-v6sm6003010ioc.28.2018.10.31.12.28.10
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:28:10 -0700 (PDT)
From:   Joe Nall <joe@nall.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: '\0' termination on writes to /selinux/*
Message-Id: <E018DB57-F85F-4F0E-ADC6-520DEBC0AEC8@nall.com>
Date:   Wed, 31 Oct 2018 14:28:09 -0500
To:     selinux@vger.kernel.org
X-Mailer: Apple Mail (2.3445.101.1)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I was looking to mitigate =
https://github.com/SELinuxProject/selinux-kernel/issues/38 somewhat in =
our older RHEL6 systems for which a kernel update would be a big deal =
with a ENOMEM errno check and retry on the writes in libselinux. In =
looking at the code, it appears that whether the NUL termination is =
written out is inconsistent.=20

grep write *c| grep -v swig| grep strlen
canonicalize_context.c:	ret =3D write(fd, buf, strlen(buf) + 1);
check_context.c:	ret =3D write(fd, con, strlen(con) + 1);
compute_av.c:	ret =3D write(fd, buf, strlen(buf));
compute_create.c:	ret =3D write(fd, buf, strlen(buf));
compute_member.c:	ret =3D write(fd, buf, strlen(buf));
compute_relabel.c:	ret =3D write(fd, buf, strlen(buf));
compute_user.c:	ret =3D write(fd, buf, strlen(buf));
disable.c:	ret =3D write(fd, buf, strlen(buf));
procattr.c:			ret =3D write(fd, context, =
strlen(context) + 1);
setenforce.c:	ret =3D write(fd, buf, strlen(buf));

Is the NUL required inconsistently, not really required, or is this a =
bug?

joe

