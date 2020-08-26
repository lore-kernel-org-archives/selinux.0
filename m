Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57816C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF320707
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvljJX1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgHZLqk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:46:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgHZLcL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 07:32:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBTGKw052284;
        Wed, 26 Aug 2020 11:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=7kpJnUdWpHetd5cIVb8DwPCwBujDgY3ez9LpDs6af+o=;
 b=YvljJX1lzqLFf1jwL9TuDihCf6S9dohrC44y5WELRXTpOF0jvIgw3e+FQNb847F0XAEN
 9uyIsJHD6xxknU3Foajngx5659T78M2JqPfGOXChMmsQNLHTHS9mqHWH6rHszIGWx0BI
 KhYmxGriVxea6DfW5b9/Ji43UY25WCP40xy9+b5qc35yn8gZaXZHAnw01MUGPC86gfHK
 RNGHZKZqCVn5WA+H1jXMSo2iOsTpzulPcI+eWRWjlOgursvdrBV5On4z0VCK7Uip3aKG
 ysMUqrS0rqcsRSkzvvqFkZ6A47P0jU/UVrs5p3eSfMhrAOXf00CHaDh1XQruOMd8GQ21 GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6txbjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:32:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUFYQ001060;
        Wed, 26 Aug 2020 11:31:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 333rua27y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:31:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QBVuif024247;
        Wed, 26 Aug 2020 11:31:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:31:55 -0700
Date:   Wed, 26 Aug 2020 14:31:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] selinux: fix error handling bugs in security_load_policy()
Message-ID: <20200826113148.GA393664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=2 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260093
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are a few bugs in the error handling for security_load_policy().

1) If the newpolicy->sidtab allocation fails then it leads to a NULL
   dereference.  Also the error code was not set to -ENOMEM on that
   path.
2) If policydb_read() failed then we call policydb_destroy() twice
   which meands we call kvfree(p->sym_val_to_name[i]) twice.
3) If policydb_load_isids() failed then we call sidtab_destroy() twice
   and that results in a double free in the sidtab_destroy_tree()
   function because entry.ptr_inner and entry.ptr_leaf are not set to
   NULL.

One thing that makes this code nice to deal with is that none of the
functions return partially allocated data.  In other words, the
policydb_read() either allocates everything successfully or it frees
all the data it allocates.  It never returns a mix of allocated and
not allocated data.

I re-wrote this to only free the successfully allocated data which
avoids the double frees.  I also re-ordered selinux_policy_free() so
it's in the reverse order of the allocation function.

Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I was wrong about context_cpy().  There is no double free in the error
handling there.  Sorry about that.

 security/selinux/ss/services.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a48fc1b337ba..645e436cdb85 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2127,10 +2127,10 @@ static void selinux_policy_free(struct selinux_policy *policy)
 	if (!policy)
 		return;
 
-	policydb_destroy(&policy->policydb);
 	sidtab_destroy(policy->sidtab);
-	kfree(policy->sidtab);
 	kfree(policy->map.mapping);
+	policydb_destroy(&policy->policydb);
+	kfree(policy->sidtab);
 	kfree(policy);
 }
 
@@ -2224,23 +2224,25 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		return -ENOMEM;
 
 	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
-	if (!newpolicy->sidtab)
-		goto err;
+	if (!newpolicy->sidtab) {
+		rc = -ENOMEM;
+		goto err_policy;
+	}
 
 	rc = policydb_read(&newpolicy->policydb, fp);
 	if (rc)
-		goto err;
+		goto err_sidtab;
 
 	newpolicy->policydb.len = len;
 	rc = selinux_set_mapping(&newpolicy->policydb, secclass_map,
 				&newpolicy->map);
 	if (rc)
-		goto err;
+		goto err_policydb;
 
 	rc = policydb_load_isids(&newpolicy->policydb, newpolicy->sidtab);
 	if (rc) {
 		pr_err("SELinux:  unable to load the initial SIDs\n");
-		goto err;
+		goto err_mapping;
 	}
 
 
@@ -2254,7 +2256,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	rc = security_preserve_bools(state, &newpolicy->policydb);
 	if (rc) {
 		pr_err("SELinux:  unable to preserve booleans\n");
-		goto err;
+		goto err_free_isids;
 	}
 
 	/*
@@ -2279,13 +2281,23 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
 			" table\n");
-		goto err;
+		goto err_free_isids;
 	}
 
 	*newpolicyp = newpolicy;
 	return 0;
-err:
-	selinux_policy_free(newpolicy);
+
+err_free_isids:
+	sidtab_destroy(newpolicy->sidtab);
+err_mapping:
+	kfree(newpolicy->map.mapping);
+err_policydb:
+	policydb_destroy(&newpolicy->policydb);
+err_sidtab:
+	kfree(newpolicy->sidtab);
+err_policy:
+	kfree(newpolicy);
+
 	return rc;
 }
 
-- 
2.28.0

