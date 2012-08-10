Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7A48hbi003919
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 00:08:43 -0400
Received: by vbbfc26 with SMTP id fc26so1323584vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 21:08:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 9 Aug 2012 21:08:41 -0700
Message-ID: <CAFftDdqbGbhQc3s9nOqad=jzuj0jQDfY0u66GTg3YMweYaSH2g@mail.gmail.com>
Subject: system_app should be signed platform
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shouldn't an app running in system_app domain also be signed as platform?

Does this break something I missed?

diff --git a/seapp_contexts b/seapp_contexts
index 71eca75..6605f6f 100644
--- a/seapp_contexts
+++ b/seapp_contexts
@@ -30,7 +30,7 @@
 # level may be used to specify a fixed level for any UID.
 #
 isSystemServer=true domain=system
-user=system domain=system_app type=system_data_file
+user=system seinfo=platform domain=system_app type=system_data_file
 user=nfc domain=nfc type=nfc_data_file
 user=radio domain=radio type=radio_data_file
 user=app_* domain=untrusted_app type=app_data_file levelFromUid=true

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
