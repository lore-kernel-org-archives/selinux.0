Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t55BA47K004199
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 07:10:04 -0400
From: Masatake YAMATO <yamato@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sepolicy-generate: Handle more reserved port types
Date: Fri,  5 Jun 2015 20:09:31 +0900
Message-Id: <1433502571-27116-1-git-send-email-yamato@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently only reserved_port_t, port_t and hi_reserved_port_t
are handled as special when making a ports-dictionary.
However, as fas as corenetwork.te.in of serefpolicy,
both unreserved_port_t and ephemeral_port_t also handled
in the same way.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 policycoreutils/sepolicy/sepolicy/generate.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index 6b53035..446eb39 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -90,7 +90,9 @@ def get_rpm_nvr_list(package):
 def get_all_ports():
     dict = {}
     for p in sepolicy.info(sepolicy.PORT):
-        if p['type'] == "reserved_port_t" or \
+        if p['type'] == "ephemeral_port_t" or \
+                p['type'] == "unreserved_port_t" or \
+                p['type'] == "reserved_port_t" or \
                 p['type'] == "port_t" or \
                 p['type'] == "hi_reserved_port_t":
             continue
-- 
2.1.0
