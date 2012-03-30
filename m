Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2UFw8uw016752
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2012 11:58:08 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2UFw7WJ006810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2012 11:58:07 -0400
Received: from dhcp-189-250.bos.redhat.com (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q2UFw6Dl006375
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2012 11:58:07 -0400
Message-ID: <4F75D80E.4010905@redhat.com>
Date: Fri, 30 Mar 2012 11:58:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Adding a booleans.subs file to selinux policy.
Content-Type: multipart/mixed;
 boundary="------------090803090705070506070105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090803090705070506070105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Basically I am sick of some of the bad names we chose for booleans when we
were first writing policy, so I want a mechanism to allow us to change the
names but still support the old names.

This patch will allow policy developers to ship a
/etc/selinux/targeted/contexts/booleans.subs

Then libselinux will check if a boolean name exists, if not it will see if
there is a substitute name and attempt to use that.

I have attached the libselinux_bools-subs.patch and the first pass at what a
booleans.subs file will look like in Fedora 18.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk912A4ACgkQrlYvE4MpobMrlgCfZxzuF2VoA19pnI0Uu6Ivn2zM
Fd4AoI1Rvrk7z05siNDadM+FCS6U8Jsx
=ry7g
-----END PGP SIGNATURE-----

--------------090803090705070506070105
Content-Type: text/plain; charset=UTF-8;
 name="booleans.subs"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="booleans.subs"

allow_auditadm_exec_content auditadm_exec_content
allow_console_login login_console_enabled
allow_cvs_read_shadow cvs_read_shadow
allow_daemons_dump_core daemons_dump_core
allow_daemons_use_tcp_wrapper daemons_use_tcp_wrapper
allow_daemons_use_tty daemons_use_tty
allow_domain_fd_use domain_fd_use
allow_execheap selinuxuser_execheap
allow_execmod selinuxuser_execmod
allow_execstack selinuxuser_execstack
allow_ftpd_anon_write ftpd_anon_write
allow_ftpd_full_access ftpd_full_access
allow_ftpd_use_cifs ftpd_use_cifs
allow_ftpd_use_nfs ftpd_use_nfs
allow_gssd_read_tmp gssd_read_tmp
allow_guest_exec_content guest_exec_content
allow_httpd_anon_write httpd_anon_write
allow_httpd_mod_auth_ntlm_winbind httpd_mod_auth_ntlm_winbind
allow_httpd_mod_auth_pam httpd_mod_auth_pam
allow_httpd_sys_script_anon_write httpd_sys_script_anon_write
allow_kerberos kerberos_enabled
allow_mplayer_execstack mplayer_execstack
allow_mount_anyfile mount_anyfile
allow_nfsd_anon_write nfsd_anon_write
allow_polyinstantiation polyinstantiation_enabled
allow_postfix_local_write_mail_spool postfix_local_write_mail_spool
allow_rsync_anon_write rsync_anon_write
allow_saslauthd_read_shadow saslauthd_read_shadow
allow_secadm_exec_content secadm_exec_content
allow_smbd_anon_write smbd_anon_write
allow_ssh_keysign ssh_keysign
allow_staff_exec_content staff_exec_content
allow_sysadm_exec_content sysadm_exec_content
allow_user_exec_content user_exec_content
allow_user_mysql_connect selinuxuser_mysql_connect_enabled
allow_user_postgresql_connect selinuxuser_postgresql_connect_enabled
allow_write_xshm xserver_clients_write_xshm
allow_xguest_exec_content xguest_exec_content
allow_xserver_execmem xserver_execmem
allow_ypbind nis_enabled
allow_zebra_write_config zebra_write_config
user_direct_dri selinuxuser_direct_dri_enabled
user_ping selinuxuser_ping
user_share_music selinuxuser_share_music

--------------090803090705070506070105
Content-Type: text/x-patch;
 name="libselinux-bools-subs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-bools-subs.patch"

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fbcd3ac..8e6f917 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -515,6 +515,7 @@ extern const char *selinux_x_context_path(void);
 extern const char *selinux_sepgsql_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
+extern const char *selinux_booleans_subs_path(void);
 extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
 extern const char *selinux_users_path(void);
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 1510043..3104bbd 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -86,45 +86,119 @@ int security_get_boolean_names(char ***names, int *len)
 }
 
 hidden_def(security_get_boolean_names)
+
+static char * bool_sub(const char *name) 
+{
+	char *sub = NULL;
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	FILE *cfg = fopen(selinux_booleans_subs_path(), "r");
+
+	if (!cfg)
+		return NULL;
+
+	while (getline(&line_buf, &line_len, cfg)) {
+		char *ptr = NULL;
+		char *src = line_buf;
+		char *dst = NULL;
+
+		while (*src && isspace(*src))
+			src++;
+		if (src[0] == '#') continue;
+		ptr = src;
+		while (*ptr && ! isspace(*ptr))
+			ptr++;
+		*ptr++ = '\0';
+		if (! *src || (strcmp(src, name) != 0))
+			continue;
+
+		dst = ptr;
+		while (*dst && isspace(*dst))
+			dst++;
+		ptr=dst;
+		while (*ptr && ! isspace(*ptr))
+			ptr++;
+		*ptr='\0';
+		if (! *dst)
+			continue;
+
+		sub = strdup(dst);
+		break;
+	}
+
+	free(line_buf);
+	fclose(cfg);
+	return sub;
+}
+
+static int bool_open(const char *name, int flag) {
+	char *fname = NULL;
+	char *alt_name = NULL;
+	int len;
+	int fd = -1;
+	char *ptr;
+
+	len = strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
+	fname = (char *)malloc(sizeof(char) * len);
+	if (!fname)
+		return fd;
+
+	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
+
+	fd = open(fname, flag);
+	if (fd >= 0 || errno != ENOENT) 
+		goto out;
+
+	alt_name = bool_sub(name);
+	if (! alt_name)
+		goto out;
+
+	len = strlen(alt_name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
+	ptr = realloc(fname, len);
+	if (!ptr) 
+		goto out;
+
+	fname = ptr;
+	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, alt_name);
+	fd = open(fname, flag);
+
+out:
+	free(fname);
+	free(alt_name);
+
+	return fd;
+}
+
 #define STRBUF_SIZE 3
 static int get_bool_value(const char *name, char **buf)
 {
 	int fd, len;
-	char *fname = NULL;
+	int rc = -1;
 
 	if (!selinux_mnt) {
 		errno = ENOENT;
 		return -1;
 	}
 
-	*buf = (char *)malloc(sizeof(char) * (STRBUF_SIZE + 1));
+	*buf = malloc(sizeof(char) * (STRBUF_SIZE + 1));
 	if (!*buf)
 		goto out;
-	(*buf)[STRBUF_SIZE] = 0;
 
-	len = strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
-	fname = (char *)malloc(sizeof(char) * len);
-	if (!fname)
-		goto out;
-	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
+	(*buf)[STRBUF_SIZE] = 0;
 
-	fd = open(fname, O_RDONLY);
-	if (fd < 0)
+	fd = bool_open(name, O_RDONLY);
+	if (fd < 0) 
 		goto out;
 
 	len = read(fd, *buf, STRBUF_SIZE);
 	close(fd);
 	if (len != STRBUF_SIZE)
 		goto out;
+	rc = 0;
 
-	free(fname);
-	return 0;
       out:
-	if (*buf)
-		free(*buf);
-	if (fname)
-		free(fname);
-	return -1;
+	free(*buf);
+	return rc;
 }
 
 int security_get_boolean_pending(const char *name)
@@ -164,8 +238,8 @@ hidden_def(security_get_boolean_active)
 
 int security_set_boolean(const char *name, int value)
 {
-	int fd, ret, len;
-	char buf[2], *fname;
+	int fd, ret;
+	char buf[2];
 
 	if (!selinux_mnt) {
 		errno = ENOENT;
@@ -176,17 +250,9 @@ int security_set_boolean(const char *name, int value)
 		return -1;
 	}
 
-	len = strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
-	fname = (char *)malloc(sizeof(char) * len);
-	if (!fname)
+	fd = bool_open(name, O_WRONLY);
+	if (fd < 0) 
 		return -1;
-	snprintf(fname, len, "%s%s%s", selinux_mnt, SELINUX_BOOL_DIR, name);
-
-	fd = open(fname, O_WRONLY);
-	if (fd < 0) {
-		ret = -1;
-		goto out;
-	}
 
 	if (value)
 		buf[0] = '1';
@@ -196,8 +262,7 @@ int security_set_boolean(const char *name, int value)
 
 	ret = write(fd, buf, 2);
 	close(fd);
-      out:
-	free(fname);
+
 	if (ret > 0)
 		return 0;
 	else
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index 0b00156..1aa4734 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -25,3 +25,4 @@ S_(BINPOLICY, "/policy/policy")
     S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
     S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dist")
     S_(SEPGSQL_CONTEXTS, "/contexts/sepgsql_contexts")
+    S_(BOOLEAN_SUBS, "/booleans.subs")
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 907b004..2ffaa84 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -47,7 +47,8 @@
 #define FILE_CONTEXT_SUBS 23
 #define SEPGSQL_CONTEXTS  24
 #define FILE_CONTEXT_SUBS_DIST 25
-#define NEL               26
+#define BOOLEAN_SUBS      26
+#define NEL               27
 
 /* Part of one-time lazy init */
 static pthread_once_t once = PTHREAD_ONCE_INIT;
@@ -442,6 +443,12 @@ const char *selinux_virtual_image_context_path(void)
 
 hidden_def(selinux_virtual_image_context_path)
 
+const char * selinux_booleans_subs_path(void) {
+	return get_path(BOOLEAN_SUBS);
+}
+
+hidden_def(selinux_booleans_subs_path)
+
 const char * selinux_file_context_subs_path(void) {
 	return get_path(FILE_CONTEXT_SUBS);
 }
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 4db366a..8d752f7 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -60,6 +60,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_setenforce)
     hidden_proto(security_deny_unknown)
     hidden_proto(selinux_binary_policy_path)
+    hidden_proto(selinux_booleans_subs_path)
     hidden_proto(selinux_current_policy_path)
     hidden_proto(selinux_default_context_path)
     hidden_proto(selinux_securetty_types_path)

--------------090803090705070506070105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
