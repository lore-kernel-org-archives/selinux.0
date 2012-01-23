From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 02/11] Ensure there is a prototype for 'matchpathcon_lib_destructor'
Date: Mon, 23 Jan 2012 15:41:12 +0000
Message-Id: <1327333281-4223-3-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

---
 libselinux/src/matchpathcon.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 48f7a11..804442b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -292,6 +292,8 @@ static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 	matchpathcon_fini();
 }
 
+void __attribute__((destructor)) matchpathcon_lib_destructor(void);
+
 void __attribute__((destructor)) matchpathcon_lib_destructor(void)
 {
 	if (destructor_key_initialized)
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
