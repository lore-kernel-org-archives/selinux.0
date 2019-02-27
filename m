Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9939CC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 01:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BC72063F
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 01:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsBoXHdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfB0B3E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:29:04 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:32783 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfB0B3E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Feb 2019 20:29:04 -0500
Received: by mail-pg1-f171.google.com with SMTP id h11so7103142pgl.0
        for <selinux@vger.kernel.org>; Tue, 26 Feb 2019 17:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:content-transfer-encoding:mime-version:subject
         :message-id:date:to;
        bh=Q+UUTNmzwrqVPQ9oYTpTWnSnUp3LJpcA2THeuXQKIM8=;
        b=IsBoXHdQmUeuBFZC4yFdSzox2WOmfTnFfRiVJilx+ua5l97GwNAmtV+B5D+rSsy0lx
         wxL7KXCmNlgvs69dRcUweiKoxT+SiSIzcGbgquo2ZGZg27EE1mzFc5kPsluc8pRNLNSa
         74Oir9SNCgrurnrMVAvmb7tS+UsO5NN8uOKuIup+Hhmxo+PdLGS37YEogZyOlUsRc/EI
         1waVLk/hyDdoQY59fFoCtkel2Yw+EVLdxyzC8blGV6iuxouKCBvUev4ObFPmvz/Np608
         dNkHMteFnT10re1JRUJhCF9XfST0e5CrJo5mfZ2yzrPQGDAzkImxk0lZrkaWDFFdUabw
         tAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:content-transfer-encoding
         :mime-version:subject:message-id:date:to;
        bh=Q+UUTNmzwrqVPQ9oYTpTWnSnUp3LJpcA2THeuXQKIM8=;
        b=XE0a6Ww+PJoijEMbPoFDKyXnpa97WaVHYOZBRo69o5B9/Ujp6yRqSed1YdIccTcTQa
         HYjR4SZDsx85XKKvq6u4VX64gpJvQgNj8sUozuw6nrqjWwwOrvxZaJPQRpDpwVT78+iV
         DmR6qlL9dTq1gtuw6ynnjGo9jCA3HMkD0fxtaq91hmUQJotV0Op1KgJzTk7YsBQeAHYr
         DJUEeVGsDnZ/2YgQdlzau64F7U+U3thuFRXA7zDjjqBJxqbRoTlspSvYYhl/90hbAWLe
         Q+etct3nB9KCHuqRODWR6QMerHc20dkPZRZlif80OgGx/BwvemXFLTQR5Hj+jwa4e1HC
         LZLw==
X-Gm-Message-State: AHQUAuY2LXA/n4bvHMmfC0KP5LJoLdRcMksfGGahAZLm6IZsUR177JdJ
        CWJS0+iO2NpLTJR0gVsgIPuKpggq9Bs=
X-Google-Smtp-Source: AHgI3IZxPye0/mvIXmIf5siJgT5JT0/ExNd8Ja8cYjLOFU3H21uaWqxMImWKNQ7x5iexqLiGGH/D+A==
X-Received: by 2002:a63:112:: with SMTP id 18mr380376pgb.139.1551230943691;
        Tue, 26 Feb 2019 17:29:03 -0800 (PST)
Received: from [192.168.20.167] ([136.49.78.73])
        by smtp.gmail.com with ESMTPSA id o5sm36496697pfi.118.2019.02.26.17.29.02
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:29:02 -0800 (PST)
From:   Joe Nall <joe@nall.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: neverallow rules
Message-Id: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
Date:   Tue, 26 Feb 2019 19:29:00 -0600
To:     selinux@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Looking at neverallow rules, the semanage.conf file says
"# expand-check check neverallow rules when executing all semanage =
commands.
 # Large penalty in time if you turn this on. "

If I don't set expand-check=3D1, are the neverallow rules actually =
enforced?
If so, when?

An semodule -i of a policy module with neverallow rules that are =
violated by the existing binary policy succeeds without complaint unless =
expand-check=3D1 in RHEL 7.6. This is not what I expected.

The time taken by a trivial module installation goes from ~.3 seconds to =
~14 seconds, so the time hit for expand-check is pretty serious.

We are trying to establish some policy invariants to protect against =
unexpected/unnoticed RHEL upstream policy changes, some of which have =
bitten us recently. Any suggestions are welcome.

joe=
