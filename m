Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967480;
	b=Nmg63i2do2YRjLD+xiurmTINjmbqgT7mlnp9pya0lpysLQVcPDsEk5Et572+vBw8BhBz
	 EkKKCGyEn5ZfjX0X0tRqp4K5vwMJp9pwGBL6kJjT9TtqYDa2Zc28e3U8yIXKa+lPjjldM
	 54UTvfzYd+qFgZYAwn8On9Qtil2tQduUk3EnHccshKn7oqOQzpAOFp1Ku6hz2w3bcMDdf
	 WETd4TwRU8nH+tiBcJxowrWzQctwE6jPgkRnrfHjLpLG4Yk+SxPfzvJ5m6J+C0GRcsm63
	 LC3UHRLOyNJG7XC/1zzYOR8ZlfOe84Bc3A1x2w9ttShwyqCfbZILXIcXtycSsqJYFOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967480;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2JgN3L0p/EZ/VzxVkdL+SkDFZvfmPBp4KFHYRXStWBw=;
	b=2WxevjH5TZL5pIC038a8vY8zeQSFQWkhWhidKRYeJq71OxSZr020BgSTXNJRqVlTYq5z
	 7lc8mT2emPnleibrZMiwLG7TQK5hRvg+L5AK/ARzOZcP+XG+xOiZ58R0O4ra2tiUk4UrN
	 OU3DeAdCPZ3ZcHxvJdBrnUITs7jpcqapGJwnxDmTcHPiSgQ2b4OSJkYyOqckbiveNx3Rh
	 IbYk0eWM25wDPVHXM4cWZ4Ec9Ij3lRRhmRADuI5uY/6UjHQTAfUzOvzSVWBe8GJMBeG5K
	 pfeva9AN34yYnfOZya68SNUTPbE9L4QzlJAtgLG5WX/SjiubMZnooflIJNFYc6c/ZIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862E606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4862E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793967470;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JgN3L0p/EZ/VzxVkdL+SkDFZvfmPBp4KFHYRXStWBw=;
	b=uC6KI756TVgCuj3nXRwCsD/v+rQ987Iq4w6o4gbgg5amNcYwS9LL6/VThL9cOVnIH52Gds
	DCgPiUvt0mjoy+BPnTCp/8LLVxzn+xAOLdwEZykCztx2XGx8UGHR5BFFe/FsqBB50HbpWN
	R+w3REVMuAaFIm6YUiuPaqaDvoImkij1sgqAgou3vApSHhLFRr5fYEmPPMU9NNLhf+W6bd
	JgfSK94lZWd6ELf6tDhN9U/542pC86kgBzrGkCaUn0sn0jp84XLODS0WNtyT1HVs3MBNrE
	rf7oYRPUSSCjemVU1JRwRub/XW+3orxo8yRJWowKYxlhwdR+8tGNjK03ZJeYiQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 5/5] libselinux/audit2why: free reason_buf on a TE denial in audit2why analyze()
Date: Fri,  6 Nov 2026 13:17:24 +0100
Message-ID: <20261106121725.48778-4-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-1-cgoettsche@seltendoof.de>
References: <20261106121725.48778-1-cgoettsche@seltendoof.de>
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

sepol_compute_av_reason_buffer() allocates reason_buf for a constraint
reason, but only the CONSTRAINT branch freed it. A mixed TE|CONS reason
returns through the type-enforcement branch first and leaked the buffer.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 7bdc7acd..0552f690 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -436,10 +436,12 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 		avc->av = av;
 		nbools = check_booleans(&bools);
 		if (PyErr_Occurred()) {
+			free(reason_buf);
 			free_bools(bools);
 			return NULL;
 		}
 		if (nbools == 0) {
+			free(reason_buf);
 			if (av & ~avd.auditdeny) {
 				RETURN(DONTAUDIT)
 			} else {
@@ -456,6 +458,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 			b = bools;
 			outboollist = PyList_New(len);
 			if (!outboollist) {
+				free(reason_buf);
 				free_bools(bools);
 				return NULL;
 			}
@@ -465,12 +468,14 @@ static PyObject *analyze(PyObject *self __attribute__((unused)), PyObject *args)
 								b->active);
 				if (!bool_) {
 					Py_DECREF(outboollist);
+					free(reason_buf);
 					free_bools(bools);
 					return NULL;
 				}
 				PyList_SetItem(outboollist, len++, bool_);
 				b++;
 			}
+			free(reason_buf);
 			free_bools(bools);
 			/* 'N' steals the reference to outboollist */
 			return Py_BuildValue("iN", BOOLEAN, outboollist);
-- 
2.55.0

