Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C470C6786F
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 02:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C620664
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 02:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0wlOse4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9C620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeJaLqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:46:01 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:35681 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeJaLqA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 07:46:00 -0400
Received: by mail-qt1-f179.google.com with SMTP id a10-v6so16114255qtp.2
        for <selinux@vger.kernel.org>; Tue, 30 Oct 2018 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2FIPVwj4rVHCtWWh2hkXu29f4CB39AU3QrAGlt1eLTw=;
        b=U0wlOse4teZwi4D6I3qgQNaCJiDFOp938cVdMBtrIEArTFW1k5mw3BlsxtA6u1gnWm
         trCuPGHScGz7rNZw9bJybUHVB+ipcgKf5gk9f0UQSX/ig9q1Q3uITUPVRl6tgjvjr3tN
         v6D9Duh47MOOqAaqKGb5Khs9kwE+Z4/1v0PeCCbYSaiXEB53RvDngqDY+wUcaXArTc2o
         paJPMkUoLz3hLdkYdLf9j5mQjbQc+ao0NrQetE4lQEcJOpw+hTRMQV1JslXRjk4zBQp0
         1IJS5tOsk6UQ3fK7Rir+5wuxMJVvSyv07vXZ+lcFz0RpoDRjQEGzafdEFtP1Gx5MSl82
         5NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2FIPVwj4rVHCtWWh2hkXu29f4CB39AU3QrAGlt1eLTw=;
        b=LX6KSCA8fiB9Qq5RmO9z7RENHRvrFNTArvLwn4z54OiaqodAfk9hvchEnEAWGRPddx
         9cx6wI3gu1GbSLs4s8FFqjiNtrt/eaRoLBk15cXZnrAKf4biJT0Tr+cjy78AHEUsi9/y
         DeMdXBOdCJTqMXBhVmFVQTiCUeySvFOMNzvoX47PI86DQ9oi81sT2iYyQRGKhnro4hsc
         Y8cDkn9fDpvcr1Fkvnv4GIFzjzAt5UvSR2zknCkkCLwHSKlcEz59yu66YzspuV+pEvRH
         ukOWtrS7LZf3qb0U0RMVK74tyt5YN+XQK0oSCsF19HHCeIQqx98cLzhjOzwRKC7YvfhI
         auvg==
X-Gm-Message-State: AGRZ1gIfhn0AcNR4Ggw+eWqNlvvRx+yF9slzGeuLfO9JEF1r03NjM7CP
        k67qDki0YkJjVQUZDJViO64uhDpGzwBQqGQP7t7aBCsNXB8p5g==
X-Google-Smtp-Source: AJdET5elSheJSGr1BjTVJiGEcaKSi0WzkdzR/lA1L/AMhZ5LbawkatYOdX371lMK7jq0wYSI3D4TJ5l5g7SjNiLO6ts=
X-Received: by 2002:aed:2461:: with SMTP id s30-v6mr1096228qtc.160.1540954196816;
 Tue, 30 Oct 2018 19:49:56 -0700 (PDT)
MIME-Version: 1.0
From:   Jiyong Park <jiyong@google.com>
Date:   Wed, 31 Oct 2018 11:49:20 +0900
Message-ID: <CALeUXe4MeHnt_4_pSZVTCYC4RNt2UKG0kEg0O9PRQTnmkXiLEQ@mail.gmail.com>
Subject: android-security-selinux@google.com
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

I am Jiyong Park from Google. I have a question regarding the behavior
of selabel_open.

selabel_open() returns -1 when it is given with file_contexts.bin
compiled from following:

(/.*)?                u:object_r:system_file:s0
/lib                   u:object_r:system_dir:s0

, but it runs okay when the file has at least one regex without meta
characters and having '/' after the first character (i.e., when there
is a stem in it). So, selabel_open() accepts this:

(/.*)?                u:object_r:system_file:s0
/lib/                  u:object_r:system_dir:s0

It looks like, when compiling file_contexts, num_stems becomes 0 when
there is no line having a stem in the regex [1]. And selabel_open()
fails when the length of the stems is found to be 0 [2].

[1] https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.h#L320
[2] https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.c#L235

I would like to first know whether or not this is intended behavior.
If intended, could any of you tell me the rationale behind it? If not,
what would be the best way to fix it?

Thanks,

Jiyong
