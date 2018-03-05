Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w25N0941005656
 for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2018 18:00:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zwFjn4R0Xz19Yv0
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:13 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zwFjn3qwQz19Ytg
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 380CD56128D
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:58:30 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon,  5 Mar 2018 23:58:18 +0100
Message-Id: <20180305225820.23610-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/3] libsepol: initialize tmp_key->ibdev_name if its
 allocation failed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In sepol_ibendport_key_create(), if sepol_ibendport_alloc_ibdev_name()
fails to allocate tmp_key->ibdev_name, sepol_ibendport_key_free() is
called to free the memory associated with tmp_key, which results in
free() being called on uninitialized tmp_key->ibdev_name.

This issue is reported by clang's static analyzer with the following
message:

    ibendport_record.c:115:2: warning: 1st function call argument is an
    uninitialized value
            free(key->ibdev_name);
            ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/ibendport_record.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
index 912aeb536fd9..8285a9d6ffcf 100644
--- a/libsepol/src/ibendport_record.c
+++ b/libsepol/src/ibendport_record.c
@@ -62,8 +62,10 @@ int sepol_ibendport_key_create(sepol_handle_t *handle,
 		goto omem;
 	}
 
-	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
+	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0) {
+		tmp_key->ibdev_name = NULL;
 		goto err;
+	}
 
 	strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
 	tmp_key->port = port;
-- 
2.16.0
