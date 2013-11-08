From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 07/08] Cleanup whitespace
Date: Fri,  8 Nov 2013 08:17:34 -0500
Message-Id: <1383916655-9354-8-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/setsebool/setsebool.8 | 1 -
 policycoreutils/setsebool/setsebool.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setsebool/setsebool.8 b/policycoreutils/setsebool/setsebool.8
index 7338f15..916a58c 100644
--- a/policycoreutils/setsebool/setsebool.8
+++ b/policycoreutils/setsebool/setsebool.8
@@ -20,7 +20,6 @@ the policy file on disk. So they will be persistent across reboots.
 
 If the \-N option is given, the policy on disk is not reloaded into the kernel.
 
-
 If the \-V option is given, verbose error messages will be printed from semanage libraries.
 
 
diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index 89412d0..b101f08 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -53,10 +53,10 @@ int main(int argc, char **argv)
 			permanent = 1;
 			break;
 		case 'N':
-		        reload = 0;
+			reload = 0;
 			break;
 		case 'V':
-		        verbose = 1;
+			verbose = 1;
 			break;
 		default:
 			usage();
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
