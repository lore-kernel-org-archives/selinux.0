Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA72F49EE
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737265; cv=none; b=daL7Qj+bad8+Cn2ReB5EjpkpuZdVnzQ5OEt1InU90MRnlKEvhHeNQJutkqDRwr4AKY+TWHOzOP9gqF8Q8OG8j9xqwK1pkji6TMTkpcoPpt5OFXiO7z2UaKfU/cy91aoAMsWNqCweyukPciFUIDAonKYlXpuRqbBHS4xKHOjxb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737265; c=relaxed/simple;
	bh=7FHZ/RjBZgxK297OlWFq9FPsR0K4pxTekF/TLjvad8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzFGzQfcdabWnfclkrig6BzFlvqx0/0+kIkbx1skRoo3SEgaeWGIyI6Wx6AiUN201Ymq5KMUf6u7qCBVLoIbYmM/y+3xJw4M+sc/9xn2eXzbYDjRKCOAU/RrtTfF5lq4OsSvJfjWhYVzXmlgujzbg6NLou4dTsyxz9/9rURkMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJDXgox3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJDXgox3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhvldLkrYUHgRLP0SJGZUBt/Rjx7qci2lSrgy/Wpqmg=;
	b=PJDXgox3w8kdasog1CItuiEXZsDBBVS1sYfE/51c8/8WyIzd1dOjrpeuMjpMTtVd78ZxYS
	wabAF9tU3yLrNiwmbhOQ1x1bRA+GVbTsKHh6IFj618v/2n6vbfHA5sVxlCXKa5cAwnoFOO
	nsLRVAd2SNUbTWEY4SIPsWpYS3XzT30=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-f99K_0grNGOOkgJJdve-QQ-1; Mon,
 01 Sep 2025 10:34:20 -0400
X-MC-Unique: f99K_0grNGOOkgJJdve-QQ-1
X-Mimecast-MFC-AGG-ID: f99K_0grNGOOkgJJdve-QQ_1756737260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D97519560BB
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:20 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C2A330001BB
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:19 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
Date: Mon,  1 Sep 2025 15:31:13 +0100
Message-ID: <20250901143412.2904562-2-rjones@redhat.com>
In-Reply-To: <20250901143412.2904562-1-rjones@redhat.com>
References: <20250901143412.2904562-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have
differing contexts.  However doing this involves building a large
internal hashtable that stores the full path of every file examined by
setfiles.  For filesystems that have very large numbers of files or
long pathnames, this uses a lot of memory, which makes SELinux
relabelling in constrained memory environments infeasible.

This adds a new setfiles -A option that disables this tracking.

For example, using setfiles to relabel a filesystem with 15 million
files took 3.7GB of RAM.  Using this option, the same filesystem can
be relabelled in 121MB (albeit with no warnings or errors possible for
conflicting labels, but for our use case we don't care about that.)

Fixes: https://issues.redhat.com/browse/RHEL-111505
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 policycoreutils/setfiles/setfiles.8 | 4 ++++
 policycoreutils/setfiles/setfiles.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index eabf0a1c..7c9c5d39 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -23,6 +23,7 @@ setfiles \- set SELinux file security contexts.
 .RB [ \-I | \-D ]
 .RB [ \-T
 .IR nthreads ]
+.RB [ \-A ]
 .I spec_file
 .IR pathname \ ...
 
@@ -187,6 +188,9 @@ use up to
 threads.  Specify 0 to create as many threads as there are available
 CPU cores; 1 to use only a single thread (default); or any positive
 number to use the given number of threads (if possible).
+.TP
+.B \-A
+do not track conflicting inodes (saves memory)
 
 .SH "ARGUMENTS"
 .TP
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index ad09f840..40f2e7fe 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 	const char *base;
 	int errors = 0;
 	const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
+	const char *sopts = "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:A";
 	const char *opts;
 	union selinux_callback cb;
 	long unsigned skipped_errors;
@@ -375,6 +375,9 @@ int main(int argc, char **argv)
 			if (*optarg == '\0' || *endptr != '\0')
 				usage(argv[0]);
 			break;
+		case 'A':
+			r_opts.add_assoc = 0;
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
-- 
2.50.1

