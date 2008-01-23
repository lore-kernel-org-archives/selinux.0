Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0N0jpA5015508
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2008 19:45:51 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0N0joBR008210
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 00:45:50 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 23/27] NFS: Fix memory leak
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 23 Jan 2008 00:45:47 +0000
Message-ID: <20080123004547.15602.89596.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
References: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix a memory leak whereby multiple clientaddr=xxx mount options just overwrite
the duplicated client_address option pointer, without freeing the old memory.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/super.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0b0c72a..7f5e747 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -936,6 +936,7 @@ static int nfs_parse_mount_options(char *raw,
 			string = match_strdup(args);
 			if (string == NULL)
 				goto out_nomem;
+			kfree(mnt->client_address);
 			mnt->client_address = string;
 			break;
 		case Opt_mountaddr:


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
