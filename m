From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 06/11] Add prototype decl for destructor
Date: Mon, 23 Jan 2012 15:41:16 +0000
Message-Id: <1327333281-4223-7-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

---
 libselinux/src/setrans_client.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index e074142..9432f49 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -253,6 +253,8 @@ static void setrans_thread_destructor(void __attribute__((unused)) *unused)
 	free(prev_r2c_raw);
 }
 
+void __attribute__((destructor)) setrans_lib_destructor(void);
+
 void __attribute__((destructor)) setrans_lib_destructor(void)
 {
 	if (destructor_key_initialized)
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
