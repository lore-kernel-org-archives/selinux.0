From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 03/08] Add domain to short list of domains, when -t and -d used together
Date: Fri,  8 Nov 2013 08:17:30 -0500
Message-Id: <1383916655-9354-4-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/sepolicy/sepolicy/gui.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 94ddb72..5ca87b9 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -484,6 +484,8 @@ class SELinuxGui():
         path = None
         if test:
             domains = [ "httpd_t", "abrt_t" ]
+            if app and app not in domains:
+                domains.append(app)
         else:
             domains = sepolicy_domains
             loading_gui.show()
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
