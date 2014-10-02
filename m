Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s92DBQTr030422
 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2014 09:11:28 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/3] policycoreutils/hll/pp: fix '\n' parsing in filecon
 statements
Date: Thu, 2 Oct 2014 09:10:09 -0400
Message-ID: <1412255410-15537-3-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some module fc files do not contain a trailing new line. This
caused contexts to have their last character to be deleted. When
parsing each line from a fc file, we only strip off the last character
if it is a new line.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index d424f80..55cf819 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -2753,7 +2753,9 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 	fp = fmemopen(fc, fc_len, "r");
 	while ((line_len = getline(&line, &len, fp)) != -1) {
 		buf = line;
-		buf[line_len - 1] = '\0';
+		if (buf[line_len - 1] == '\n') {
+			buf[line_len - 1] = '\0';
+		}
 		while (*buf && isspace(buf[0])) {
 			buf++;
 		}
-- 
1.9.3
