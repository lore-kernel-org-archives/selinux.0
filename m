Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368F37B011
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348342; cv=none; b=s9oz0ing00SdzgMZ3Ys0Bkk6EmqYvqZZ2gdOULAzUIT5GWfNRfftFf3HsG74r2P6axskyu7joxxKBkkc2mftEVxIgvM5T53/ZbcESPNlWGWu1pP3cuoqerdDbqzxFBq4ulCajIoS+702IyMCI8YeON/6FHG/Chj984xPtpLyt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348342; c=relaxed/simple;
	bh=j9u+zMyHGShyc/9iI6AnsQJ4z4YtER+Oip8oIkyliRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obory8GtFLtdjlmTjde7yRj5EA5CZBAcJdBaiH62zpvDRrJOCN4Ax+0cvFKQTpdoQtC6GuIYJBPNAKpqTTCCvSIwYLP2Q16XmXiS9f/WjfDa3pti4pay7Z/FKDe35VUCaPmipNIymW0yODIy34GhMEzHJJ3D0Ej+rZTRTPT+Gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjwvO/+I; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjwvO/+I"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a818fc4so24326061cf.2
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348340; x=1783953140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKM3ltC3A1zD0djhk28EYVX+3H3y259eeZiiZXcd2jA=;
        b=SjwvO/+IcFpYHGQ1L7WaD+Vnf6QPcs+qK+NYx+S6Acka3jFhtGe68Gn9CEkMf+oIGH
         O84q1aegw4cCPCwZlp4IPIPVsQ8ne+bIZle/ikkzO0etanSFu8nbqLgXW499q259TDlw
         CBIXfQV6clkjuCPnSduTRNIdq9bk1lb3hr1A2BGEniqQZfcqz5Z0qfUJeIwy/6epBUNE
         H2fAsvmtDf0qPvQp7+IbHMdfoK9OskNtH/NO6pe2vaLPygNnIQkyjQKUKokdHSryBHyN
         d6tgNt5hrebIONlVPbNSVDd6MddTLiGPmgZltG5s3WMSNq3UWYrvpXN0MxT09+JHukwL
         DksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348340; x=1783953140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKM3ltC3A1zD0djhk28EYVX+3H3y259eeZiiZXcd2jA=;
        b=PNWk7lu4XmekE+CVGFFD0QLv/JAuMI/a4jJTeSWQIAENbtz255PrpuiC9/aD8hEi1A
         sv03SQa6b++5d0cjcdgYeYYCRmXIW3axBwsBeW0+3vKR4kvbN1qCb7gmLhL9N4/oMa47
         nNTbnKhrW0mfFjT15HqDn3iRHlA9cZyr9fFzuVAjlwO5PHKhIf1ygurXCJLXubomcRzJ
         9ya83wr3UkYz2wWiLrGGbWwtR/Ls5YYAaRTPy7MKsl44gczQT1/uV5lVJiNUTNzKtj8x
         /2Xx2pulM0zT7c6Rv2x3i/aw1aiuiUsQGPgsA3eV6oFBNb5Avb8feDWGxrCpgqqlRj8/
         tOfQ==
X-Gm-Message-State: AOJu0YwIPSbCRRYpk/d8nGFGDNoFWa55qz3DwVEgkj1XdtFf2+jLVzZ+
	exhIpPcTt/6g1G6xcc9uftMx7hk4Ix3my3AKUS+zra0/eDJrFCARZFvzx3X1kw==
X-Gm-Gg: AfdE7clHpGdTjDl87sISEDT+fjeU8Z5M/n++cmemqqouRL61O+g3VpQkICeBdwASt8r
	+Gnu0YHxYYt0bveiOX8E9P8W8BeO9Mj+ejP/AGypKSBLhWhCSVTJlMuJfHcK2RPkWh0+Y5XXkJG
	r5Oec0hY7QGweLnBMGsDFM7q+TWYAqwe8tjHVFSDQsdcfzVh9KLs/nWlBpJk5BYxdfhava7759I
	pnQz86+ONqdMGOuT2XrvVENW0jUdlFt70PPDy88cbt8JZKHSBGXLrwG3zor7aSsszQsV2y8F/qa
	BZkBKe48A9ZkUWU5xnwKPfr7+Jiqc/Qn+C2JIQzllk9BuQelKf5j4fNMhhdBOStQr16AyV01t+u
	dYjMQqWhDCp4TBx3+If8MUQNsrFDWQqEUeGXx6jDzRVCEU9KCo3RXFPr/HEvdLdhGRSYtczhLWv
	ZftLDSpkhkESfgcrUQ3w7M2CPvam5yTZP518krHGF+cB4iFSWbtKxDfiOfUbpWZUXBy96520ocx
	iA+goXKh1duSiWk
X-Received: by 2002:a05:622a:14ca:b0:51c:a8:51cd with SMTP id d75a77b69052e-51c747ca0e9mr9637921cf.1.1783348340180;
        Mon, 06 Jul 2026 07:32:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 4/5] libselinux: stringrep: snapshot perm names in security_av_string()
Date: Mon,  6 Jul 2026 10:31:54 -0400
Message-ID: <20260706143155.36629-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_av_string() makes two passes, one to compute the length
of the string and one to populate it. Internally this calls
security_av_perm_to_string() on both passes, but they might not
be consistent if there is an interleaving policy reload that
triggers a selinux_flush_class_cache(). Save the permission
name pointers during the first pass to ensure we use the
same ones during the second pass. The pointers remain valid
because selinux_flush_class_cache() merely retires the nodes
rather than freeing them.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/stringrep.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index cd9841ca..6a59f1c0 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -342,16 +342,16 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	size_t len = 5;
 	access_vector_t tmp = av;
 	int rc = 0;
-	const char *str;
+	const char *perm[MAXVECTORS] = { NULL };
 	char *ptr;
 
 	/* first pass computes the required length */
 	for (i = 0; tmp; tmp >>= 1, i++) {
 		if (tmp & 1) {
-			str = security_av_perm_to_string(
+			perm[i] = security_av_perm_to_string(
 				tclass, av & (UINT32_C(1) << i));
-			if (str)
-				len += strlen(str) + 1;
+			if (perm[i])
+				len += strlen(perm[i]) + 1;
 		}
 	}
 
@@ -372,12 +372,8 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 
 	ptr += sprintf(ptr, "{ ");
 	for (i = 0; tmp; tmp >>= 1, i++) {
-		if (tmp & 1) {
-			str = security_av_perm_to_string(
-				tclass, av & (UINT32_C(1) << i));
-			if (str)
-				ptr += sprintf(ptr, "%s ", str);
-		}
+		if ((tmp & 1) && perm[i])
+			ptr += sprintf(ptr, "%s ", perm[i]);
 	}
 	sprintf(ptr, "}");
 out:
-- 
2.54.0

