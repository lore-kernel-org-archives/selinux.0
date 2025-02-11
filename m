Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310C1E4110
	for <selinux@vger.kernel.org>; Tue, 11 Feb 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298133; cv=none; b=QVfmPOzFO7h9XGgD4N8iP380cAsXSS34m2DddDdPiUlziaFD2fJIuflnpyX/og12JJ42j/iMbXEpfrkEA7iMpdrEa0Gp698tHZYwv2I2l6dnb3fOzoaOPrcFt4Z2p/KQOikaLfpJxqttJ8R7oL4XNhmiX4z3aUYLwBNoaW4V4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298133; c=relaxed/simple;
	bh=ITRZrP3FpfDeiyplYaXyZTKMATGzwsyCTLD/YeblKZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fH9lwdD0lkdhiMwTzniQhMen44dlCwmkGuNPu/W1XC1g7AOyEvMtkiyue9cg2/gJCTxfpVgwtKc7EZwA9/iS+KO/RPuTDKahXNEBqnOrBtJRJIwbaVYcNMCHtBlfkC3uo9mkR/lJfBSqqf+Dma/tehCKCrZTDXz3F0vikAu5scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b=c58dtGVh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b="c58dtGVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739298127; x=1739902927; i=kippndavis.work@gmx.com;
	bh=Xq1RYqk5Qe817yTEKtqAmUfPfJkN1K9pJ44b/LVYtPE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c58dtGVhXyPp0WhiI/77Y7YiIV7im36+KeTBGeGF0/mi/Fc50SoSw547GU5f8X34
	 0E34m3pSd0ZuL0imsVzy3nq07dKBIhNgcmCEwhHvQ5CFJ6OvKPRKnG+g80qn/wnAg
	 TM6JrBG0fuxVOZoxBpqzIIg3xRS/VFnqbcWpYMXYxTeyqBpn/eiiOe2QHWHnH/Svb
	 tfkPJLwQaz5i/eco0mk/QONNRcVxYvvKKWjjOI3OlCjGiGjBBTfK9aWpry3GuRSfX
	 JIyI+xasIJCo315koYbSD7bqgrH116NFf4XEvMgc2h66OzorszbBWTTTOzAXhULm4
	 M76j6Rc27bIZJrNYxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ip-192-168-122-31.ec2.internal ([52.70.167.183]) by
 mail.gmx.net (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MWzfl-1tsjah2FHl-00KIHq; Tue, 11 Feb 2025 19:22:06 +0100
From: kippndavis.work@gmx.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH v2] selinux: add permission checks for loading other kinds of kernel files
Date: Tue, 11 Feb 2025 13:21:59 -0500
Message-ID: <20250211182159.37744-1-kippndavis.work@gmx.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JJDF0FlhCcIJTZWYjl2vVIEDbpyDFZ0V7w2dQcGxhUX0ICSeND9
 Z5z1Usd+xApx00Py9T44Ks3Q9XBerQCzDNBS95IB5J/9b2bwEaaEdGx8zsGEFfQlsL6vGn8
 xL3KGVxxc6WETPS2tmZnpoxF4PsdIHjaHZmbZnQdwVtqkoFAh2NEuwzUS60ztVZtFw3i0FY
 D82SSzkQs3p7A435sfUHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B19rRLN2+I0=;5B3ezFDXRwc8UknVOl3dXgnjOw6
 o71SCcWe8tCs+KXrCW3rsV3xJ5aEDj1zJaTuavv+xOH9IiV+v+hBC5WXYtA9UfzN6F2QhPm/N
 aeZf9RsbhCKXYvkGCPe871WHMrSpxa+iv3F3nhEDT48tZhUIoO2kIDcGmQAesa4LiWlceAEDX
 bNmuuM53hy8w5f+vFFbEZMCnAYnE62VADARcY+sftpdK9lbEdOstTNH3KQeoMOTIq+J9azKWj
 oJyf9BX+Gw8Lif3+PDX42R1/CaR9BhLsed02PGLnJ5QVztmRe4tiYd2aeCkfI9tP5atDbuh8o
 vZ28dIVUYXj2AAszZFRB251NMyld1hw15tEoMLBLD71sHeGO9C5XIVGM/HUw6QcgiW1OcBmZf
 Zo7pwJ2Db1d5dgj1MAvHUmoWi0MvritLBg7nRMWjqFXOih76i1ZFvjegmArgjq1b9NJd7gbkY
 8J93oEPA9OcZgiJ0y7XW7An8d0JmUNBju0at6d2XxcZ9IaAg9EBGMS4mXkENwqQhUr/MNFs5C
 VnQTDsKRCW4N+aLX3i9fhR0akys5xCiCHXMLNvhjmMAMh4Mo47FNjUG4/wGBVxz0NovUegXTV
 lzfokCWj0ZfO2cE3q1XH+s6Ea2CtShLRpqYVXgGMPzWrB/IBWo2yB+4q2yCxGNch54PiY9ai9
 HEV/KynAh4M84lDcep+Ejt8uijzgTEgakbIpu07+S5TP6nMgjImzHdWaGnCg7pY82J0i4Yg8F
 GUNjFm2f2MBFcl9fVoyoPqEXQIAdZ00QKM1Zv3wSsw3UMbfMCbxHjrpUx5rIn9dbFgCrujGru
 N8jlfEmTtAxs0xllgbAXmueYqNyOH8NUUGN7rpuMsVFojTGAI0lspnrWdpx66cKjZB5JK7UHh
 wnkdxj4uabyh+xxM3/zdCtTq42ondMkdZ3DxkkAy+DbAWgcrTd5digtPJnQ0W1NA+5UL5fLgp
 rcVUqHneeBnr2F4s3YqbA2VquVCeq04Zs22a5tEpBTNN7n5Uz1IvIpzJrKgqVORHiHYceL7pq
 Yo8f62PDDDpliJObWpA4I7QomIyMDTKEOF2njyqFUQAhe6S7WXLNLXfBX0twOXRmyApJ1l6Ps
 VYCyga7dSS3CZ2fdflISPYZ1wvFkX1FU3mdrG7g+6Opn82Z3K7XhxhiDQ02JAWo+5aBGrZ4Lg
 8SXpQg+Yc/ISrLjG+wUvNo8Da02sB+Z48RfKFSntwD2+bajospYhlzwjUDIvkksmmFg/8LhDu
 pbr6dfqljOiS215aC7u3oTBrKpP1D+Ed7jfB6WJQhfvvlaWb3ngbu96CFZo9Nk1QVHiZFBIii
 hnxaT+4+69nnQ5Un3v0m7a8s+ywTkumOyg12n+x3sVjZFzBl2t9D/8F8DpukRGGlZPjEhlEFM
 Y5Hx5sI4d6RXFBDFyqVBxAnzFIaBLNWvi9wLvOdv7B97WHzoWbTBqvnXw3a1pJLtpkYliD7qU
 pDLWcMg==

From: "Kipp N. Davis" <kippndavis.work@gmx.com>

Although the LSM hooks for loading kernel modules were later generalized
to cover loading other kinds of files, SELinux didn't implement
corresponding permission checks, leaving only the module case covered.
Define and add new permission checks for these other cases.

Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>

=2D--
Changes in v2:
  - Removed the `-EACCES` return in default case in
    selinux_kernel_read_file() and selinux_kernel_load_from_file(),
    reverting previous fallback behavior.
  - Added a compile-time check in these	functions to catch new
    READING/LOADING_XXX	entries.

Thanks for your review! I've adjusted the default case so as to not
return an error and depart from pre-existing logic. I first tried to use
the pre-processor #errors but failed with the READING/LOADING_MAX_ID
enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
those same enums instead to catch new entries.
=2D--
 security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
 security/selinux/include/classmap.h |  4 ++-
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..67bf37693cd7 100644
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
@@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct file *f=
ile,
 				    bool contents)
 {
 	int rc =3D 0;
-
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
+                 "New kernel_read_file_id introduced; update SELinux!");
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
 		break;
@@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct file *f=
ile,
 static int selinux_kernel_load_data(enum kernel_load_data_id id, bool con=
tents)
 {
 	int rc =3D 0;
-
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
+        "New kernel_load_data_id introduced; update SELinux!");
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
 		break;
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

