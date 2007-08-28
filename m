Subject: RE: Looks like we have a 64 bit problem on Rawhide.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        Joshua Brindle <method@manicmethod.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010085CB@exchange.columbia.tresys.com>
References: <46D44D99.9020405@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B01588010085CB@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 28 Aug 2007 13:15:49 -0400
Message-Id: <1188321349.26572.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-28 at 12:55 -0400, Todd Miller wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > libsepol.module_package_read_offsets: offsets are not increasing (at
> > 2, offset 61226322186831055 -> 0
> > 
> > rpm -q libsepol
> > libsepol-2.0.7-1.fc8
> > 
> > Can't update policy on x86_64 machines.
> 
> It looks like "off" in module_package_read_offsets() should
> be unsigned, not size_t.  Right now there is a 32 vs. 64 bit
> mismatch. 

Yep, try this:

Index: libsepol/src/module.c
===================================================================
--- libsepol/src/module.c	(revision 2538)
+++ libsepol/src/module.c	(working copy)
@@ -353,21 +353,27 @@
 				       struct policy_file *file,
 				       size_t ** offsets, uint32_t * sections)
 {
-	uint32_t buf[3], nsec;
+	uint32_t *buf = NULL, nsec;
 	unsigned i;
-	size_t *off;
+	size_t *off = NULL;
 	int rc;
 
+	buf = malloc(sizeof(uint32_t)*3);
+	if (!buf) {
+		ERR(file->handle, "out of memory");
+		goto err;
+	}
+	  
 	rc = next_entry(buf, file, sizeof(uint32_t) * 3);
 	if (rc < 0) {
 		ERR(file->handle, "module package header truncated");
-		return -1;
+		goto err;
 	}
 	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
 		ERR(file->handle,
 		    "wrong magic number for module package:  expected %u, got %u",
 		    SEPOL_MODULE_PACKAGE_MAGIC, le32_to_cpu(buf[0]));
-		return -1;
+		goto err;
 	}
 
 	mod->version = le32_to_cpu(buf[1]);
@@ -376,23 +382,29 @@
 	if (nsec > MAXSECTIONS) {
 		ERR(file->handle, "too many sections (%u) in module package",
 		    nsec);
-		return -1;
+		goto err;
 	}
 
 	off = (size_t *) malloc((nsec + 1) * sizeof(size_t));
 	if (!off) {
 		ERR(file->handle, "out of memory");
-		return -1;
+		goto err;
 	}
 
-	rc = next_entry(off, file, sizeof(uint32_t) * nsec);
+	free(buf);
+	buf = malloc(sizeof(uint32_t) * nsec);
+	if (!buf) {
+		ERR(file->handle, "out of memory");
+		goto err;
+	}
+	rc = next_entry(buf, file, sizeof(uint32_t) * nsec);
 	if (rc < 0) {
 		ERR(file->handle, "module package offset array truncated");
-		return -1;
+		goto err;
 	}
 
 	for (i = 0; i < nsec; i++) {
-		off[i] = le32_to_cpu(off[i]);
+		off[i] = le32_to_cpu(buf[i]);
 		if (i && off[i] < off[i - 1]) {
 			ERR(file->handle, "offsets are not increasing (at %u, "
 			    "offset %zu -> %zu", i, off[i - 1],
@@ -401,10 +413,15 @@
 		}
 	}
 
-	
+	free(buf); 	
 	off[nsec] = policy_file_length(file);
 	*offsets = off;
 	return 0;
+
+err:
+	free(buf);
+	free(off);
+	return -1;
 }
 
 /* Flags for which sections have been seen during parsing of module package. */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
