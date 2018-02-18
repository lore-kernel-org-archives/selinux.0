Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1IMLvSB024450
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 17:21:57 -0500
Received: by mail-vk0-f52.google.com with SMTP id m197so4688233vka.3
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 14:21:54 -0800 (PST)
From: Lee Stubbs <lee.stubbs@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Lee Stubbs <lee.stubbs@gmail.com>
Date: Sun, 18 Feb 2018 17:21:41 -0500
Message-Id: <20180218222141.95374-1-lee.stubbs@gmail.com>
Subject: [PATCH] Minor update for bash completion. Bash completion
 for ports is missing '-' for type. Based on documentation,
 it should be --type, not -type.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 python/semanage/semanage-bash-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index 6b53292..2d811c9 100644
--- a/python/semanage/semanage-bash-completion.sh
+++ b/python/semanage/semanage-bash-completion.sh
@@ -59,7 +59,7 @@ __get_export_opts () { echo '$ALL_OPTS --f --output_file' ; }
 __get_boolean_opts () { echo '$ALL_OPTS --on -off -1 -0' ; }
 __get_user_opts () { echo '$ALL_OPTS $MANAGED_OPTS -L --level -r --range -R --role '; }
 __get_login_opts () { echo '$ALL_OPTS $MANAGED_OPTS -s --seuser -r --range'; }
-__get_port_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t -type -r --range -p --proto'; }
+__get_port_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -r --range -p --proto'; }
 __get_interface_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type '; }
 __get_node_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -M --mask -p --proto'; }
 __get_fcontext_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -e --equal -f --ftype '; }
-- 
2.10.1 (Apple Git-78)
