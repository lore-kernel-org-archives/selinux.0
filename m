Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v52K1flK006590
 for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2017 16:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80F6737EEC
 for <selinux@tycho.nsa.gov>; Fri,  2 Jun 2017 20:01:40 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] sepolicy/interface: Use relative python 3 imports
Date: Fri,  2 Jun 2017 22:01:30 +0200
Message-Id: <20170602200131.16718-2-plautrba@redhat.com>
In-Reply-To: <20170602200131.16718-1-plautrba@redhat.com>
References: <20170602200131.16718-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
Verify sepolicy interface -c -i works ... Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 699, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 508, in interface
    print_interfaces(args.interfaces, args)
  File "/usr/bin/sepolicy", line 492, in print_interfaces
    interface_compile_test(i)
  File "/usr/lib/python3.6/site-packages/sepolicy/interface.py", line 226, in interface_compile_test
    fd.write(generate_compile_te(interface, idict))
  File "/usr/lib/python3.6/site-packages/sepolicy/interface.py", line 184, in generate_compile_te
    from templates import test_module
ModuleNotFoundError: No module named 'templates'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/interface.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 8956f394..c64122e5 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -171,7 +171,7 @@ def get_interface_format_text(interface, path="/usr/share/selinux/devel/policy.x
 
 
 def get_interface_compile_format_text(interfaces_dict, interface):
-    from templates import test_module
+    from .templates import test_module
     param_tmp = []
     for i in interfaces_dict[interface][0]:
         param_tmp.append(test_module.dict_values[i])
@@ -181,7 +181,7 @@ def get_interface_compile_format_text(interfaces_dict, interface):
 
 
 def generate_compile_te(interface, idict, name="compiletest"):
-    from templates import test_module
+    from .templates import test_module
     te = ""
     te += re.sub("TEMPLATETYPE", name, test_module.te_test_module)
     te += get_interface_compile_format_text(idict, interface)
-- 
2.13.0
