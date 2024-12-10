Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7CAD24;
	Tue, 10 Dec 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792450; cv=none; b=D9Pa9y4Qmc6Af4ePZ/UJrNpNtEYRQMKsro/OdMpIhKqCELFLFeZQ3Q98pz9P0Nh9L0TWMSUMKMLbN2tNgVvNO1kxqWpIt+8ErM9zG5gLKMWClT5UoGmu7FSqDJXIFvpzj9NtL/Cj3Ph/YCdzi8XcEjuYc9O8w/EwhqLEw3A9aqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792450; c=relaxed/simple;
	bh=wmHRlz8o90hMUNEjf5cgrWzY8LmiRFOnVcrNEwSmTKE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QR0Y8iueNuNVjqvOaXX+txfEfITroWwmChChXAPK1SvOdXPguqHcjEP2GYZsS2TUjvJeNlHxXSTdtEK5UPDMVDH+HiG49JJRJDKYfnFRKzW8pU+sOxkV9/TWFsRuJ5OKVGr1UQkSpMpRWLJUEexJpgUdw6VWH5nxXaowCF93ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EzeyLReL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EzeyLReL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IBaiN003264;
	Tue, 10 Dec 2024 01:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YOErngZJQDe8Cp26Glg7mR
	PZU0VIL+MkOjNuZYM8awc=; b=EzeyLReLlF4wBSfA618VeTMFsSnWFkByv/1jvY
	cY8MIPt39aADyoSgcxF5d2w3PkPflI+y1lOj0DmEPVS6GV/CV09IgUv9q4qib9pa
	B577gfTbZkVKXz/ytJU5tRlg74aF7PXIl81WUgOXS94QnBnLHyU4m/8GtWDobai5
	HIyQyllw6TltXJ06gzcoc1RVf2E1GPoz4Y7N6IL+4+BIoLOaF917F8+fYEZPPUsX
	/bYvQ6Bhm73wQ4H94QF/Z1qLuhVNQjuDVhXbOQSvTz2yjfpkdShTrZ7M6uUJZNIr
	ViAbzxOV+SN5SeXr9eshuyu5MP6qMm2OBOSe4fCHlgi13zkA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1xjn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 01:00:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA10gYV007174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 01:00:42 GMT
Received: from la-sh002-lnx.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 17:00:38 -0800
From: Joey Jiao <quic_jiangenj@quicinc.com>
To: Paul Moore <paul@paul-moore.com>,
        Stephen Smalley
	<stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
CC: <kernel@quicinc.com>, <quic_jiangenj@quicinc.com>
Subject: [PATCH] selinux: KASAN; slab-out-of-bounds in avc_lookup
Date: Tue, 10 Dec 2024 09:00:29 +0800
Message-ID: <20241210010030.2854024-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i2cz6UVd9m6_bSwrWF80-rrlNP0XKgnu
X-Proofpoint-ORIG-GUID: i2cz6UVd9m6_bSwrWF80-rrlNP0XKgnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100004

From: "Jiao, Joey" <quic_jiangenj@quicinc.com>

BUG: KASAN: slab-out-of-bounds in avc_lookup+0x174/0x298
Read of size 8 at addr ffffff8846ef70b1 by task spdaemon/1037

Call trace:
 dump_backtrace+0xf0/0x13c
 show_stack+0x18/0x28
 dump_stack_lvl+0xd0/0x128
 print_report+0x13c/0x6f8
 kasan_report+0xe8/0x148
 __asan_load8+0x98/0xa0
 avc_lookup+0x174/0x298
 avc_has_perm_noaudit+0x60/0x12c
 selinux_inode_permission+0x278/0x3cc
 security_inode_permission+0x84/0xc8
 inode_permission+0xb8/0x2b8
 link_path_walk+0x178/0x7c0
 path_lookupat+0x6c/0x298
 filename_lookup+0x11c/0x2e4
 vfs_statx+0xb4/0x3f0
 vfs_fstatat+0xfc/0x3e4
 __arm64_sys_newfstatat+0x88/0x340
 invoke_syscall+0x6c/0x17c
 el0_svc_common+0xf8/0x138
 do_el0_svc+0x30/0x40
 el0_svc+0x3c/0x70
 el0t_64_sync_handler+0x68/0xbc
 el0t_64_sync+0x19c/0x1a0

To fix this, protect the rcu read access

Signed-off-by: Jiao, Joey <quic_jiangenj@quicinc.com>
---
 security/selinux/avc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32eb67fb3e42..ded3823d4451 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -528,6 +528,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 
 	hvalue = avc_hash(ssid, tsid, tclass);
 	head = &selinux_avc.avc_cache.slots[hvalue];
+	rcu_read_lock();
 	hlist_for_each_entry_rcu(node, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -536,6 +537,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.47.1

