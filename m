Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqUjY011894
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:34 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so5798214wib.6
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:31 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] Make RANLIB variable overridable
Date: Wed, 25 Sep 2013 17:52:00 +0200
Message-Id: <1380124322-32745-4-git-send-email-sven.vermeulen@siphos.be>
In-Reply-To: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
References: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If the RANLIB variable is defined by the user, use that value instead of
the /usr/bin/ranlib binary.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c4f5d4c..9a25d2b 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -82,7 +82,7 @@ override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BIT
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
 
-RANLIB=ranlib
+RANLIB ?= ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
 ifneq (,$(filter i386,$(ARCH)))
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
