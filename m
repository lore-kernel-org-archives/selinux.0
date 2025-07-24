Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBA2D5C9F
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346455; cv=none; b=IoOLPPJS5TJWp5VF2dUeopkmWLL/YOTWQdKGkCvkzDberUvkoN5z+BnmAUbTyMX1/TObYU/JfJVJOGG7C/EAtRdXhIjnP56+MelM72gY0qnuh4rWFuzVMu4G3DZ8LlDQG55d2IMuG86fNUn+Ge/AlwZWaoMAJ1mxdeQDS6wVTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346455; c=relaxed/simple;
	bh=5al0yfJaL7CVuxT4rO81FvA9vhqGrmZ5u9o+DyaZqsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=RzJbNBZjawL9JCWVFdUCINhjAdlkavJD+cJpiZrXYP7VjtXgTZAjPj8TKxUczb0N7Pa1Zm9qugSJLhFj+qzMzM2SewK6THEge0dPn3iMngL2AQ4ZPTFjO3SS5zKK+eGVFXRqZYQ+QdMIDapQ4cHQlacroQ9iPWBywI+DL/X9cPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CetBOs7+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CetBOs7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753346452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2IOnkApAXvH87sX0BvhFrBNLh6QevozhSW1zrl6sCr0=;
	b=CetBOs7+LL7AXn2Vo9pVyBJWGN/x3y7/pYoKc7usrop8PkKPwvpESXiFjzUmAk1QhGEcOH
	wZDkb2RqxIFjJIF9RCM26Z71cXOk4habCsljBzleM1oMfE36qIfnA0BQfHnHfMh8LhGbxx
	SO28VXZ/AXiLBuA3IFOzaXmZd1bzOUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-GvexnckbNEmQH-jyJfJD7w-1; Thu,
 24 Jul 2025 04:40:50 -0400
X-MC-Unique: GvexnckbNEmQH-jyJfJD7w-1
X-Mimecast-MFC-AGG-ID: GvexnckbNEmQH-jyJfJD7w_1753346449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521021800D8C
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 08:40:49 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3163318002AF;
	Thu, 24 Jul 2025 08:40:47 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] Update CONTRIBUTING.md
Date: Thu, 24 Jul 2025 10:40:29 +0200
Message-ID: <20250724084044.23390-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is based on
https://github.com/SELinuxProject/selinux/wiki/Contributing with
preserved "Developer Certificate of Origin" part

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 CONTRIBUTING.md | 51 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 575410bf8c3d..c501cf842dcd 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -4,18 +4,31 @@ Contributing to the SELinux userspace project is a similar process to
 other open source projects. Bug reports, new features to the existing
 code, additional tools, or updated documentation are all welcome.
 
-You can find a list of open issues where you might contribute to the SELinux kernel code at
-https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinux userspace code at
-https://github.com/SELinuxProject/selinux/issues.
+You can find a list of open issues to the SELinux userspace code at
+https://github.com/SELinuxProject/selinux/issues
 
-See the SELinux userspace
-[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
-information on mailing lists, documentation, and other resources.
+See the SELinux kernel [Getting Started](https://github.com/selinuxproject/selinux-kernel/wiki/Getting-Started)
+guide if you want to contribute to SELinux kernel development instead.
+
+## Mailing list
+
+SELinux has a public mailing list for developers, subscribe by sending an email to
+[selinux+subscribe@vger.kernel.org](mailto:selinux+subscribe@vger.kernel.org).
+It is generally wise to read relevant postings to the list before beginning any
+area of new work. Searchable mailing list archives are available externally at
+https://lore.kernel.org/selinux/ . Patches for SELinux are tracked via
+https://patchwork.kernel.org/project/selinux/list/ .
+
+## IRC
+
+An unofficial SELinux IRC channel is
+[\#selinux](https://web.libera.chat/?channel=#selinux) on [Libera.Chat](https://libera.chat/).
 
 ## Reporting Bugs
 
-All bugs and patches should be submitted to the [SELinux mailing
-list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org.
+All bugs and patches should be submitted to the
+[SELinux mailing list](https://lore.kernel.org/selinux) at
+[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
 
 When reporting bugs please include versions of SELinux related libraries and
 tools (libsepol, libselinux, libsemanage, checkpolicy). If you are
@@ -23,17 +36,20 @@ using a custom policy please include it as well.
 
 ## Compiling
 
-See README.md for instructions on how to compile and test this project.
+There are a number of dependencies required to build the userspace
+tools/libraries. Consult the [README.md](https://github.com/SELinuxProject/selinux/blob/main/README.md)
+for the current list of dependencies and how to build the userspace code.
 
 ## Contributing Code
 
-After obtaining the code of the repository (see below), create a patch
-against the repository, and post that patch to the [SELinux mailing
-list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org. When preparing
-patches, please follow these guidelines:
+After cloning the code of the repository (see below), create a patch against the
+repository, and post that patch to the
+[SELinux mailing list](https://lore.kernel.org/selinux) at
+[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
+When preparing patches, please follow these guidelines:
 
--   Patches should apply with -p1
--   Must apply against HEAD of the master branch
+-   Patches should apply with git am
+-   Must apply against HEAD of the main branch
 -   Separate large patches into logical patches
 -   Patch descriptions must end with your "Signed-off-by" line. This means your
     code meets the Developer's certificate of origin, see below.
@@ -43,10 +59,7 @@ design on the mailing list prior to submitting the patch.
 
 ## Development Repository
 
-Git is a modern source code management system. For more information
-about Git please see the Git website.
-
-To get an anonymous checkout of the SELinux userland repository you can
+To get a copy of the SELinux userland repository you can
 run:
 
     $ git clone https://github.com/SELinuxProject/selinux.git
-- 
2.50.1

