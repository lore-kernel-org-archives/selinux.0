Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EACC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002A720781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d6Z5C7sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgHDBdp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31646C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g26so37104093qka.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=dI103vdqyGcVlIl5+VUq0P5t55uuTpMc/MxyiAd6DuM=;
        b=d6Z5C7sl8xoE0fxDe75Ku7tcB3RyCn0fE6ccWX8NqSfEtX8QkM9raE/mwBsqMET07d
         f0G/lju9rV4cUjp2jFYYNG4YZiQuDQpYLiEt6FQNfx0F6MDwlRakbeBcV0mEBVqIbzA3
         GkW73pKEOGxtXDTwTY4jL0oQdYFWwqAX+T9Us86VtXndUZFijr765vp7V5ZjfnjSiiBG
         dLUt6Ylchokiq4Vn1NnArkcqdLQRPCny9LTaIy8Ek8xV2MF3aKsC3SYzSIpbCt910S8d
         YqAdxwqGbG72XXKNxB1W0Sa3WmR4te9vvK7HVSae1eunaiF6yHuebLwa1IIs2tPngRQc
         DkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dI103vdqyGcVlIl5+VUq0P5t55uuTpMc/MxyiAd6DuM=;
        b=keXFiHzHhx6tK1rSo6NbfJShDNiLDfuDCIhI2uIWPbpVPhOtUZTO3nwh03O+W4Fn/D
         2Eqfww30lHX3IyocEreRqKAgR9MOmPJVjRAEBubi9b7TCO1i5fD3dZO+vVmxfSJRkyBa
         6wfRQ6OpFTaW+iuid3vHpz+dD+daMN0i9a1SGCbhd5bol6DbONEB2M6OR96NJkL+99Aj
         8Ih1m6yc9cYDGtFDAaFe+f+NoR+JVtD2Dh7i+mGGsTBk+gh7rsRNlWjKzQ7/U3iQxjOW
         apvhgPMd10Y9VY/5mcLbtptdHnVCsRaMrqGWdP2/W0wweUbg5dIYacddRF9YisMXx/YP
         FZVw==
X-Gm-Message-State: AOAM531uuZeXrhIvBp0vIpmO5zXPk86e5Q2CjD4Jc8w2y1hmOciiQyUS
        6VKMKAQRRivujBrOI6kR7HZNbTOfZM1S
X-Google-Smtp-Source: ABdhPJz1LRXl8Rtz/z3lGohLopO6e5AdcETvBaJ4rOAetAO1mPi++uuG3PZNWDPsoirxZu4jxBOixg==
X-Received: by 2002:a37:a882:: with SMTP id r124mr14461038qke.56.1596504823596;
        Mon, 03 Aug 2020 18:33:43 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id l189sm21236963qke.67.2020.08.03.18.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:42 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 04/18] x_windows: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:42 -0400
Message-ID: <159650482221.8961.7779250010228783136.stgit@sifl>
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

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/x_windows.md |  330 +++++++++++++++++++++++++++---------------------------
 1 file changed, 163 insertions(+), 167 deletions(-)

diff --git a/src/x_windows.md b/src/x_windows.md
index e2625f7..86f966e 100644
--- a/src/x_windows.md
+++ b/src/x_windows.md
@@ -68,7 +68,8 @@ time, then the X-function will only succeed if allowed by all the
 security extensions in the chain.
 
 This interface is defined in the
-"[**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf)". The specification also defines the hooks available to OMs and
+"[**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf)".
+The specification also defines the hooks available to OMs and
 how they should be used. The provision of polyinstantiation services for
 properties and selections is also discussed. The XACE interface is a
 similar service to the LSM that supports the kernel OMs.
@@ -85,8 +86,6 @@ managers such as Gnome, twm or KDE.
 [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
 section.
 
-<br>
-
 ## Polyinstantiation
 
 The OM / XACE services support polyinstantiation of properties and
@@ -104,8 +103,6 @@ polyinstantiation, instead the MLS policy uses
 [**`mlsconstrain`**](constraint_statements.md#mlsconstrain) to limit the scope
 of properties and selections.
 
-<br>
-
 ## Configuration Information
 
 This section covers:
@@ -234,167 +231,169 @@ client * system_u:object_r:remote_t:s0
 A full description of the *x_contexts* file format is given in the
 [***x_contexts***](policy_config_files.md#contextsx_contexts) section.
 
-<br>
-
 ## SELinux Extension Functions
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Function Name</strong></td>
-<td><strong>Minor Parameters</strong></td>
-<td><strong>Opcode</strong></td>
-<td><strong>Comments</strong></td>
-</tr>
-<tr>
-<td>XSELinuxQueryVersion</td>
-<td>0</td>
-<td>None</td>
-<td>Returns the XSELinux version. Fedora returns 1.1</td>
-</tr>
-<tr>
-<td>XSELinuxSetDeviceCreateContext</td>
-<td>1</td>
-<td>Context+Len</td>
-<td>Sets the context for creating a device object (<em>x_device</em>).</td>
-</tr>
-<tr>
-<td>XSELinuxGetDeviceCreateContext</td>
-<td>2</td>
-<td>None</td>
-<td>Retrieves the context set by <em>XSELinuxSetDeviceCreateContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxSetDeviceContext</td>
-<td>3</td>
-<td>DeviceID + Context+Len</td>
-<td>Sets the context for creating the specified DeviceID object.</td>
-</tr>
-<tr>
-<td>XSELinuxGetDeviceContext</td>
-<td>4</td>
-<td>DeviceID</td>
-<td>Retrieves the context set by <em>XSELinuxSetDeviceContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxSetWindowCreateContext</td>
-<td>5</td>
-<td>Context+Len</td>
-<td>Set the context for creating a window object (<em>x_window</em>).</td>
-</tr>
-<tr>
-<td>XSELinuxGetWindowCreateContext</td>
-<td>6</td>
-<td>None</td>
-<td>Retrieves the context set by <em>XSELinuxSetWindowCreateContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxGetWindowContext</td>
-<td>7</td>
-<td>WindowID</td>
-<td>Retrieves the specified WindowID context.</td>
-</tr>
-<tr>
-<td>XSELinuxSetPropertyCreateContext</td>
-<td>8</td>
-<td>Context + Len</td>
-<td>Sets the context for creating a property object (<em>x_property</em>).</td>
-</tr>
-<tr>
-<td>XSELinuxGetPropertyCreateContext</td>
-<td>9</td>
-<td>None</td>
-<td>Retrieves the context set by <em>XSELinuxSetPropertyCreateContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxSetPropertyUseContext</td>
-<td>10</td>
-<td>Context + Len</td>
-<td>Sets the context of the property object to be retrieved when polyinstantiation is being used.</td>
-</tr>
-<tr>
-<td>XSELinuxGetPropertyUseContext</td>
-<td>11</td>
-<td>None</td>
-<td>Retrieves the property object context set by <em>SELinuxSetPropertyUseContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxGetPropertyContext</td>
-<td>12</td>
-<td>WindowID + AtomID</td>
-<td>Retrieves the context of the property atom object.</td>
-</tr>
-<tr>
-<td>XSELinuxGetPropertyDataContext</td>
-<td>13</td>
-<td>WindowID + AtomID</td>
-<td>Retrieves the context of the property atom data. </td>
-</tr>
-<tr>
-<td>XSELinuxListProperties</td>
-<td>14</td>
-<td>WindowID</td>
-<td>Lists the object and data contexts of properties associated with the selected WindowID.</td>
-</tr>
-<tr>
-<td>XSELinuxSetSelectionCreateContext</td>
-<td>15</td>
-<td>Context+Len</td>
-<td>Sets the context to be used for creating a selection object.</td>
-</tr>
-<tr>
-<td>XSELinuxGetSelectionCreateContext</td>
-<td>16</td>
-<td>None</td>
-<td>Retrieves the context set by <em>SELinuxSetSelectionCreateContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxSetSelectionUseContext</td>
-<td>17</td>
-<td>Context+Len</td>
-<td>Sets the context of the selection object to be retrieved when polyinstantiation is being used. See the <em>XSELinuxListSelections</em> function for an example.</td>
-</tr>
-<tr>
-<td>XSELinuxGetSelectionUseContext</td>
-<td>18</td>
-<td>None</td>
-<td>Retrieves the selection object context set by <em>SELinuxSetSelectionUseContext</em>.</td>
-</tr>
-<tr>
-<td>XSELinuxGetSelectionContext</td>
-<td>19</td>
-<td>AtomID</td>
-<td>Retrieves the context of the specified selection atom object.</td>
-</tr>
-<tr>
-<td>XSELinuxGetSelectionDataContext</td>
-<td>20</td>
-<td>AtomID</td>
-<td>Retrieves the context of the selection data from the current selection owner (<em>x_application_data</em> object).</td>
-</tr>
-<tr>
-<td>XSELinuxListSelections</td>
-<td>21</td>
-<td>None</td>
-<td><p>Lists the selection atom object and data contexts associated with this display. The main difference in the listings is that when (for example) the <em>PRIMARY</em> selection atom is polyinstantiated, multiple entries can returned. One has the context of the atom itself, and one entry for each process (or x-client) that has an active polyinstantiated entry, for example:</p>
-<p>Atom: PRIMARY - label defined in the<em> x_contexts</em> file (this is also for non-poly listing):</p>
-<p>Object Context: system_u:object_r:primary_xselection_t</p>
-<p>Data Context:  system_u:object_r:primary_xselection_t</p>
-<p>Atom: PRIMARY - Labels for client 1:</p>
-<p>Object Context: system_u:object_r:x_select_paste1_t</p>
-<p>Data Context:  system_u:object_r:x_select_paste1_t</p>
-<p>Atom: PRIMARY - Labels for client 2:</p>
-<p>Object Context: system_u:object_r:x_select_paste2_t</p>
-<p>Data Context:  system_u:object_r:x_select_paste2_t</p></td>
-</tr>
-<tr>
-<td><em><em>XSELinuxGetClientContext</em></em></td>
-<td><em><em>22</em></em></td>
-<td><em><em>ResourceID</em></em></td>
-<td><em><em>Retrieves the client context of the specified ResourceID.</em></em></td>
-</tr>
-</tbody>
-</table>
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxQueryVersion              | 0                | None       |
+
+Returns the XSELinux version. Fedora returns 1.1.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetDeviceCreateContext    | 1                | Context + Len         |
+
+Sets the context for creating a device object (*x_device*).
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetDeviceCreateContext    | 2                | None                  |
+
+Retrieves the context set by *XSELinuxSetDeviceCreateContext*.
+
+| Function Name                   | Minor Parameter | Opcode                   |
+| ------------------------------- | --------------- | ------------------------ |
+| XSELinuxSetDeviceContext        | 3               | DeviceID + Context + Len |
+
+Sets the context for creating the specified DeviceID object.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetDeviceContext          | 4                | DeviceID              |
+
+Retrieves the context set by *XSELinuxSetDeviceContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetWindowCreateContext    | 5                | Context + Len         |
+
+Set the context for creating a window object (*x_window*).
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetWindowCreateContext    | 6                | None                  |
+
+Retrieves the context set by *XSELinuxSetWindowCreateContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetWindowContext          | 7                | WindowID              |
+
+Retrieves the specified WindowID context.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetPropertyCreateContext  | 8                | Context               |
+
+Sets the context for creating a property object (*x_property*).
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetPropertyCreateContext  | 9                | None                  |
+
+Retrieves the context set by *XSELinuxSetPropertyCreateContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetPropertyUseContext     | 10               | Context + Len         |
+
+Sets the context of the property object to be retrieved when polyinstantiation
+is being used.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetPropertyUseContext     | 11               | None                  |
+
+Retrieves the property object context set by *SELinuxSetPropertyUseContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetPropertyContext        | 12               | WindowID + AtomID     |
+
+Retrieves the context of the property atom object.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetPropertyDataContext    | 13               | WindowID + AtomID     |
+
+Retrieves the context of the property atom data.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxListProperties            | 14               | WindowID              |
+
+Lists the object and data contexts of properties associated with the selected
+WindowID.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetSelectionCreateContext | 15               | Context + Len         |
+
+Sets the context to be used for creating a selection object.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetSelectionCreateContext | 16               | None                  |
+
+Retrieves the context set by *SELinuxSetSelectionCreateContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxSetSelectionUseContext    | 17               | Context + Len         |
+
+Sets the context of the selection object to be retrieved when polyinstantiation
+is being used. See the *XSELinuxListSelections* function for an example.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetSelectionUseContext    | 18               | None                  |
+
+Retrieves the selection object context set by *SELinuxSetSelectionUseContext*.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetSelectionContext       | 19               | AtomID                |
+
+Retrieves the context of the specified selection atom object.
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetSelectionDataContext   | 20               | AtomID                |
+
+Retrieves the context of the selection data from the current selection owner
+(*x_application_data* object).
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxListSelections            | 21               | None                  |
+
+Lists the selection atom object and data contexts associated with this display.
+The main difference in the listings is that when (for example) the *PRIMARY*
+selection atom is polyinstantiated, multiple entries can returned. One has the 
+context of the atom itself, and one entry for each process (or x-client) that
+has an active polyinstantiated entry, for example:
+
+Atom: PRIMARY - label defined in the *x_contexts* file (this is also for
+non-poly listing):
+
+- Object Context: *system_u:object_r:primary_xselection_t*
+- Data Context: *system_u:object_r:primary_xselection_t*
+
+Atom: PRIMARY - Labels for client 1:
+
+- Object Context: *system_u:object_r:x_select_paste1_t*
+- Data Context: *system_u:object_r:x_select_paste1_t*
+
+Atom: PRIMARY - Labels for client 2:
+
+- Object Context: *system_u:object_r:x_select_paste2_t*
+- Data Context: *system_u:object_r:x_select_paste2_t*
+
+| Function Name                     | Minor Parameters | Opcode                |
+| --------------------------------- | ---------------- | --------------------- |
+| XSELinuxGetClientContext          | 22               | ResourceID            |
+
+Retrieves the client context of the specified ResourceID.
 
 **Table 12: The XSELinux Extension Functions** - *Supported by the object
 manager as X-protocol extensions. Note that some functions will return
@@ -402,9 +401,6 @@ the default contexts, while others (2, 6, 9, 11, 16, 18) will not return
 a value unless one has been set the the appropriate function (1, 5, 8,
 10, 15, 17) by an SELinux-aware application.*
 
-
-<br>
-
 <!-- %CUTHERE% -->
 
 ---

