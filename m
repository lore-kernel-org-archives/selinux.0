Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DL2KeM008158
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 17:02:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 40N9FM2dsbz4BPFZ
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:01:59 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 40N9FM1Fd5z4BPFY
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 72DFA564947
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 23:01:14 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 22:34:21 +0200
Message-Id: <20180413203424.20542-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180413203424.20542-1-nicolas.iooss@m4x.org>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/5] libsepol: ensure the level context is not empty
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When load_users() parses an invalid line with an empty level context
(ie. nothing between "level" and "range" keywords), it allocates memory
with malloc(0) and uses it. The behavior of malloc() in this case is
an unspecified behavior: it might return NULL, which would lead to a
segmentation fault.

Fix this issue by reporting the invalid entry instead. While at it,
ensure that the character before "range" is a space, and change the
logic slightly in order to avoid using "--p; ... p++;".

This issue is reported by clang's static analyzer with the following
message:

    genusers.c:222:11: warning: Use of zero-allocated memory
                                            *r++ = *s;
                                                 ^
    genusers.c:225:7: warning: Use of zero-allocated memory
                            *r = 0;
                               ^

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/genusers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 556821066e3e..9bea83fd8304 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -201,11 +201,11 @@ static int load_users(struct policydb *policydb, const char *path)
 			if (!(*p))
 				BADLINE();
 			q = p;
-			while (*p && strncasecmp(p, "range", 5))
+			while (*p && (!isspace(*p) || strncasecmp(p + 1, "range", 5)))
 				p++;
-			if (!(*p))
+			if (!(*p) || p == q)
 				BADLINE();
-			*--p = 0;
+			*p = 0;
 			p++;
 
 			scontext = malloc(p - q);
-- 
2.17.0
