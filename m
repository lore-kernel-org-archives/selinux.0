Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A786C433F5
	for <selinux@archiver.kernel.org>; Mon,  2 May 2022 00:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356359AbiEBAyE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 May 2022 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356457AbiEBAxu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 May 2022 20:53:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D510FD1
        for <selinux@vger.kernel.org>; Sun,  1 May 2022 17:50:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l72-20020a63914b000000b003c1ac4355f5so3047386pge.4
        for <selinux@vger.kernel.org>; Sun, 01 May 2022 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FOMU61QtLNIhCcO443IaAbPythoovtkrDMR8bH0Vhu8=;
        b=H/HLblGgD5zGZse8AT1acfVSeM49QjDg79wsGCl7L9/XBqXSNg3gxiHjZgEG6HpQ8q
         aLNKL7jPld9jWS5findWpdmJJfvyxQ8xz6bEgteN1jSTAbP2tOpaFN+Hc+1xSAPtUztJ
         wrA75uF5O0XKkM1LYMsmUUkvXmbZRRU5b/1UWvKM1ZuiE8DAc2PuhbTXRbgoTmzKq8lY
         H39d6lX/9SnLCKOlxd+IrkhPKOkaD1UZWZuov5ADI/UqKCsHZvyTBMuxWWjDrfWJ9x0k
         4oJOWcjxbsxuTi5hBNDLfd2BDE1U7eVN03avaJjXaJAEtdpIonXWl4+A2QlaUt/64b/+
         ZR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FOMU61QtLNIhCcO443IaAbPythoovtkrDMR8bH0Vhu8=;
        b=gt/UHNqk3VXJjlLbWNCVD+h9ey+3/phUPwECcOoK9NVSvAzwc8Fp6oD0l1kYxQyUJ/
         0gTHWt3FpTkvgMq07PZkWwnUMeOTHl1XISCNgdWhIuY59QMw/a6Ro3Qg9cyKeKLtWjzS
         +AQbySODwwr+YOcuESh2oUBjiukaFLwAn/JY6+YyK7+rftJ7Gb6+UvIWiBlpIDTh09/2
         QHvrCuvNZaY7c1ySnZvtT4q7zzaOQJaCHcO+/AHbQ+BGyO4FNbpfPwKcczNO4aTw0cSB
         wcfL/q93hI7sL0VkbFgROXsDOuui7kGkmVWDCk/fsQtODsr+u3cdz06vd6ZQvHRxpxDz
         rgnQ==
X-Gm-Message-State: AOAM531d5/8n9p627Iwgd5BnIP3UZWGLURLYE49QFlVsLOvTyVFA2CXl
        7iuWgH2ROcYGKv4WV1b5T2HzuwP9ow==
X-Google-Smtp-Source: ABdhPJwSd2rb9tf3DwgKCKN7b010akS/OEJ9N3Mh3m5C9KDQB9QenIfe6km5KgRs4wnXspScktDrWXynGg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a17:902:f28b:b0:15c:5c21:dc15 with SMTP id
 k11-20020a170902f28b00b0015c5c21dc15mr9690735plc.16.1651452621491; Sun, 01
 May 2022 17:50:21 -0700 (PDT)
Date:   Mon,  2 May 2022 10:49:52 +1000
Message-Id: <20220502004952.3970800-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        John Stultz <jstultz@google.com>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        stable@vger.kernel.org
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

Previously, Android configurations were not setting up the
firmware_class.path command line argument and were relying on the
userspace fallback mechanism. In this case, the security context of the
userspace daemon (i.e. ueventd) was consistently used to read firmware
files. More Android devices are now found to set firmware_class.path
which gives the kernel the opportunity to read the firmware directly
(via kernel_read_file_from_path_initns). In this scenario, the current
process credentials were used, even if unrelated to the loading of the
firmware file.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Cc: <stable@vger.kernel.org> # 5.10
---
v4: Add stable to Cc
v3:
	- Add call to put_cred to avoid a memory leak. Confirmed that no new
		memory leak occurs on a Pixel 4a.
	- Update commit log.
v2: Add comment

 drivers/base/firmware_loader/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 94d1789a233e..406a907a4cae 100644
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
@@ -776,6 +790,9 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 	} else
 		ret =3D assign_fw(fw, device);
=20
+	revert_creds(old_cred);
+	put_cred(kern_cred);
+
  out:
 	if (ret < 0) {
 		fw_abort_batch_reqs(fw);
--=20
2.36.0.464.gb9c8b46e94-goog

