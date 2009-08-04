Subject: [PATCH v2] libsemanage:  Enable configuration of bzip behavior
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1249392325.9193.76.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249388013.9193.52.camel@moss-pluto.epoch.ncsc.mil>
	 <1249389656.9193.73.camel@moss-pluto.epoch.ncsc.mil>
	 <1249392325.9193.76.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 04 Aug 2009 10:08:00 -0400
Message-Id: <1249394880.9193.80.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Allow the administrator to customize the bzip block size and "small"
flag via semanage.conf.  After applying you can add entries like these
to your /etc/selinux/semanage.conf to trade off memory vs disk space
(block size) and to trade off memory vs runtime (small):

bzip-blocksize=4
bzip-small=1

You can also disable bzip compression altogether for your module store
via:
bzip-blocksize=0

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 2001afb..5b2c859 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -58,6 +58,7 @@ static int parse_errors;
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
 %token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN
+%token BZIP_BLOCKSIZE BZIP_SMALL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -82,6 +83,8 @@ single_opt:     module_store
         |       save_linked
         |       disable_genhomedircon
         |       handle_unknown
+	|	bzip_blocksize
+	|	bzip_small
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -163,6 +166,16 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
 	free($3);
  }
 
+bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
+	current_conf->bzip_blocksize = atoi($3);
+	free($3);
+}
+	
+bzip_small:  BZIP_SMALL '=' ARG {
+	current_conf->bzip_small = atoi($3);
+	free($3);
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -230,6 +243,8 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->expand_check = 1;
 	conf->handle_unknown = -1;
 	conf->file_mode = 0644;
+	conf->bzip_blocksize = 9;
+	conf->bzip_small = 0;
 
 	conf->save_previous = 0;
 	conf->save_linked = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index faa0aeb..8af5137 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -47,6 +47,8 @@ save-previous     return SAVE_PREVIOUS;
 save-linked       return SAVE_LINKED;
 disable-genhomedircon return DISABLE_GENHOMEDIRCON;
 handle-unknown    return HANDLE_UNKNOWN;
+bzip-blocksize	return BZIP_BLOCKSIZE;
+bzip-small	return BZIP_SMALL;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[verify module]" return VERIFY_MOD_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index bd13387..92799ad 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -401,7 +401,9 @@ static int parse_base_headers(semanage_handle_t * sh,
 
 /* bzip() a data to a file, returning the total number of compressed bytes
  * in the file.  Returns -1 if file could not be compressed. */
-static ssize_t bzip(const char *filename, char *data, size_t num_bytes) {
+static ssize_t bzip(semanage_handle_t *sh, const char *filename, char *data,
+			size_t num_bytes) 
+{
 	BZFILE* b;
 	size_t  size = 1<<16;
 	int     bzerror;
@@ -413,7 +415,16 @@ static ssize_t bzip(const char *filename, char *data, size_t num_bytes) {
 		return -1;
 	}
 
-	b = BZ2_bzWriteOpen( &bzerror, f, 9, 0, 0);
+	if (!sh->conf->bzip_blocksize) {
+		if (fwrite(data, 1, num_bytes, f) < num_bytes) {
+			fclose(f);
+			return -1;
+		}
+		fclose(f);
+		return num_bytes;
+	}
+
+	b = BZ2_bzWriteOpen( &bzerror, f, sh->conf->bzip_blocksize, 0, 0);
 	if (bzerror != BZ_OK) {
 		BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
 		return -1;
@@ -443,15 +454,19 @@ static ssize_t bzip(const char *filename, char *data, size_t num_bytes) {
 
 /* bunzip() a file to '*data', returning the total number of uncompressed bytes
  * in the file.  Returns -1 if file could not be decompressed. */
-ssize_t bunzip(FILE *f, char **data) {
+ssize_t bunzip(semanage_handle_t *sh, FILE *f, char **data)
+{
 	BZFILE* b;
 	size_t  nBuf;
 	char    buf[1<<18];
 	size_t  size = sizeof(buf);
 	int     bzerror;
 	size_t  total=0;
+
+	if (!sh->conf->bzip_blocksize)
+		return -1;
 	
-	b = BZ2_bzReadOpen ( &bzerror, f, 0, 0, NULL, 0 );
+	b = BZ2_bzReadOpen ( &bzerror, f, 0, sh->conf->bzip_small, NULL, 0 );
 	if ( bzerror != BZ_OK ) {
 		BZ2_bzReadClose ( &bzerror, b );
 		return -1;
@@ -486,11 +501,12 @@ ssize_t bunzip(FILE *f, char **data) {
  * the file into '*data'.
  * Returns the total number of bytes in memory .
  * Returns -1 if file could not be opened or mapped. */
-static ssize_t map_file(int fd, char **data, int *compressed)
+static ssize_t map_file(semanage_handle_t *sh, int fd, char **data,
+			int *compressed)
 {
 	ssize_t size = -1;
 	char *uncompress;
-	if ((size = bunzip(fdopen(fd, "r"), &uncompress)) > 0) {
+	if ((size = bunzip(sh, fdopen(fd, "r"), &uncompress)) > 0) {
 		*data = mmap(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 		if (*data == MAP_FAILED) {
 			free(uncompress);
@@ -997,7 +1013,7 @@ static int semanage_direct_install(semanage_handle_t * sh,
 					   &filename)) != 0) {
 		goto cleanup;
 	}
-	if (bzip(filename, data, data_len) <= 0) {
+	if (bzip(sh, filename, data, data_len) <= 0) {
 		ERR(sh, "Error while writing to %s.", filename);
 		retval = -3;
 		goto cleanup;
@@ -1029,7 +1045,7 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
+	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 		
@@ -1127,7 +1143,7 @@ static int semanage_direct_upgrade(semanage_handle_t * sh,
 						 data, data_len, 
 						 &filename);
 	if (retval == 0) {
-		if (bzip(filename, data, data_len) <= 0) {
+		if (bzip(sh, filename, data, data_len) <= 0) {
 			ERR(sh, "Error while writing to %s.", filename);
 			retval = -3;
 		}
@@ -1155,7 +1171,7 @@ static int semanage_direct_upgrade_file(semanage_handle_t * sh,
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
+	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 
@@ -1197,7 +1213,7 @@ static int semanage_direct_install_base(semanage_handle_t * sh,
 	if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
 		goto cleanup;
 	}
-	if (bzip(filename, base_data, data_len) <= 0) {
+	if (bzip(sh, filename, base_data, data_len) <= 0) {
 		ERR(sh, "Error while writing to %s.", filename);
 		retval = -3;
 		goto cleanup;
@@ -1225,7 +1241,7 @@ static int semanage_direct_install_base_file(semanage_handle_t * sh,
 		return -1;
 	}
 
-	if ((data_len = map_file(in_fd, &data, &compressed)) <= 0) {
+	if ((data_len = map_file(sh, in_fd, &data, &compressed)) <= 0) {
 		goto cleanup;
 	}
 		
@@ -1347,7 +1363,7 @@ static int semanage_direct_list(semanage_handle_t * sh,
 		ssize_t size;
 		char *data = NULL;
 
-		if ((size = bunzip(fp, &data)) > 0) {
+		if ((size = bunzip(sh, fp, &data)) > 0) {
 			fclose(fp);
 			fp = fmemopen(data, size, "rb");
 			if (!fp) {
diff --git a/libsemanage/src/direct_api.h b/libsemanage/src/direct_api.h
index 1ad7d1d..e56107b 100644
--- a/libsemanage/src/direct_api.h
+++ b/libsemanage/src/direct_api.h
@@ -41,6 +41,6 @@ int semanage_direct_mls_enabled(struct semanage_handle *sh);
 
 #include <stdio.h>
 #include <unistd.h>
-ssize_t bunzip(FILE *f, char **data);
+ssize_t bunzip(struct semanage_handle *sh, FILE *f, char **data);
 
 #endif
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 7ee139f..4118910 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -40,6 +40,8 @@ typedef struct semanage_conf {
 	int disable_genhomedircon;
 	int handle_unknown;
 	mode_t file_mode;
+	int bzip_blocksize;
+	int bzip_small;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 6d4c3ce..a3b0819 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1529,7 +1529,7 @@ static int semanage_load_module(semanage_handle_t * sh, const char *filename,
 	ssize_t size;
 	char *data = NULL;
 
-	if ((size = bunzip(fp, &data)) > 0) {
+	if ((size = bunzip(sh, fp, &data)) > 0) {
 		fclose(fp);
 		fp = fmemopen(data, size, "rb");
 		if (!fp) {


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
