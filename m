Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F411DE4D5
	for <selinux@vger.kernel.org>; Mon, 13 Jan 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804311; cv=none; b=I3pfXsmXbHsN00uQDDM9hAqOk0D01gXzIPpXldlB7PaQZ2bhrViLAok+4WRDyjtCC75N5r8f4vD/wSKPQMieDFElxuT2Bd+ihx1MyPt3HL/LjhleBoMenBK0x+Cqa0p8q+gJEv6+i35FR74RVoro8NWavzAJBBU7NjCX4JPTw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804311; c=relaxed/simple;
	bh=G1g3oKvTm2VVqTP64efE/XWNjb2cw+R4GPZqxv6LDV4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Je5GemwaQp7ScGV3747teMPAUuuRg384Jfl4WbFsjklCttnwTXHKHsfIrgUUc1flIK02YRBOMOoJ+widtzFWO1HbrdpgCY53QOTJe11BDBRTOccl1WU6RRKnXI/He9+61Bf4bJyO0KkXcSHm0cLZ8J5Iymv0NnOBHoaiCaBnEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GoTyHDwh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GoTyHDwh"
Received: from DESKTOP-NVB873J.corp.microsoft.com (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93D96205919B
	for <selinux@vger.kernel.org>; Mon, 13 Jan 2025 13:38:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93D96205919B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736804309;
	bh=6VUF5znnnJ8/OzKjMof4erO1YB/NzBTyAo+zI0xvYTo=;
	h=From:To:Subject:Date:From;
	b=GoTyHDwhEMuzgBGkMuwPs4bP7KGJkHP8qj71NJKmiVv6nXGyLfBFYN6iOaw5h2MzF
	 BgcbN1TkzAPHpEQjus/HWygFyQBpjs0Gi2+Cd22pYyA7fmXAC4H971LQBy9NreOE91
	 lrT+OBvEcka+O2nZDm4p78CpZQMGRrcIUB6Mq/Yc=
From: Daniel Burgener <dburgener@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH] CONTRIBUTING.md: Drop dependency and build instructions
Date: Mon, 13 Jan 2025 16:38:24 -0500
Message-Id: <20250113213824.26000-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are redundant with README.md, and haven't been kept up to date.
For example, the CONTRIBUTING.md dependencies are missing the xmlto
dependency.  Rather than try to maintain this information in two places,
just refer contributors to the README and keep the CONTRIBUTING doc
focused on high level process.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 CONTRIBUTING.md | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 7c548e58..e6a677a0 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -23,14 +23,7 @@ using a custom policy please include it as well.
 
 ## Compiling
 
-There are a number of dependencies required to build the userspace
-tools/libraries. On a Fedora system you can install them with yum:
-
-    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre2-devel python-devel setools-devel swig ustr-devel
-
-The tools and libraries can be built and installed under a private directory from the top level with make, e.g.
-
-    $ make DESTDIR=~/obj install install-pywrap
+See README.md for instructions on how to compile and test this project.
 
 ## Contributing Code
 
-- 
2.34.1

