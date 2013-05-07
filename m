Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r479E4QJ013193
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2013 05:14:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so3489383wiv.2
        for <selinux@tycho.nsa.gov>; Tue, 07 May 2013 02:14:02 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id m14sm1434993wij.9.2013.05.07.02.13.58
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 02:13:59 -0700 (PDT)
Date: Tue, 7 May 2013 11:13:06 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Fix KeyError when using sepolicy transition
Message-ID: <20130507091306.GA10869@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When calling "sepolicy transition", a KeyError exception occurred:

~# sepolicy transition -s sysadm_t -t portage_t
Traceback (most recent call last):
  File "/usr/bin/sepolicy-2.7", line 465, in <module>
    args.func(args)
  File "/usr/bin/sepolicy-2.7", line 309, in transition
    mytrans.output()
  File "/usr/lib64/python2.7/site-packages/sepolicy/transition.py", line 76, in output
    print self.out(self.source)
  File "/usr/lib64/python2.7/site-packages/sepolicy/transition.py", line 72, in out
    buf+= self.out(x, seen, "%s%s ... " % (header, name))
  File "/usr/lib64/python2.7/site-packages/sepolicy/transition.py", line 67, in out
    for t in self.sdict[name]["map"]:
KeyError: 'map'

By updating the code to first check if the "map" key is known to the dictionary
(and only then executing the mentioned code) this error is no longer prevalent:

~# sepolicy transition -s sysadm_t -t portage_t
sysadm_t @ portage_exec_t --> portage_t
sysadm_t ... dhcpc_t ... initrc_t ... puppet_t @ portage_exec_t --> portage_t
sysadm_t ... dhcpc_t ... initrc_t ... puppet_t ... portage_fetch_t @ portage_exec_t --> portage_t
sysadm_t ... dhcpc_t ... initrc_t ... crond_t @ portage_exec_t --> portage_t
sysadm_t ... dhcpc_t ... initrc_t ... crond_t ... system_cronjob_t @ portage_exec_t --> portage_t

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/sepolicy/sepolicy/transition.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/transition.py b/policycoreutils/sepolicy/sepolicy/transition.py
index 5850622..5e308e3 100755
--- a/policycoreutils/sepolicy/sepolicy/transition.py
+++ b/policycoreutils/sepolicy/sepolicy/transition.py
@@ -64,8 +64,9 @@ class setrans:
             return buf
         seen.append(name)
 
-        for t in self.sdict[name]["map"]:
-            buf += "%s%s @ %s --> %s\n" % (header, t["source"], t["target"], t["transtype"])
+        if "map" in self.sdict[name]:
+            for t in self.sdict[name]["map"]:
+                buf += "%s%s @ %s --> %s\n" % (header, t["source"], t["target"], t["transtype"])
 
         if "child" in self.sdict[name]:
             for x in self.sdict[name]["child"]:
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
