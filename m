Return-Path: <SRS0=cnGJ=RB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E7C43381
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 22:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E820652
	for <selinux@archiver.kernel.org>; Tue, 26 Feb 2019 22:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6t7btYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBZWUz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:20:55 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37462 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWUz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Feb 2019 17:20:55 -0500
Received: by mail-wm1-f52.google.com with SMTP id x10so3728487wmg.2
        for <selinux@vger.kernel.org>; Tue, 26 Feb 2019 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xK5x2iXzZ+ZH7k5NhrFSI3BUfSa/3kSOJf5xA5rlTGU=;
        b=t6t7btYvN/QXBvfh2csTfFYjK+SXq6jly74zHV9ZvIpya4Pb/7nHR1k4yUbNWPSSw8
         eH9mKx+NCfgA67PfCjcDyVrXsjMMFAVuH3XE13KyrKHwIuS8uGPW/t39yW3d7c2Etpg+
         KKsOfP33Eeq7im7ximXf5J0WRYzxUugyZvCTyZWAE8pveILisgWoisc2dGHfMgv+vhdO
         WSyxtv9VnJNNQO0f2vjqsImb4QNnUioskPKcafsJu2KVVNCXG0fccMviGcl9mRo1Nqts
         5X+1cunk96ec5enB0cU/86WDXRpM8vduW9sRPegPY64XWEqC9s6cPeZvuZ6QXb3xVBY4
         Xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xK5x2iXzZ+ZH7k5NhrFSI3BUfSa/3kSOJf5xA5rlTGU=;
        b=nXOuXm1skmnaDPaPO+F2XlvzYacec17IvAI+38QtbsNiyWSwOVWlEDoAxgM06KY9F6
         jD4GmuPTvajMrIWrt0C0C/9Qkk7eKYgJGA+n7V92SLnOUNL5zZYbcsB8qu0RldMwd5Cj
         xdDVV/AG4BNJRuGtE38xXYBBe6C2aoHk5phTKE7KanbLWvr++NZGEZV+RjWNWCQFJbwI
         SGvctylwAQKRBclfwyfpM5lAvx8b2fH0b+xjuW1BRcV7oekl0c31jYauR1aIX9qdNFzf
         jJkTWPwQfehZi2xCFEFXtNqFOPzYU/QqXNjdIswkmyihq898tVFIoxhF2+fWV3UbIuid
         SqlA==
X-Gm-Message-State: AHQUAuZxEvq9ajwBuSkLoYYTfCD1OhJWvofLtKocr68NfYNpkRLBZXpW
        skIEHqFhoSyzea9Xy23Q7kQNIrwj6mJcusM4FbBGw3ZL
X-Google-Smtp-Source: AHgI3IYlmJFz2KZHUrVIWoyzpdwyrXARbGBKxUXnPK8qhWubUOTgZcthmh9YSSS8NvvRnH+xXh37QSl+LelIgR5geqE=
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr189712wmb.52.1551219652868;
 Tue, 26 Feb 2019 14:20:52 -0800 (PST)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Tue, 26 Feb 2019 16:20:42 -0600
Message-ID: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
Subject: RHEL auth_role using logging_send_audit_msgs
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The RHEL version of the auth_role macro which we are getting through
our use of userdom_unpriv_user_template uses logging_send_audit_msgs
which give a type the audit_write capability and allow rules for a
number of netlink_audit_socket operations. It seem counterintuitive to
give an unprivileged user type audit write related policy.The
ref-policy version of auth_role does not use logging_send_audit_msgs.
We're considering patching our policy but I wanted to see what others
though about giving unprivileged user types this policy?

Ted
