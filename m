From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 01/14] patch fix_use_before_init_in_nfsd4_list_rec_dir
Date: Wed, 26 Nov 2008 16:03:01 -0500
Message-Id: <1227733394-1114-2-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/nfsd/nfs4recover.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index bb93946..7084252 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -228,8 +228,10 @@ nfsd4_list_rec_dir(struct dentry *dir, recdir_func *f)
 
 	filp = dentry_open(dget(dir), mntget(rec_dir.mnt), O_RDONLY);
 	status = PTR_ERR(filp);
-	if (IS_ERR(filp))
-		goto out;
+	if (IS_ERR(filp)) {
+		nfs4_reset_user(uid, gid);
+		return PTR_ERR(filp);
+	}
 	INIT_LIST_HEAD(dentries);
 	status = vfs_readdir(filp, nfsd4_build_dentrylist, &dla);
 	fput(filp);
-- 
1.5.5.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
