Return-Path: <SRS0=YXBU=Z5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322FC43603
	for <selinux@archiver.kernel.org>; Sat,  7 Dec 2019 00:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1920637
	for <selinux@archiver.kernel.org>; Sat,  7 Dec 2019 00:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJXKnUkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLGARl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:17:41 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:37903 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLGARk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Dec 2019 19:17:40 -0500
Received: by mail-pg1-f169.google.com with SMTP id a33so3913561pgm.5
        for <selinux@vger.kernel.org>; Fri, 06 Dec 2019 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NXRpf3teo9zD7/4xIBOoEWwZWibxTbOpSaJc2moPEMs=;
        b=iJXKnUkWvGOYbp2f5555kmlNopu/UFNpDj0ylfNQs98MVDIMdeHndEkFzarabZC7Wv
         DlYRjiSRYJezON0ExeFuzsudoKbsUFOKl9p5Ujzxi/ss2ufR5ExNUEEzqrmx8h5zyiy/
         hyzwustjqojveYoJp8L2GLXyqU0KU09M/UpqsCLjrBSSwe2mjMHxEM00oJZDe+FjnetI
         oVAfPwxy4YpW58NfwJ3A9P/RIszrSglKi1dU1Tu7z8+RBPK8W4H3xdtNdhx6Ae4vEdPX
         3RiDXocsYxRDoiDxBya8RseCQrSSoUA7iyDOKKFQbAsmE+G6zT3l0xcxpVV0UFRld+Hj
         JUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NXRpf3teo9zD7/4xIBOoEWwZWibxTbOpSaJc2moPEMs=;
        b=OKM5KmxMh73no7p3K4/MWVzNTNtTCeQQR3WMv4xD6WRzMJvSzP5d/s15d/fjuBYbAz
         7KcyeX7Yf5xunZzZc6pUWHVbulc9MFZgBJ0yxkMVWovoFSRCimIFdsIxnFNVG9hfyb6U
         1sbPnM7K/butzTwOipPHNb0eXsib9FPtM/kdHl2OGAMVs1wTT4QReZFMmQDKzNT8y1gF
         H86aWmjubUFKdyX+n02iWoffYGw5FVaD4f4S+vLk+OOwc2Pzi5tWdHGlcuskNNYdVj1U
         /71Fo6F+tQuBkqE1vt5KhoeuvEGMxo1CLzKMwabPTP+Ph6I/ndR69OIT8UEXrscoRF11
         2b2Q==
X-Gm-Message-State: APjAAAUymBEbory/+Xm6iuV1V/AMqBjtL1OjChUvu5AMRikfhrCmXtm/
        DluSAfAfPkjwJttf3oqID+GvIBfCH842M5Vg7nrOM9NC
X-Google-Smtp-Source: APXvYqzERCn2H/8SuBzKYHy6bYz+ekx6fWxeetYVXMdb4dpCokAYEkAt3c70G0SA73Mt2e6OsYx28FCcgi1u6DiDWTE=
X-Received: by 2002:aa7:9567:: with SMTP id x7mr17408764pfq.133.1575677859766;
 Fri, 06 Dec 2019 16:17:39 -0800 (PST)
MIME-Version: 1.0
From:   Joshua Schmidlkofer <joshland@gmail.com>
Date:   Fri, 6 Dec 2019 16:17:44 -0800
Message-ID: <CAHduLLQV07RPLcV-3ffaebEosQS_DRAk_7ZconHbdkx8oAHejQ@mail.gmail.com>
Subject: [PATCH] python/semanage: check variable type of port before trying to split
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While using Ansible's Selinux module to manage ports, I discovered
that numerical ports caused an unhandled exception in 'seobject.py'.
This appears to be a bug, and I am proposing a fix which checks the
type of the argument before operating on it.  This maintains the
original functionality in the case of a string, and acts in the same
fashion if you supply an integer.

I did not find any open bug report against the SELinux project. The
downstream bug report is here:
https://github.com/ansible/ansible/issues/60968


Signed-off-by: Joshua Schmidlkofer <joshua@joshuainnovates.us>
---
 python/semanage/seobject.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index dc413ca5..0e9ce290 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1070,7 +1070,11 @@ class portRecords(semanageRecords):
         if port == "":
             raise ValueError(_("Port is required"))

-        ports = port.split("-")
+        if isinstance(port, str):
+            ports = port.split('-', 1)
+        else:
+            ports = (port,)
+
         if len(ports) == 1:
             high = low = int(ports[0])
         else:
--
2.23.0
