Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIhiaK004239
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:43:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 40tX7Z3THlz1pJ8g
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:22 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 40tX7Y65GQz1pJ8w
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4576956069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:52 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:13 +0200
Message-Id: <20180526184213.4896-8-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 7/7] libsepol: destroy the copied va_list
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

va_copy()'s manpage [1] states:

    Each invocation of va_copy() must be matched by a corresponding
    invocation of va_end() in the same function.

create_str_helper() is using va_copy() without va_end(). Add the missing
call.

[1] https://linux.die.net/man/3/va_copy

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 342bc3c91df9..7c5699c52c95 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -80,10 +80,13 @@ static char *create_str_helper(const char *fmt, int num, va_list vargs)
 		goto exit;
 	}
 
+	va_end(vargs2);
+
 	return str;
 
 exit:
 	free(str);
+	va_end(vargs2);
 	return NULL;
 }
 
-- 
2.17.0
