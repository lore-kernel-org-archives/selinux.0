Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6597269CF1
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501014; cv=none; b=PZlMUnIlkgepFZb0dGMcz4dKRH4+7bWo7medZ+gHH2PEwNZ1zggb2O6ButVd8Zx37HzAcuUDQSOqI9CzEJahPa1e0/x7Dk+n9U8tJ65Bds8DbpFrfrmcHu6+p6le2H+CiMBWMXKoL/zK3dNBFqlJ3YGchC26+vj3OA8LDW+A61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501014; c=relaxed/simple;
	bh=WFksCsibGB/SwCMFPfcYFRBd+Smq+WvBU4YGRmhJxvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpWFrrvq7ioFoNupBCJQR1fTav5QOYNyn3k31EeuXGYxD9LjOGYS6CPls3rMhS5EgTKXqnDf95Vigyxha8yAfB91F3j0KSobLJMBOBKT0IMLlHWN1hjlyYSuk3P7wBLd2nBfRODdg2DUl+AS1kHdFB0d4785XKH94DCvZXyaNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/8HBSle; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/8HBSle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757501011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTo4uNxnmpg8ecgZd+Ql1KG/iLxhsvShTcGXpFhrQHs=;
	b=Y/8HBSlez/0qolgyiOM8/F14YCiKqOeoeTRG1SGSQIhWGreXxi5g/lTIXbyhNf+Dm7zd+J
	myYdxPR1SQL29pjhwYwelgjeQva7aRQIWJI8JLvg+xgy5NsEA0nbAcEPocqCRwd/ugoGId
	X+OntfoQLiX9ZfEWknmphgWw1nMu0XE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-XRkfNYmYNI6uCwPIRVlDDA-1; Wed,
 10 Sep 2025 06:43:28 -0400
X-MC-Unique: XRkfNYmYNI6uCwPIRVlDDA-1
X-Mimecast-MFC-AGG-ID: XRkfNYmYNI6uCwPIRVlDDA_1757501008
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D914619560BA;
	Wed, 10 Sep 2025 10:43:27 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.226.196])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 923D31800446;
	Wed, 10 Sep 2025 10:43:26 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH v3] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
Date: Wed, 10 Sep 2025 11:42:09 +0100
Message-ID: <20250910104322.328299-2-rjones@redhat.com>
In-Reply-To: <20250910104322.328299-1-rjones@redhat.com>
References: <20250910104322.328299-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes with
multiple hard links or bind mounts that have differing contexts.
However doing this involves building a large internal hashtable that
stores the full path of every file examined by setfiles.  For
filesystems that have very large numbers of files or long pathnames,
this uses a lot of memory, which makes SELinux relabelling in
constrained memory environments infeasible.

This adds a new setfiles -A option that disables this tracking.

For example, using setfiles to relabel a filesystem with 15 million
files took 3.7GB of RAM.  Using this option, the same filesystem can
be relabelled in 121MB (albeit with no warnings or errors possible for
conflicting labels, but for our use case we don't care about that.)

Fixes: https://issues.redhat.com/browse/RHEL-111505
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 policycoreutils/setfiles/setfiles.8 |  5 +++++
 policycoreutils/setfiles/setfiles.c | 11 +++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index eabf0a1c..d43e4ad2 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -23,6 +23,7 @@ setfiles \- set SELinux file security contexts.
 .RB [ \-I | \-D ]
 .RB [ \-T
 .IR nthreads ]
+.RB [ \-A ]
 .I spec_file
 .IR pathname \ ...
 
@@ -187,6 +188,10 @@ use up to
 threads.  Specify 0 to create as many threads as there are available
 CPU cores; 1 to use only a single thread (default); or any positive
 number to use the given number of threads (if possible).
+.TP
+.B \-A
+do not track inodes with multiple hard links or bind mounts that would
+match different contexts (saves memory)
 
 .SH "ARGUMENTS"
 .TP
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index ad09f840..31034316 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -40,9 +40,9 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
-			"usage:  %s [-diIDlmnpqvCEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
-			"usage:  %s -s [-diIDlmnpqvFUWT] spec_file\n",
+			"usage:  %s [-diIDlmnpqvACEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
+			"usage:  %s [-diIDlmnpqvACEFUWT] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
+			"usage:  %s -s [-diIDlmnpqvAFUWT] spec_file\n",
 			name, name, name);
 	}
 	exit(-1);
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 	const char *base;
 	int errors = 0;
 	const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
+	const char *sopts = "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
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

