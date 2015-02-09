Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19N6ol5025099
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t19N6mGW006216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:48 -0500
Subject: [PATCH 4/4] selinux-testsuite: allow unconfined_t entrypoint to
 test_nnp_bounded_exec_t
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 09 Feb 2015 18:06:47 -0500
Message-ID: <20150209230647.2579.61237.stgit@localhost>
In-Reply-To: <20150209230426.2579.84520.stgit@localhost>
References: <20150209230426.2579.84520.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Stephen Smalley <sds@tycho.nsa.gov>

A necessary fix for recent systems running the NNP tests from the
unconfined_t domain.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
[PM: tweaked the subject line and added a brief description]
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 0 files changed

diff --git a/policy/test_nnp.te b/policy/test_nnp.te
index 69cd714..54ebfd3 100644
--- a/policy/test_nnp.te
+++ b/policy/test_nnp.te
@@ -13,6 +13,7 @@ typebounds unconfined_t test_nnp_bounded_t;
 type test_nnp_bounded_exec_t;
 files_type(test_nnp_bounded_exec_t)
 domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+domain_entry_file(unconfined_t, test_nnp_bounded_exec_t)
 
 # Run it!  This should succeed on v3.18 or later, fail on older kernels.
 unconfined_runs_test(test_nnp_bounded_t)
