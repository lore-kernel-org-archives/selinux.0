Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEXvRn017448
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:33:57 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEXrTs004939
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:33:53 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 38/45] NFS: Add some new I/O counters for FS-Cache doing
	things for NFS [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:33:26 +0000
Message-ID: <20080328143325.3483.43820.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add some new NFS I/O counters for FS-Cache doing things for NFS.  A new line is
emitted into /proc/pid/mountstats if caching is enabled that looks like:

	fsc: <rok> <rfl> <wok> <wfl> <unc>

Where <rok> is the number of pages read successfully from the cache, <rfl> is
the number of failed page reads against the cache, <wok> is the number of
successful page writes to the cache, <wfl> is the number of failed page writes
to the cache, and <unc> is the number of NFS pages that have been disconnected
from the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/iostat.h |   30 ++++++++++++++++++++++++++++++
 fs/nfs/super.c  |   11 +++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/iostat.h b/fs/nfs/iostat.h
index 6350ecb..20dbc4f 100644
--- a/fs/nfs/iostat.h
+++ b/fs/nfs/iostat.h
@@ -107,6 +107,18 @@ enum nfs_stat_eventcounters {
 	__NFSIOS_COUNTSMAX,
 };
 
+/*
+ * NFS local caching servicing counters
+ */
+enum nfs_stat_fscachecounters {
+	NFSIOS_FSCACHE_PAGES_READ_OK,
+	NFSIOS_FSCACHE_PAGES_READ_FAIL,
+	NFSIOS_FSCACHE_PAGES_WRITTEN_OK,
+	NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL,
+	NFSIOS_FSCACHE_PAGES_UNCACHED,
+	__NFSIOS_FSCACHEMAX,
+};
+
 #ifdef __KERNEL__
 
 #include <linux/percpu.h>
@@ -114,6 +126,9 @@ enum nfs_stat_eventcounters {
 
 struct nfs_iostats {
 	unsigned long long	bytes[__NFSIOS_BYTESMAX];
+#ifdef CONFIG_NFS_FSCACHE
+	unsigned long long	fscache[__NFSIOS_FSCACHEMAX];
+#endif
 	unsigned long		events[__NFSIOS_COUNTSMAX];
 } ____cacheline_aligned;
 
@@ -149,6 +164,21 @@ static inline void nfs_add_stats(struct inode *inode, enum nfs_stat_bytecounters
 	nfs_add_server_stats(NFS_SERVER(inode), stat, addend);
 }
 
+#ifdef CONFIG_NFS_FSCACHE
+static inline void nfs_add_fscache_stats(struct inode *inode,
+					 enum nfs_stat_fscachecounters stat,
+					 unsigned long addend)
+{
+	struct nfs_iostats *iostats;
+	int cpu;
+
+	cpu = get_cpu();
+	iostats = per_cpu_ptr(NFS_SERVER(inode)->io_stats, cpu);
+	iostats->fscache[stat] += addend;
+	put_cpu_no_resched();
+}
+#endif
+
 static inline struct nfs_iostats *nfs_alloc_iostats(void)
 {
 	return alloc_percpu(struct nfs_iostats);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 70604b9..7cd9e41 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -564,6 +564,10 @@ static int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
 			totals.events[i] += stats->events[i];
 		for (i = 0; i < __NFSIOS_BYTESMAX; i++)
 			totals.bytes[i] += stats->bytes[i];
+#ifdef CONFIG_NFS_FSCACHE
+		for (i = 0; i < __NFSIOS_FSCACHEMAX; i++)
+			totals.fscache[i] += stats->fscache[i];
+#endif
 
 		preempt_enable();
 	}
@@ -574,6 +578,13 @@ static int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
 	seq_printf(m, "\n\tbytes:\t");
 	for (i = 0; i < __NFSIOS_BYTESMAX; i++)
 		seq_printf(m, "%Lu ", totals.bytes[i]);
+#ifdef CONFIG_NFS_FSCACHE
+	if (nfss->options & NFS_OPTION_FSCACHE) {
+		seq_printf(m, "\n\tfsc:\t");
+		for (i = 0; i < __NFSIOS_FSCACHEMAX; i++)
+			seq_printf(m, "%Lu ", totals.bytes[i]);
+	}
+#endif
 	seq_printf(m, "\n");
 
 	rpc_print_iostats(m, nfss->client);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
