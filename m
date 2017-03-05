Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOT026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:25 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 431735613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:22 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/6] restorecond: add noreturn attribute to exitApp()
Date: Sun,  5 Mar 2017 18:13:00 +0100
Message-Id: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This makes it possible for static analyzers such as clang's one to
understand that strings_list_add() cannot dereference a NULL pointer in
the following code:

    if (!newptr)
        exitApp("Out of Memory");
    newptr->string = strdup(string);

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/restorecond.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/restorecond.h b/restorecond/restorecond.h
index a6be584c84a5..db7e50f72d2d 100644
--- a/restorecond/restorecond.h
+++ b/restorecond/restorecond.h
@@ -33,7 +33,7 @@ extern int run_as_user;
 extern int start(void);
 extern int server(int, const char *watch_file);
 
-extern void exitApp(const char *msg);
+extern void exitApp(const char *msg) __attribute__((__noreturn__));
 extern void read_config(int fd,	const char *watch_file);
 
 extern int watch(int fd, const char *watch_file);
-- 
2.11.1
