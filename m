Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDF4C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273022073E
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vu33aD4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgHDBfS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBfS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:35:18 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5797AC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:35:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t23so26673148qto.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Dc8AYh+xKrW6bt28TiOUk6Y7q3XKmI9/D9m478kISuY=;
        b=vu33aD4saztHtCOIQHLCxZoN2R4/t9bRfXaeHWivjipW3WDlp7seo1u9j99IWX5Cbd
         HD3kA3DLJE3fFwGJk7iqlt4a20C/a+fU8k8I9z8lTCW7lQAqMlVJj7k0V1wMbJE1Mq1K
         U4DBSL9xoOrjE6sJWdwQ6H3tSllBmaMz7ONTK/QEZGyUOkWOdQqf36D0t5l5GLpmd9AZ
         Z4ndrWFtA8SXaCUEB3N7kRGfa4PHUeej5KumjVI2nJbQvqmhfkRPExJmRtiroNhtq7IP
         jw7a2gwvvb2XMHGDqyKVk7mbtNytJuYXLK8hhd/gWABwi/pGNhaeX2LkoURJ//LoWOBy
         j79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Dc8AYh+xKrW6bt28TiOUk6Y7q3XKmI9/D9m478kISuY=;
        b=CvpImKKlPQEnJxjryq2O5ENtFRJ2qOJ1an3GOYIH03rXEdRwiM9F8hOf3Qpf9277Vi
         9kW4iIycH2MJS0MfbpLCXr9jASfxSRpHqOCAhanQodEm7CxgdWVMq6YL+OVxfzAZbDXo
         /YPFGmO8C3bm5Jy3IbEDXuR3RwEv6LWfC7CanPanykRM6jd5MK/oFUt9c1UakP04H4xD
         qFZfR6on6TXYs7joKCnsWCPvWrzDaIR6ww50bfmb5h1rKaBiE969tESAIdPyAAKdjnZw
         Rv0o/0ig+1EFRkQXkGLulgRl1/pYY7Wruefp5d2GN8DtAXneZNxzXKf1ELiUR8ACMPQu
         INhQ==
X-Gm-Message-State: AOAM530sTLAGQ2dh3mAAOzIqIIVpYtyP868Id+B/4neVMolbTIrVkiB2
        +8Atez8lJsmfHio1MPoMZgnFfoByXHul
X-Google-Smtp-Source: ABdhPJxsX+aISkL207IEthO78BoMQ+Kyz/ZwHr1IrSvedI7Uh0d1GFs6b1rHyGT+p5qw/TBV4wAUVA==
X-Received: by 2002:ac8:d4e:: with SMTP id r14mr1351953qti.325.1596504916833;
        Mon, 03 Aug 2020 18:35:16 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id d8sm24130998qtr.12.2020.08.03.18.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:35:16 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 18/18] x_windows: don't call table 12 a
 table
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:35:15 -0400
Message-ID: <159650491552.8961.7366503197541412357.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Richard Haines <richard_c_haines@btinternet.com>

I've removed the Table 12: reference and reworded. This now just looks
like a list.

Also fixed a few minor nits + added a contents list.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/x_windows.md |  146 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 79 insertions(+), 67 deletions(-)

diff --git a/src/x_windows.md b/src/x_windows.md
index 6fdd39e..74edc62 100644
--- a/src/x_windows.md
+++ b/src/x_windows.md
@@ -1,5 +1,14 @@
 # X-Windows SELinux Support
 
+-   [**Infrastructure Overview**](#infrastructure-overview)
+-   [**Polyinstantiation**](#polyinstantiation)
+-   [**Configuration Information**](#configuration-information)
+    -    [**Enable/Disable the OM from Policy Decisions**](#enabledisable-the-om-from-policy-decisions)
+    -    [**Configure OM Enforcement Mode**](#configure-om-enforcement-mode)
+    -    [**Determine OM X-extension Opcode**](#determine-om-x-extension-opcode)
+    -    [**The *x_contexts* File**](#the-x_contexts-file)
+-   [**SELinux Extension Functions**](#selinux-extension-functions)
+
 The SELinux X-Windows (XSELinux) implementation provides fine grained
 access control over the majority of the X-server objects (known as
 resources) using an X-Windows extension acting as the object manager
@@ -53,7 +62,7 @@ information that is required by the OM for labeling certain objects. The
 OM reads its contents using the ***selabel_lookup**(3)* function.
 
 **XSELinux Object Manager** - This is an X-extension for the X-server
-process that mediates all access decisions between the the X-server (via
+process that mediates all access decisions between the X-server (via
 the XACE interface) and the SELinux security server (via *libselinux*).
 The OM is initialised before any X-clients connect to the X-server.
 
@@ -235,21 +244,30 @@ A full description of the *x_contexts* file format is given in the
 
 ## SELinux Extension Functions
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxQueryVersion              | 0                | None       |
+The XSELinux Extension Functions listed below are supported by the object
+manager as X-protocol extensions.
+
+Note that **XSELinuxGet\*** functions return a default context, however
+those with Minor Parameter: 2, 6, 9, 11, 16 and 18 will not return a value
+unless one has been set by the appropriate **XSELinuxSet\*** function (Minor
+Parameter: 1, 5, 8, 10, 15 and 17).
+
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxQueryVersion              | 0               | None                  |
 
 Returns the XSELinux version. Fedora returns 1.1.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxSetDeviceCreateContext    | 1                | Context + Len         |
+
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxSetDeviceCreateContext    | 1               | Context + Len         |
 
 Sets the context for creating a device object (*x_device*).
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetDeviceCreateContext    | 2                | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetDeviceCreateContext    | 2               | None                  |
 
 Retrieves the context set by *XSELinuxSetDeviceCreateContext*.
 
@@ -259,115 +277,115 @@ Retrieves the context set by *XSELinuxSetDeviceCreateContext*.
 
 Sets the context for creating the specified DeviceID object.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetDeviceContext          | 4                | DeviceID              |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetDeviceContext          | 4               | DeviceID              |
 
 Retrieves the context set by *XSELinuxSetDeviceContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
+| Function Name                     | Minor Parameter | Opcode                |
 | --------------------------------- | ---------------- | --------------------- |
 | XSELinuxSetWindowCreateContext    | 5                | Context + Len         |
 
 Set the context for creating a window object (*x_window*).
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetWindowCreateContext    | 6                | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetWindowCreateContext    | 6               | None                  |
 
 Retrieves the context set by *XSELinuxSetWindowCreateContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetWindowContext          | 7                | WindowID              |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetWindowContext          | 7               | WindowID              |
 
 Retrieves the specified WindowID context.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxSetPropertyCreateContext  | 8                | Context               |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxSetPropertyCreateContext  | 8               | Context               |
 
 Sets the context for creating a property object (*x_property*).
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetPropertyCreateContext  | 9                | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetPropertyCreateContext  | 9               | None                  |
 
 Retrieves the context set by *XSELinuxSetPropertyCreateContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxSetPropertyUseContext     | 10               | Context + Len         |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxSetPropertyUseContext     | 10              | Context + Len         |
 
 Sets the context of the property object to be retrieved when polyinstantiation
 is being used.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetPropertyUseContext     | 11               | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetPropertyUseContext     | 11              | None                  |
 
 Retrieves the property object context set by *SELinuxSetPropertyUseContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetPropertyContext        | 12               | WindowID + AtomID     |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetPropertyContext        | 12              | WindowID + AtomID     |
 
 Retrieves the context of the property atom object.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetPropertyDataContext    | 13               | WindowID + AtomID     |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetPropertyDataContext    | 13              | WindowID + AtomID     |
 
 Retrieves the context of the property atom data.
 
-| Function Name                     | Minor Parameters | Opcode                |
+| Function Name                     | Minor Parameter | Opcode                |
 | --------------------------------- | ---------------- | --------------------- |
 | XSELinuxListProperties            | 14               | WindowID              |
 
 Lists the object and data contexts of properties associated with the selected
 WindowID.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxSetSelectionCreateContext | 15               | Context + Len         |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxSetSelectionCreateContext | 15              | Context + Len         |
 
 Sets the context to be used for creating a selection object.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetSelectionCreateContext | 16               | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetSelectionCreateContext | 16              | None                  |
 
 Retrieves the context set by *SELinuxSetSelectionCreateContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxSetSelectionUseContext    | 17               | Context + Len         |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxSetSelectionUseContext    | 17              | Context + Len         |
 
 Sets the context of the selection object to be retrieved when polyinstantiation
 is being used. See the *XSELinuxListSelections* function for an example.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetSelectionUseContext    | 18               | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetSelectionUseContext    | 18              | None                  |
 
 Retrieves the selection object context set by *SELinuxSetSelectionUseContext*.
 
-| Function Name                     | Minor Parameters | Opcode                |
+| Function Name                     | Minor Parameter | Opcode                |
 | --------------------------------- | ---------------- | --------------------- |
 | XSELinuxGetSelectionContext       | 19               | AtomID                |
 
 Retrieves the context of the specified selection atom object.
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetSelectionDataContext   | 20               | AtomID                |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetSelectionDataContext   | 20              | AtomID                |
 
 Retrieves the context of the selection data from the current selection owner
 (*x_application_data* object).
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxListSelections            | 21               | None                  |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxListSelections            | 21              | None                  |
 
 Lists the selection atom object and data contexts associated with this display.
 The main difference in the listings is that when (for example) the *PRIMARY*
@@ -391,18 +409,12 @@ Atom: PRIMARY - Labels for client 2:
 - Object Context: *system_u:object_r:x_select_paste2_t*
 - Data Context: *system_u:object_r:x_select_paste2_t*
 
-| Function Name                     | Minor Parameters | Opcode                |
-| --------------------------------- | ---------------- | --------------------- |
-| XSELinuxGetClientContext          | 22               | ResourceID            |
+| Function Name                     | Minor Parameter | Opcode                |
+| --------------------------------- | --------------- | --------------------- |
+| XSELinuxGetClientContext          | 22              | ResourceID            |
 
 Retrieves the client context of the specified ResourceID.
 
-**Table 12: The XSELinux Extension Functions** - *Supported by the object
-manager as X-protocol extensions. Note that some functions will return
-the default contexts, while others (2, 6, 9, 11, 16, 18) will not return
-a value unless one has been set the the appropriate function (1, 5, 8,
-10, 15, 17) by an SELinux-aware application.*
-
 <!-- %CUTHERE% -->
 
 ---

