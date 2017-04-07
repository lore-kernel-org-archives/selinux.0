Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37C5Hk7030732
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 08:05:17 -0400
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/load_policy: Drop is_selinux_enabled() check
Date: Fri,  7 Apr 2017 14:05:07 +0200
Message-Id: <20170407120507.3815-1-aranea@aixah.de>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This check is a remnant of the libselinux <2.5 era, back when
is_selinux_enabled() checked whether a policy had been loaded. Nowadays
it only checks whether selinuxfs is mounted, and "load_policy -i"
therefore incorrectly refuses operation when selinuxfs is mounted, but
no policy has been loaded yet.

While it doesn't make much sense to call selinux_init_load_policy()
twice, there's no harm in doing so either, so let's just drop this
safeguard instead of fixing it.
---
 policycoreutils/load_policy/load_policy.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/policycoreutils/load_policy/load_policy.c b/policycoreutils/load_policy/load_policy.c
index 7c2c2a7..2707d6f 100644
--- a/policycoreutils/load_policy/load_policy.c
+++ b/policycoreutils/load_policy/load_policy.c
@@ -65,13 +65,6 @@ int main(int argc, char **argv)
 			argv[0], argv[optind++]);
 	}
 	if (init) {
-		if (is_selinux_enabled() == 1) {
-			/* SELinux is already enabled, we should not do an initial load again */
-			fprintf(stderr,
-					_("%s:  Policy is already loaded and initial load requested\n"),
-					argv[0]);
-			exit(2);
-		}
 		ret = selinux_init_load_policy(&enforce);
 		if (ret != 0 ) {
 			if (enforce > 0) {
-- 
2.12.2
