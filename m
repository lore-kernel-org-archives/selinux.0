Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v52K1flL006590
 for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2017 16:01:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB1AB80C0B
 for <selinux@tycho.nsa.gov>; Fri,  2 Jun 2017 20:01:41 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sepolicy: Fix sorting of port_strings in python 3
Date: Fri,  2 Jun 2017 22:01:31 +0200
Message-Id: <20170602200131.16718-3-plautrba@redhat.com>
In-Reply-To: <20170602200131.16718-1-plautrba@redhat.com>
References: <20170602200131.16718-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
$ sepolicy network -d httpd_t

httpd_t: tcp name_connect
Traceback (most recent call last):
  File /usr/bin/sepolicy, line 699, in <module>
    args.func(args)
  File /usr/bin/sepolicy, line 319, in network
    _print_net(d, tcp, name_connect)
  File /usr/bin/sepolicy, line 276, in _print_net
    port_strings.sort(numcmp)
TypeError: must use keyword argument for key function

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy.py | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 5bf9b526..141f64ec 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -241,19 +241,13 @@ def generate_custom_usage(usage_text, usage_dict):
 
     return usage_text
 
-
-def numcmp(val1, val2):
+# expects formats:
+# "22 (sshd_t)", "80, 8080 (httpd_t)", "all ports (port_type)"
+def port_string_to_num(val):
     try:
-        v1 = int(val1.split(",")[0].split("-")[0])
-        v2 = int(val2.split(",")[0].split("-")[0])
-        if v1 > v2:
-            return 1
-        if v1 == v2:
-            return 0
-        if v1 < v2:
-            return -1
+        return int(val.split(" ")[0].split(",")[0].split("-")[0])
     except:
-        return cmp(val1, val2)
+        return 99999999
 
 
 def _print_net(src, protocol, perm):
@@ -273,7 +267,7 @@ def _print_net(src, protocol, perm):
                     port_strings.append("%s (%s) %s" % (", ".join(recs), t, boolean_text))
                 else:
                     port_strings.append("%s (%s)" % (", ".join(recs), t))
-        port_strings.sort(numcmp)
+        port_strings.sort(key=lambda param: port_string_to_num(param))
         for p in port_strings:
             print("\t" + p)
 
-- 
2.13.0
