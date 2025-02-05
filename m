Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57232214216
	for <selinux@vger.kernel.org>; Wed,  5 Feb 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789161; cv=none; b=Ue6N3Cmdv1sKeG38I0qcPj7sh8yYAu99jVvktZfIs+9wMqQItychljMJClApsN/F1Eu5ABQqs/862/BkN8rQ9WfuIDXG5S72lkKE4AKw+I5eIaWFa4KDxXHrX6it0Ij7fr/8r2JWQeG/ItuTKvC+gBz5d7mXdVrm6Ux1THG7AEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789161; c=relaxed/simple;
	bh=xQIiXSB/5DfjJWl2fH/vZNdH9MAEJxK2cVYZXbHCxd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/IJF/Qa5RLOyUSnbewBERHjulupSfzX6ACi70Honc6b80TuxOGnrSAu3Kk3dGeIjArtUmyL4XQBKDudJ7FPmojQmt/3mDQngsrQUy6PrWROO4RUkCeeLnHeGZhxloEBEN14lGBt1UMlVAUboVfjWHpcUI1wIheiBaZ2gi6lOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b=IS5cuELi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b="IS5cuELi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738789155; x=1739393955; i=kippndavis.work@gmx.com;
	bh=4ITmxPiD4Dxufx6bIBs13bU4YVtq9CbB2GZM4b6BCJM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IS5cuELiK4kha3iWvP+aubWZzPNL0dn1wgnFKzcYSHgVj/J3c9yKJBhC/7vIuN9O
	 Ns/Ad75a18pchy+U7AMGA8pSlniGELC9p1mX8/VIvDFJYOj5MkecSaAtG92ayF79j
	 yaDO81PtZeF5/AvxYFwdW4gtCaaJGEUyh3KAYrrzEoK5awyN34nEK9m256u8jNI9a
	 1imMvylNxDoA2Hyv1bJEF6VTEkaYywEf4L8Tw5lWnv+QOuHb5zIlz0i5GtfMgKjuu
	 inkOx781D3GaYSQfMCLP5t0iMlMjT1KdiyFJnA8HPIddaMgCOh264iDWHPUYXbTGR
	 yL0dWMAwVLg2Fp0vYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ip-192-168-122-31.ec2.internal ([52.70.167.183]) by
 mail.gmx.net (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MlNpH-1t0iZK2S5N-00oUoG; Wed, 05 Feb 2025 21:59:15 +0100
From: kippndavis.work@gmx.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH] selinux: add permission checks for loading other kinds of kernel files
Date: Wed,  5 Feb 2025 15:59:09 -0500
Message-ID: <20250205205909.19515-1-kippndavis.work@gmx.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdT7fm6hBDT2maErn7cJvYkWiG3MhK4n9zey+SfwYGsxXR1BGuz
 sFe5gwss279E8OKVkrqkApm2A/U6odDRMgGQ3W0CYPZRGvm5xMwJ2QWmEO4ZheZArpGykBQ
 PM8ov417dFUKmh6YnVJKhSJcJWNFYq8Y/kUibCk/E5U/0UQeIPXa6PJ5w+b7Hu+9DPHi0TV
 0JczAZRU8BdnRJ3PVBcQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cFZV4fuVfvc=;VOtX/fwEO0KrNsGWyA2Byq6izxy
 5pPtxXe4TD8mquEI1F9sD5ia3CiW9rg/Q23xHcEx6kEiYOBJ0XR/+yq6SaX2xy8X0rsBWoBaJ
 D1chW3F2NVywGsBq81DJJ/7hpUu5aKAN+M7VnFqynXZr9NKI3nz03Z4hK2S/3ZVX/TLv/eKgw
 eFrhOJiZgP/lmcgWs13YKaRjmpZNZvJUenHFtw9YWLRpr/pYBk8lAjuvJB0GyBXpl1FbF4Fc/
 ROcU1Vxrr8Nosq9qqdzf98MAv8Jr5jH1evZa2T/44y09RO0ukvitc2r7kAEQ0Fpo3wo/HlL4n
 R1Ih1QkT2mi1xJxT82GBDO6/MzXXqi187iVIjjpSBnPoAinpUi7Si5JoQiSnRt1LoK2AO9QRn
 ss7bxK/tYAYdGHL5InujArhhQkPKX6yzozOVKHaJFWnNbVF19WlsXZTb9hBWWVqQYnHeleh7L
 iaIBZoCEinLE2o6e/Zu7PWVuSTBilGnGs8QVpC0fP24AVxRkF3AQE4RNpI082cZEOnPz47huP
 yMEAvFYmfptYgN/+X4YE4KyH/hzmw3VwGVLZ/XaGntP5vVPu9TLixw7Q1wt+jENdXZOsLkF7X
 VCHNGL+uypRRdjK9ga0Sl4Eh2XHIO4HHQRRzi/X4q6BTcUcWEki7QxDLshO5Z13eC6PC8/YCi
 8a/Ycfr9HM9RIEAHPDZ+dqOdbsO8EdZU+wNtLEbLpLoq3GvvozgbdQMlS3HNHpn4HW/LVk5Fm
 bCY2fZyoutqfdvvAdBdNO/lkhAJCXAc1Xcgez7mgv5mPmrbt1ju8JxEFY3vLBlH9Kr2/i5xC+
 fZk60d2V/zkzF7jsCfN+M9y3yEYf0y+IeEZ5e33+E3A6YvNGEhlm02PIQFZNqWQoVUHqbt4ZE
 G/c+hIKXzWnEf0R1utpjGY0gBNj46WWq3OqKEVRb4oe3qsQjysx/rvw342cwMG/4c0N73turr
 zr4QnrJO0XP+sRfsNmSSmK0+gFvCwBw9Ew6yA18LdZgsum1L4lvNV6QfqZNo1hvzUtDGReMLr
 9JNfOfbS9VjIc83KkkKYDhJXFNh9MPmMp4zMmXanTNLAqJN40dr7j8iEA7OmPu4ZyqdyiaONR
 OlfwkXgXUfEx1FaS1evxFypcnuEbIpIIvCFmjUTy/z78T5BLcU6e8tjIdqQTv0btfcXkL9R8t
 bxBX0NgHgjDFD2wtSMG4bREDEdurazWFkD0HMa1pvt6f+TS+TjVwejh3llXTO3tLrWCdNXd1+
 0H5dguUMmsFsOCIZXV4gyIcMVsaTsTrtXwMfJM1DX7ZZkVYJi1X1mMI0EoOZ29tDeBSP3BVZz
 /hsqhlnfRMRmSOZ9no2N6hGfrftudvtZSQDfTSOYnBHzkQ=

From: "Kipp N. Davis" <kippndavis.work@gmx.com>

Although the LSM hooks for loading kernel modules were later generalized
to cover loading other kinds of files, SELinux didn't implement
corresponding permission checks, leaving only the module case covered.
Define and add new permission checks for these other cases.

Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
=2D--
 security/selinux/hooks.c            | 54 ++++++++++++++++++++++++-----
 security/selinux/include/classmap.h |  4 ++-
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..e96ade50c137 100644
=2D-- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *kmod_=
name)
 			    SYSTEM__MODULE_REQUEST, &ad);
 }

-static int selinux_kernel_module_from_file(struct file *file)
+static int selinux_kernel_load_from_file(struct file *file, u32 requested=
)
 {
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
@@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(struct f=
ile *file)
 	u32 sid =3D current_sid();
 	int rc;

-	/* init_module */
 	if (file =3D=3D NULL)
 		return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
-					SYSTEM__MODULE_LOAD, NULL);
-
-	/* finit_module */
+					requested, NULL);

 	ad.type =3D LSM_AUDIT_DATA_FILE;
 	ad.u.file =3D file;
@@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(struct fi=
le *file)

 	isec =3D inode_security(file_inode(file));
 	return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
-				SYSTEM__MODULE_LOAD, &ad);
+				requested, &ad);
 }

 static int selinux_kernel_read_file(struct file *file,
@@ -4133,10 +4130,33 @@ static int selinux_kernel_read_file(struct file *f=
ile,
 	int rc =3D 0;

 	switch (id) {
+	case READING_FIRMWARE:
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__FIRMWARE_LOAD);
+		break;
 	case READING_MODULE:
-		rc =3D selinux_kernel_module_from_file(contents ? file : NULL);
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__MODULE_LOAD);
+		break;
+	case READING_KEXEC_IMAGE:
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__KEXEC_IMAGE_LOAD);
+		break;
+	case READING_KEXEC_INITRAMFS:
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__KEXEC_INITRAMFS_LOAD);
+		break;
+	case READING_POLICY:
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__POLICY_LOAD);
+		break;
+	case READING_X509_CERTIFICATE:
+		rc =3D selinux_kernel_load_from_file(contents ? file : NULL,
+				SYSTEM__X509_CERTIFICATE_LOAD);
 		break;
 	default:
+		pr_err("SELinux:  kernel_read_file_id unknown");
+		rc =3D -EACCES;
 		break;
 	}

@@ -4148,10 +4168,28 @@ static int selinux_kernel_load_data(enum kernel_lo=
ad_data_id id, bool contents)
 	int rc =3D 0;

 	switch (id) {
+	case LOADING_FIRMWARE:
+		rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__FIRMWARE_LOAD);
+		break;
 	case LOADING_MODULE:
-		rc =3D selinux_kernel_module_from_file(NULL);
+		rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__MODULE_LOAD);
+		break;
+	case LOADING_KEXEC_IMAGE:
+		rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_IMAGE_LOAD);
+		break;
+	case LOADING_KEXEC_INITRAMFS:
+		rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_INITRAMFS_LOAD=
);
+		break;
+	case LOADING_POLICY:
+		rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__POLICY_LOAD);
+		break;
+	case LOADING_X509_CERTIFICATE:
+		rc =3D selinux_kernel_load_from_file(NULL,
+				SYSTEM__X509_CERTIFICATE_LOAD);
 		break;
 	default:
+		pr_err("SELinux:  kernel_read_file_id unknown");
+		rc =3D -EACCES;
 		break;
 	}

diff --git a/security/selinux/include/classmap.h b/security/selinux/includ=
e/classmap.h
index 03e82477dce9..cfac41d12f7d 100644
=2D-- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] =3D {
 	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
-	    "module_request", "module_load", NULL } },
+	    "module_request", "module_load", "firmware_load",
+	    "kexec_image_load", "kexec_initramfs_load", "policy_load",
+	    "x509_certificate_load", NULL } },
 	{ "capability", { COMMON_CAP_PERMS, NULL } },
 	{ "filesystem",
 	  { "mount", "remount", "unmount", "getattr", "relabelfrom",
=2D-
2.48.1

