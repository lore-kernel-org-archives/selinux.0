Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEZP4D017750
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:35:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEZLTs005599
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:35:21 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 45/45] NFS: Add mount options to enable local caching on NFS
	[ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:34:01 +0000
Message-ID: <20080328143401.3483.55053.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add NFS mount options to allow the local caching support to be enabled.

The attached patch makes it possible for the NFS filesystem to be told to make
use of the network filesystem local caching service (FS-Cache).

To be able to use this, a recent nfsutils package is required.

There are three variant NFS mount options that can be added to a mount command
to control caching for a mount.  Only the last one specified takes effect:

 (*) Adding "fsc" will request caching.

 (*) Adding "fsc=<string>" will request caching and also specify a uniquifier.

 (*) Adding "nofsc" will disable caching.

For example:

	mount warthog:/ /a -o fsc


The cache of a particular superblock (NFS FSID) will be shared between all
mounts of that volume, provided they have the same connection parameters and
are not marked 'nosharecache'.

Where it is otherwise impossible to distinguish superblocks because all the
parameters are identical, but the 'nosharecache' option is supplied, a
uniquifying string must be supplied, else only the first mount will be
permitted to use the cache.

If there's a key collision, then the second mount will disable caching and give
a warning into the kernel log.


Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/client.c   |    2 ++
 fs/nfs/internal.h |    1 +
 fs/nfs/super.c    |   25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d67d52f..8357f68 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -669,6 +669,7 @@ static int nfs_init_server(struct nfs_server *server,
 
 	/* Initialise the client representation from the mount data */
 	server->flags = data->flags & NFS_MOUNT_FLAGMASK;
+	server->options = data->options;
 
 	if (data->rsize)
 		server->rsize = nfs_block_size(data->rsize, NULL);
@@ -1056,6 +1057,7 @@ static int nfs4_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = data->flags & NFS_MOUNT_FLAGMASK;
 	server->caps |= NFS_CAP_ATOMIC_OPEN;
+	server->options = data->options;
 
 	if (data->rsize)
 		server->rsize = nfs_block_size(data->rsize, NULL);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ab23769..dac9eea 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -39,6 +39,7 @@ struct nfs_parsed_mount_data {
 	int			acregmin, acregmax,
 				acdirmin, acdirmax;
 	int			namlen;
+	unsigned int		options;
 	unsigned int		bsize;
 	unsigned int		auth_flavor_len;
 	rpc_authflavor_t	auth_flavors[1];
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7cd9e41..6215f54 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -76,6 +76,7 @@ enum {
 	Opt_acl, Opt_noacl,
 	Opt_rdirplus, Opt_nordirplus,
 	Opt_sharecache, Opt_nosharecache,
+	Opt_fscache, Opt_nofscache,
 
 	/* Mount options that take integer arguments */
 	Opt_port,
@@ -92,6 +93,7 @@ enum {
 	/* Mount options that take string arguments */
 	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
 	Opt_addr, Opt_mountaddr, Opt_clientaddr,
+	Opt_fscache_uniq,
 
 	/* Mount options that are ignored */
 	Opt_userspace, Opt_deprecated,
@@ -125,6 +127,9 @@ static match_table_t nfs_mount_option_tokens = {
 	{ Opt_nordirplus, "nordirplus" },
 	{ Opt_sharecache, "sharecache" },
 	{ Opt_nosharecache, "nosharecache" },
+	{ Opt_fscache, "fsc" },
+	{ Opt_fscache_uniq, "fsc=%s" },
+	{ Opt_nofscache, "nofsc" },
 
 	{ Opt_port, "port=%u" },
 	{ Opt_rsize, "rsize=%u" },
@@ -486,6 +491,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * nfss->client->cl_timeout->to_initval / HZ);
 	seq_printf(m, ",retrans=%u", nfss->client->cl_timeout->to_retries);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+	if (nfss->options & NFS_OPTION_FSCACHE)
+		seq_printf(m, ",fsc");
 }
 
 /*
@@ -806,6 +813,24 @@ static int nfs_parse_mount_options(char *raw,
 		case Opt_nosharecache:
 			mnt->flags |= NFS_MOUNT_UNSHARED;
 			break;
+		case Opt_fscache:
+			mnt->options |= NFS_OPTION_FSCACHE;
+			kfree(mnt->fscache_uniq);
+			mnt->fscache_uniq = NULL;
+			break;
+		case Opt_nofscache:
+			mnt->options &= ~NFS_OPTION_FSCACHE;
+			kfree(mnt->fscache_uniq);
+			mnt->fscache_uniq = NULL;
+			break;
+		case Opt_fscache_uniq:
+			string = match_strdup(args);
+			if (!string)
+				goto out_nomem;
+			kfree(mnt->fscache_uniq);
+			mnt->fscache_uniq = string;
+			mnt->options |= NFS_OPTION_FSCACHE;
+			break;
 
 		case Opt_port:
 			if (match_int(args, &option))


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
