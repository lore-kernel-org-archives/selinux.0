Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG7336017847
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:07:03 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG711t020812
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:07:01 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/16] NFS: Configuration and mount option changes to enable
	local caching on NFS [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:06:13 +0100
Message-ID: <20070810160613.24698.9814.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Changes to the kernel configuration defintions and to the NFS mount options to
allow the local caching support added by the previous patch to be enabled.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/Kconfig        |    8 ++++++++
 fs/nfs/client.c   |   14 ++++++++++----
 fs/nfs/internal.h |    2 ++
 fs/nfs/super.c    |   40 ++++++++++++++++++++++++++++++++++------
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7feb4cb..76d5d16 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1600,6 +1600,14 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_FSCACHE
+	bool "Provide NFS client caching support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
+	help
+	  Say Y here if you want NFS data to be cached locally on disc through
+	  the general filesystem cache manager
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files"
 	depends on NFS_FS
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f1783b2..0de4db4 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -543,7 +543,8 @@ error:
 /*
  * Create a version 2 or 3 client
  */
-static int nfs_init_server(struct nfs_server *server, const struct nfs_mount_data *data)
+static int nfs_init_server(struct nfs_server *server, const struct nfs_mount_data *data,
+			   unsigned int extra_options)
 {
 	struct nfs_client *clp;
 	int error, nfsvers = 2;
@@ -580,6 +581,7 @@ static int nfs_init_server(struct nfs_server *server, const struct nfs_mount_dat
 	server->acregmax = data->acregmax * HZ;
 	server->acdirmin = data->acdirmin * HZ;
 	server->acdirmax = data->acdirmax * HZ;
+	server->options = extra_options;
 
 	/* Start lockd here, before we might error out */
 	error = nfs_start_lockd(server);
@@ -776,6 +778,7 @@ void nfs_free_server(struct nfs_server *server)
  * - keyed on server and FSID
  */
 struct nfs_server *nfs_create_server(const struct nfs_mount_data *data,
+				     unsigned extra_options,
 				     struct nfs_fh *mntfh)
 {
 	struct nfs_server *server;
@@ -787,7 +790,7 @@ struct nfs_server *nfs_create_server(const struct nfs_mount_data *data,
 		return ERR_PTR(-ENOMEM);
 
 	/* Get a client representation */
-	error = nfs_init_server(server, data);
+	error = nfs_init_server(server, data, extra_options);
 	if (error < 0)
 		goto error;
 
@@ -911,7 +914,8 @@ error:
  * Create a version 4 volume record
  */
 static int nfs4_init_server(struct nfs_server *server,
-		const struct nfs4_mount_data *data, rpc_authflavor_t authflavour)
+		const struct nfs4_mount_data *data, rpc_authflavor_t authflavour,
+		unsigned int extra_options)
 {
 	int error;
 
@@ -930,6 +934,7 @@ static int nfs4_init_server(struct nfs_server *server,
 	server->acregmax = data->acregmax * HZ;
 	server->acdirmin = data->acdirmin * HZ;
 	server->acdirmax = data->acdirmax * HZ;
+	server->options = extra_options;
 
 	error = nfs_init_server_rpcclient(server, authflavour);
 
@@ -948,6 +953,7 @@ struct nfs_server *nfs4_create_server(const struct nfs4_mount_data *data,
 				      const char *mntpath,
 				      const char *ip_addr,
 				      rpc_authflavor_t authflavour,
+				      unsigned int extra_options,
 				      struct nfs_fh *mntfh)
 {
 	struct nfs_fattr fattr;
@@ -967,7 +973,7 @@ struct nfs_server *nfs4_create_server(const struct nfs4_mount_data *data,
 		goto error;
 
 	/* set up the general RPC client */
-	error = nfs4_init_server(server, data, authflavour);
+	error = nfs4_init_server(server, data, authflavour, extra_options);
 	if (error < 0)
 		goto error;
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 76cf55d..34ef000 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -33,6 +33,7 @@ extern struct rpc_program nfs_program;
 extern void nfs_put_client(struct nfs_client *);
 extern struct nfs_client *nfs_find_client(const struct sockaddr_in *, int);
 extern struct nfs_server *nfs_create_server(const struct nfs_mount_data *,
+					    unsigned int,
 					    struct nfs_fh *);
 extern struct nfs_server *nfs4_create_server(const struct nfs4_mount_data *,
 					     const char *,
@@ -40,6 +41,7 @@ extern struct nfs_server *nfs4_create_server(const struct nfs4_mount_data *,
 					     const char *,
 					     const char *,
 					     rpc_authflavor_t,
+					     unsigned int,
 					     struct nfs_fh *);
 extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *,
 						      struct nfs_fh *);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index b2a851c..17473f6 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -67,6 +67,7 @@ struct nfs_parsed_mount_data {
 				acdirmin, acdirmax;
 	int			namlen;
 	unsigned int		bsize;
+	unsigned int		options;
 	unsigned int		auth_flavor_len;
 	rpc_authflavor_t	auth_flavors[1];
 	char			*client_address;
@@ -101,6 +102,7 @@ enum {
 	Opt_acl, Opt_noacl,
 	Opt_rdirplus, Opt_nordirplus,
 	Opt_sharecache, Opt_nosharecache,
+	Opt_fscache, Opt_nofscache,
 
 	/* Mount options that take integer arguments */
 	Opt_port,
@@ -149,6 +151,8 @@ static match_table_t nfs_mount_option_tokens = {
 	{ Opt_nordirplus, "nordirplus" },
 	{ Opt_sharecache, "sharecache" },
 	{ Opt_nosharecache, "nosharecache" },
+	{ Opt_fscache, "fsc" },
+	{ Opt_nofscache, "nofsc" },
 
 	{ Opt_port, "port=%u" },
 	{ Opt_rsize, "rsize=%u" },
@@ -495,6 +499,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * clp->retrans_timeo / HZ);
 	seq_printf(m, ",retrans=%u", clp->retrans_count);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+	if (nfss->options & NFS_OPTION_FSCACHE)
+		seq_printf(m, ",fsc");
 }
 
 /*
@@ -725,6 +731,15 @@ static int nfs_parse_mount_options(char *raw,
 			break;
 		case Opt_nosharecache:
 			mnt->flags |= NFS_MOUNT_UNSHARED;
+			mnt->options &= ~NFS_OPTION_FSCACHE;
+			break;
+		case Opt_fscache:
+			/* sharing is mandatory with fscache */
+			mnt->options |= NFS_OPTION_FSCACHE;
+			mnt->flags &= ~NFS_MOUNT_UNSHARED;
+			break;
+		case Opt_nofscache:
+			mnt->options &= ~NFS_OPTION_FSCACHE;
 			break;
 
 		case Opt_port:
@@ -1081,10 +1096,13 @@ out_err:
  */
 static int nfs_validate_mount_data(struct nfs_mount_data **options,
 				   struct nfs_fh *mntfh,
-				   const char *dev_name)
+				   const char *dev_name,
+				   unsigned int *_extra_options)
 {
 	struct nfs_mount_data *data = *options;
 
+	*_extra_options = 0;
+
 	if (data == NULL)
 		goto out_no_data;
 
@@ -1131,6 +1149,7 @@ static int nfs_validate_mount_data(struct nfs_mount_data **options,
 			.acregmax	= 60,
 			.acdirmin	= 30,
 			.acdirmax	= 60,
+			.options	= 0,
 			.mount_server.protocol = IPPROTO_UDP,
 			.mount_server.program = NFS_MNT_PROGRAM,
 			.nfs_server.protocol = IPPROTO_TCP,
@@ -1139,6 +1158,7 @@ static int nfs_validate_mount_data(struct nfs_mount_data **options,
 
 		if (nfs_parse_mount_options((char *) *options, &args) == 0)
 			return -EINVAL;
+		*_extra_options = args.options;
 
 		data = kzalloc(sizeof(*data), GFP_KERNEL);
 		if (data == NULL)
@@ -1372,16 +1392,17 @@ static int nfs_get_sb(struct file_system_type *fs_type,
 	struct nfs_fh mntfh;
 	struct nfs_mount_data *data = raw_data;
 	struct dentry *mntroot;
+	unsigned int extra_options;
 	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
 	int error;
 
 	/* Validate the mount data */
-	error = nfs_validate_mount_data(&data, &mntfh, dev_name);
+	error = nfs_validate_mount_data(&data, &mntfh, dev_name, &extra_options);
 	if (error < 0)
 		goto out;
 
 	/* Get a volume representation */
-	server = nfs_create_server(data, &mntfh);
+	server = nfs_create_server(data, extra_options, &mntfh);
 	if (IS_ERR(server)) {
 		error = PTR_ERR(server);
 		goto out;
@@ -1556,11 +1577,14 @@ static int nfs4_validate_mount_data(struct nfs4_mount_data **options,
 				    rpc_authflavor_t *authflavour,
 				    char **hostname,
 				    char **mntpath,
-				    char **ip_addr)
+				    char **ip_addr,
+				    unsigned int *_extra_options)
 {
 	struct nfs4_mount_data *data = *options;
 	char *c;
 
+	*_extra_options = 0;
+
 	if (data == NULL)
 		goto out_no_data;
 
@@ -1616,11 +1640,13 @@ static int nfs4_validate_mount_data(struct nfs4_mount_data **options,
 			.acregmax	= 60,
 			.acdirmin	= 30,
 			.acdirmax	= 60,
+			.options	= 0,
 			.nfs_server.protocol = IPPROTO_TCP,
 		};
 
 		if (nfs_parse_mount_options((char *) *options, &args) == 0)
 			return -EINVAL;
+		*_extra_options = args.options;
 
 		if (!nfs_verify_server_address((struct sockaddr *)
 						&args.nfs_server.address))
@@ -1727,19 +1753,21 @@ static int nfs4_get_sb(struct file_system_type *fs_type,
 	rpc_authflavor_t authflavour;
 	struct nfs_fh mntfh;
 	struct dentry *mntroot;
+	unsigned extra_options;
 	char *mntpath = NULL, *hostname = NULL, *ip_addr = NULL;
 	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
 	int error;
 
 	/* Validate the mount data */
 	error = nfs4_validate_mount_data(&data, dev_name, &addr, &authflavour,
-					 &hostname, &mntpath, &ip_addr);
+					 &hostname, &mntpath, &ip_addr,
+					 &extra_options);
 	if (error < 0)
 		goto out;
 
 	/* Get a volume representation */
 	server = nfs4_create_server(data, hostname, &addr, mntpath, ip_addr,
-				    authflavour, &mntfh);
+				    authflavour, extra_options, &mntfh);
 	if (IS_ERR(server)) {
 		error = PTR_ERR(server);
 		goto out;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
