Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SF5F3K023908
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 11:05:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SF4qU4018693
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 15:05:14 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 27/45] AFS: prevent double cell registration [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:32:29 +0000
Message-ID: <20080328143229.3483.92808.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Sven Schnelle <svens@stackframe.org>

kafs doesn't check if the cell already exists - so if you do an
echo "add newcell.org 1.2.3.4" >/proc/fs/afs/cells it will try to
create this cell again. kobject will also complain about a double
registration. To prevent such problems, return -EEXIST in that case.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 970d38f..788865d 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -127,14 +127,20 @@ struct afs_cell *afs_cell_create(const char *name, char *vllist)
 
 	_enter("%s,%s", name, vllist);
 
+	down_write(&afs_cells_sem);
+	read_lock(&afs_cells_lock);
+	list_for_each_entry(cell, &afs_cells, link) {
+		if (strcasecmp(cell->name, name) == 0)
+			goto duplicate_name;
+	}
+	read_unlock(&afs_cells_lock);
+
 	cell = afs_cell_alloc(name, vllist);
 	if (IS_ERR(cell)) {
 		_leave(" = %ld", PTR_ERR(cell));
 		return cell;
 	}
 
-	down_write(&afs_cells_sem);
-
 	/* add a proc directory for this cell */
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
@@ -167,6 +173,11 @@ error:
 	kfree(cell);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
+
+duplicate_name:
+	read_unlock(&afs_cells_lock);
+	up_write(&afs_cells_sem);
+	return ERR_PTR(-EEXIST);
 }
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
