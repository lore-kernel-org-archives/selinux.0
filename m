Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4GG9WHw007626
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 12:09:32 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75E8F7D0CA
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 16:09:30 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: Fix checkmodule output message
Date: Mon, 16 May 2016 18:09:25 +0200
Message-Id: <1463414965-5639-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Originally checkmodule stated that it wrote to the input file instead of
to the output file.

Reported-By: Milos Malik <mmalik@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 checkpolicy/checkmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 418f77b..53cc5a0 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -314,7 +314,7 @@ int main(int argc, char **argv)
 
 		if (!cil) {
 			printf("%s:  writing binary representation (version %d) to %s\n",
-				   argv[0], policyvers, file);
+				   argv[0], policyvers, outfile);
 
 			if (write_binary_policy(&modpolicydb, outfp) != 0) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
-- 
2.7.4
