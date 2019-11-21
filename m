Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B50C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E8206CC
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=joshuainnovates-us.20150623.gappssmtp.com header.i=@joshuainnovates-us.20150623.gappssmtp.com header.b="qnUR3PPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKURgv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:36:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42756 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKURgv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 12:36:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id b16so3663811otk.9
        for <selinux@vger.kernel.org>; Thu, 21 Nov 2019 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joshuainnovates-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ztI1h0nrX91hNmJqqJs6AXeQmsoWdAOjC/I3yopqNUk=;
        b=qnUR3PPRLl3l5WysfwnfFWza416OCP5570nqWI/7LlL8ClIIgcOp4yhNZXlC62Q8Fo
         a06LTJ85g6Y4BLMND8m4F5DFMr2uop+YYI1PALA993UGQaf8DEBPBDfl9otDoStzHDXK
         AwHfldSrTHXiHZWVmpd2gzbCnDl03zJi1nGhqWL20mZF4rAfBpjrHo0mHNpHv3hdDvJk
         ufMDDETCbTv1dEQpbS5ykSMVFnxDGGHCDenr02T7furXoYFKkQbqIJGD4ueqLA6yH3op
         nWFblLkf525V01c53HctCHy28eZaHhUUAygkYQqUsRuo3AZPxU5NbmVmVXnLDZOwYzv7
         YCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ztI1h0nrX91hNmJqqJs6AXeQmsoWdAOjC/I3yopqNUk=;
        b=To8sBi2nHRrDOf/vZicCAWOpR9ixt45/QM10rVmh5HtkAs+k2YDU05G5sJpC87fE+y
         oGtrHUvOrZQcLLJiZ11bPzHM85FekB9e5FLo51Uf3sgK1JvAzdbfdPztP5u2xbMcXr++
         etKwLyU8rNTrCMn8riZPAp2F84zUhNK4KuEQApSirS2c1D/fMTcdsu9uoJaINh4LiLdB
         3JeOBVDnOPZ6WbJ6TH5iL7atlAwnCc0w/WFOkQaInysCnvXo+Bcx5VsrHXc75H4XRXd5
         3RVysjn90/Pv8fYhAv60Ph/WJBH2Q7N7R30FsglGwT1h8jbsK0aNQ6f4azZyPruN8YTC
         vi8Q==
X-Gm-Message-State: APjAAAWbMsYcv+aZqxI2eBWEt1VIDnU+HDRXFG4iRNf6xmkP/jJEoMQv
        DYmRSYCQj7H24xmWJtLobKgiFKiFHkCsAMRO/ryUjPM+A/k=
X-Google-Smtp-Source: APXvYqwyzVstRBKAXceAenYxEFDOmR/5OTHab2It99DGRA6JxUG7hAHPpSrh4OCdjQbmo5VCwxV/K7IV3wC+Wdp9mPg=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr7541518otj.239.1574357809783;
 Thu, 21 Nov 2019 09:36:49 -0800 (PST)
MIME-Version: 1.0
From:   Joshua Schmidlkofer <joshua@joshuainnovates.us>
Date:   Thu, 21 Nov 2019 09:36:34 -0800
Message-ID: <CAOCpKqn51K_QEzk__doirKztMPTZMuKoqBSDW4wdoWbfoPhNVw@mail.gmail.com>
Subject: [PATCH] Fix: check variable type of port before trying to split                                          
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I ran into a bug passing port numbers are integers to the python
policy tools.  Here is a proposed fix.

Signed-off-by: Joshua Schmidlkofer <joshua@joshuainnovates.us>
---
 python/semanage/seobject.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index dc413ca5..c067222d 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1070,13 +1070,17 @@ class portRecords(semanageRecords):
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
             low = int(ports[0])
             high = int(ports[1])
-
+
         if high > 65535:
             raise ValueError(_("Invalid Port"))

-- 
2.23.0
