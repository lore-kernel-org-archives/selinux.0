Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9819DF4D;
	Thu,  7 Aug 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575579; cv=fail; b=DT+n86kwEdrxMIj7etZO2s0nIupqHCucxdW+NTOz6lgjD7a/GD/vVtosXY8is7EFUip9MIqr29GTpnxGZNZBx+XVjt6V62f3OkPtVpIM7HTSPSaVHDBcugEba85pK9Si9Agj4HMlttD+lC8YdBG29Fmu/WQFFGCLlTVQ4w1wacY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575579; c=relaxed/simple;
	bh=D6D4T/Z+20Oy5samUQBcuUyO282MaRhbptIx5WlitLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZXzBke4kjsnq/LQ8F8oJq2b7HjFhVul2JzVWx1sCOC0VUCjCWcXQGUpUQOOlwOd/F95vY5geVIsg4sXRuwLhc4tPLIim/DCWodNwPWy8y/i3oH6wo7c9jvzY6ccdVWLm9qEe8FoB8o2YBej978FTw4+FFGJWwDSLrB16NBTRFEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OMfMyLcl; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OMfMyLcl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hovu1rPLYDvOPsxHZSi9AMUTBfZtzaIQhTw9+yb257DxFKl0Uv686MPzeghmoig90cZxBMVkPnoKIjFMYkLm5dHprJlgkwEkMVeWcVHGXajvGenDTq7QjCuEfOnW71PzBwoh0lSXYBO531r5sCxzKf2CL2J1UMwy/yMRrMDhnBXVDRaltVmT/OgO09LmMVkD4rdqoCXtVSDo8Y/YmQs8dwHeXVr7+qQk8EUdJXUIYXdP+b+CmMm3YUvzYoHunfCMq9xrERdUWfqZAQUJ3MSZge7yfMfcYrYMjjqxNAv71jvP41jH2ZZkvF3+J6S4L5JMo5Ah0DjJbTwFYVv5jj8CwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdx/umFsXow8/zUITIZQibtW3yERtLxrQaDAorCQBHE=;
 b=DZGPysi+t9JCbm7Fb6rgpj4OrD3CRsYEToMPMNIfVI+fEiBueIEI7gaMMa/63ZdtroKbvps1gdOfhPFayNwG2lNGtBVWf6f/D92Kd+61rjF3TUFcymPxKgnFeASYrJbksXd3knd8bXZDwOWQ7UUHc6Q1YvZo8XEL2magFNS5Hp9pCmvVqPqhDt/9qU90YsuZrB1LkhvMSWOixK6mH3y4+BN6T0yP2iQba+yZ20ue7Nt2GKK8Pr3oFL7d0cve2PaNJtwNpelFLAmKEaq2mkkSIjsEVhd5xfF9PB0Vp5bJfNM36HtF8iOQRb6W8UxkxbVv8OEte/K/uLHhGJYJbN91uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdx/umFsXow8/zUITIZQibtW3yERtLxrQaDAorCQBHE=;
 b=OMfMyLclZFzRdkRUq0390l+4vDJ6mb+ZwWc5cn315KsqbEosfiLqFSCzqPpAbfw8pGV5qRRSIFO84FsRQmLKVMkwVUh6a1LKcmnc5EbkE7VLjzN53zROtq+3pksmgKiNX4UFIZUwR7jjNBRD1cdGtQVLM409JVq2YFr7Y2NXlocQkETf34uGrMKzIi7R3M9uCoOzLT11Lu+/ZsxfwS6GaaDdaVCtSQTfGa/1Zvn1s3qN/l9tmUdM4s+/g7JZ4P7TKcpfIjKpB2H/HMHyJKslMUDMk7OXrrH0v8tYj8jtJZ7Nnf1YzkrAEqmfnekqQU//g4z4Z4Ow3eCzyguugjT3dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY1PPFECF6DCA7C.apcprd06.prod.outlook.com (2603:1096:408::92f) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.29; Thu, 7 Aug 2025 14:06:12 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:06:12 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] selinux: Remove redundant __GFP_NOWARN
Date: Thu,  7 Aug 2025 22:05:45 +0800
Message-Id: <20250807140545.566615-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY1PPFECF6DCA7C:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6d04cf-eb70-4812-2993-08ddd5bb9107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPSZIbgI2pkEkTuuog7IL3CCqKkhR7EXtdfw4JC1l1kdwEG+6ogpDsNyPNqp?=
 =?us-ascii?Q?vZ179tDki+wbPG3KzGM5l0xpyhAUNQmkCCJNMWOfwY76pN+EEyO+q8abrWz4?=
 =?us-ascii?Q?e72z7AsQLfXslWO8ogGUiEgoodSb5aUYU454bwLAfW7f2u2y8JPAbkVAVK/H?=
 =?us-ascii?Q?z6xm6ObsFQezMP2KC28MQYxJsLbjlurKiTtZw09nwyNzst46eY9ZEZ35ltoT?=
 =?us-ascii?Q?EQJ/8WeZUJugcHBVJOZX4xgWXrL2YeYmdaQnsltOfGy9e9E/IK/dTKVPfi03?=
 =?us-ascii?Q?3/b8YZ85w1aVvniaXAo2K+M4VJLG08/WbaSCLk3rwmiDV3Z7ys2G0AiXxTMW?=
 =?us-ascii?Q?g8Iz9ICGvyXzp075m4NrjakF1xS1i1j0G1jwuGEcMe3REswlvRUa+lW+rH/9?=
 =?us-ascii?Q?PSRuOjcmlT7CNock0fC/7093nN6rwloW4D6F9Rx3Gx912YFd+2jfltIHLtoy?=
 =?us-ascii?Q?mqwhQav4+j1mofygQRORlcIGQ/oPxDCgcOQaXNradr0Ua1jbh+zQLKUcg6vX?=
 =?us-ascii?Q?mSrLJLNe0yzNnJHFuoqZ9hyTb4lml+a8xrNQCeLoriRFNuoaXpm6MQr66KP7?=
 =?us-ascii?Q?Laqmsxf5inl/NFNlmJMM2ww42c3QYwJ7xLK13bYFp0CWyYZL1EzfBcgGBobC?=
 =?us-ascii?Q?d9ahq1LvKGbhN+F9Jh+wXaFfeHKY8O8Iao6TAVUn+YqBNyYblj+3XqCqmNbo?=
 =?us-ascii?Q?z5LMDc4a/oPVElVDpx3i+HpG2Qm3LQcWjTKw2VPAVPNCKDOVs4PrjDw6sFDu?=
 =?us-ascii?Q?zUXQFjwdUbCdPCz4rRQMi0oM7L7InxlhN9pDySn49pK4+zb8x8vc3QlFyxFu?=
 =?us-ascii?Q?FHtyzYVn8TuJtPGvzl5PXbfvEOGOF5A+jMaLB56OP9pqffamQrnbdjYBNJhQ?=
 =?us-ascii?Q?PhzkKdueWjbelMWa5+c5ss14+Iu21RjE1uHK2LeGpJKNlJxhW/9h5Y1PP6wf?=
 =?us-ascii?Q?g4gKv5z1Lk2G4q8+Zq2i2GtIJLFFhT5QBYEy8XssNjsFX9YjLTza7XhatReX?=
 =?us-ascii?Q?R3yoYxlvZzAwJBOopRkoZ4vb6t5P9zzKki3DNGbRFHqGJM6M1y6xpwEKby5b?=
 =?us-ascii?Q?fY6l6XHKuG5G+h+u4JG6dmYD6YzUwAhlEQfUYICn4wUkxq/6ZnLQKrgJDtN4?=
 =?us-ascii?Q?2D6WCpi2XC6xN9iUMUztEkONOnvDLthBayVE/XLH0hCg03rJ5IFiSAH2g47q?=
 =?us-ascii?Q?R3BgyZcyUC6RfVyqSI8H6CPQ22kKa9urcrFCcm1LH/yhi5xb2AaXu6rX2sbG?=
 =?us-ascii?Q?NNBKo3/jqQANzk9sIvEK9XXa/gr21NIATF4AsO7GhqO3McBs/QIazTKtEdXy?=
 =?us-ascii?Q?TN0dVag/JxMtWsHNHDfa+zPW4oQyMMoSVNwdoVPqKmRoX3/SE81fRkO1dE0J?=
 =?us-ascii?Q?tTek4Z6pwhJihPB3EHBMWRxJIr5DdeUkIZ8Kp8b0u7eb3eu/ysW0rOAHJJxm?=
 =?us-ascii?Q?+xmGptqTjZ3WegSf1JJttSA1vkPm8z6kIXAs4lDzruW/WsQZp7KIeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Inxw5e8sxFA+YdmTggMmczT0Rpj1/eHTozJdp8rvmRoFwUMQqPywp8mE1AUB?=
 =?us-ascii?Q?3rqJEzFTQdt0p26av86RJ4avLYK838vISIkGnFCRR7pHFDqtkJ40lLfwPd7f?=
 =?us-ascii?Q?094PGguqWBmCclHf+P3FxcHdorUA6is9M9mF3DVgziVs91kWoMydU9xHxJzF?=
 =?us-ascii?Q?W0Y8fstb5ZJQUVQ4qmFhtNg1lAOdh8Tpsl9zLFseX0qzhfoXzDZ5WzF4uf6+?=
 =?us-ascii?Q?oVIIrL5qOqFHdoSXuPVsagprf6HSnGHq2PPTlfs1LRZHPyizB1gbKZTLpWFM?=
 =?us-ascii?Q?pcjsDuAkA+qCIgLIlbooEm21IK22wdrOrRhxtKcQ9kzw6i+wRWgGtLO8a37G?=
 =?us-ascii?Q?sz5+rdmkwtDG8r73BzJ1cCPBWIhy/HLTW4+Tb78dO6zdHaz0bw6QTfoTklGX?=
 =?us-ascii?Q?7p3wU3ZWWYFKcckJdC4bme2wmwOalqSHXPrRe13oHe3IJUMFwcmiI+13BDHP?=
 =?us-ascii?Q?540fjONHQM7nv0IMhKKOFs3XdN/lfgawFOrjr3nZUPz3/NSXMGEwZTH4O9qJ?=
 =?us-ascii?Q?IZ4zQeOyMZGbAyZx8gIjmdMKGMdR08DZIZdekcX7nm2RVuO5RerQ4NNniX13?=
 =?us-ascii?Q?A7yXBJlRzuVRYxRWWT3COPjO0hSx7Kw+Lz0mvxQvu7ynocohpVZ10M8XxIQ1?=
 =?us-ascii?Q?PjnoXFlNsA7d16mH280DGr5xO9mSVo/Q42emcwNzLFAGju6vbyPHJf5GU2J5?=
 =?us-ascii?Q?78Z9bISIho0eicWAjK1kCbinfOlRuE9qaJ8a78aZK0PjDk641MU0Z/v6GPzf?=
 =?us-ascii?Q?UnR2r1ugn3fqFEKeDExc2zOmk/lkC4IrhwsuFmTNhW7NxozcglJyRlR35MLa?=
 =?us-ascii?Q?j4T+1hCZX3DWvxMLpxpCSXMoeBcqceBasfIJAqlvzcoQuiKs1dwr2RcSe3qa?=
 =?us-ascii?Q?mwXbfcZmDYIJ45bWKOmtXw6S8txdGfEkQEsj0q6WP2gMENcjgA1rMxsIHj2h?=
 =?us-ascii?Q?M91BaseByLtTgrXg6AEZZDLS5N/oFCuydA8B3OCeYsIPzfi++hycOFHoXo58?=
 =?us-ascii?Q?1Z72hh9E7IKNf6gF/fbc5Tt0YghhmDeWvarKqYuVBKvvmqlff5NtLqW7I8ql?=
 =?us-ascii?Q?3UBHB29Rn6www1FqJYf5y/9cZV4zx9aJyGURCSbdHSSDC1bz4DQSnRHv80mZ?=
 =?us-ascii?Q?2zr0TSKREr39BSyJcr+oLKGOZz/6vBB0P23L12bgtgiliYVux5y2jvfaTClF?=
 =?us-ascii?Q?rqlzonr/bVL70NeT+GXLfYBPcetqF8YeaGXb0sYUXyxcoKE/ojs2pB0fU5xQ?=
 =?us-ascii?Q?VmBhrqIguafinjUCPat1QJTDwuGrRxclpOQ5F0KKenZ0AXuufrkNIJxQRqu3?=
 =?us-ascii?Q?CZFbM//J3nWh9HWwj4GNIcXNvRaDQJ05dmhAIx0Lhm5TR9tg28rCHWkgjlO1?=
 =?us-ascii?Q?0EibsTL+0UUqrXn/0XKkv7EueeDLQTXxCGBQGRxWv0GtHWapdDs4Y2ywrgO2?=
 =?us-ascii?Q?Cgki/ptzH7KqEOHSI6tOj8gNlEUYuTcTzNdxnjrvmi02VHjoX+4hHKZIQQTC?=
 =?us-ascii?Q?exJgDoGnZTxchSIWqXgoEHRzhx5LC3GjP54BoRyoe5T05SYmBAvPy297HWVn?=
 =?us-ascii?Q?Vg8yBE4KlPP1/9ZW0nZofxs69v6T0XV6txc+0ZBB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6d04cf-eb70-4812-2993-08ddd5bb9107
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:06:12.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDkJyTVenPhsUXCaAVLqUm4+QbUXyyFHKDOpEoY3crLwucSVysc3IHLew335aqjIPL5RpwRDKlCA+wU0TPJ2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFECF6DCA7C

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 security/selinux/avc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 4b4837a20225..c70053f2806e 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -293,26 +293,26 @@ static struct avc_xperms_decision_node
 	struct extended_perms_decision *xpd;
 
 	xpd_node = kmem_cache_zalloc(avc_xperms_decision_cachep,
-				     GFP_NOWAIT | __GFP_NOWARN);
+				     GFP_NOWAIT);
 	if (!xpd_node)
 		return NULL;
 
 	xpd = &xpd_node->xpd;
 	if (which & XPERMS_ALLOWED) {
 		xpd->allowed = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_NOWAIT | __GFP_NOWARN);
+						GFP_NOWAIT);
 		if (!xpd->allowed)
 			goto error;
 	}
 	if (which & XPERMS_AUDITALLOW) {
 		xpd->auditallow = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_NOWAIT | __GFP_NOWARN);
+						GFP_NOWAIT);
 		if (!xpd->auditallow)
 			goto error;
 	}
 	if (which & XPERMS_DONTAUDIT) {
 		xpd->dontaudit = kmem_cache_zalloc(avc_xperms_data_cachep,
-						GFP_NOWAIT | __GFP_NOWARN);
+						GFP_NOWAIT);
 		if (!xpd->dontaudit)
 			goto error;
 	}
@@ -340,7 +340,7 @@ static struct avc_xperms_node *avc_xperms_alloc(void)
 {
 	struct avc_xperms_node *xp_node;
 
-	xp_node = kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT | __GFP_NOWARN);
+	xp_node = kmem_cache_zalloc(avc_xperms_cachep, GFP_NOWAIT);
 	if (!xp_node)
 		return xp_node;
 	INIT_LIST_HEAD(&xp_node->xpd_head);
@@ -495,7 +495,7 @@ static struct avc_node *avc_alloc_node(void)
 {
 	struct avc_node *node;
 
-	node = kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT | __GFP_NOWARN);
+	node = kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
 	if (!node)
 		goto out;
 
-- 
2.34.1

