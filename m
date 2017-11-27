Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vARA1fUU021045
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 05:01:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D05A4E33E
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 10:01:26 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 27 Nov 2017 11:01:02 +0100
Message-Id: <20171127100102.4409-1-jzarsky@redhat.com>
In-Reply-To: <CAFftDdosb4sqRyexNmT11mjgATWLNW4jrabJ-u0zKuuCOWx4-g@mail.gmail.com>
References: <CAFftDdosb4sqRyexNmT11mjgATWLNW4jrabJ-u0zKuuCOWx4-g@mail.gmail.com>
Subject: [PATCH] libsemanage: properly check return value of iterate function
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Function dbase_llist_iterate() iterates over records and checks return
value of iterate function. According to a manpage semanage_iterate(3),
handler can return value 1 for early exit. dbase_llist_iterate()
currently checks for return value > 1, which does not include
expected value 1.

Affected functions:
semanage_bool_iterate_local
semanage_fcontext_iterate
semanage_fcontext_iterate_local
semanage_ibendport_iterate_local
semanage_ibpkey_iterate_local
semanage_iface_iterate_local
semanage_node_iterate_local
semanage_port_iterate_local
semanage_seuser_iterate
semanage_seuser_iterate_local
semanage_user_iterate
semanage_user_iterate_local

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/src/database_llist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 8ce2e2c1..c8f4ff0b 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -263,7 +263,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
 		if (rc < 0)
 			goto err;
 
-		else if (rc > 1)
+		else if (rc > 0)
 			break;
 	}
 
-- 
2.14.3
