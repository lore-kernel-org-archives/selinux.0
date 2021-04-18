Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BBC433B4
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 20:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2817C60FF3
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhDRUCj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Apr 2021 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRUCi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Apr 2021 16:02:38 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62206C06174A
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 13:02:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m13so33460631oiw.13
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V981CE5/HCb1I7MNyZX7QUqQsmDMKqXkT7IPa9eMCh4=;
        b=EKefpPgb4ALQeS5y2fxx9l3a75VbTuBymc1OU4jJZDBsiSytaoDVQDY1HirO2dPpx/
         Ywt5in1vO7k0gOO9fwUEPrn4hWO7/NnDA2I00+0gBVXGGOeKqcD50W43B2N8F4V2UNv8
         I+k/lFJH4JelVCD+FZZVntJlRoJzHLOaZVjiG0Hvk21nfwOSMGHSlxNOgiP8sy7IUXKW
         bjudWB4EMjxu3SU7wrqed+KBZ8Nnt9CXdj6EnszopYlIMdYJ8AeKNgWw8+u6O3Ukj2dn
         iaw6zFEOQppDBPF4gU8/8QeMckkEviGtA3+qpOwyeiZWiiatmJeQTxLF1WMUddHl6d4U
         oL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V981CE5/HCb1I7MNyZX7QUqQsmDMKqXkT7IPa9eMCh4=;
        b=mS0YurZ1gMKlz0IQ1Gke4COf3JAjC2cTC2u5rlkukVs1AFB1iLeSxAnOOj1gYlEduT
         4/45XWWg24d0ACW3uVZrCDJUoB2LoJMwzu1p0Xb7mWuw6UIU8hGlW/vgKWrXtfNth+MW
         tlQ8aA9pe7qGrHeeGT8a5w5+wngAKL6OA1CjJI+UPA1oF+0Am+4s7sH6nfv8SQoGzyN/
         b84KUpSAjEDmtwm5snBCjaE0Vfj2ht9FcY90awlFr+R5V2BeIk+vstfq40DfjFnHxveu
         fmq8lVR5JmZSOdKbuhnK/olsC6r9ukdH225iU7mlN42EYaqCtdSZOoINHXoSeuzjP2v8
         Vllg==
X-Gm-Message-State: AOAM533/4CbSH0Z4yeJ3Zv5uk/cay9ybZvi0htBqK0FoLMSUuoB4rPtx
        M4rWYKYNi1HTQnTy+Z09VB5O+rDAFg52gNieXJov/CM7n97KKg==
X-Google-Smtp-Source: ABdhPJxvDakCohxCjbSstoOc8XnXO8L9v5XyTW8/h9ZRL/gnfdPubChDRGxjBpxs8cBD8UT+2jLPLGl4FWUlQALItDk=
X-Received: by 2002:a05:6808:7cc:: with SMTP id f12mr13168593oij.121.1618776129456;
 Sun, 18 Apr 2021 13:02:09 -0700 (PDT)
MIME-Version: 1.0
From:   "Paul R. Tagliamonte" <paultag@gmail.com>
Date:   Sun, 18 Apr 2021 16:01:58 -0400
Message-ID: <CAO6P2QQvFmMrhUgFHPMPgdN81jKUxcQxK+xdpvZbV=xA1ZEZVw@mail.gmail.com>
Subject: MCS NetLabel
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello SELinux folks,

I'm running a test system using MCS and just starting to get to the
point where I'm interested in enabling NetLabel + CIPSO to pass along
context on a LAN. As a first step, I was able to get it working off
`localhost` before adding in CIPSO or other boxen.

I'm able to run in enforcing mode (amazing!) and get the peer context
(even more amazing!) -- which I can use to calculate the effective
"connection context" for logical filtering on common categories.
That's really great!

I'm a bit confused with some of the enforcement on this, though. When
I run my server (with a user and binary at the level of `s0:c1`),
connecting to localhost via a user at `s0` results in a connection
getting established.

While I understand this isn't the same as MLS / sensitivity level, I'm
a bit surprised that it didn't refuse to connect to the privileged
resource. Certainly I can't cat a file from a user at `s0` that's at
`s0:c1`, or likely (I haven't tried, but it stands to reason) a UNIX
Socket with `c1` -- so the TCP connection going through was a bit
surprising. I can see in the peer context that the user is at `s0`
(without `c1`), so it'd be possible to filter this software-side, but
it'd also be a bit more of a mental relief if only processes with the
`c1` category could connect.

Is there any documentation on how to set that particular type of enforcement?

Thank you all very much!
  Paul


-- 
:wq
