Subject: Re: [PATCH] libsepol - cond_expr mapping and package num_sections
	bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1138396578.3728.6.camel@moss-spartans.epoch.ncsc.mil>
References: <43DA88D1.5000408@tresys.com>
	 <1138396578.3728.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 13:51:07 -0500
Message-Id: <1138647067.7076.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-27 at 16:16 -0500, Stephen Smalley wrote:
> This seems prone to similar bugs later.  Suppose I call
> sepol_module_package_set_file_contexts multiple times; each time it
> frees the old one and replaces it, so I shouldn't be incrementing the
> number of sections here.
> 
> Possibly num_sections shouldn't be part of the state of the struct at
> all; it should just be a local variable.  In the read case, we pull it
> from the image/file and use it locally (just need to pass it back from
> read_offsets to the caller).  For write, we always start with a count of
> 1 and increment it if we have a p->file_contexts.

How about the patch below instead?

Index: libsepol/include/sepol/policydb/module.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb/module.h,v
retrieving revision 1.4
diff -u -p -r1.4 module.h
--- libsepol/include/sepol/policydb/module.h	25 Oct 2005 12:09:09 -0000	1.4
+++ libsepol/include/sepol/policydb/module.h	30 Jan 2006 18:22:46 -0000
@@ -33,7 +33,6 @@
 struct sepol_module_package {
 	sepol_policydb_t *policy;
 	uint32_t	 version;
-	uint32_t	 num_sections;
 	char 		 *file_contexts;
 	size_t	         file_contexts_len;
 };
Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.13
diff -u -p -r1.13 link.c
--- libsepol/src/link.c	18 Oct 2005 13:28:24 -0000	1.13
+++ libsepol/src/link.c	30 Jan 2006 18:22:22 -0000
@@ -1010,6 +1010,9 @@ static int copy_cond_list(cond_node_t *l
                         goto cleanup;
                 /* go back through and remap the expression */
                 for (cur_expr = new_node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
+			/* expression nodes don't have a bool value of 0 - don't map them */
+			if (cur_expr->expr_type != COND_BOOL)
+				continue;
                         assert(module->map[SYM_BOOLS][cur_expr->bool - 1] != 0);
                         cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
                 }
Index: libsepol/src/module.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/module.c,v
retrieving revision 1.14
diff -u -p -r1.14 module.c
--- libsepol/src/module.c	15 Nov 2005 12:58:29 -0000	1.14
+++ libsepol/src/module.c	30 Jan 2006 18:27:21 -0000
@@ -78,7 +78,6 @@ static int module_package_init(sepol_mod
 	if (sepol_policydb_create(&p->policy))
 		return -1;
 
-	p->num_sections = 0;
 	p->version = 1;
 	return 0;
 }
@@ -235,10 +234,12 @@ static int read_helper(char *buf, struct
 
 /* Get the section offsets from a package file, offsets will be malloc'd to
  * the appropriate size and the caller must free() them */
-static int module_package_read_offsets(sepol_module_package_t *mod, 
-				struct policy_file *file, size_t **offsets)
+static int module_package_read_offsets(sepol_module_package_t *mod,
+				       struct policy_file *file,
+				       size_t **offsets,
+				       uint32_t *sections)
 {
-	uint32_t *buf;
+	uint32_t *buf, nsec;
 	unsigned i;
 
 	buf = next_entry(file, sizeof(uint32_t) * 3);
@@ -252,26 +253,26 @@ static int module_package_read_offsets(s
 	}
 	
 	mod->version = le32_to_cpu(buf[1]);
-	mod->num_sections = le32_to_cpu(buf[2]);
+	nsec = *sections = le32_to_cpu(buf[2]);
 
-	if (mod->num_sections > MAXSECTIONS) {
-		ERR(file->handle, "too many sections (%u) in module package", mod->num_sections);
+	if (nsec > MAXSECTIONS) {
+		ERR(file->handle, "too many sections (%u) in module package", nsec);
 		return -1;
 	}
 
-	*offsets = (size_t *)malloc((mod->num_sections + 1) * sizeof(size_t));
+	*offsets = (size_t *)malloc((nsec + 1) * sizeof(size_t));
 	if (!*offsets) {
 		ERR(file->handle, "out of memory");
 		return -1;
 	}
 
-	buf = next_entry(file, sizeof(uint32_t) * mod->num_sections);
+	buf = next_entry(file, sizeof(uint32_t) * nsec);
 	if (!buf) {
 		ERR(file->handle, "module package offset array truncated");
 		return -1;
 	}
 
-	for (i = 0; i < mod->num_sections; i++) {
+	for (i = 0; i < nsec; i++) {
 		(*offsets)[i] = le32_to_cpu(buf[i]);
 		if (i && (*offsets)[i] < (*offsets)[i - 1]) {
 			ERR(file->handle, "offsets are not increasing (at %u, offset %u->%u)", i, (*offsets)[i-1], (*offsets)[i]);
@@ -279,7 +280,7 @@ static int module_package_read_offsets(s
 		}
 	}
 
-	(*offsets)[mod->num_sections] = policy_file_length(file);
+	(*offsets)[nsec] = policy_file_length(file);
 	return 0;
 }
 
@@ -291,17 +292,17 @@ int sepol_module_package_read(sepol_modu
 			      struct sepol_policy_file *spf, int verbose)
 {
 	struct policy_file *file= &spf->pf;
-	uint32_t *buf;
+	uint32_t *buf, nsec;
 	size_t *offsets, len;
         int retval = -1;
 	unsigned i, seen = 0;
 
-	if (module_package_read_offsets(mod, file, &offsets))
+	if (module_package_read_offsets(mod, file, &offsets, &nsec))
 		return -1;
 
 	/* we know the section offsets, seek to them and read in the data */
 
-	for (i = 0; i < mod->num_sections; i++ ) {
+	for (i = 0; i < nsec; i++ ) {
 	
 		if (policy_file_seek(file, offsets[i])) {
 			ERR(file->handle, "error seeking to offset %u for module package section %u", offsets[i], i);
@@ -383,18 +384,18 @@ int sepol_module_package_info(struct sep
 {
 	struct policy_file *file = &spf->pf;
 	sepol_module_package_t *mod = NULL;
-	uint32_t *buf, len;
+	uint32_t *buf, len, nsec;
 	size_t *offsets = NULL;
 	unsigned i, seen = 0;
 
 	if (sepol_module_package_create(&mod))
 		return -1;
 
-	if (module_package_read_offsets(mod, file, &offsets)) {
+	if (module_package_read_offsets(mod, file, &offsets, &nsec)) {
 		goto cleanup;
 	}
 
-	for (i = 0; i < mod->num_sections; i++ ) {
+	for (i = 0; i < nsec; i++ ) {
 	
 		if (policy_file_seek(file, offsets[i])) {
 			ERR(file->handle, "error seeking to offset %u for module package section %u", offsets[i], i);
@@ -525,7 +526,7 @@ int sepol_module_package_write(sepol_mod
 {
 	struct policy_file *file = &spf->pf;
 	policy_file_t polfile;
-	uint32_t buf[3], offsets[2], len, len2, idx;
+	uint32_t buf[3], offsets[2], len, len2, idx, nsec = 0;
 
 	if (p->policy) {
 		/* compute policy length */
@@ -536,10 +537,9 @@ int sepol_module_package_write(sepol_mod
 		if (policydb_write(&p->policy->p, &polfile))
 			return -1;
 		len = polfile.len;
-		if (polfile.len)
-			p->num_sections++;
-		else 
+		if (!polfile.len)
 			return -1;
+		nsec++;
 		
 	} else {
 		/* We don't support writing a package without a module at this point */
@@ -547,23 +547,23 @@ int sepol_module_package_write(sepol_mod
 	}
 
 	if (p->file_contexts)
-		p->num_sections++;
+		nsec++;
 
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
 	buf[1] = cpu_to_le32(p->version);
-	buf[2] = cpu_to_le32(p->num_sections);
+	buf[2] = cpu_to_le32(nsec);
 	if (put_entry(buf, sizeof(uint32_t), 3, file) != 3)
 		return -1;
 
 	/* first section offset */
-	offsets[0] = (p->num_sections + 3) * sizeof(uint32_t);
+	offsets[0] = (nsec + 3) * sizeof(uint32_t);
 	buf[0] = cpu_to_le32(offsets[0]);
 	if (p->file_contexts) {
 		/* second section offset is offset[0] +  module length  */	
 		offsets[1] = offsets[0] + len;
 		buf[1] = cpu_to_le32(offsets[1]);
 	}
-	if (put_entry(buf, sizeof(uint32_t), p->num_sections, file) != p->num_sections)
+	if (put_entry(buf, sizeof(uint32_t), nsec, file) != nsec)
 		return -1;
 
 	if (policydb_write(&p->policy->p, file))

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
