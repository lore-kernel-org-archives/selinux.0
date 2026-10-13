Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAA4EDCB2
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905666; cv=none; b=KIYk7psoUZD31cyMiia5W5i3af4wpj2IBy/cPVy9mg50UZYwwndQeFbVGRtfIXAyoooXDy7Vu5P5rUNLzvMvVCYVmJz0i3i75zp44NmvqFjMi0+0KD7xzT6CcxlSjal/hGTZbYkbPXapCaTHJXnyyNQc0Vd7czaWlgRSrMVLuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905666; c=relaxed/simple;
	bh=UiQdlrM7Jj2tqt4z61MwiKhCke9Av92n/+bnB6kQuBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEc/6JNOEkouDdQIRUkUEtC1P2M1ZbsL+6T75e0rXwDeILUSJQXxHYBQmsJ5miwdKqGOOuEoK6lljpW4DyLkXZi7oII48M/0hxyyt4hu0pfUi1iwIaUggDJx8gPvtwUIMF//+VJ4GZWKS88MhBMi6CKLuCnLsHJrvWyDM01mRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTnOYN+x; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTnOYN+x"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93d92abf38dso302633385a.3
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791905664; x=1792510464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fV3bPpLgc5Pyu7pHivwF0xCHO2N7juiOeCBoqXb8CGU=;
        b=CTnOYN+x+GgyNBIwNq94KQ5bkh9ATVKn29r895pNxEXeVDMc46dS+0s0cvedD9Ey9d
         ohVDrIvBr7mkOePAUh1BLAhG8j7grQ7p3kQAobIBFmnB/zaTycX7JTSc/geeDoeJ0iLi
         n55A7lcwI65uskKHSIL624cKw2o3sDu10W9d0YJRo1oYI3d8GSsy/j/iAelxrFiIZ1bV
         oGU1VrsrrHvFiP8eLW+coAJvO2JUAYVtr9i1KZiarHfJL29HlGhCXfBD2lYNEvFmUpGm
         9dtYyDxwkMbX5bi2z2B7URcMAg2hb//9K7TjHPC3dZAqxN0jm3MvD8QBTsIkgEcCOOGZ
         j9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791905664; x=1792510464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fV3bPpLgc5Pyu7pHivwF0xCHO2N7juiOeCBoqXb8CGU=;
        b=kTSvVpEaOWnLS5B7ziZnVpchLZEEHmfNqA+9znwujAp+P+E81WSPbPrRwIsjLP/pkE
         NqAUaJbtSb8DkyCffaziH/RCorJJW2OvvCpXCLCh/yxHlqVwtvxQkShqks9EElYgpcd9
         o7ZRdUd7aFRFFIekm3urPCTUswhAIDswR7ojVv0Pxb33I+fHCNRU8dAInOWFmqjfPIun
         +9zcY7sqIbjQM55gcX81yNozZExNd+dZGyAXUZ38WFMqFLLbJDCgWMd6g+PK/XGub2JH
         ZqK9ncU2Ipp9taViHME3NQkg6XarA7pebGqdS+AY7JRxrpsg/2ZkLiVOvv02aXmNRldU
         r5Sg==
X-Gm-Message-State: AFq9FYJ0w0YNMmqfLfXP968TAeCgOxThdn4p6EWyiR9+j1aQpClmpATn
	X4w6Ma/3OavSuJy+BdH8gxfGunKQI9f9h8VcjhDqQBinxBNGw6wJvA4cIVrhhw1k
X-Gm-Gg: AYBFou0BMWpj56qXPIJGmddGVCcAATByv6lyDRDhEddJ0/3/a9Ny+Z99E20vzASBwmJ
	abl10mCBDvLZujIHZQxLGQ7yP7Lwjj5yFStEl1RfKEeOxJGp6ozR7MWmRAMevjjdldQHEbrAYN+
	V+iHLZnUesrAMYi3fqvtZXlKlx8X6pLLzrEgweahggVg2FFfnjWAwBpFR5CfePL+LeyzhbFCknd
	rFC1/c3cYPYwGvLFlDd1EPL2NciOevQ0XEBuvXgeqiFBCOEd1dXtsZnJSYWRFLG601t+S/LKVsQ
	x/Oo01l1ICRcjAew1zmZkcUVXDeWYKnyz/eNZUH3x3LmN3rSVn1LnIt+7/e6swjNIZTcxe3WhOP
	73vjtfRRRrnB6xp30JW+S3EpKGEa4zafrsDYMJYucyaJ16Nk2SkqBRdxXIQqzLvaeUdHvV3jcjt
	K9ZDd31Ec1O6vKBXPURvvA41MFv+RcTSP/xWtxvWqeLfnsSTIMv6dwXZNjghS1I8UHNu3M1gqFP
	HQ1mULp3fo3+A9R0qBMakxAo3YQ7qHipcu7xwQY7mL5z0tYgIsErhcH32pebjcKuSwfBvu06CnW
X-Received: by 2002:a05:620a:17a9:b0:93c:61e0:81fb with SMTP id af79cd13be357-93ebd259f1emr2121445785a.46.1791905664479;
        Tue, 13 Oct 2026 08:34:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5027dd4sm263780285a.19.2026.10.13.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:34:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2] checkpolicy: validate policydb before writing
Date: Tue, 13 Oct 2026 11:32:11 -0400
Message-ID: <20261013153210.218423-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpolicy does not currently validate the policydb with
policydb_validate() before writing it, which could consequently
generate a policy file that can't be consumed by the readers.
Validate and reject it before writing.

Only validate when the output policydb is a kernel policy. On the
source -> CIL path (-C without -b) policydbp points at the POLICY_BASE
parse_policy, which is parser-shaped rather than read-side-shaped:
classes with no access_vectors entry have a NULL permissions.table,
initial SIDs with no assigned context carry a zero context, and
policyvers is a kernel-range value. policydb_validate() assumes
read-side invariants and would reject or crash on these; the parser is
authoritative on source input.

For -b input policydb_read() has already run policydb_validate(), so
this is only new coverage for the expand_module() output and for
re-validation after -O or a -c version downgrade.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 only calls policydb_validate() when the output policy is a kernel
policy, since policydb_validate() will reject a POLICY_BASE
parse_policy and the parser is authoritative on source policies.

 checkpolicy/checkpolicy.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index cc866b3f..6ea7cdd6 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -374,6 +374,8 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
+extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+
 int main(int argc, char **argv)
 {
 	policydb_t parse_policy;
@@ -685,6 +687,23 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * Validate the kernel policydb before writing it so we fail here
+	 * rather than producing a policy file that policydb_read() will
+	 * reject. The POLICY_BASE parse_policy on the source->CIL path is
+	 * not validated: policydb_validate() assumes read-side invariants
+	 * that the parser does not establish, and the parser is authoritative
+	 * on source input.
+	 */
+	if (policydbp->policy_type == POLICY_KERN) {
+		ret = policydb_validate(NULL, policydbp);
+		if (ret) {
+			fprintf(stderr, "%s: validation of policydb failed\n",
+				argv[0]);
+			exit(1);
+		}
+	}
+
 	if (outfile) {
 		if (!strcmp(outfile, "-")) {
 			outfp = stdout;
-- 
2.55.0

