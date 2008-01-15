From: David Howells <dhowells@redhat.com>
Subject: [PATCH 22/26] NFS: Fix memory leak
To: sds@tycho.nsa.gov, casey@schaufler-ca.com, Trond.Myklebust@netapp.com,
        npiggin@suse.de
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Tue, 15 Jan 2008 23:48:50 +0000
Message-ID: <20080115234849.22183.67884.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
References: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
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
