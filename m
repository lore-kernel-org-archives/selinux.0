Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6363307482
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835413; cv=none; b=P7sNBAvcv7J3LeoIPQB3WzblHdlM3fulnao+0v66KHmvLK3iqRaEfzEMRYbORmtDUmQXbFqr9BqFTqAywPA0C38htuwBWRDxgWIptZE8veMgP7bM68upbchcnAS/R3WxPDGxEN6YpJVKvQgFTj4Pr8hJSRMm6akLadhYpMWWVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835413; c=relaxed/simple;
	bh=ZgS9tvZlsqtiDOB1I7l9yp5gefstFb/oQVd4Ny6jx1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQYSANs2swcOvWAEB7i8KNdlR57OhM4JiV0B68/PgOs8txFR3iN+R4e84CCRasnCStTvIVz4JAM5vULKYqwVoaYMti7QIX0ZMJIy7tkECp2xIYyiaImRpmqHtBrrd4KBQiOahgoU9iMj5+ZlzW0G2qgUqxg49CHacjteqbyoYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWxEpKMZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWxEpKMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756835410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr7+DUYjRrhs73uJezrKiw5SmVLWiaYaopZPEBwukc4=;
	b=dWxEpKMZF5oXlhwqKBxuNkHkcajbvv0MZPAMU9ZjVgsF0CyD0Y454XTQzeINbVbNtQsynS
	LmD8uBjxBq1b1eSM5VdYaUN+12Nxkr2sNkUGj1cQ7x5VCrgrecuYuL1c4Vb2tZtudBmc1P
	FZWXqA467VOPWGRS1G3TTmnvuIXKbBU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-K72gF1MVPPuGByR8qFaNuA-1; Tue,
 02 Sep 2025 13:50:07 -0400
X-MC-Unique: K72gF1MVPPuGByR8qFaNuA-1
X-Mimecast-MFC-AGG-ID: K72gF1MVPPuGByR8qFaNuA_1756835406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FB10180028C;
	Tue,  2 Sep 2025 17:50:06 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BC7819560AB;
	Tue,  2 Sep 2025 17:50:05 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	lautrbach@redhat.com
Subject: [PATCH v2] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
Date: Tue,  2 Sep 2025 18:48:48 +0100
Message-ID: <20250902175000.3214164-2-rjones@redhat.com>
In-Reply-To: <20250902175000.3214164-1-rjones@redhat.com>
References: <20250902175000.3214164-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 policycoreutils/setfiles/setfiles.8 |  4 ++++
 policycoreutils/setfiles/setfiles.c | 11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

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
index ad09f840..4db3e894 100644
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

