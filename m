Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8RFpLrP016437
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 11:51:24 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6D29ADAF9
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 15:51:22 +0000 (UTC)
From: Miroslav Grepl <mgrepl@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Do not always print a module name warning
Date: Tue, 27 Sep 2016 17:51:13 +0200
Message-Id: <20160927155113.19322-2-mgrepl@redhat.com>
In-Reply-To: <20160927155113.19322-1-mgrepl@redhat.com>
References: <20160927155113.19322-1-mgrepl@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Miroslav Grep <mgrepl@redhat.com>

7a728e46 commit supposed to add a warning when a module name is
different than a filename, but this warning is printed always. This
commit fixes it.

Fixes:
$ semodule -X 400 -i testmod.pp
Warning: SELinux userspace will refer to the module from testmod.pp as
testmod rather than testmod

Signed-off-by: Miroslav Grepl <mgrepl@redhat.com>
---
 libsemanage/src/direct_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 4320f43..3719cb1 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1619,7 +1619,9 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		if ((retval = parse_module_headers(sh, data, data_len, &module_name, &version)) != 0)
 			goto cleanup;
 
-		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
+		if (strcmp(module_name, filename) != 0)
+			fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
+
 		free(version);
 	}
 	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
-- 
1.8.3.1
