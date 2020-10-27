Return-Path: <SRS0=znNI=EC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DDC55178
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E5F22258
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 11:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="yXaCB0NH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421949AbgJ0LNB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:13:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44322 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421944AbgJ0LNB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Oct 2020 07:13:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id o3so579778pgr.11
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2020 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0obnKK22a8yhO2TgUoiNlMZZVsDd+/2OFl4hOBmzrM=;
        b=yXaCB0NHyNyybMGnHh5QVTruEUIV49sJKL3lgQ2Dve6jQ/kaxL/HgSZdeVL1jHQeEg
         ZSV6SLAcYocHoFUZrQLucg48qxnfhB/atzi2PX2fdzPKsSdOZYQQBGrSX7t1emGbhvg6
         qxeeDs6dKXHdFIA8vxL1YY6hXcODBES71wD5okidj4PfmT4ql68ZW25WwEpB2osfbJn2
         gMah+0JkFCY2teOc7vr3OnN4qnPtGghiTxIkQuPbetV+X1uMgT7bQ1ZxKaDmgLya+6Kl
         /jk0t6ArB0sZpzEQn8pkqAIwkT3UKpsPDIJesq0XfcgZ1Rzm5HkcFP3aBcfdqYCXYHiW
         MFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0obnKK22a8yhO2TgUoiNlMZZVsDd+/2OFl4hOBmzrM=;
        b=Ya3zB4XXIUpIiSMqVuqUzqJhnEZz2f3MK7ECoyGJXr4EVtJNFY0Pm0C+QQ/+biRV/r
         tB1u3vWSKuFTukzt5298+oud/nEmwv8xmmqKijaVlAW2ba4Td1XtEKjzC2zzDCh5Bpe1
         o67afD6Ba6OrAbqLaSw0AM/48Aoe0CMZ3OU3GvILrZdXQhMmQbBnuJzGgugAkOw4hzJ4
         0aUObsGCsoOrU/KKbGAv/DGZ3Ffn32tfssKFlWsB4g7A4cY9uPTPXGD3LrQpyPC8HtFR
         R57EiSdb56AAQjNshkZIrwWCX+EXYY6wdNL5LNlHeHqTwQcMzqiwIVXnN7pbzRaSqTm+
         /KSw==
X-Gm-Message-State: AOAM532LpuwaUUYB0JQbtAMFbyy1tXmHCLnMOcUD9qAax78Z+Vh2WfsW
        j86gVsvUHRotyO9WTCi7Qt8yzFa2oA1UE2I0ySmtmA==
X-Google-Smtp-Source: ABdhPJwNXsobNqHBfTMRnKA0/4DYKbtWXwrxiHZ0otyjRkKDaMpp7WAYp1AZxS5LICHLvS6GNAQ9qjaSIX+B+EZ0th0=
X-Received: by 2002:a63:d80e:: with SMTP id b14mr1468884pgh.114.1603797180695;
 Tue, 27 Oct 2020 04:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpdSwCB4jZn22cSeTHiwPmsZPUZMhtAYardTouAcgxpmA@mail.gmail.com>
 <B129404A-41AA-4803-91CA-3F110BAE26BF@gmail.com> <CAFftDdqwLidE7bc9Z0jLmJwvvTtfWCbeGHnZ3kUMP=y5gUguEQ@mail.gmail.com>
In-Reply-To: <CAFftDdqwLidE7bc9Z0jLmJwvvTtfWCbeGHnZ3kUMP=y5gUguEQ@mail.gmail.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Tue, 27 Oct 2020 16:42:49 +0530
Message-ID: <CAP2OjchG4ZS0R6aQRCA3eGsf0bPOyaqKTUuVh-c9stKdSzjBKw@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ian M <merinian@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi All ,

I am evaluating a use case of  SELINUX + RAMFS scenario & came across
this thread.

Can team please provide pointer on :
a) Use of TMPFS over RAMFS for initramfs
    As that would allow use of "fs_use_xattr"  and hence restorecon
would not be required with "REFPOLICY"
    Am I correct in my understanding here or am I missing any aspect ?

b) Team input / comment on https://lwn.net/Articles/745260/
     patch to extend initramfs archive format to support xattrs

c) Any standard way / location to derive "dependent packages " that
should be present
    on ROOTFS before trying to build ref-policy from
"https://github.com/TresysTechnology/refpolicy"

Thanks ,
Ashish Kumar Mishra
