Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD624315F
	for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590108; cv=none; b=Gaj7vnFEKS+8zdzV0rKNnL4+KoaQIHcmAJ0189cicSXAkVjupa+Iw0teVU3265sso1NI2IhQ6ap+MDL/UFQavAGQMUAbydxm/bT4l5oJ47nt1XjygW1ZfkC3zn/IwXgMxaHUZH2zeL4JdX5l2ErPTAAZibs6/IJw1dEOOFlJwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590108; c=relaxed/simple;
	bh=9Wm4VcnEwMFppndjBZNQxJlhhqAeyYrn7oCzP2XBfsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRDcnFbFaxqqBf2M2CKQLOA2b9NMXtAquv9JGbHsqXtPlwQKyROo58ca0gUvBLtLS02IJ9r46KVqh9D9dCgc7o/FvGFueh52w1mCLvKvqgrF2feorE1Eejm+5TsXI1YSmdWxSixz/ZtrWUoHdYQu+yY41qVzKv9HeoscJMVQsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dd0TM436; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dd0TM436"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DLfndg031169;
	Tue, 13 Aug 2024 23:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=cOBPT+sB0AqVG9
	AG4OYvSdgTxKT6DDvxZg1GgfwofRE=; b=dd0TM4361B0lwEWAYiI91FGW6aUN1E
	Hwg8fTpdVH9gvseqS8Cr4+AUmHzVCdyFZsEXmsvkbRqNJP2gw3FXkjbIzphTnxyp
	1ILQJ7F1CWCdIS9IQelsoNV/qvJXwFrLQJjqAw6fatGVEWjGACwxeRgGYocL88Cp
	brvHUuSSNBLVRzCqkmyshYb5ykAruoqMjOS+CvaymObc2CpssnZr85TL2I0c3IYd
	+EBNnbOLQkj7gzviXNfjDaVfI8weeGkZY0jq1K0194EY01gvVUbUQzUNkXtfbqs8
	4IldFNt9/XHA0YI4u0KjIGWK+596tP6eEsPDl9lKDfqDpZbelR3jbiUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gahrhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 23:01:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DLn5Et010659;
	Tue, 13 Aug 2024 23:01:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn95t7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 23:01:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47DN1gn6010756;
	Tue, 13 Aug 2024 23:01:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxn95t69-1;
	Tue, 13 Aug 2024 23:01:42 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: selinux@vger.kernel.org, samasth.norway.ananda@oracle.com
Subject: [PATCH] selinux: fix Null pointer deference at sidtab_convert_hashtable()
Date: Tue, 13 Aug 2024 16:01:40 -0700
Message-ID: <20240813230140.3575291-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130165
X-Proofpoint-GUID: zExI-_YuwqNZ17OwjwtJXS_Nf-V8vcFt
X-Proofpoint-ORIG-GUID: zExI-_YuwqNZ17OwjwtJXS_Nf-V8vcFt

Handle the case where SID (Security Identifier) being looked up was
not found in the SID-to-Domain mapping table.

Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
This error was found through static analysis tool and has only been
compile tested.
---
 security/selinux/ss/sidtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c8848cbba81f..b1fbdeaa8817 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -367,6 +367,8 @@ static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 
 	for (i = 0; i < count; i++) {
 		entry = sidtab_do_lookup(s, i, 0);
+		if (!entry)
+			continue;
 		entry->sid = index_to_sid(i);
 		entry->hash = context_compute_hash(&entry->context);
 
-- 
2.45.2

