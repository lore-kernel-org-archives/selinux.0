Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF1FA372A
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796CC21A49
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VQ7QnUjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437775AbfJQVY5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:24:57 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:37030 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfJQVY4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 17:24:56 -0400
Received: by mail-vs1-f52.google.com with SMTP id p13so2619047vsr.4
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uWyNNIcy6VN5N82idO9PIb87dvcNUKG8Tpuln9d1Qvc=;
        b=VQ7QnUjbLmM9mDCJ+m4R0Kj1zzekoe0IWe+iYozKhkEqbyScIswzqGBiqY11ztkqHa
         q2fvWrVCxIDVaHlpy1lslSL+3/MMmbHVYGqaJSht8uAVlwUNo2CToJjQVCkCDHpmtKKa
         5bzNqPOILDh3/EgOvub9QhRm6jrYmupsD2ugtwxagsU+Q3STwSxAYiJVldv2oZZO//Va
         yOaX82zNgsye4Jfx+urBRV+KatcLqyc6S2b+ApzYrxf8E+LpJqtGzLWC2lln1A9dWjGD
         IfrBWR39JD8GNXtZh+yhPbhlqh1Xg/DCHgLwZf5hfHH8DMvu1IQpcVr+ws+WB1PInVWq
         nGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uWyNNIcy6VN5N82idO9PIb87dvcNUKG8Tpuln9d1Qvc=;
        b=QfAMgWc3girCMZKL7REUPkVc1m3fZIdmaDfDruv1glQRV78IY3ls87EjRcfPD9cYB8
         6gP2zoKvVg2Q7a6S23AFpqV4jS/EOguUaC4XuGFBSh4hxOR19NRWAQbWKbGsgiNwoatW
         TJrWkvFy7E4io1Z8CapG6z6EBiHS++AdOPV4AFPYEFaYCmv1oCSy48QMcqsPGks7J45F
         cNjb2+EjU/ftQPDsCuVgqn/vaFJtSRwbUtGNkUaQl7cr3V/RBXBbIkgSnIbP2GjnxH/3
         BeXXvfQ6TDkx5SBN+2lY3VL6af5lCVoXcPK0j/ExW+Wj3IJYIgwdaoyNQVlLAjQ/eojF
         xEtw==
X-Gm-Message-State: APjAAAVqdskZOSY3HNopDpVLVIqfn62OwWyP8YgTPiaIpQurjwgYrayo
        VztgUepEp6u7Eb8xanuRWvy+3jl3/Qv5EL6R6RrvdTCo
X-Google-Smtp-Source: APXvYqy1wTNtC+iME7L8ACw4xZcGs1s6v4Enir6EkGxMXaOuCNDxL6Na+4UgMgEYuhvs45poTiKEAhxsATvZl5hqICY=
X-Received: by 2002:a67:eeca:: with SMTP id o10mr3277075vsp.2.1571347493961;
 Thu, 17 Oct 2019 14:24:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 17 Oct 2019 23:24:42 +0200
Message-ID: <CAJ2a_Dc6KDDgkZ4KmGf0oDR0X8q8Ve0Typ7x9RcEp-dbhcHeeA@mail.gmail.com>
Subject: src:shadow: dropping passwd shortcut
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,
I am working to migrate src:shadow to today's SELinux api as
previously mentioned.
Currently there is a shortcut in the passwd check:

If user root tries to change a password for another user AND the
user-identity part (before first colon) of the previous (exec-wise)
context equals the username in question, no SELinux check is
performed.

Stephen suggested to drop this logic as nowadays SELinux
user-identities rarely matches usernames and we only skip is simple
passwd:passwd check.

So I'd like to announce that this logic is probably going to be removed.

Kind regards,
     Christian G=C3=B6ttsche

p.s.:
in fedoras passwd, the logic does not exist:
https://pagure.io/passwd/blob/master/f/selinux_utils.c
