Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqUjZ011894
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:35 -0400
Received: by mail-wg0-f44.google.com with SMTP id b13so6321382wgh.23
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:30 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] Update pkgconfig definition
Date: Wed, 25 Sep 2013 17:51:59 +0200
Message-Id: <1380124322-32745-3-git-send-email-sven.vermeulen@siphos.be>
In-Reply-To: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
References: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libselinux/src/libselinux.pc.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 5691559..2bd3c0e 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -7,6 +7,6 @@ Name: libselinux
 Description: SELinux utility library
 Version: @VERSION@
 URL: http://userspace.selinuxproject.org/
-Requires.private: libsepol
-Libs: -L${libdir} -lselinux
+Requires.private: libsepol libpcre
+Libs: -L${libdir} -lselinux -lpthread
 Cflags: -I${includedir}
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
