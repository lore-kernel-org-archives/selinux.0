Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5G8UJmf008432
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 04:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BDF7796F0
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 08:30:16 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.43.12.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D50D588F1B
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 08:30:15 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/fixfiles: do not dereference link files in tmp
Date: Fri, 16 Jun 2017 10:29:59 +0200
Message-Id: <20170616082959.20461-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Files in /tmp, /var/tmp, /var/run and /var/lib/debug labeled as
unlabeled_t or undefined_t are relabeled to match corresponding
directory label. Stop dereferencing link files in these folders
in order not to accidentally change label of other files in the
system.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1458831

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/scripts/fixfiles | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 0eeeea4..1aa330f 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -255,10 +255,10 @@ case "$RESTORE_MODE" in
 	UNDEFINED=`get_undefined_type` || exit $?
 	UNLABELED=`get_unlabeled_type` || exit $?
 	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
-	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /tmp {} \;
-	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/tmp {} \;
-	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /var/run {} \;
-	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --reference /lib {} \;
+	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
+	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
+	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run {} \;
+	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
     ;;
 esac
 }
-- 
2.9.4
