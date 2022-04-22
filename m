Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E22EC433EF
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 01:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443083AbiDVBfT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443071AbiDVBfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 21:35:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4AB49F17
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 18:32:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n10-20020a25da0a000000b0064149e56ecaso5908036ybf.2
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eQsf5nicRRkooM+lPXT1i7kU80hx8qfA2QKyrV7j43E=;
        b=H0TY2pwXZRgytNxh3KspS7rSXdUAuP00gjDwEB+/SKqhgFjUBskIUUXjQbQrNKOGNz
         phnFArg4RdKRUgLkURBkzIeV2JOr/h+u7nPZ+KL6T5+qd8y3GXWzRh+TWJWcreEtXGYz
         P/+lqJIKmZxxpWanOz1F1onAfVWxGeCCo2dHh88l3d3q8SVY07u/kJWxyccDWYVrgM+J
         kNh81ABIVV2VBHOpm7o00Y0kq86ENBu9KaqwLITWH4Ho5b2PoH+cQ0i9ot2ldqZcFai2
         RVYdyK4whDEPxGP4xXceor9QkTiO998n2P/as90CU3w0cjJvHddlpfYBKxweeMeTaclr
         63YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eQsf5nicRRkooM+lPXT1i7kU80hx8qfA2QKyrV7j43E=;
        b=qtApuTjoDYCyHPQdl8ckZM5hsZ5YQBbQMRIRez1/QCkAR7yk4n3SlZi0rezsMZgCw5
         1qwXIWV3UaHNvztJLyy91daq8rDl1X2dhOhIigMvffi9uuN7ESZ1gHp19/gZb1ZSb6ty
         RdJoeqbatXQmYUjoNykz5/ka7fnD1Va6X36WtZsoYfCxaUTIWm8NEd5J/RAIJlKvXMeb
         XXtKWY29kJJkXEJicNfvcobZ0QFtnLdJmi2ZhgvsJ8MfIwSVLETVjNmM6ITUWHSJQUTM
         Sg3vpcW7v5sEbUAYN3mVjJRAat8nUIADjW+y+JNa3jS5G4Mv/FRCt0xSmhG+3dsHd4dS
         2QLg==
X-Gm-Message-State: AOAM532bdFyoGKrBrP+DZJf5Wu3XUL6uyrRUfbZ4q1epenCawJxYg/e/
        gxiZS83NvUQd7PQ8/zkL0e+i2Zts+g==
X-Google-Smtp-Source: ABdhPJzAd9VmD7psH97oeNGynxoYxQ224gs9qO/ix+P/PSWQya4fbwYFqBTmyc1V0j9TkylV6BY2XSlLMg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a81:d551:0:b0:2f4:e3c9:c0e1 with SMTP id
 l17-20020a81d551000000b002f4e3c9c0e1mr2458358ywj.125.1650591147043; Thu, 21
 Apr 2022 18:32:27 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:32:15 +1000
Message-Id: <20220422013215.2301793-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Device drivers may decide to not load firmware when probed to avoid
slowing down the boot process should the firmware filesystem not be
available yet. In this case, the firmware loading request may be done
when a device file associated with the driver is first accessed. The
credentials of the userspace process accessing the device file may be
used to validate access to the firmware files requested by the driver.
Ensure that the kernel assumes the responsibility of reading the
firmware.

This was observed on Android for a graphic driver loading their firmware
when the device file (e.g. /dev/mali0) was first opened by userspace
(i.e. surfaceflinger). The security context of surfaceflinger was used
to validate the access to the firmware file (e.g.
/vendor/firmware/mali.bin).

Because previous configurations were relying on the userspace fallback
mechanism, the security context of the userspace daemon (i.e. ueventd)
was consistently used to read firmware files. More devices are found to
use the command line argument firmware_class.path which gives the kernel
the opportunity to read the firmware directly, hence surfacing this
misattribution.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2: Add comment

 drivers/base/firmware_loader/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 94d1789a233e..8f3c2b2cfc61 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -735,6 +735,8 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw =3D NULL;
+	struct cred *kern_cred =3D NULL;
+	const struct cred *old_cred;
 	bool nondirect =3D false;
 	int ret;
=20
@@ -751,6 +753,18 @@ _request_firmware(const struct firmware **firmware_p, =
const char *name,
 	if (ret <=3D 0) /* error or already assigned */
 		goto out;
=20
+	/*
+	 * We are about to try to access the firmware file. Because we may have b=
een
+	 * called by a driver when serving an unrelated request from userland, we=
 use
+	 * the kernel credentials to read the file.
+	 */
+	kern_cred =3D prepare_kernel_cred(NULL);
+	if (!kern_cred) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	old_cred =3D override_creds(kern_cred);
+
 	ret =3D fw_get_filesystem_firmware(device, fw->priv, "", NULL);
=20
 	/* Only full reads can support decompression, platform, and sysfs. */
@@ -776,6 +790,8 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 	} else
 		ret =3D assign_fw(fw, device);
=20
+	revert_creds(old_cred);
+
  out:
 	if (ret < 0) {
 		fw_abort_batch_reqs(fw);
--=20
2.36.0.rc2.479.g8af0fa9b8e-goog

