Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t59BQZG1031980
 for <selinux@tycho.nsa.gov>; Tue, 9 Jun 2015 07:26:36 -0400
Received: by wgv5 with SMTP id 5so10743694wgv.1
 for <selinux@tycho.nsa.gov>; Tue, 09 Jun 2015 04:26:32 -0700 (PDT)
Received: from siphos.be (ip-81-11-255-51.dsl.scarlet.be. [81.11.255.51])
 by mx.google.com with ESMTPSA id gz3sm2468672wib.0.2015.06.09.04.26.31
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2015 04:26:32 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Tue, 9 Jun 2015 13:26:24 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Only invoke RPM on RPM-enabled Linux distributions
Message-ID: <20150609112624.GA10618@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When calling "sepolgen generate" to automatically generate a SELinux
policy template, the command fails when it cannot invoke RPM related
commands on Linux distributions that do not support RPM by default:

Failed to retrieve rpm info for selinux-policy
Traceback (most recent call last):
  File "/usr/lib/python-exec/python2.7/sepolicy", line 643, in <module>
    args.func(args)
  File "/usr/lib/python-exec/python2.7/sepolicy", line 517, in generate
    print mypolicy.generate(args.path)
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1370, in generate
    out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1219, in write_spec
    fd.write(self.generate_spec())
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1181, in generate_spec
    selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
TypeError: 'NoneType' object has no attribute '__getitem__'

As the RPM related steps are only needed on RPM-enabled distributions,
we should ignore these steps on other Linux distribution platforms.

In this patch, we use the Python platform module to get the Linux
distribution, and only start the RPM-related activities on Linux
distributions that use RPM as their native package manager.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/sepolicy/sepolicy/generate.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index 6b53035..4858582 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -26,6 +26,7 @@ import re
 import sepolicy
 from sepolicy import get_all_types, get_all_attributes, get_all_roles
 import time
+import platform
 
 from templates import executable
 from templates import boolean
@@ -1171,7 +1172,8 @@ allow %s_t %s_t:%s_socket name_%s;
 			newsh += re.sub("TEMPLATETYPE", self.name, t1)
 
                 newsh += self.generate_user_sh()
-                newsh += re.sub("TEMPLATEFILE", self.file_name, script.rpm)
+                if (platform.linux_distribution(full_distribution_name=0)[0] in ("redhat","centos","SuSE","fedora","mandrake","mandriva")):
+                    newsh += re.sub("TEMPLATEFILE", self.file_name, script.rpm)
 
 		return newsh
 
@@ -1367,6 +1369,7 @@ Warning %s does not exist
             out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
             out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
             if self.type != NEWTYPE:
-                out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
+                if (platform.linux_distribution(full_distribution_name=0)[0] in ("redhat","centos","SuSE","fedora","mandrake","mandriva")):
+                    out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
                 out += "%s # %s\n" % (self.write_sh(out_dir), _("Setup Script"))
             return out
-- 
2.3.6
