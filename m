Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMMOHjw010064
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 17:24:25 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C51B9564822
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 23:24:23 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] libsepol: fix unknown magic section number error message
Date: Tue, 22 Nov 2016 23:23:42 +0100
Message-Id: <20161122222342.16771-5-nicolas.iooss@m4x.org>
In-Reply-To: <20161122222342.16771-1-nicolas.iooss@m4x.org>
References: <20161122222342.16771-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running hll/pp on some invalid policy module, it can output:

    libsepol.sepol_module_package_read: unknown magic number at section
    1, offset: 251, number: 0x

The last number looks funny and was caused by using "%ux". "u" is not a
prefix like "l", "h", "z"... and "%x" already expects an unsigned
integer (cf. http://man7.org/linux/man-pages/man3/printf.3.html).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 1c2becea5ef6..219355f30d27 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -627,7 +627,7 @@ int sepol_module_package_read(sepol_module_package_t * mod,
 		default:
 			/* unknown section, ignore */
 			ERR(file->handle,
-			    "unknown magic number at section %u, offset: %zx, number: %ux ",
+			    "unknown magic number at section %u, offset: %zx, number: %x ",
 			    i, offsets[i], le32_to_cpu(buf[0]));
 			break;
 		}
-- 
2.10.2
