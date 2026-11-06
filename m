Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971028;
	b=NQw61qhfAeaARPpnoRSCfRNclbZoFGTmi+Kd+MnCY35RPOXn2IxgTelR/fj/TEYn4Mkx
	 IZWFoiYWeWAqprGVWNQeRbC5Gzk4vCQaoLeRIuQ8ro5ZSgNUyyl7nak44kfZ1CTMjUOl/
	 sMjne8XlOCISN06w1nkWu4O7cumS/jcJPKO9NoHbM1iQiPZvGBtzy//v6MGCpv4IDimQT
	 W6JKDOyHKcYMGVPa2gEair/upYMejygt9davxDJ0DvTp1J9xSttnvVjd6UJaNnaui+DFM
	 Dds3TJZGud/5lLVk11eD/mpO/htm6A4OGGu5QUY5ezskYOC6i+3XI7lRqKbhkLR9gRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971028;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Uk+d3IQhjVHVeK0xDDLDJDD4HVhiXaTHO1kNbFz2D+4=;
	b=xh/XmDjkv27PqGck8AOIgnsq/aB6BxLGLHAdjHRM+Eg1R+9ffwQ2Dz/ATQ8u+Z1P2fyr
	 k8UFl26W2z1RTBsb8xm9VrMWuWUemuF3KD9OOnFjd14tnRnFZO4xPWLoA+7ug6EpDi4OQ
	 cpSdqoCYMwFERC0Ibq2USbVDwPJ0kli/VZUnMV98gfpUrWeZOWzQpzONkAp97Ewe2GZ6s
	 uC82uMnRe9QzjfnzMpEQT299vKVqEmrhvT6erXhSORLZy+fN37c+ntjGiwSEwsvecEdcI
	 VclUp9TlMID1H8XYBhYrbap+iI+YsL/IoJij2YzYzHFhRFDYuVmSyLDPK9fTm3xeAng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=bhH8upTK;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9E606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 13:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF9E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=bhH8upTK
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793971025;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Uk+d3IQhjVHVeK0xDDLDJDD4HVhiXaTHO1kNbFz2D+4=;
	b=bhH8upTKdWaVi7VJeRfAr2i72IAfhe0dWv3hTOYPwbMsNst0Z2LssJ4RP7pMTp3LSs/KZ6
	Ead+B/74byVs0MmIsfXtV/3oJsmnXXq2rvhEoHUbPO/bKT7BxBSGBEPPF00YLWY4jZ8XPm
	F5a9Yqk/WzaBxoGzW94Vf/RJ3BkWY8aX1Nz1kRO//9jPX6oKUxWU4P37a90y8R+rPBkBRi
	1/6Q3r8FyxA3beQU+tg2Yizl8Fp9TRUKnP7Yl5xWPe6Csr+PvInFukQTxftGhi2gKsxyJd
	9wsnRCKLZtDJ89jXTdwq6hKIK8ow43VGmUNKxxGckWnQrvjt/I2qd72plJCutA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libsepol: keep the uncompressed filename transition format for Xen
Date: Fri,  6 Nov 2026 14:16:51 +0100
Message-ID: <20261106131652.267648-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Commit 890bc6bf ("libsepol,checkpolicy: update remaining policyvers
comparisons to correctly handle Xen policies") restricted the
uncompressed filename transition format to SELinux policies older than
POLICYDB_VERSION_COMP_FTRANS. Xen policy versions are numbered
separately and never gained the compressed format, so Xen policies are
now read and written in the compressed format instead, which is
incompatible with every earlier release. For example, a Xen v30 policy
with a named type transition written by checkpolicy 3.11 fails to load:

    ebitmap: map size 4 does not match my size 64 (high bit was 8)

and policies written now cannot be read by 3.11.

Use the compressed format only for SELinux policies of version
POLICYDB_VERSION_COMP_FTRANS or later, via a common helper for reading
and writing.

Add a Xen v30 binary policy written by checkpolicy 3.11 to the
checkpolicy tests and check that it is read correctly and that the same
source compiles to an identical binary, as a roundtrip through a single
implementation does not detect such format changes.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/tests/policy_allonce_xen.30.bin | Bin 0 -> 2085 bytes
 checkpolicy/tests/test_roundtrip.sh         |  25 ++++++++++++++++++++
 libsepol/src/policydb.c                     |   3 +--
 libsepol/src/private.h                      |   9 +++++++
 libsepol/src/write.c                        |   3 +--
 5 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100644 checkpolicy/tests/policy_allonce_xen.30.bin

diff --git a/checkpolicy/tests/policy_allonce_xen.30.bin b/checkpolicy/tests/policy_allonce_xen.30.bin
new file mode 100644
index 0000000000000000000000000000000000000000..6e7dec3adb1d4b4a7f79e748e3992f877a2f5204
GIT binary patch
literal 2085
zcma)-&u$Yz491go3IBxX0f`&*$SvB02bgWNl`3tzRT3mPp^`2lP?0K$IPnO)FcMPm
zZ+5@b6hh+4W6x*%vu9_N{#bwi`JmNmy{*2UUSBT1yf7aD>zIZ{+h&o2+WdtdH8^?b
z{l;oPD2K!HJcSZyaFLIOaR-u^BKK;uSwGIMtIftakR#N3xmnDo)pF?}`J_^IXv!HF
z0vQz9c-(KMqd&no98oV+h{ZFI6Ipr<i>PVE$=IW?KWqG87FF&m^O4Y~a2g>YuD6SD
zA%3r~qQ0_m$doBS;u&!O{FwOA5yMx^x8P`A$n~N)wO+1f3%`}G5wL1ADvLY~2B6|s
z@Gj14MIcab2>QVQR0J9bOrq}WDe47tP!)+COai9({KMyJx_Z9|3Yzsk7xJi44Pe{W
z<lRM{6=&HvC91jqh`eSv`Y4)BCZnFdlLzC)0%$7OW4SI+#4*$JlGz7fP+#7AYybht
zX5xOfJ#+#EsvcCo8Rw&|*QuU?OeewlB9(>wq%4cn<wW<PtsU##ZXLua65AcxEB>`!
zuM@NF_{Y2Mn0FMXto`Ho0ct-qxaUbCBLgHB6{iOBmO<*g+kU)Vl<Uxy_`N>9$9QF@
zXGMOV4RdOAzxX~z?Y0=Xx`}_)`53*$qd7PS65?7fI_s{SCzej`|MG~Dw@>bK%X?|M
zFQ=tOUhJ+KxDoh~UHQcKnVGz&rrn#%)u--i-o2{6&8F2ZdaH;MY(>dOWJBE53qGnC
XSBiv2h5H{eV#4*$`)>ZR<siQSCP85d

literal 0
HcmV?d00001

diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test_roundtrip.sh
index d05b36bb..0de07785 100755
--- a/checkpolicy/tests/test_roundtrip.sh
+++ b/checkpolicy/tests/test_roundtrip.sh
@@ -39,3 +39,28 @@ check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt.conf  '-M
 
 check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected.conf      '--target xen -c 30 -E'
 check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected_opt.conf  '--target xen -c 30 -E -S -O'
+
+# Compare against a binary policy written by an earlier release, to catch
+# changes to the binary format of an existing policy version, which a
+# roundtrip through the same implementation cannot detect.
+# policy_allonce_xen.30.bin was written by checkpolicy 3.11 via:
+#   checkpolicy --target xen -c 30 -E policy_allonce_xen.conf
+check_reference() {
+	POLICY=$1
+	REFERENCE=$2
+	EXPECTED=$3
+	OPTS=$4
+
+	echo "==== Testing ${2}"
+
+	${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/${REFERENCE}" -o "${BASEDIR}/testpol.conf"
+	diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
+
+	${CHECKPOLICY} ${OPTS} "${BASEDIR}/${POLICY}" -o "${BASEDIR}/testpol.bin"
+	cmp "${BASEDIR}/${REFERENCE}" "${BASEDIR}/testpol.bin"
+
+	echo "==== ${2} success"
+	echo ""
+}
+
+check_reference  policy_allonce_xen.conf  policy_allonce_xen.30.bin  policy_allonce_xen.expected.conf  '--target xen -c 30 -E'
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fbfc0bfc..1bb26250 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2541,8 +2541,7 @@ static int filename_trans_read(policydb_t *p, struct policy_file *fp)
 		return -1;
 	nel = le32_to_cpu(buf[0]);
 
-	if (p->target_platform == SEPOL_TARGET_SELINUX &&
-	    p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+	if (!policydb_has_comp_ftrans(p)) {
 		for (i = 0; i < nel; i++) {
 			rc = filename_trans_read_one_compat(p, fp);
 			if (rc < 0)
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 7f7344a8..92936275 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -45,6 +45,15 @@
 
 #define MAX_ALIAS_REPEATS 32
 
+/*
+ * Whether the binary policy stores filename transitions in the compressed
+ * format introduced with POLICYDB_VERSION_COMP_FTRANS. Xen policy versions
+ * have their own numbering and never had that format.
+ */
+#define policydb_has_comp_ftrans(p)                       \
+	((p)->target_platform == SEPOL_TARGET_SELINUX && \
+	 (p)->policyvers >= POLICYDB_VERSION_COMP_FTRANS)
+
 #define PERMISSION_MASK(nprim)                          \
 	((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : \
 				       ((UINT32_C(1) << (nprim)) - 1))
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f2a7463a..c27aeeed 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -478,8 +478,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	uint32_t buf[1];
 	int rc;
 
-	if (p->target_platform == SEPOL_TARGET_SELINUX &&
-	    p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+	if (!policydb_has_comp_ftrans(p)) {
 		buf[0] = cpu_to_le32(p->filename_trans_count);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
-- 
2.55.0

