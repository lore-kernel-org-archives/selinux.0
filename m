Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E3C433F5
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 17:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJJRVK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJJRVE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 13:21:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75C26AE3
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 10:21:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d26so19165582eje.10
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Upwuzx0snW0MV+uTk0NJ1z84aslBk1ETaN81UiW/eUo=;
        b=IrqKY8X1EWULyWY+DrS5cphyk2Z7dV5L4msjYp86nxfV2De1VTjdsn3vnkmySSsrx0
         QzxkK4npF592JjhxSoTj4ikneIi9zJSdRNBHzlnXxs1t4w/o0pdn4/797hpN3Cxd6/41
         j5+5THqNg7MQ4jfg9UPevsxDYRvrUKEwlhbFdfpS4cBv5ZiqaxWI1NhZt0cYMcHSZ8xd
         vBmH6lEOVhtEJBCX3aSD9wPV3VONYbIgkC9jIpJJthDsqpBium+3lftzSsm32ZhIaKXf
         yw3bjhsCrUN+VfYnQ/ImSRYF0Wi1ZaKEPd5o2fZCCZkUkH8OofeoQ/fNqYATX81zsRdT
         V/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Upwuzx0snW0MV+uTk0NJ1z84aslBk1ETaN81UiW/eUo=;
        b=kPJ8xyVnxdzivZMzzO0jjlK+YToav1nWbexjhffwBgM3Lz62REsOvGexa122CytpMt
         oWDTA3PeXa5xtyWq8YUJSZNcy1E2AV7HdWEZPXTBJx7ZJwey+Dnr1lqxe6nn4u66dwXN
         sAvQ9KOd6xQalxDt8T09U389xUpMHO2Tk0Avh9phV5CREXR5qaP1GCAfYfEfLu/O0Hh/
         Fm3Q1RPQCCFdsb8JCp6aZ2/Fz5Zc9dygqqiZktQ4P8Tjjx2YZ60t1JAU7idDfWxl9JOo
         zqjk721A2XKRM5If+1wcV9cz2x2vP5VALBdwbGsHbdD7CtFwuXqxW4Cace23MktVOgMM
         0gbQ==
X-Gm-Message-State: ACrzQf3yewGmz1ahuIC5x+yLfjNvH/sUFDsSiScsasAyNp48/UTqOi8d
        Qp8j5d0fBbP/VzHKWSM8vq7KrDLZMimmFZfC9TbTqB4je0Y=
X-Google-Smtp-Source: AMsMyM6e0dhpRwbmzF8Q5YInWAsb81wdyuPDiD9SeNoDHc2Wc2FS+2CK4W47qtwir/6PPWcrkjayjbxYB5j8F4ZvJMM=
X-Received: by 2002:a17:907:2ce8:b0:78d:49a8:4f54 with SMTP id
 hz8-20020a1709072ce800b0078d49a84f54mr15365696ejc.577.1665422460423; Mon, 10
 Oct 2022 10:21:00 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Mon, 10 Oct 2022 12:20:49 -0500
Message-ID: <CAFPpqQFxHtjJ-8FQpB71WHhHwOgREGwU4TexjO5Vty8pjM+o3A@mail.gmail.com>
Subject: systemd socket activation selinux context pr review
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'd appreciate it if some committers would review this pull request
and add comments as it seems to have stalled.

https://github.com/systemd/systemd/pull/24702

From 86f28a8638a59cb73800c54b26c0bd5874bc50dc Mon Sep 17 00:00:00 2001
From: "Ted X. Toth" <txtoth@flycast.org>
Date: Tue, 13 Sep 2022 15:27:47 -0700
Subject: [PATCH] Use target process context to set socket context when using
 SELinuxContextFromNet not systemds context

---
 src/core/socket.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/src/core/socket.c b/src/core/socket.c
index f67a79705499..ad0e81607807 100644
--- a/src/core/socket.c
+++ b/src/core/socket.c
@@ -1409,39 +1409,27 @@ static int
socket_determine_selinux_label(Socket *s, char **ret) {
         assert(s);
         assert(ret);

-        if (s->selinux_context_from_net) {
-                /* If this is requested, get the label from the
network label */
+        Unit *service;
+        ExecCommand *c;
+        _cleanup_free_ char *path = NULL;

-                r = mac_selinux_get_our_label(ret);
-                if (r == -EOPNOTSUPP)
-                        goto no_label;
-
-        } else {
-                /* Otherwise, get it from the executable we are about
to start. */
-
-                Unit *service;
-                ExecCommand *c;
-                _cleanup_free_ char *path = NULL;
-
-                r = socket_load_service_unit(s, -1, &service);
-                if (r == -ENODATA)
-                        goto no_label;
-                if (r < 0)
-                        return r;
-
-                c = SERVICE(service)->exec_command[SERVICE_EXEC_START];
-                if (!c)
-                        goto no_label;
+        r = socket_load_service_unit(s, -1, &service);
+        if (r == -ENODATA)
+                goto no_label;
+        if (r < 0)
+                return r;

-                r = chase_symlinks(c->path,
SERVICE(service)->exec_context.root_directory, CHASE_PREFIX_ROOT,
&path, NULL);
-                if (r < 0)
-                        goto no_label;
+        c = SERVICE(service)->exec_command[SERVICE_EXEC_START];
+        if (!c)
+                goto no_label;

-                r = mac_selinux_get_create_label_from_exe(path, ret);
-                if (IN_SET(r, -EPERM, -EOPNOTSUPP))
-                        goto no_label;
-        }
+        r = chase_symlinks(c->path,
SERVICE(service)->exec_context.root_directory, CHASE_PREFIX_ROOT,
&path, NULL);
+        if (r < 0)
+                goto no_label;

+        r = mac_selinux_get_create_label_from_exe(path, ret);
+        if (IN_SET(r, -EPERM, -EOPNOTSUPP))
+                goto no_label;
         return r;

 no_label:
