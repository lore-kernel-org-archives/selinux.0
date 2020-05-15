Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D9DC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD002070A
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="b2LMh0Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEOUII (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgEOUII (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 16:08:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1412C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:08:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so3967499qkh.2
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=JIdqeZKj7ghcAKNC/sIBwJ/PtX3t75osPSsD2grpYBk=;
        b=b2LMh0Hp6RVE0U8fqWdtoiCEgct2gJWVUFTY5Hi1P1Pt88X6UsX6bC8NWQX3+MVoIS
         P3pVRXyE8DaU3SjshoHqYp2X3kIeY0vdaXQTKYGwfoEYKYIxyscIpcrLA4+qHRlBCpcv
         YJKozBaTzSEcCTIo4l2BDlEJhtZGyvWPSAel0+zr7XoNZJf9gmjlK3ADPxp9BKALWE6n
         MUCoxOJyKQQd7kgMdQL3RkHTIMchx9qHzewInb8t4BGZ7aY02flxxrm9gyjnB4hI1QuM
         BQ+R1KONLzCdB4mj2FH8U4LO0cdsfSViswmdIvHbOj706LVztvgbNH7hTeQmcicdKAIC
         gcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JIdqeZKj7ghcAKNC/sIBwJ/PtX3t75osPSsD2grpYBk=;
        b=ijsGUtFHZlUuG0DadBQv3q5anMwyo27VJUs7gtvnG9TWmdRcg2XefZPNd2QllrXbcG
         fLnXrxHYaIRtFgo0ZNvUWkEJo7Xpq4fV0OnFX5oRPqjma5yCVAM9w489Iih3DHMApein
         YdFtzl2SJDypf4r5LS8sVnzVaDQwpvL6Q2/hXIw993y44NG1YHALcBfJMvbl1x1RWLRs
         FfpChdrDUaqmdJiCNVmo+10yiANqRC4uNOHZ0YT18a3zd6fjTidJqegdLgU873fQRKhQ
         33BQOkrDWnhX8qWSTt9WbJo9sD0JwxU7vyL4RRFxXK9y1+ADcdfMYEP9YHIlD+W06MJH
         4azQ==
X-Gm-Message-State: AOAM530/ZfmSjiWE5k8Iq69pgyQOxYxum7eeEZi/DpftmtKaTel+4DWs
        CjbPgYSu69GjN0uD+Ww/5BFrtPZmj4tUM9nFsQgEeCAqD/Y=
X-Google-Smtp-Source: ABdhPJxFgbr9yPYAJsmUm8NL5HOG7F0K6Od0TRSE9AW8s6HDlnkd6iuYD3w6QBN/2vR6PqtcHHse1utpw0hkwciA1mA=
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr4992916qke.48.1589573287012;
 Fri, 15 May 2020 13:08:07 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Fri, 15 May 2020 16:09:14 -0400
Message-ID: <CAGeouKHKm+Bzk6=gX_GEJc=faTB8tzwQ7txKVEhdbzK1sf-Z1A@mail.gmail.com>
Subject: [PATCH] Add restorecon -x to not cross FS boundaries
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, the following patch adds a -x option to restorecon to prevent
it from crossing filesystem boundaries, as requested in
https://github.com/SELinuxProject/selinux/issues/208.

As per Stephen Smalley's suggestion, this is accomplished using
r_opts.xdev = SELINUX_RESTORECON_XDEV;

Please do let me know if there are any errors in this, it's been over
two decades since I've lurked in majordomo lists and about as long
since I've contributed a patch via email. (In particular, I am having
issues with sending plaintext, so spaces in the patch are munged; any
pointers on correcting than in the gmail web client would be more than
welcome.)

Thanks,

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP

From: Peter Whittaker <pww@edgekeep.com>

As per #208, add the option -x to prevent restorecon from cross file
system boundaries, by setting SELINUX_RESTORECON_XDEV iff
iamrestorecon. If setfiles, call usage().

Signed-off-by: Peter Whittaker <pww@edgekeep.com>

From 3a1c4a3e94f18bb240f663fb5fbcff77068e5c4a Mon Sep 17 00:00:00 2001
From: Peter Whittaker <pww@EdgeKeep.com>
Date: Fri, 15 May 2020 13:05:27 -0400
Subject: [PATCH] Add restorecon -x to not cross FS boundaries

As per #208, add the option -x to prevent restorecon from cross file
system boundaries, by setting SELINUX_RESTORECON_XDEV iff
iamrestorecon. If setfiles, call usage().
---
 policycoreutils/setfiles/setfiles.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c
b/policycoreutils/setfiles/setfiles.c
index 16bd592ca..2d0224bb6 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -43,8 +43,8 @@ static __attribute__((__noreturn__)) void
usage(const char *const name)
 {
  if (iamrestorecon) {
  fprintf(stderr,
- "usage:  %s [-iIDFmnprRv0] [-e excludedir] pathname...\n"
- "usage:  %s [-iIDFmnprRv0] [-e excludedir] -f filename\n",
+ "usage:  %s [-iIDFmnprRv0x] [-e excludedir] pathname...\n"
+ "usage:  %s [-iIDFmnprRv0x] [-e excludedir] -f filename\n",
  name, name);
  } else {
  fprintf(stderr,
@@ -386,6 +386,13 @@ int main(int argc, char **argv)
  case '0':
  null_terminated = 1;
  break;
+ case 'x':
+ if (iamrestorecon) {
+ r_opts.xdev = SELINUX_RESTORECON_XDEV;
+ } else {
+ usage(argv[0]);
+ }
+ break;
  case 'h':
  case '?':
  usage(argv[0]);
--
