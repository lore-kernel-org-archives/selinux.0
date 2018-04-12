Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3CAQErs003319
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 06:26:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 40MHB93tjmzJnW9
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 10:26:09 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 40MHB937kRzJmrD
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 10:26:09 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 252B8EBFE5
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 10:26:06 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8E7DDEEC6
 for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2018 10:26:05 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 12 Apr 2018 12:26:01 +0200
Message-Id: <20180412102601.32191-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] libsemanage: do not change file mode of seusers and
 users_extra
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 8702a865e08b5660561e194a83e4a363061edc03 causes file mode of
seusers and users_extra to change based on the value defined in config
file whenever direct_commit is called and policy is not rebuilt.
(e.g. when setting a boolean).

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1512639

$ ll /var/lib/selinux/targeted/active/users_extra
-rw-------. 1 root root 101 11. dub 17.31 /var/lib/selinux/targeted/active/users_extra
$ ll /var/lib/selinux/targeted/active/seusers
-rw-------. 1 root root 73 11. dub 17.31 /var/lib/selinux/targeted/active/seusers
$ semanage boolean -m --on httpd_can_network_connect
$ ll /var/lib/selinux/targeted/active/seusers
-rw-r--r--. 1 root root 73 23. bře 16.59 /var/lib/selinux/targeted/active/seusers
$ ll /var/lib/selinux/targeted/active/users_extra
-rw-r--r--. 1 root root 101 23. bře 16.59 /var/lib/selinux/targeted/active/users_extra
$ rpm -Vq selinux-policy-targeted
.M.....T.    /var/lib/selinux/targeted/active/seusers
.M.....T.    /var/lib/selinux/targeted/active/users_extra

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e7ec952f..c58961be 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1481,7 +1481,7 @@ rebuild:
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_STORE_SEUSERS),
-						    sh->conf->file_mode);
+						    0);
 			if (retval < 0)
 				goto cleanup;
 			pseusers->dtable->drop_cache(pseusers->dbase);
@@ -1499,7 +1499,7 @@ rebuild:
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_USERS_EXTRA),
-						    sh->conf->file_mode);
+						    0);
 			if (retval < 0)
 				goto cleanup;
 			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
-- 
2.14.3
