Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6PNqxI5015528
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2012 19:52:59 -0400
From: "Nogin, Aleksey" <anogin@hrl.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 25 Jul 2012 16:52:55 -0700
Subject: [PATCH: system/core 4.0.4] Fix an init segfault.
Message-ID: <409A0E510096B044A0EE3778BB3F1F5CCD624D596F@EXMAIL.hrl.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixes an init segfault introduced in change
I81070ea36fd7ffcab4ee8b3ef1bb0028d4b7839c ("chown -R"). The call to fts_open 
assumes that argv is NULL-terminated, but init parser does not NULL-terminate
argv arrays, so we can not just point fts_open to an argv suffix.
---
 init/builtins.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init/builtins.c b/init/builtins.c
index ab839af..693ff14 100644
--- a/init/builtins.c
+++ b/init/builtins.c
@@ -672,7 +672,7 @@ int do_chown(int nargs, char **args) {
         char *options = args[1];
         uid_t uid = decode_uid(args[2]);
         uid_t gid = decode_uid(args[3]);
-        char **path_argv = &args[4];
+        char * path_argv[] = {args[4], NULL};
         if (strcmp(options, "-R")) {
             ERROR("do_chown: Invalid argument: %s\n", args[1]);
             return -EINVAL;
--
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
