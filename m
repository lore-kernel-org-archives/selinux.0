Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7F1E1DEE;
	Fri,  7 Mar 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341423; cv=none; b=anVeh6+etQfEvxaHW4gmdIhlQoUf9/cAbNln/39O7CtcAYSxKG79aOyQyOa4oKTYXpbulBpf0MDr4cMF40O64Ms0mTFUvPH+n0tnVYmZUb+sORsagN5pSHclXHeqnEXlI/YUSxS80B5IJ8Yko3rfQEHu+dOqZhLbSZJ/NE6Yunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341423; c=relaxed/simple;
	bh=0KzVUS9lS1mWOExLoBlUcB71/E5nvpGgJsLuWnzqLiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WZ/AS0uUNntDvI6iprawRwBqrZ+kVF6c7kOUQ7U6yi0UloMk4sHVIRXRPo5gd1UeiNxqQTyXOFEO+ve9mO31Hg5vXWi8u3leMpZekY43GNvE6Si293PJMJZPTr7bFynp6MWL+qnStEPBQAW/1W0e/xgd5MNJIZ4KIirbpxhZJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z8M7N6kBwz6J7nJ;
	Fri,  7 Mar 2025 17:53:52 +0800 (CST)
Received: from frapeml500004.china.huawei.com (unknown [7.182.85.22])
	by mail.maildlp.com (Postfix) with ESMTPS id E5113140B39;
	Fri,  7 Mar 2025 17:56:52 +0800 (CST)
Received: from smtpsde.huawei.com (10.221.117.194) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Mar 2025 10:56:52 +0100
From: Tim Schumacher <tim.schumacher1@huawei.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Dominick Grift <dominick.grift@defensec.nl>
CC: Tim Schumacher <tim.schumacher1@huawei.com>, Stephen Smalley
	<sds@tycho.nsa.gov>, <selinux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] selinux: Chain up tool resolving errors in install_policy.sh
Date: Fri, 7 Mar 2025 10:56:43 +0100
Message-ID: <20250307095645.326982-1-tim.schumacher1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: frapeml500004.china.huawei.com (7.182.85.22) To
 frapeml500004.china.huawei.com (7.182.85.22)

Subshell evaluations are not exempt from errexit, so if a command is
not available, `which` will fail and exit the script as a whole.
This causes the helpful error messages to not be printed if they are
tacked on using a `$?` comparison.

Resolve the issue by using chains of logical operators, which are not
subject to the effects of errexit.

Fixes: e37c1877ba5b1 ("scripts/selinux: modernize mdp")
Signed-off-by: Tim Schumacher <tim.schumacher1@huawei.com>
---
 scripts/selinux/install_policy.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 24086793b0d8..db40237e60ce 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -6,27 +6,24 @@ if [ `id -u` -ne 0 ]; then
 	exit 1
 fi
 
-SF=`which setfiles`
-if [ $? -eq 1 ]; then
+SF=`which setfiles` || {
 	echo "Could not find setfiles"
 	echo "Do you have policycoreutils installed?"
 	exit 1
-fi
+}
 
-CP=`which checkpolicy`
-if [ $? -eq 1 ]; then
+CP=`which checkpolicy` || {
 	echo "Could not find checkpolicy"
 	echo "Do you have checkpolicy installed?"
 	exit 1
-fi
+}
 VERS=`$CP -V | awk '{print $1}'`
 
-ENABLED=`which selinuxenabled`
-if [ $? -eq 1 ]; then
+ENABLED=`which selinuxenabled` || {
 	echo "Could not find selinuxenabled"
 	echo "Do you have libselinux-utils installed?"
 	exit 1
-fi
+}
 
 if selinuxenabled; then
     echo "SELinux is already enabled"
-- 
2.43.0

